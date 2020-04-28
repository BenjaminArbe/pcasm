# file: count4a.s
# to build: 	make X=13count4a D=13drcount L=-lstdc++
# to test:		./13count4a
# -----------------------------------------------------------------------------	
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

		.sect	.bss
# -----------------------------------------------------------------------------
byte_bit_count:		.zero		256			# lookup table		

		.sect	.text
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

		.func	count
		.type	count, @function
# ----------------------------------------------------------------------------
count:
# extern "C" int count(unsigned data);
# Description:	counts bits "on" in data.
# @param:		data (+8)
# @return:		number of bit "on" in data
		enter	$0, $0
		push	%ebx

		call	initialize_count_bits
		mov		$0, %eax			# clear EAX = accumulator
		mov		$4, %ecx			# loop counter
		mov		8(%ebp), %edx
1:		mov		%edx, %ebx
		and		$0xf, %ebx
		addb 	byte_bit_count(%ebx), %al
		shr		$4, %edx
		loop	1b		
		
		pop		%ebx
		leave
		ret
		.endfunc		
		.globl	count
		.end

# -----------------------------------------------------------------------------
unsigned char byte_bit_count[256];

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

int
count (unsigned int data) {
	const unsigned char *byte = (unsigned char *)&data;

	initialize_count_bits();

	return byte_bit_count[byte[0]] + byte_bit_count[byte[1]] +
			byte_bit_count[byte[2]] + byte_bit_count[byte[3]];
}
						

