/* file: factorial.cpp
 * to build:	make X=12fact D=12factorial L=-lstdc++
 * to execute:  ./12fact
 */
#include <iostream>
#include <iomanip>
using std::cout;
using std::setw;

extern "C" int fact(int n);

int 
main (int argc, char **argv) {
	int i = 0;
	cout << "List of first 10 factorials: \n";
	while (i < 10) {
		cout << setw(4) << i << ": "
			<< setw(10) << fact(i++) << "\n";
	}
}
