{
open Parser

exception Lex_error of string;;
let lexical_error msg = raise (Lex_error (Printf.sprintf "Lexical error: %s" msg))
}

let alpha = ['a'-'z' 'A'-'Z']
let digit = ['0'-'9']
let white = [' ' '\t']+
let nl = '\n'

let ident = (alpha | '_') (alpha | digit | '_')*

rule tokenize =
  parse
  | white { tokenize lexbuf }
  | nl { Lexing.new_line lexbuf; tokenize lexbuf }

  | digit* as d { INT (int_of_string d) }
  | ident as idt { IDENT idt }

  | '.' { DOT }
  | ',' { COMMA }
  | '!' { BANG }
  | ':' { COLON }
  | ';' { SEMICOLON }
  | '(' { LPAREN }
  | ')' { RPAREN }
  | '{' { LCURLY }
  | '}' { RCURLY }

  | ":=" { ASSIGN }
  | "=" { SET }
  | "|" { PIPE }
  | "|>" { APPLY }
  | "->" { ARROW }
  | "=>" { FATARROW }
  | "<" | ">" | ">=" | "<=" | "==" | "!="
    as o { OP o }

  | '"' { str_slurp (Buffer.create 20) lexbuf }

  | _ { lexical_error ("foreign character `" ^ Lexing.lexeme lexbuf ^ "`") }
  | eof { EOF }

and str_slurp buf = 
  parse
  | '"' { STR (Buffer.contents buf) }
  | '\\' 'n' { Buffer.add_char buf '\n'; str_slurp buf lexbuf}
  | '\\' 'r' { Buffer.add_char buf '\r'; str_slurp buf lexbuf}
  | '\\' 't' { Buffer.add_char buf '\t'; str_slurp buf lexbuf}
  | [^ '"' '\\']+ { Buffer.add_string buf (Lexing.lexeme lexbuf);
                    str_slurp buf lexbuf }
  | _ { lexical_error ("illegal character `" ^ Lexing.lexeme lexbuf ^ "` inside string") }
  | eof { lexical_error "eof in string; expected string close" }
