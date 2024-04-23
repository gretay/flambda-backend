(* TEST
<<<<<<< HEAD
   flags = "-extension layouts_alpha"

   * runtime5
   ** native
   ** bytecode
 *)
||||||| parent of 363966e5 (Implement mixed blocks in runtime 4 (#2422))
 flags = "-extension layouts_alpha";
 runtime5;
 {
   native;
 }{
   bytecode;
 }
*)
=======
 flags = "-extension layouts_alpha";
 flambda2;
 {
   native;
 }{
   bytecode;
 }
*)
>>>>>>> 363966e5 (Implement mixed blocks in runtime 4 (#2422))

type t = { t : t; flt : float# }

(* Run Gc.full_major while constructing [t] so that it is promoted
   to the major heap. This ensures that the [caml_modify] run as part
   of [caml_update_dummy] actually does some interesting work.
*)

let rec t =
  { t;
    flt = (Gc.full_major (); #0.);
  };;

let (_ : t) = Sys.opaque_identity t
