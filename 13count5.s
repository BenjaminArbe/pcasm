# To build:		make X=13count5 D=13drcount L=-lstdc++
# 				./13count5
# ----------------------------------------------------------------------------
			.file	"13count5.s"

			.sect	.data
# ----------------------------------------------------------------------------
mask:		.int	0x55555555, 0x33333333, 0x0F0F0F0F, 0x00FF00FF, 0x0000FFFF

			.sect	.text
			.func	count
			.type	count, @function
# -----------------------------------------------------------------------------
count:
# extern "C" int count(unsigned x);
# Description:	calculates the bits "on" in x
# @param:		n
# @return:		number of bits "on" in n
		enter	$8, $0
		
		mov		8(%ebp), %eax
		mov		%eax, -4(%ebp)		# local variable(-4) = current x value
		mov		$0, %edx			# EDX = i = loop counter
		mov		$1, %ecx			# ECX = shift
1:		cmp		$5, %edx
		jae		2f
		mov		-4(%ebp), %eax
		and		mask(,%edx,4), %eax	# x & mask[i]
		mov		%eax, -8(%ebp)		# temp variable(-8)
		mov		-4(%ebp), %eax
		shr		%cl, %eax			# x >> shift
		and		mask(,%edx,4), %eax	# (x >> shift) & mask[i]
		add		-8(%ebp), %eax
		mov		%eax, -4(%ebp)

		inc		%edx				# i++
		shl		$1, %ecx			# shift*=2
		jmp		1b
2:		mov		-4(%ebp), %eax		
		leave
		ret
		.endfunc
		.globl	count
		.end
# -----------------------------------------------------------------------------
int
count_bits (unsigned int x) {
	static unsigned int mask[] = { 0x55555555, 0x33333333, 0x0F0F0F0F,
									0x00FF00FF, 0x0000FFFF };

	int i;
	int shift;		/* number of positions to shift to right */
	
	for (i=0, shift=1; i<5; i++, shift*=2)
		x = (x & mask[i]) + ((x >> shift) & mask[i]);
	return x;
}
