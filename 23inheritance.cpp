// file: 23inheritance.cpp
// to build:	cc -m32 23inheritance.cpp -lstdc++ -o inh
//				./inh
#include <cstddef>			// for offsetof()
#include <iostream>
using namespace std;

class A {
	public:
	virtual void m() {
		cout << "A::m()" << endl;
	}
	int	ad;
};

class B : public A {
	public:
	virtual void m() {
		cout << "B::m()" << endl;
	}
	int	bd;
};

void
f (A *p) {
	p->ad = 5;
	p->m();
}

int
main(int argc, char **argv) {
	A a;
	B b;
	cout << "Size of a: " << sizeof(a)
		<< " Offset of ad: " << offsetof(A, ad) << endl;
	cout << "Size of b: " << sizeof(b)
		<< " Offset of ad: " << offsetof(B, ad)
		<< " Offset of bd: " << offsetof(B, bd) << endl;
	f(&a);
	f(&b);
}


