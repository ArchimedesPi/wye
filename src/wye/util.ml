open Parser
open Lexing

(* lexer utils *)

let dump_position lexbuf = 
  let pos = lexbuf.lex_curr_p in
  Printf.sprintf "%s:%d:%d" pos.pos_fname pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1) 

let dump_token tok =
  match tok with
  | IDENT x -> "id(" ^ x ^ ")"
  | STR x -> "str(" ^ x ^ ")"
  | INT x -> "int(" ^ string_of_int x ^ ")"
  | FLOAT x -> "float(" ^ string_of_float x ^ ")"

  | ADD -> "+" | SUB -> "-" | MUL -> "*" | DIV -> "/"
  | EQ -> "==" | NEQ -> "!=" | LT -> "<" | GT -> ">" | LEQ -> "<=" | GEQ -> ">="

  | ASSIGN -> "assign"
  | SET -> "set"
  | APPLY -> "apply"
  | PIPE -> "pipe"
  | FATARROW -> "fatarrow"
  | ARROW -> "arrow"
  
  | DOT -> "dot"
  | COMMA -> "comma"
  | BANG -> "bang"
  | COLON -> "colon"
  | SEMICOLON -> "semicolon"
  | LPAREN -> "lparen"
  | RPAREN -> "rparen"
  | LCURLY -> "lcurly"
  | RCURLY -> "rcurly"

  | USING -> "using"
  | AS -> "as"
  | LET -> "let"
  | MATCH -> "match"
  | WHEN -> "when"
  | WHERE -> "where"

  | EOF -> "eof"
;;

