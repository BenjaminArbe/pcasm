# This is our skeleton from which we start
# To build:
# make X=02skeleton
# -----------------------------------------------------------------------------
		.include "macros.inc"

		.section	.data
# -----------------------------------------------------------------------------
# Initialized data is put in the data segment here
# -----------------------------------------------------------------------------

		.section	.bss
# -----------------------------------------------------------------------------
# Uninitialized data is put in the bss segment
# -----------------------------------------------------------------------------

		.section	.text
		
		.func	asm_main
		.type	asm_main, @function
asm_main:
		enter	$0, $0			# setup routine
		pusha

# Code is put in the text segment. Do not modify the code before or after
# this comment.

		popa
		mov		$0, %eax		# return back to C++
		leave
		ret

		.endfunc
		.globl	asm_main
		.end	
	
