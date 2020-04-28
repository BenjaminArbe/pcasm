# To build: make X=13count3 D=13drcount L=-lstdc++
# to test:	./13count3
# -----------------------------------------------------------------------------
		.file	"count3.s"

		.sect	.text
		.func	count
		.type	count, @function
# -----------------------------------------------------------------------------
count:
# extern "C" int count(unsigned int data);
# Description:	count bits that are "on" in data.
# @param:		data (+8)
# @return:		the numbers of bits that are "on"
		enter	$0, $0
		
		mov		$0, %eax		# EAX = cnt
1:		mov		8(%ebp), %ecx	# ECX = data
		cmp		$0, %ecx
		je		2f
		dec		%ecx
		and		%ecx, 8(%ebp)
		inc		%eax
		jmp		1b
2:
		leave
		ret

		.endfunc
		.globl	count
		.end
# -----------------------------------------------------------------------------

int
count_bits (unsigned int data) {
	int cnt = 0;
	
	while ( data != 0 ) {
		data & (data - 1);
		cnt++;
	}
	return cnt;
}
