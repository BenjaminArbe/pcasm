			.file		"count1.s"
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

		mov		8(%ebp), %eax	# EAX = n
		movb	$0, %bl			# BL will contain the count
		mov		$32, %ecx		# ECX = loop counter
1:		shll	$1, %eax		# shift bit into carry flag
		jnc		2f				# if CF == 0, skip increase BL
		incb	%bl
2:		loop	1b
		movzx	%bl, %eax		
		pop		%ebx
		leave
		ret

		.endfunc
		.globl	count
		.end

		
