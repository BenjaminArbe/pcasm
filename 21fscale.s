# to build:		make X=21fscale
#				./21fscale
# -----------------------------------------------------------------------------
			.file	"21fscale.s"
			.include "macros.inc"

			.sect	.data
# -----------------------------------------------------------------------------
x:			.double		2.75
five:		.int		5
fmt:		.asciz		"Result of %g * 2^%d = %g\n"


			.sect	.text
			.func	asm_main
			.type	asm_main, @function
# -----------------------------------------------------------------------------
asm_main:
			enter	$8, $0
	
			fildl	five			# STACK: ST0=5
			fldl	x				# STACK: ST0=2.75, ST1=5
			fscale					# STACK: ST0=2.75 * 32, ST1=5
			fstpl	-8(%ebp)		# STACK: 5
			ffree	%st(0)			# STACK: empty
			dump_math $1

			push	-4(%ebp)
			push	-8(%ebp)
			push	five
			push	x+4
			push	x
			push	$fmt
			call	printf
			add		$24, %esp
			
			leave
			ret
			.endfunc
			.globl	asm_main
			.end			
