# file: sub5.s
		.include 	"macros.inc"

		.section	.text
		.func		calc_sum
		.type		calc_sum, @function
# -----------------------------------------------------------------------------
calc_sum:
# Description:	Finds the sum of the integers 1 through n
# @param:		n 		what to sum up to (+8)
# @param:		sump	pointe to int to store sum into (+12)
# @return:		None
#
# pseudo-code:
#	void calc_sum (int n, int* sump) {
#		int i, sum = 0;
#		for ( i=1; i<=n; i++)
#			sum += i;
#		*sump = sum;
#	}
# local variable:
#	sum @ -4(%ebp)
		enter	$4, $0				# make room for sum on stack
		push	%ebx				# IMPORTANT!

		movl	$0, -4(%ebp)		# sum = 0
		dump_regs	$1
		dump_stack	$1, $2, $4		# print out stack from EBP-8 to EBP+16
		mov		$1, %ecx			# ECX = i
floop:	
		cmp		8(%ebp), %ecx		# !(i <= n)
		jnle	eloop

		add		%ecx, -4(%ebp)		# sum += i
		inc		%ecx
		jmp		floop

eloop:	mov		12(%ebp), %ebx		# EBX = sump
		mov		-4(%ebp), %eax		# EAX = sum
		mov		%eax, (%ebx)

		pop		%ebx				# restore EBX
		leave
		ret
		.endfunc
		.globl	calc_sum
		.end

