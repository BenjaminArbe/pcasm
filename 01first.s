# File: first.s
# First assembly program. This program asks for two integers as input and
# prints out their sum.
# To compile:	make X=01first
# ============================================================================
		.include	"macros.inc"
		.section	.data

prompt1:	.asciz		"Enter a number: "
prompt2:	.asciz		"Enter another number: "
outmsg1:	.asciz		"You entered "
outmsg2:	.asciz		" and "
outmsg3:	.asciz		", the sum of these is "

		.section	.bss
input1:		.space		4
input2:		.space		4


		.section	.text
asm_main:
		enter	$0, $0			# setup routine
		pusha

		lea		prompt1, %eax	# print out prompt
		call	print_string

		call	read_int		# read integer
		mov		%eax, input1	# store into input1

		lea		prompt2, %eax	# print out prompt
		call	print_string

		call	read_int		# read integer
		mov		%eax, input2	# store into input2

		mov		input1, %eax
		add		input2, %eax	# eax = input1 + input2
		mov		%eax, %ebx		# ebx = eax

		dump_regs	$1			# print out registers
		dump_mem	$2, $outmsg1, $1 # print out memory

# Next print out result message as series of steps:
		lea		outmsg1, %eax
		call	print_string	# print out message
		mov		input1, %eax
		call	print_int		# print out input1
		lea		outmsg2, %eax
		call	print_string	# print out second message
		mov		input2, %eax	
		call	print_int		# print out input2
		lea		outmsg3, %eax
		call	print_string	# print out third message
		mov		%ebx, %eax		
		call	print_int		# print out sum
		call	print_nl		# print new_line

		popa
		mov		$0, %eax		# return back to C
		leave
		ret

		.globl	asm_main
		.end
