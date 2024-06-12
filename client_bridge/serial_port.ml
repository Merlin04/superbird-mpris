open Lwt.Infix

let serial_port_gadget_path =
  Lwt_unix.files_of_directory "/dev"
    |> Lwt_stream.to_list
    >|= List.filter (String.starts_with ~prefix:"ttyGS")
    >|= function
      | s :: _ -> "/dev/" ^ s
      | _ -> failwith "Could not find gadget serial device. Make sure the USB serial gadget is enabled."