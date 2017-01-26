open Core.Std
open Lexing
open Parser

let program = "print $ 2 != 4.";;

let dump_token tok =
  match tok with
  | IDENT x -> "id(" ^ x ^ ")"
  | STRING x -> "str(" ^ x ^ ")"
  | INT x -> "int(" ^ string_of_int x ^ ")"
  | FLOAT x -> "float(" ^ string_of_float x ^ ")"

  | DOT -> "."
  | OP x -> "op(" ^ x ^ ")"
  | LPAREN -> "("
  | RPAREN -> ")"
  | SEMICOLON -> ";"

  | EOF -> "eof";;

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
