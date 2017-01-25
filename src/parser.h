#pragma once

#include "lexer.h"

namespace Wye {
	typedef struct ParserState {
		Lexer *lexer;
	} ParserState;

	bool parse(const char *input);
}

int yyparse(Wye::ParserState *ps);

