%{
#include "parser.h"
using namespace Wye;
%}

%pure-parser
%parse-param {ParserState *s}
%lex-param {ParserState *s}

%{
static void yyerr(ParserState *ps, const char *s);
%}

%union {
	int num_int;
	float num_float;
}

%token END 0

%token pipe

%%
main: ;
%%

int yylex(YYSTYPE *val, ParserState *ps);

static void yyerror(ParserState *ps, const char *s) {
}
