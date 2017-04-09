open Core.Std
open Wye
open Parser
open Util

let parse_with_error buf =
  try (Ok (Parser.main Lexer.tokenize buf)) with
  | Lexer.Lex_error e -> Error e
  (* | Parsing.Basics.Error -> Error "Parse error" *)
;;

let print_error e buf =
  Printf.printf "\n----\n%s: %s\n" (dump_position buf) e
;;

let rec parse_and_print buf =
  let ast = parse_with_error buf in
  match ast with
  | Ok (Some a) -> print_endline (Ast.show_ast a);
  | Ok None -> print_endline "empty source file";
  | Error e -> print_error e buf
;;

let () =
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
    parse_and_print lexbuf;
;;
