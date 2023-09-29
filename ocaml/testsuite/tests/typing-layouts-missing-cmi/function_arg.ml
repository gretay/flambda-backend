(* TEST

readonly_files = "function_a.ml function_b.ml"
* setup-ocamlc.byte-build-env
** ocamlc.byte
module = "function_a.ml"
*** ocamlc.byte
module = "function_b.ml"
**** script
script = "rm -f function_a.cmi"
***** expect
*)
(* CR layouts v2.9: all error messages below here are unreviewed *)


#directory "ocamlc.byte";;
#load "function_b.cmo";;

(* This tests that sorts are correctly extracted from function types,
   even in the presence of a missing cmi file. *)

let f0 (g : Function_b.fun_t) = g ~arg1:(assert false)

[%%expect{|
Line 1, characters 40-54:
1 | let f0 (g : Function_b.fun_t) = g ~arg1:(assert false)
                                            ^^^^^^^^^^^^^^
Error: Function arguments and returns must be representable.
       The layout of Function_a.t is any, because
         the .cmi file for Function_a.t is missing.
       But the layout of Function_a.t must be a sublayout of '_representable_layout_1, because
         it's used as a function argument.
       No .cmi file found containing Function_a.t.
       Hint: Adding "function_a" to your dependencies might help.
|}]

let f1 (g : Function_b.fun_t) = g ()

[%%expect{|
Line 1, characters 34-36:
1 | let f1 (g : Function_b.fun_t) = g ()
                                      ^^
Error: Function arguments and returns must be representable.
       The layout of Function_a.t is any, because
         the .cmi file for Function_a.t is missing.
       But the layout of Function_a.t must be a sublayout of '_representable_layout_2, because
         it's used as a function argument.
       No .cmi file found containing Function_a.t.
       Hint: Adding "function_a" to your dependencies might help.
|}]

let f2 : Function_b.fun_t = fun ~arg1:_ ~arg2 () -> arg2

[%%expect{|
Line 1, characters 28-56:
1 | let f2 : Function_b.fun_t = fun ~arg1:_ ~arg2 () -> arg2
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Error: Function arguments and returns must be representable.
       The layout of Function_a.t is any, because
         the .cmi file for Function_a.t is missing.
       But the layout of Function_a.t must be a sublayout of '_representable_layout_3, because
         it's used as a function argument.
       No .cmi file found containing Function_a.t.
       Hint: Adding "function_a" to your dependencies might help.
|}]

let f3 : Function_b.return_t = fun () -> assert false

[%%expect{|
Line 1, characters 31-53:
1 | let f3 : Function_b.return_t = fun () -> assert false
                                   ^^^^^^^^^^^^^^^^^^^^^^
Error: Function arguments and returns must be representable.
       The layout of Function_a.t is any, because
         the .cmi file for Function_a.t is missing.
       But the layout of Function_a.t must be a sublayout of '_representable_layout_4, because
         it's used as a function result.
       No .cmi file found containing Function_a.t.
       Hint: Adding "function_a" to your dependencies might help.
|}]

let f4 (_ : Function_b.take_t) = ()
let x1 = f4 Function_b.f_opt

[%%expect{|
val f4 : Function_b.take_t -> unit = <fun>
Line 2, characters 12-28:
2 | let x1 = f4 Function_b.f_opt
                ^^^^^^^^^^^^^^^^
Error: Function arguments and returns must be representable.
       The layout of Function_a.t is any, because
         the .cmi file for Function_a.t is missing.
       But the layout of Function_a.t must be a sublayout of '_representable_layout_5, because
         it's used as a function argument.
       No .cmi file found containing Function_a.t.
       Hint: Adding "function_a" to your dependencies might help.
|}]

let f5 (_ : Function_b.return_t) = ()
let x2 = f5 Function_b.f_opt_2

[%%expect{|
val f5 : Function_b.return_t -> unit = <fun>
Line 2, characters 12-30:
2 | let x2 = f5 Function_b.f_opt_2
                ^^^^^^^^^^^^^^^^^^
Error: Function arguments and returns must be representable.
       The layout of Function_a.t is any, because
         the .cmi file for Function_a.t is missing.
       But the layout of Function_a.t must be a sublayout of '_representable_layout_6, because
         it's used as a function result.
       No .cmi file found containing Function_a.t.
       Hint: Adding "function_a" to your dependencies might help.
|}]