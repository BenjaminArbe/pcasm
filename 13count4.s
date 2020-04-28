		.file	"count4.s"

		.sect	.text
		.func	count_bytes
		.type	count_bytes, @function
# -----------------------------------------------------------------------------
count_bytes:
# extern "C" int count_bytes(unsigned n);
# Description:	count bits turn "on" in an unsigned
# @param:		unsigned int n (+8)
# @return:		number of bits turn "on" in n.
		enter 	$4, $0
		mov		8(%ebp), %ecx
		mov		%ecx, -4(%ebp)		# copy 'n' in local variable

		mov		$0, %eax			# EAX = cnt
1:		cmp		$0, -4(%ebp)
		je		2f
		mov		-4(%ebp), %ecx
		dec		%ecx
		and		%ecx, -4(%ebp)
		inc		%eax
		jmp		1b

2:		leave
		ret
		
		.endfunc


		.func	initialize_count_bits
		.type	initialize_count_bits, @function
# ------------------------------------------------------------------------------
initialize_count_bits:
# extern "C" void initializando_count_bits(void);
# Description:	initialize byte_bit_count array.
# @return:		None
		enter	$0, $0

		mov		$255, %ecx			# ECX = loop counter & array index	
1:		push	%ecx								
		call	count_bytes		
		pop		%ecx
		movb	%al, byte_bit_count(%ecx) 	# store the result into the array
		loop	1b		
	
		leave
		ret

		.endfunc
		.globl	initialize_count_bits
		.end

# -----------------------------------------------------------------------------
void
initialize_count_bits () {
	unsigned cnt, i, data;

	for (i=0; i<256; i++) {		
		cnt = 0;
		data = i;
		while( data != 0 ) {	
			data = data & (data-1);
			cnt++;
		}

		byte_bit_count[i] = cnt;
	}
}
						

