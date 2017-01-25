#include "parser.h"

using namespace Wye;

bool Wye::parse(const char *input) {
	Lexer lexer(input);
	ParserState ps;
	ps.lexer = &lexer;

	if (yyparse(&ps) != 0) {
		return false;
	} else {
		return true;
	}
}
