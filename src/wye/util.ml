open Parser

let dump_token tok =
  match tok with
  | IDENT x -> "id(" ^ x ^ ")"
  | STR x -> "str(" ^ x ^ ")"
  | INT x -> "int(" ^ string_of_int x ^ ")"
  | FLOAT x -> "float(" ^ string_of_float x ^ ")"

  | OP x -> "op(" ^ x ^ ")"
  | ASSIGN -> "assign"
  | SET -> "set"
  | APPLY -> "apply"
  | PIPE -> "pipe"
  | FATARROW -> "fatarrow"
  
  | DOT -> "dot"
  | SEMICOLON -> "semicolon"
  | LPAREN -> "lparen"
  | RPAREN -> "rparen"
  | LCURLY -> "lcurly"
  | RCURLY -> "rcurly"

  | EOF -> "eof";;

