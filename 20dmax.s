			.file 	"20dmax.s"
			
			.sect	.text
			.func	dmax
			.type	dmax, @function
# ------------------------------------------------------------------------------
dmax:
# extern "C" double dmax (double d1, double d2);
# Description:	returns the larger of its two double arguments.
# @param:		d1	first double (+8)
# @param:		d2	second double(+16)
# @return:		larger of d1 and d2 (in ST0)
			enter	$0, $0

			fldl	16(%ebp)
			fldl	8(%ebp)				# STACK: d1, d2
			fcomip	%st(1)				# STACK: d2
			jna		d2_bigger			# d1 < d2
			fcomp	%st(0)				# pop d2 from stack
			fldl	8(%ebp)				# STACK: d1
			jmp		exit
d2_bigger:								# if d2 is max, nothing to do
exit:
			leave
			ret
			.endfunc
			.globl	dmax
			.end

