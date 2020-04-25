# file: main4.s
# This module depends on sub4.s
# To compile:
#   make X="09main4 09sub4"
# to test:	./09main4
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
# -----------------------------------------------------------------------------
asm_main:
		enter	$0, $0
		pusha
	
		mov		$1, %edx			# EDX = i
wloop:	push	%edx				# save i on stack
		push	$input				# push input address
		call	get_int
		add		$8, %esp			# remove i and &input from stack

		mov		input, %eax
		cmp		$0, %eax
		je		eloop

		add		%eax, sum			# sum += input

		inc		%edx
		jmp		wloop

eloop:	push	sum					# push sum
		call	print_sum
		pop		%ecx				# remove sum from stack

		popa
		leave
		ret
		.endfunc
		.globl	asm_main
		.end

