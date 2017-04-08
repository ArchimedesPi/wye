open Core.Std
open Lexing
open Parser
open Util

let tokenize_with_error buf =
  try (Ok (Lexer.tokenize buf)) with
  | Lexer.Lex_error e -> Error e;;

let print_error e buf =
  Printf.printf "\n----\n%s: %s\n" (dump_position buf) e

let rec lex buf =
  let tok = tokenize_with_error buf in
  match tok with
  | Error e -> print_error e buf;
  | Ok EOF -> print_endline "eof";
  | Ok t -> (
    print_string (dump_token t ^ "; ");
    lex buf
  )
  ;;

let progin =
  if Array.length Sys.argv > 1
  then open_in Sys.argv.(1)
  else stdin in
let file_name = if progin = stdin then "stdin" else Sys.argv.(1) in
let lexbuf = Lexing.from_channel progin in
  lexbuf.Lexing.lex_curr_p <- {
    Lexing.pos_fname = file_name;
    pos_lnum = 1;
    pos_bol = 0;
    pos_cnum = 0; 
  };
  lex lexbuf
