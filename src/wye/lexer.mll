{
open Parser
open Printf

let line_num = ref 1;;

exception Lex_error of string;;
let lexical_error msg = raise (Lex_error (
    sprintf "Lexical error: %s (on line %d)" msg !line_num))
}

let alpha = ['a'-'z' 'A'-'Z']
let digit = ['0'-'9']
let white = [' ' '\t']+

let ident = (alpha | '_') (alpha | digit | '_')*

rule tokenize = parse
  | '\n' { incr line_num; tokenize lexbuf }
  | white { tokenize lexbuf }

  | digit* as d { INT (int_of_string d) }
  | ident as idt { IDENT idt }

  | '.' { DOT }
  | ';' { SEMICOLON }
  | '(' { LPAREN }
  | ')' { RPAREN }

  | "<" | ">" | ">=" | "<=" | "==" | "!=" | "|" | "|>" | "="
    as o { OP o }

  | _ as c { lexical_error ("foreign character `" ^ String.make 1 c ^ "`") }
  | eof { EOF }
