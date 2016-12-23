#pragma once

#include <string>
#include <cstring>
#include <vector>

#include "parser.tab.h"

namespace Wye {
	class Lexer {
	public:
		Lexer(const char *input);

		int lex(YYSTYPE *val);

	private:
		const char *input;


		// -- REQUIRED BY RAGEL
		const char *p; // pointer to data
		const char *pe; // pointer to end of data
		const char *eof; // pointer to end of file

		int cs; // current state of state machine
		int act; // id of last token (used for backtracking)
		const char *ts; // pointer to match character data
		const char *te; // pointer to end of match character data
	};
}
