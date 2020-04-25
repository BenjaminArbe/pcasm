# file: max.s
# to build:	make X=05max
# ------------------------------------------------------------------------------
		.include	"macros.inc"
		
		.section	.data
# ------------------------------------------------------------------------------
mesg1:		.asciz		"Enter a number: "
mesg2:		.asciz		"Enter another number: "
mesg3:		.asciz		"The largest number is: "

		.section	.bss
# ------------------------------------------------------------------------------
input1:		.zero		4			# first number entered

		.section	.text
		.func		asm_main
		.type		asm_main, @function
asm_main:
		enter	$0, $0				# setup routine
		pusha

		lea		mesg1, %eax			# print out first message
		call	print_string
		call	read_int			# input first number
		mov		%eax, input1

		lea		mesg2, %eax			# print out second message
		call	print_string
		call	read_int			# input second number
		
		xor		%ebx, %ebx
		cmp		input1, %eax		# compare second and first number
		setg	%bl					# ebx = (input2 > input1) ? 1 : 0
		dump_regs $1
		# negate is: if it is 1 the neg is -1 or 0xFFFFFFFF
		neg		%ebx				# ebx = (input2 > input1) ? 0xFFFFFFFF : 0
		dump_regs $2
		mov		%ebx, %ecx			# ecx = (input2 > input1) ? 0xFFFFFFFF : 0
		and		%eax, %ecx			# ecx = (input2 > input1) ? 	input2 : 0
		not		%ebx				# ebx = (input2 > input1) ? 		 0 : 0xFFFFFFFF
		and		input1, %ebx		# ebx = (input2 > input1) ?          0 : input1
		or		%ebx, %ecx			# ecx = (input2 > input1) ?     input2 : input1

		lea		mesg3, %eax			# print out result
		call	print_string
		mov		%ecx, %eax
		call	print_int
		call	print_nl

		popa
		mov		$0, %eax			# return back to C++
		leave
		ret

		.endfunc
		.globl	asm_main
		.end
