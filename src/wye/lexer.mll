{
open Parser

exception Lex_error of string;;
let lexical_error msg = raise (Lex_error (Printf.sprintf "Lexical error: %s" msg));;

let keyword_table =
  Util.create_hashtbl 8 [
    ("using", USING);
    ("as", AS);
    ("let", LET);
    ("match", MATCH);
    ("when", WHEN);
    ("where", WHERE);
  ];;
}

let alpha = ['a'-'z' 'A'-'Z']
let digit = ['0'-'9']

let decimal = '.' digit*
let exponential = ['e' 'E'] ['-' '+']? digit+
let int = '-'? digit*
let float = '-'? digit* decimal? exponential?

let white = [' ' '\t']+
let nl = '\n'

let ident = (alpha | '_') (alpha | digit | '_')*

rule tokenize =
  parse
  | white { tokenize lexbuf }
  | nl { Lexing.new_line lexbuf; tokenize lexbuf }

  | int as d { INT (int_of_string d) }
  | float as d { FLOAT (float_of_string d) }

  | ident as idt { try let keywd_token = Hashtbl.find keyword_table idt in
                    keywd_token
                   with Not_found -> IDENT idt }

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

  | "/*" { comment_slurp 0 lexbuf } (* eat multiline comments via a subparser *)
  | "//" [^ '\n'] nl (* eat one-line comments *)

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
  | eof { lexical_error "eof in string; expected a closing string quote *somewhere*" }

and comment_slurp level = 
  parse
  | "*/" { if level = 0 then tokenize lexbuf (* if we're closing at top level, drop back to the main lexer*)
            else comment_slurp (level-1) lexbuf } (* otherwise decrement level, recurse. MOAR COMMENTS TO LEX. *)
  | "/*" { comment_slurp (level+1) lexbuf } (* we hit a new comment level so increment and recurse *)

  | _ { comment_slurp level lexbuf } (* eat all characters inside comments *)
  | eof { lexical_error "eof in multiline comment; expected a closing comment delimiter *somewhere*"}
