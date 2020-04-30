// To compile:
// g++ inheritance2.cpp -m32 -o inheritance2
// to run: ./inheritance2
#include <iostream>
#include <cstddef>
using namespace std;

class A {
	public:
	virtual void m1() { cout << "A::m1()" << endl; }
	virtual void m2() { cout << "A::m2()" << endl; }
	int	ad;
};

class B : public A {	// B inherits A's m2()
	public:
	virtual void m1() { cout << "B::m1()" << endl; }
	int bd;
};

/* prints the vtable of given object */
void
print_vtable (A *pa) {
	// p sees as an array of dwords
	unsigned *p = reinterpret_cast<unsigned*>(pa);
	// vt sees as an array of pointers 
	void **vt = reinterpret_cast<void **>(p[0]);
	cout << hex << "vtable address = " << vt << endl;
	for (int i = 0; i < 2; i++)
		cout << "dword " << i << ":" << vt[i] << endl;

	// call virtual functions in EXTREMELY non-portable way!
	void (*m1func_pointer)(A *);	// function pointer variable
	m1func_pointer = reinterpret_cast<void(*)(A*)>(vt[0]);
	m1func_pointer (pa);			// call method m1 via function pointer

	void (*m2func_pointer)(A *);	// function pointer variable
	m2func_pointer = reinterpret_cast<void(*)(A*)>(vt[1]);
	m2func_pointer(pa);				// call method m2 via function pointer
}

int
main() {
	A a; B b1; B b2;
	cout << "a: " << endl; print_vtable(&a);
	cout << "b1: " << endl; print_vtable(&b1);
	cout << "b2: " << endl; print_vtable(&b2);
}

