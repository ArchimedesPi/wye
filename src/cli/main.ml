open Wye
open Parser
open Util

module T = ANSITerminal

let lex_start_pos fname =
  {
    Lexing.pos_fname = fname;
    pos_lnum = 1;
    pos_bol = 0;
    pos_cnum = 0;
  }

let parse_with_error buf =
  try (Ok (Parser.main Lexer.tokenize buf)) with
  | Lexer.Lex_error e -> Error e
  | Parser.Error -> Error "Parse error"
;;

let error_with_pos e buf =
  Printf.sprintf "\n----\n%s: %s\n" (dump_position buf) e
;;

let dump_parse_res ast buf =
  match ast with
  | Ok (Some a) -> List.iter (fun node -> print_endline (Ast.show_ast node)) a
  | Ok None -> print_endline "empty source file"
  | Error e -> print_endline (error_with_pos e buf)
;;

let rec repl () =
  T.print_string [T.Bold; T.green] "wye(.)> "; flush stdout;

  try
    let input_line = input_line stdin ^ "\n" in
      if String.length input_line = 0 then repl ();
    let lexbuf = Lexing.from_string input_line in
      lexbuf.Lexing.lex_curr_p <- lex_start_pos "repl";
    let ast = parse_with_error lexbuf in
      dump_parse_res ast lexbuf;
      repl ()
  with End_of_file ->
    exit 0
;;

let parse_from_file fname =
  let fchannel = open_in fname in
  let lexbuf = Lexing.from_channel fchannel in
    lexbuf.Lexing.lex_curr_p <- lex_start_pos fname;
  let ast = parse_with_error lexbuf in
    dump_parse_res ast lexbuf
;;

let () =
  if Array.length Sys.argv > 1 then parse_from_file Sys.argv.(1)
  else repl ()
;;
