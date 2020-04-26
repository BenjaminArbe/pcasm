			.file 	"fact.s"
			.sect	.text
			.func	fact
			.type	fact, @function
# ------------------------------------------------------------------------------
fact:
# extern "C" int fact(int n);
# Description:	recursive calculation of factorial of number n.
# @param:		n  the integer we want to get it's factorial (+8)
# @return:		the result.
		enter	$0, $0

		mov		8(%ebp), %eax		# EAX = n
		cmp		$1, %eax
		jbe		base_case
		dec		%eax
		push	%eax
		call	fact				# EAX = fact(n-1)
		add		$4, %esp
		mull	8(%ebp)				# EDX:EAX = n * fact(n-1)
		jmp		recurse			
			
base_case:	mov	$1, %eax
recurse:
		leave
		ret

		.endfunc
		.globl	fact
		.end
