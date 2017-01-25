#include "parser.h"

using namespace Wye;

int main() {
	const char *input_program = "aaaa <<<<";

	printf("%s\n", parse(input_program) ? "true" : "false");

	return 0;
}
