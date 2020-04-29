// To compile:
// make X=19prime2 D=19fprime
// to execute: ./19prime2
#include <cstdio>
#include <cstdlib>

/* 
 * function: find_primes
 * finds the indicated number of primes
 * @param:	a  array to hold primes
 * @param:	n  how many primes to find
 */
extern "C" void find_primes (int *a, unsigned n);

int
main (int argc, char** argv) {
	int status;
	unsigned i;
	unsigned max;
	int	*a;

	printf ("How many primes do you wish to find? ");
	scanf  ("%u", &max);

	a = (int *)calloc (sizeof(int), max);

	if ( a ) {
		find_primes (a, max);

		/* print out the last 20 primes found */
		for (i = (max > 20)?max-20:0; i<max; i++)
			printf ("%3d %d\n", i+1, a[i]);
		
		free (a);
		status = 0;
	} else {
		fprintf (stderr, "Can not create array of %u ints\n", max);
		status = 1;
	}
	return status;
}

