#pragma once

#include "lexer.h"

namespace Wye {
	typedef struct ParserState {
		Lexer *lexer;
	} ParserState;
}
