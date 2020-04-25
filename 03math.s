# This the example from Chaper 2 called math.asm
# To build:
#	make X=03math
# -----------------------------------------------------------------------------
		.include 	"macros.inc"

		.section	.data
# -----------------------------------------------------------------------------
# Output strings:
prompt:			.asciz		"Enter a number: "
square_msg:		.asciz		"Square of input is "
cube_msg:		.asciz		"Cube of input is "
cube25_msg:		.asciz		"Cube of input times 25 is "
quot_msg:		.asciz		"Quotient of cube/100 is "
rem_msg:		.asciz		"Remainder of cube/100 is "
neg_msg:		.asciz		"The negation of the remainder is "

		.section	.bss
# ------------------------------------------------------------------------------
input:			.zero		4

		.section	.text

		.func	asm_main
		.type	asm_main, @function
# ------------------------------------------------------------------------------
asm_main:
		enter	$0, $0				# setup routine
		pusha

		lea		prompt, %eax
		call	print_string

		call	read_int
		mov		%eax, input

		imul	%eax				# edx:eax = eax * eax
		mov		%eax, %ebx			# save answer in ebx
		lea		square_msg, %eax	
		call	print_string
		mov		%ebx, %eax
		call	print_int
		call	print_nl

		mov		%eax, %ebx
		imul	input, %ebx			# ebx *= *input
		lea		cube_msg, %eax
		call	print_string
		mov		%ebx, %eax
		call	print_int
		call	print_nl

		imul	$25, %ebx, %ecx		# ecx = ebx * 25
		lea		cube25_msg, %eax
		call	print_string
		mov		%ecx, %eax
		call	print_int
		call	print_nl

		mov		%ebx, %eax
		cdq							# initialize edx by sign extension
		mov		$100, %ecx			# can't divide by immediate value
		idiv	%ecx				# edx:eax / ecx
		mov		%eax, %ecx			# save quotient into ecx
		lea		quot_msg, %eax
		call	print_string
		mov		%ecx, %eax
		call	print_int
		call	print_nl
		lea		rem_msg, %eax
		call	print_string
		mov		%edx, %eax
		call	print_int
		call	print_nl

		neg		%edx				# negate the remainder
		lea		neg_msg, %eax
		call 	print_string
		mov		%edx, %eax
		call	print_int
		call	print_nl

		popa
		mov		$0, %eax			# return back to C
		leave
		ret

		.endfunc
		.globl	asm_main
		.end

