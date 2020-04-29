// To compile:
// make X=17quad D=17quadt
// 		./17quad
#include <cstdio>

extern "C" int quadratic (double, double, double, double*, double*);

int
main (int argc, char **argv) {
	double a, b, c, root1, root2;

	printf ("Enter a, b, c: ");
	scanf  ("%lf %lf %lf", &a, &b, &c);
	if ( quadratic( a, b, c, &root1, &root2 ) )
		printf ("roots: %.10g %.10g\n", root1, root2);
	else
		printf ("No real roots\n");
}

