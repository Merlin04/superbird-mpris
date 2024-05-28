(*let version = 1

type capabilities = {
	control : boolean;
	next : boolean;
	previous : boolean
}

type t = {

}

type loop_status = None | Track | Playlist
type playback_status = Playing | Paused | Stopped

type property_update =
	| LoopStatus of loop_status
	| PlaybackStatus of playback_status
	| Position of int64
	| Shuffle of boolean
	| Volume of float

type action =
	| Next
	| Previous
	| Play_Pause 
	| Pause
	| Play
	| Stop
	| Seek of int64
	| 

type call_id = string

type DaemonMessage =
	| PropertyValue of m_property (* a property value, either manually fetched
									 or sent due to an update *)
	| Signal of m_signal (* a signal sent over a value, so forwarding it *)
	| MethodResult of call_id * m_method_result

(*

Protocol is thin abstraction over dbus
daemon registers listeners on all the properties, so
 when a property changes client is notified
you can send a request to get a property, for init
when a signal updates, value is also sent

 *)
*)