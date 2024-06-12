open Udev

let udev_ctx = Context.create ()

let ( let^ ) (o : 'a option) (default : unit -> 'a) : 'a = match o with
  | Some v -> v
  | None -> default ()

let superbird_udev_props = [
  ("ID_USB_MODEL", "weird-midi")
]

let serial_port_of_device d : string option = List.assoc_opt "DEVNAME" (Device.properties d)

let get_serial_port_path () =
  (* first, check if it's already plugged in *)
  let^ () = Enumerate.devices udev_ctx (Enumerate.Subsystem "tty" :: (List.map (fun (p, v) -> Enumerate.Property (p, v)) superbird_udev_props))
    |> function
      | d :: _ -> serial_port_of_device d
      | _ -> None
  in

  print_endline "Waiting for Car Thing to be connected...";

  let mon = Monitor.create udev_ctx in
  Monitor.set_filter mon [Monitor.Subsystem_devtype ("tty", None)];
  Monitor.start mon;

  let rec loop () =
    let dev = Monitor.receive_device mon in
    let action = Device.action dev |> Option.get in
    if action <> Device.Add then loop () else
    let props = Device.properties dev in
    if List.find_opt (fun p -> List.mem p props |> not) superbird_udev_props <> None then loop () else
    let^ () = serial_port_of_device dev in loop ()
  in loop ()
