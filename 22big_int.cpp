#include "22big_int.hpp"
#include <iomanip>
#include <cstring>

Big_int::Big_int (size_t size, unsigned initial_value) : size_(size),
	number_(new unsigned[size]) {
	memset (number_, 0, size*sizeof(unsigned));
	number_[0] = initial_value;
}		


Big_int::Big_int (size_t size, const char* initial_value) : size_(size),
	number_(new unsigned[size]) {
	memset (number_, 0, size*sizeof(unsigned));
	char *p = (char*)initial_value;
	char *pe = p + strlen(p) - 4;
	char str[4];
	int k = 0;	
	while ( pe >= p ) {
		strncpy(str, pe, 4);
		//cout << str << "\n";
		number_[k++] = strtoul(str, NULL, 16);
		pe -= 4;
	}
	pe +=3;
	if ( pe >= p ) {			
		int i = 3;
		while ( pe >= p ) { str[i--] = *pe--; }
		while ( i>=0 ) str[i--] = '0';
		//cout << str << "\n";
		number_[k] = strtoul(str, NULL, 16);
	}		
}

const Big_int&
Big_int::operator=(const Big_int& b) {
	if ( this != &b ) {
		if ( size_ != b.size_ ) {
			size_ = b.size_;
			delete number_;
			number_ = new unsigned[size_];
		}
		memcpy(number_, b.number_, sizeof(unsigned)*size_);
	}
	return *this;
}

bool
Big_int::operator==(const Big_int& op) {
	if ( size_ != op.size_ ) throw Big_int::Size_mismatch();
	size_t i = 0;
	while ( i < size_ ) {
		if ( number_[i] != op.number_[i] ) return false;
		i++;
	}
	return true;
}

bool 
Big_int::operator>(const Big_int& op) {
	if ( size_ != op.size_ ) throw Big_int::Size_mismatch();
	int i = (int)size_; i--;
	for ( ; i >=0; i--)
		if ( number_[i] > op.number_[i] ) return true;
	return false;
}

ostream& 
operator<<(ostream& os, const Big_int& op) {
	//os << "size: " << op.size() << "\n";
	for (int i=(int)op.size()-1; i>=0; i--) {
		os << std::setfill('0') << std::right;
		os << std::hex << std::setw(4) << op.number_[i];
	}
	return os;
}




