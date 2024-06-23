import { MPRISClientImpl, RpcCall, RpcResponse } from "./mpris_pb";
import { BehaviorSubject, Observable, ReplaySubject } from "rxjs";
import { socket } from "./connection.ts";

const BASE_URL = 'ws://localhost:1337';

export function create_socket() : WebSocket {
    const w = new WebSocket(BASE_URL);
    w.binaryType = "arraybuffer";
    return w;
}

const randomCallId = () => Math.floor(Math.random() * Number.MAX_SAFE_INTEGER); // doesn't fill an int64 but good enough

const delay = (ms: number) => new Promise(r => setTimeout(r, ms));

const REQ_TIMEOUT = 5000;

export class Socket {
    socketConnector: () => WebSocket;
    webSocket: WebSocket;
    #messageQueue: ArrayBufferLike[] = []
    client: MPRISClientImpl;

    #resHandlers: { callId: number, handler: (res: Uint8Array | undefined) => void }[];

    #removeResHandler(callId: number) {
        return this.#resHandlers.splice(this.#resHandlers.findIndex(v => v.callId === callId), 1);
    }

    constructor(socketConnector: typeof create_socket = create_socket) {
        this.socketConnector = socketConnector;
        this.connect();
        this.client = new MPRISClientImpl({
            request: (_service: string, name: string, req: Uint8Array): Promise<Uint8Array> => {
                const callId = randomCallId();
                const reqBytes = RpcCall.encode({
                    callId,
                    name,
                    req
                }).finish();
                const p = new Promise<Uint8Array>((resolve, reject) => {
                    const timeout = setTimeout(() => {
                        reject("Call timeout");
                        this.#removeResHandler(callId);
                    }, REQ_TIMEOUT);
                    this.#resHandlers.push({
                        callId,
                        handler: res => {
                            clearTimeout(timeout);
                            this.#removeResHandler(callId);
                            if(res === undefined) throw new Error("Undefined response in unary RPC");
                            resolve(res);
                        }
                    });
                });
                this.#sendBytes(reqBytes);
                return p;
            },
            serverStreamingRequest: (_service: string, name: string, req: Uint8Array): Observable<Uint8Array> => {
                const callId = randomCallId();
                const reqBytes = RpcCall.encode({
                    callId,
                    name,
                    req
                }).finish();
                const o = new ReplaySubject<Uint8Array>();
                this.#resHandlers.push({
                    callId,
                    handler: res => {
                        if(res === undefined) {
                            this.#removeResHandler(callId);
                            o.complete();
                            return;
                        }
                        o.next(res);
                    }
                });

                this.#sendBytes(reqBytes);
                return o;
            },
            bidirectionalStreamingRequest(_service: string, _method: string, _data: Observable<Uint8Array>): Observable<Uint8Array> {
                throw new Error("Unsupported bidirectional streaming request");
            },
            clientStreamingRequest(_service: string, _method: string, _data: Observable<Uint8Array>): Promise<Uint8Array> {
                throw new Error("Unsupported client streaming request")
            }
        });

        this.ready.subscribe(v => {
            if(v) {
                this.#flushQueue();
            }
        });
    }

    ready = new BehaviorSubject<boolean>(false);

    connect() {
        this.webSocket = this.socketConnector();

        this.webSocket.addEventListener("open", () => {
            this.registerEventHandler();
            // noinspection JSIgnoredPromiseFromCall
            this.#pingLoop();
            // this.#flushQueue();
            // this.#readyPromiseResolvers.forEach(r => r());
            // this.#readyPromiseResolvers = [];
        });

        this.webSocket.addEventListener("close", () => {
            this.ready.next(false);
            setTimeout(this.connect.bind(this), 1000);
            return;
        });
        this.webSocket.addEventListener("error", () => {
            this.ready.next(false);
            setTimeout(this.connect.bind(this), 1000);
            return;
        });
    }

    // #readyPromiseResolvers: (() => void)[] = [];
    // ready(): Promise<void> {
    //     if(this.isReady()) return Promise.resolve();
    //     return new Promise(res => this.#readyPromiseResolvers.push(res as () => void));
    // }
    //
    // #isConnected = false;
    // isReady() { return this.webSocket.readyState > 0 && this.#isConnected; }

    async #pingLoop() {
        while(1) {
            try {
                await socket.client.Ping({});
                if(!this.ready.value) this.ready.next(true);
            } catch(err) {
                if(this.ready.value) this.ready.next(false);
            }
            await delay(1000);
        }
    }

    #sendBytes(msg: ArrayBufferLike) {
        if(!this.ready.value) {
            this.#messageQueue.push(msg);
            return;
        }
        this.webSocket.send(msg);
    }

    #flushQueue() {
        while(this.#messageQueue.length) this.#sendBytes(this.#messageQueue.shift());
    }

    registerEventHandler() {
        this.webSocket.addEventListener("message", e => {
            if(!e.data instanceof ArrayBuffer) {
                throw new Error("Received a WebSocket message that wasn't an ArrayBuffer");
            }
            const b : ArrayBuffer = e.data;
            const { callId, res } = RpcResponse.decode(new Uint8Array(b));
            const h = this.#resHandlers.find(v => v.callId === callId);
            if(!h) throw new Error("Received a response for a call ID which does not have corresponding handler");
            h.handler(res);
        });
    }
}