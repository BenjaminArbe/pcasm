/*
 * This program tests the 32-bit read_doubles() assembly procedure.
 * It reads the doubles from stdin. (Use redirection to read from file.)
 *
 * To compile:
 *	make X=18read D=18readt
 * 	to execute: ./18read
 *   or  ./18read < doubles.txt
 */
#include <cstdio>

extern "C" int read_doubles( FILE*, double*, int);
#define MAX	100

int
main(int argc, char** argv) {
	int i, n;
	double a[MAX];

	n = read_doubles(stdin, a, MAX);

	for (i = 0; i<n; i++)
		printf("%3d %g\n", i, a[i]);
}

