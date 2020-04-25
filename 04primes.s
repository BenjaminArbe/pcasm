# File: primes.s
# To build:		make X=04primes
# ------------------------------------------------------------------------------
		.include	"macros.inc"

		.section	.data
# ------------------------------------------------------------------------------
message:		.asciz		"Find primes up to: "

		.section	.bss
# ------------------------------------------------------------------------------
limit:			.zero		4		# find primes up to this limit
guess:			.zero		4		# the current guess for prime

		.section	.text
		.func		asm_main
		.type		asm_main, @function
asm_main:
		enter	$0, $0			# setup routine
		pusha

		lea		message, %eax
		call	print_string
		call	read_int		# scanf ("%u", &limit)
		mov		%eax, limit
		mov		$2, %eax		# printf ("2\n");
		call	print_int
		call	print_nl
		mov		$3, %eax		# printf ("3\n");
		call	print_int
		call	print_nl

		movl	$5, guess		# guess = 5;
wlimit:							# while ( guess <= limit )
		mov		guess, %eax
		cmp		limit, %eax
		jnbe	elimit			# use jnbe since numbers are unsigned

		mov		$3, %ebx		# ebx is factor = 3
wfactor:
		mov		%ebx, %eax
		mul		%eax			# edx:eax = eax*eax
		jo		efactor			# if answer won't fit in eax alone
		cmp		guess, %eax
		jnb		efactor			# if !(factor*factor < guess)
		mov		guess, %eax		# eax = guess
		mov		$0, %edx
		div		%ebx			# edx = edx:eax % ebx
		cmp		$0, %edx
		je		efactor			# if !(guess % factor != 0)
		
		add		$2, %ebx		# factor != 2
		jmp		wfactor
efactor:
		je		end_if			# if !(guess % factor != 0)
		mov		guess, %eax		# printf ("%u\n")
		call	print_int
		call	print_nl
end_if:
		add		$2, guess		# guess += 2
		jmp		wlimit
elimit:

		popa
		mov		$0, %eax		# return back to C
		leave
		ret
		.endfunc
		.globl	asm_main
		.end
---------------------------------------------------------------------------------
#include <cstdio>

unsigned guess;				// Current guess for prime
unsigned factor;			// Possible factor of guess
unsigned limit;				// Find primes up to this value

int
main(int argc, char** argv) {
	printf ("Find primes up to: ");
	scanf ("%u", &limit);
	printf ("2\n");			// treat first two primes as
	printf ("3\n");			// special case
	guess = 5;				// initial guess
	
	while ( guess <= limit ) {
		// look for a factor of guess
		factor = 3;
		while ( factor * factor < guess && guess % factor != 0 ) factor += 2;
		if ( guess % factor != 0 )
			printf ("%d\n", guess);
		guess += 2;		// only look at odd number 
	}
}
			
