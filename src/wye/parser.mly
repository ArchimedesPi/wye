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
%token DEF, LET, MATCH, WHEN, WHERE
%token MUT, CONST

/* operators */
%token DOT, COMMA, BANG, COLON, SEMICOLON
%token ASSIGN, SET, FATARROW, ARROW, PIPE, APPLY
%token LPAREN, RPAREN, LCURLY, RCURLY
%token EQ, NEQ, LT, GT, LEQ, GEQ
%token ADD, SUB, MUL, DIV

/* utility */
%token EOF
%token EOL

%start main
%type <Ast.ast list option> main

%%

main:
  | x = option(nonempty_list(terminated(statement, DOT))); EOF { x }

statement:
  | x=expr { x }
  | LET; q=option(qualifier); var=fq_ident; SET; value=expr { Ast.VarBind (var, value, q) }
  | DEF; f=func_proto; SET; b=nonempty_list(statement) { Ast.FuncBind (f, b) }

expr:
/* literals */
  | v=INT {Ast.Number (`Int v)}
  | v=FLOAT {Ast.Number (`Float v)}
  | v=STR {Ast.String v}
/* var */
  | var=fq_ident { Ast.Variable var }

fq_ident:
  fq_path=separated_nonempty_list(DOT, IDENT) {
   match fq_path with
   | top_name :: rev_path -> List.rev fq_path; (top_name, List.rev rev_path)
   | [] -> raise (Internal_error "Compiler bug: expected *something* in fq_path")}

  | lhs=expr; op=binary_op; rhs=expr; { BinaryOp (op, lhs, rhs) }
%inline qualifier:
  | CONST { Ast.Const }
  | MUT { Ast.Mut }

%inline binary_op:
  | ADD { Addition }
  | SUB { Subtraction }
  | MUL { Multiplication }
  | DIV { Division }

  | EQ { Equal }
  | NEQ { NotEqual }

  | GT { GreaterThan }
  | LT { LessThan }
  | GEQ { GreaterThanEqual }
  | LEQ { LessThanEqual }
;
