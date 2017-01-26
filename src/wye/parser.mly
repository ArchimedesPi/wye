%token <int> INT
%token <float> FLOAT
%token <string> IDENT
%token <string> STRING
%token DOT, SEMICOLON, LPAREN, RPAREN
%token <string> OP
%token EOF

%start program
%type <unit> program

%%

program:
  | EOF     { () }
;
