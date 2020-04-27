		.file	"endian.s"
		.section	.text
		.func		invert
		.type		invert, @function
# ----------------------------------------------------------------------------
invert_endian:
# extern "C" unsigned invert_endian(unsigned int);
# Description:	invert the endianness of a number.
# @param:		number to invert
# @return:		the inverted number
		push	%ebp
		mov		%esp, %ebp
		mov		8(%ebp), %eax
		bswap	%eax
		pop		%ebp
		ret

		.endfunc
		.globl	invert_endian
		.end

