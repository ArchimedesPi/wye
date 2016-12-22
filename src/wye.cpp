#include "lexer.h"

using namespace Wye;

int main() {
	Lexer lexer(" the_thing ");

	Token tok;
	while(tok != END) {
		tok = lexer.lex();
		printf("%i", tok);
	}

	return 0;
}
