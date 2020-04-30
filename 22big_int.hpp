#ifndef _big_int_
#define _big_int_

#include <iostream>

using std::ostream;

class Big_int;

// prototypes for assembly routines:
extern "C" {
	int add_big_ints (	Big_int&		res,
						const Big_int& 	op1,
						const Big_int& 	op2);
	int sub_big_ints (	Big_int&		res,
						const Big_int&	op1,
						const Big_int&	op2);
}

class Big_int {
	public:
	// Exception classes
	class Overflow { };
	class Size_mismatch { };

	public:
	// Constructor 1:
	// @param:	size - size of integer expressed as number of normal unsigned int's
	// @param:	initial_value - initial value of Big_int as a normal unsigned int	
	explicit Big_int (size_t size, unsigned initial_value = 0);

	// Constructor 2:
	// @param: 	size - size of integer expressed as number of normal unsigned int's
	// @param:	initial_value - initial value of Big_int as a string holding
	//			hexadecimal representation value.
	Big_int (size_t size, const char* initial_value);

	// Copy constructor:
	Big_int (const Big_int& big_int_to_copy);

	// Destructor:
	~Big_int () { delete number_; }

	// Returns size of Big_int (in terms of unsigned int's)
	size_t size() const { return size_; }


	const Big_int& operator=(const Big_int& big_int_to_copy);
	friend Big_int operator+(const Big_int& op1, const Big_int& op2);
	friend Big_int operator-(const Big_int& op1, const Big_int& op2);
	bool operator==(const Big_int& op);
	bool operator>(const Big_int& op);
	friend ostream& operator<<(ostream& os, const Big_int& op);
			
	private:
	size_t		size_;			// size of unsigned array
	unsigned*	number_;		// pointer to unsigned array holding value
};

inline Big_int
operator+( const Big_int& op1, const Big_int& op2) {
	Big_int result(op1.size());

	int res = add_big_ints( result, op1, op2);
	if ( res == 1 )
		throw Big_int::Overflow();
	if ( res == 2 )
		throw Big_int::Size_mismatch();
	return result;
}

inline Big_int
operator-( const Big_int& op1, const Big_int& op2) {
	Big_int result(op1.size());

	int res = sub_big_ints( result, op1, op2);
	if ( res == 1 )
		throw Big_int::Overflow();
	if ( res == 2 )
		throw Big_int::Size_mismatch();
	return result;
}

#endif
