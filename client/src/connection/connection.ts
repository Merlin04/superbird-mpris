import { Socket } from "./Socket.ts";
import { useEffect, useState } from "react";

export let socket: Socket = new Socket();


export function useConnection() {
    // const [connected, setConnected] = useState(false);
    // useEffect(() => {
    //     void async function() {
    //         await socket.ready();
    //         setConnected(true);
    //
    //         void ();
    //     }();
    // }, []);

    // return { connected };
}