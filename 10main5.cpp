// File: main5.cpp
// To compile this:
//	make X=10sub5 D=10main5
// To test: ./10sub5
#include <cstdio>

// prototype for assembly routine
extern "C" void calc_sum(int, int*) __attribute__((cdecl));

int
main (int argc, char** argv) {
	int	n, sum;

	printf ("Sum integers up to: ");
	scanf  ("%d", &n);
	calc_sum (n, &sum);
	printf ("Sum is %d\n", sum);
}

