#include <cstdio>

extern "C" int asm_main();

int
main( int argc, char** argv) {
	int rc;
	rc = asm_main();
	return rc;
}
