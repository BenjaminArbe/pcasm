# to build use 13drcount.cpp
# make X=13count2 D=13drcount L=-lstdc++
# to test: ./13count2
		.file		"count2.s"
		.section	.text
		.func		count
		.type		count, @function
# -----------------------------------------------------------------------------
count:
# extern "C" int count(unsigned n);
# Description:	Counts the numbers of bits that are "on" in n.
# @param:		n	
# @return:		number of bits "on" in n
		enter	$0, $0
		push	%ebx

		mov		8(%ebp), %eax # EAX = n
		movb	$0, %bl		# BL = accumulator
		mov		$32, %ecx	# ECX = loop counter
1:		shll	$1, %eax	# shift into carry flag
		adcb	$0, %bl		# add w/carry flag
		loop	1b
		movzx	%bl, %eax

		pop		%ebx
		leave
		ret

		.endfunc
		.globl	count
		.end
