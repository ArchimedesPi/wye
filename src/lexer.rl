/*
 * Wye's lexer
 * Implemented in Ragel/C
 */

#include "lexer.h"

using namespace Wye;

%%machine wye;
// emit the constant static data for the state machine
%%write data;


%%{
	ident = alpha (alnum | '_')*;

	main := |*
	ident {ret=Token::IDENTIFIER; fbreak;};

	space;
	*|;
}%%

namespace Wye {
	Lexer::Lexer(const char *input) {
		// emit the initialization code for the lexer
		%%write init;

		this->input = input;
		p = input ; // point Ragel to the input string
		pe = input + strlen(input) + 1; // point Ragel to the end of the input string
	}

	Token Lexer::lex() {
		Token ret = Token::END;

		%%write exec;

		if (p == eof) {
			ret = Token::END;
		}
		return ret;
	}
}
