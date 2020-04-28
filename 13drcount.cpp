/* file: drcount.cpp
 * to build:	make X=13count1 D=13drcount L=-lstdc++
 * to test:		./count1
 */
#include <iostream>
#include <iomanip>
#include <string>

using std::cout;
using std::cin;
using std::hex;
using std::dec;
using std::string;
using std::invalid_argument;

extern "C" int count(unsigned);

int 
main(int argc, char **argv) {
	string s; unsigned int n = 0;

	try {
	cout << "Type a hex number(up to 4 bytes): ";
	cin >> s;
	for ( char c : s ) {
		if ( !isxdigit(c) ) throw invalid_argument("Not a hexadecimal number");
		n = n*16 + (isdigit(c) ? c - '0' : 
			(isupper(c) ? 0xa + c - 'A' : 0xa + c - 'a') );
	}
	cout << "The count of bits that are \"on\" in " << hex << n
		<< " are " << dec << count(n) << ".\n";
	}
	catch (const invalid_argument& e) {
		cout << e.what();
	}
}
