// File: main6.cpp
// To compile this:
//	make X=11sub6 D=11main6
#include <cstdio>

// prototype for assembly routine
extern "C" int calc_sum(int) __attribute__((cdecl));

int
main (int argc, char** argv) {
	int	n, sum;

	printf ("Sum integers up to: ");
	scanf  ("%d", &n);
	sum = calc_sum (n);
	printf ("Sum is %d\n", sum);
}

