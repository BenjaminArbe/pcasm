/* file: endianness.cpp
 * to build X=14endian D=14endianness L=-lstdc++
 * to execute: ./14endian
 */
#include <iostream>
using std::cout;
using std::cin;
using std::hex;
using std::uppercase;

unsigned short n = 0x1234;
unsigned char* p = (unsigned char*)&n;

extern "C" unsigned invert_endian (unsigned);

int
main(int argc, char **argv) {
	bool eflag;			// true = little endian  false = big endian
	if ( p[0] == 0x12 ) {
		eflag = false;
		cout << "Big endian machine\n";
	} else {
		eflag = true;
		cout << "Little endian machine\n";
	}
	unsigned num;
	cout << "Enter a 4-byte hexadecimal: ";
	cin >> hex >> num;
	cout << hex << uppercase << "The number: " << num << " (" << 
		(eflag == true ? "little " : "big ") << "endian)\n";
	cout << hex << "inverted: " << invert_endian(num) << " (" << 
		(eflag == true ? "big " : "little ") << "endian)\n";
}
/*
unsigned
invert_endian (unsigned x) {
	unsigned invert;
	const unsigned char *xp = (const unsigned char *)&x;
	unsigned char * ip = (unsigned char *)&invert;

	ip[0] = xp[3];
	ip[1] = xp[2];
	ip[2] = xp[1];
	ip[3] = xp[0];

	return invert;
}*/
