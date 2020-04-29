			.include 	"macros.inc"
			
			.section	.text
			.func		find_primes
			.type		find_primes, @function
# -----------------------------------------------------------------------------
find_primes:
# extern "C" void find_primes(int *array, unsigned n_find);
# Description:	finds the indicated number of primes.
# @param:	array	- array to hold primes (+8)
# @param:	n_find	- how many primes to find (+12)
# @return:		None.
			enter	$12, $0			# make room for local variables
									# (-4) number of primes found so far (n)
									# (-8) floor of sqrt of guess (isqrt)
									# (-10) original control word
									# (-12) new control word
			push	%ebx
			push	%esi

			fstcw	-10(%ebp)		# get current control word
			mov		-10(%ebp), %ax
			or		$0x0C00, %ax	# set rounding bits to 11 (truncate)
			mov		%ax, -12(%ebp)
			fldcw	-12(%ebp)

			mov		8(%ebp), %esi	# ESI = points to array
			movl	$2, (%esi)		# array[0] = 2
			movl	$3, 4(%esi)		# array[1] = 3
			mov		$5, %ebx		# EBX = guess = 5
			movl	$2, -4(%ebp)	# n = 2

# This outer loop finds a new prime each iteration, which it adds to the 
# end of the array. Unlike the earlier prime finding program, this function
# does not determine primeness by dividing by all odd numbers. It only
# divides by the prime numbers that it has already found. (that's why they
# are stored in the array.)
while_limit:
			mov		-4(%ebp), %eax
			cmp		12(%ebp), %eax	# while ( n < n_find )
			jnb		quit_limit

			mov		$1, %ecx		# ECX is used as array index
			push	%ebx			# store guess on stack
			fild	(%esp)			# load guess onto coprocessor stack
			pop		%ebx			# get guess off stack
			fsqrt					# find  sqrt(guess)
//dump_math $1
			fistpl	-8(%ebp)		# isqrt = floor(sqrt(guess))
//dump_regs $1
//dump_mem $1, %ebp, $1

# This inner loop divides guess (EBX) by earlier computed prime numbers
# until it finds a prime factor of guess (which means guess is not prime)
# or until the prime number to divide is greater than floor(sqrt(guess))
while_factor:
			mov		(%esi,%ecx,4), %eax	# EAX = array[ECX]
			cmp		-8(%ebp), %eax	# while (isqrt < array[ECX]
			jnbe	quit_factor_prime
			mov		%ebx, %eax
			xor		%edx, %edx
			divl	(%esi,%ecx,4)
			or		%edx, %edx		# && guess % array[ECX] != 0
			jz		quit_factor_not_prime
			inc		%ecx			# try next prime
			jmp		while_factor

# found a new prime:
quit_factor_prime:
			mov		-4(%ebp), %eax	# EAX = n
			mov		%ebx, (%esi,%eax,4) # add guess to end of array
			inc		%eax
			mov		%eax, -4(%ebp)	# n++

quit_factor_not_prime:
			add		$2, %ebx		# try next odd number
			jmp		while_limit		
			

quit_limit:
			fldcw	-10(%ebp)		# restore control word		
			pop		%esi
			pop		%ebx
			leave
			ret
			.endfunc
			.globl	find_primes
			.end
