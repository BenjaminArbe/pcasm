/* file: 15array1.cpp
 * to build:	make X=15array1 D=15array1c
 * to execute:	./15array1c
 */
#include <cstdio>

extern "C" int asm_main(void);
extern "C" void dump_line(void);

int
main (int argc, char** argv) {
	int	rc;
	rc = asm_main ();
	return rc;
}

/*
 * function dump_line
 * dumps all chars left in current line from input buffer
 */
void
dump_line() {
	int ch;

	while ( (ch = getchar()) != EOF && ch != '\n' ) ;
		/* null body */
}

