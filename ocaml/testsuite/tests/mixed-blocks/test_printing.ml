(* TEST
<<<<<<< HEAD
   flags = "-extension layouts_alpha"

   * runtime5
   ** expect
 *)
||||||| parent of 363966e5 (Implement mixed blocks in runtime 4 (#2422))
 flags = "-extension layouts_alpha";
 runtime5;
 expect;
*)
=======
 flags = "-extension layouts_alpha";
 expect;
*)
>>>>>>> 363966e5 (Implement mixed blocks in runtime 4 (#2422))

(* Test bytecode printing of values *)

(* All-float *)
type t = { flt : float; uflt : float# }

let t = { flt = 4.0; uflt = #5.0 }

[%%expect {|
type t = { flt : float; uflt : float#; }
val t : t = {flt = 4.; uflt = <abstr>}
|}];;

(* Non-empty value prefix *)
type t = { str : string; uflt : float# }

let t = { str = "str"; uflt = #5.0 }

[%%expect {|
type t = { str : string; uflt : float#; }
val t : t = {str = "str"; uflt = <abstr>}
|}];;

(* Flat suffix mixes float# and imm *)
type t = { str : string; uflt : float#; imm : int }

let t = { str = "str"; uflt = #5.0; imm = 5 }

[%%expect {|
type t = { str : string; uflt : float#; imm : int; }
val t : t = {str = "str"; uflt = <abstr>; imm = 5}
|}];;
