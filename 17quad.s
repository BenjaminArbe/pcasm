			.include 	"macros.inc"

			.section	.data
# ------------------------------------------------------------------------------
minus4:		.long		-4

			.section	.text
			.func		quadratic
			.type		quadratic, @function
# ------------------------------------------------------------------------------
quadratic:
# extern "C" int quadratic (double a, double b, double c,
#							double *root1, double *root2);
# Description:	finds solutions to the quadratic equation:
#				a*x^2 + b*x + c = 0
# @param:		a (+8), b (+16), c (+24) coefficients of the quatratic equation
# @param:		root1 (+32) pointer to double that stores 1st root
# @param:		root2 (+36) pointer to double that stores 2nd root
# @return:		1 if real roots found
#			 	0 else
		enter	$16, $0
		push	%ebx				# must save original EBX

		fild	minus4				# STACK: -4
		fldl	8(%ebp)				# STACK: a, -4
		fldl	24(%ebp)			# STACK: c, a, -4
//dump_math $2				
		fmulp						# STACK: a*c, -4
		fmulp						# STACK: -4*a*c

		fldl	16(%ebp)			# STACK: b, -4*a*c
		fldl	16(%ebp)			# STACK: b, b, -4*a*c
		fmulp						# STACK: b*b, -4*a*c
		faddp						# STACK: b*b - 4*a*c

		ftst						# test with 0
		fstsw	%ax
		sahf
		jb		nreal				# if disc < 0, no real solutions
		fsqrt						# STACK: sqrt(b*b - 4*a*c)
		
		fstpl	-8(%ebp)			# STACK: 		; disc = store in -8(%ebp)
		fld1						# STACK: 1.0
		fldl	8(%ebp)				# STACK: a, 1.0
		fscale						# STACK: a * 2^(1.0), 1.0
		fxch						# STACK: 1.0, a*2				
		fdivp						# STACK: 1/(2*a)

		fstl	-16(%ebp)			# STACK: 1/(2*a) ; store in -16(%ebp)
		fldl	16(%ebp)			# STACK: b, 1/(2*a)
		fchs						# STACK: -b, 1/(2*a)
		fldl	-8(%ebp)			# STACK: disc, b, 1/(2*a)
		faddp						# STACK: disc-b, 1/(2*a)
		fmulp						# STACK: (-b + disc)/(2*a)

		mov		32(%ebp), %ebx
		fstpl	(%ebx)				# store in *root1
		fldl	16(%ebp)			# STACK: b
		fchs						# STACK: -b
		fldl	-8(%ebp)			# STACK: disc, -b

		fchs						# STACK: -disc, -b
		faddp						# STACK: -disc - b

		fmull	-16(%ebp)			# STACK: (-b - disc)/(2*a)
dump_math	$1
		mov		36(%ebp), %ebx		# store in *root2
		fstpl	(%ebx)
		mov		$1, %eax			# return value is 1
		jmp		quit	

nreal:
		mov		$0, %eax			# return value is 0
quit:
		pop		%ebx
		leave
		ret	
		.endfunc
		.globl	quadratic
		.end
