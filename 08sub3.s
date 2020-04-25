# file: sub3.s
# to build:		make X=sub3
# -----------------------------------------------------------------------------
		.include	"macros.inc"

		.section	.data
# -----------------------------------------------------------------------------
sum:	.long		0

		.section	.bss
# -----------------------------------------------------------------------------
input:	.zero		4

		.section	.text
		.func		asm_main
		.type		asm_main, @function
/* ****************************************************************************
 * pseudo-code algorithm
 * i = 1;
 * sum = 0;			8     12
 * while ( get_int(&input, i), input != 0 ) {
 *		sum += input;
 *		i++;
 * }
 * print_sum(sum);
 ******************************************************************************/
asm_main:
		enter	$0, $0			# setup routine
		pusha

		mov		$1, %edx		# EDX = i
wloop:	push	%edx			# save i on stack
		push	$input			# push address of input on stack
		call	get_int	
		add		$8, %esp		# remove i  and &input from stack	
		mov		input, %eax
		cmp		$0, %eax
		je		eloop

		add		%eax, sum		# sum += input
		
		inc		%edx			# i++
		jmp		wloop

eloop:	push	sum				# push sum
		call	print_sum
		pop		%ecx			# remove sum from stack

		popa
		leave
		ret

		.endfunc
		.globl	asm_main
		
		.section	.data
# -------------------------------------------------------------------------------
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
		push	%ebp
		mov		%esp, %ebp

		mov		12(%ebp), %eax
		call	print_int

		lea		prompt, %eax
		call	print_string

		call	read_int
		mov		8(%ebp), %ebx
		mov		%eax, (%ebx)		# store input into memory
		
		pop		%ebp
		ret
		.endfunc

		.section	.data
# ----------------------------------------------------------------------------
result:		.asciz		"The sum is "

		.section	.text
		.func		print_sum
		.type		print_sum, @function
# -----------------------------------------------------------------------------
print_sum:
# Description:	This function prints the number specified as parameter.
# @param:		integer to be printed. (+8)
# @return:		None
		push	%ebp
		mov		%esp, %ebp

		lea		result, %eax
		call	print_string

		mov		8(%ebp), %eax
		call	print_int
		call	print_nl

		pop		%ebp
		ret
		.endfunc
		.end




