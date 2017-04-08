open Core.Std
open Lexing
open Parser

let program = "print $ 2 != 4.";;

using discord as d.



let rec lex buf =
  let tok = try Lexer.tokenize buf with
  | x -> print_endline (Exn.to_string x) in
  match tok with
  | EOF -> ()
  | t -> (
    print_endline (dump_token t);
    lex buf
  )
  ;;

let lexbuf = Lexing.from_string program in
lex lexbuf
