# file: sub4.s
		.include 	"macros.inc"

		.section	.data
# ------------------------------------------------------------------------------
prompt:		.asciz		") Enter an integer number (0 to quit): "

		.section	.text
		.func		get_int
		.type		get_int, @function
# ------------------------------------------------------------------------------
get_int:
# Description:	This function prompts the user to enter a number.
# @parameter:	Address to store the number. (+8)
# @parameter:	Number of input. (+12)
# @return:		None
		enter	$0, $0

		mov		12(%ebp), %eax
		call	print_int

		lea		prompt, %eax
		call	print_string

		call	read_int
		mov		8(%ebp), %ebx
		mov		%eax, (%ebx)

		leave
		ret
		.endfunc
		.globl	get_int

		.section	.data
# ------------------------------------------------------------------------------
msg:		.asciz	"The sum is: "
result:		.zero	4

		.section	.text
		.func		print_sum
		.type		print_sum, @function
# ------------------------------------------------------------------------------
print_sum:
# Description:	This function prints the number specified as parameter.
# @param:		integer to be printed. (+8)
# @return:		None
		enter	$0, $0
		
		lea		msg, %eax
		call	print_string
		
		mov		8(%ebp), %eax
		call	print_int
		call	print_nl

		leave
		ret
		.endfunc
		.globl	print_sum
		.end
