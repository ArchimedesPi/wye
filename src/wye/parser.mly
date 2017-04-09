%{
  open Ast;;
%}

/* literals and identifiers */
%token <int> INT
%token <float> FLOAT
%token <string> IDENT
%token <string> STR

/* keywords */
%token USING, AS
%token LET, MATCH, WHEN, WHERE

/* operators */
%token DOT, COMMA, BANG, COLON, SEMICOLON
%token ASSIGN, SET, FATARROW, ARROW, PIPE, APPLY
%token LPAREN, RPAREN, LCURLY, RCURLY
%token EQ, NEQ, LT, GT, LEQ, GEQ
%token ADD, SUB, MUL, DIV

/* utility */
%token EOF

%start main
%type <Ast.ast option> main

%%

main:
  | EOF { None }
;
