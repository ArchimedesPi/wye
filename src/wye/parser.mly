%token <int> INT
%token <float> FLOAT
%token <string> IDENT
%token <string> STR
%token DOT, SEMICOLON
%token ASSIGN, SET, FATARROW, PIPE, APPLY
%token LPAREN, RPAREN, LCURLY, RCURLY
%token <string> OP
%token EOF

%start program
%type <unit> program

%%

program:
  | EOF     { () }
;
