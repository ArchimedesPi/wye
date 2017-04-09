%token <int> INT
%token <float> FLOAT
%token <string> IDENT
%token <string> STR

/* keywords */
%token USING, AS
%token LET, MATCH, WHEN, WHERE

%token DOT, COMMA, BANG, COLON, SEMICOLON
%token ASSIGN, SET, FATARROW, ARROW, PIPE, APPLY
%token LPAREN, RPAREN, LCURLY, RCURLY
%token <string> OP
%token EOF

%start program
%type <unit> program

%%

program:
  | EOF     { () }
;
