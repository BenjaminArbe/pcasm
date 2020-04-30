/* file: 20dmaxc.cpp
 * to build:	make X=20dmax D=20dmaxc L=-lstdc++
 *				./20dmax
 */
#include <iostream>
using std::cout;

extern "C" double dmax(double, double);

int
main(int argc, char **argv) {
	double d1 = 1.56, d2 = 10.23, d3 = 0.52;

	cout << "max (d1=" << d1 << ", d2=" << d2 << ") = " << dmax(d1, d2) << "\n";
	cout << "max (d2=" << d2 << ", d3=" << d3 << ") = " << dmax(d2, d3) << "\n";
	cout << "max (d3=" << d3 << ", d1=" << d1 << ") = " << dmax(d3, d1) << "\n";
}

