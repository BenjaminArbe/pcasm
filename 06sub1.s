# file: sub1.s
# To build:		make X=06sub1
# ------------------------------------------------------------------------------
		.include	"macros.inc"

		.section	.data
# ------------------------------------------------------------------------------
prompt1:	.asciz		"Enter a number: "
prompt2:	.asciz		"Enter another number: "
outmsg1:	.asciz		"You entered "
outmsg2:	.asciz		" and "
outmsg3:	.asciz		", the sum of these is "

		.section	.bss
# ------------------------------------------------------------------------------
input1:		.zero		4
input2:		.zero		4

		.section	.text
		.func		asm_main
		.type		asm_main, @function
# ------------------------------------------------------------------------------
asm_main:
		enter	$0, $0
		pusha

		lea		prompt1, %eax		# print first prompt
		call	print_string

		lea		input1, %ebx		# ebx = &input1
		lea		ret1, %ecx			# store return address into ecx
		jmp		get_int				# read integer
ret1:
		lea		prompt2, %eax		# print second prompt
		call	print_string
		
		lea		input2, %ebx		# ebx = &input2
		lea		. + 8, %ecx			# return address
		jmp		get_int

		mov		input1, %eax		# eax = input1
		add		input2, %eax		# eax += input2
		mov		%eax, %ebx

		lea 	outmsg1, %eax
		call	print_string		# print first message
		mov		input1, %eax
		call	print_int			# print out input1

		lea		outmsg2, %eax
		call	print_string		# print out second message
		mov		input2, %eax
		call	print_int			# print out input2

		lea		outmsg3, %eax
		call	print_string		# print out third message
		mov		%ebx, %eax
		call	print_int			# print out sum
		call	print_nl			# print new-line

		popa
		mov		$0, %eax			# return back to C
		leave
		ret

		.endfunc
		.globl	asm_main

# function: get_int
get_int:
# Description:	Retrieves an integer from keyboard.
# @param:		EBX - address of store the integer into
# @param:		ECX - address of instruction to return to
# Return:		None
		call	read_int
		mov		%eax, (%ebx)		# store input into memory
		jmp		*%ecx				# jump indirect (using address in ECX)
									# back to caller

		.end
		
