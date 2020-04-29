		.equ	ARRAY_SIZE, 100

		.section	.data
# ------------------------------------------------------------------------------
firstMsg:		.asciz		"First 10 elements of array"
prompt:			.asciz		"Enter index of element to display: "
secondMsg:		.asciz		"Element %d is %d\n"
thirdMsg:		.asciz		"Elements 20 through 29 of array"
inputFmt:		.asciz		"%d"

		.section	.bss
# ------------------------------------------------------------------------------
array:			.zero		100*4

		.section	.text
		.extern		dump_line
		.func		asm_main
		.type		asm_main, @function
# ------------------------------------------------------------------------------
asm_main:
		enter	$4, $0		# local int variable at EBP - 4
		push	%ebx
		push	%esi
		
# Initialize array to 100, 99, 98, 97, ...
		mov		$ARRAY_SIZE, %ecx
		lea		array, %ebx
1:		mov		%ecx, (%ebx)
		add		$4, %ebx
		loop	1b

		push	$firstMsg	# Print out 1st message
		call	puts
		add		$4, %esp

		push	$10
		push	$array
		call	print_array	# Print first 10 elements of array
		add		$8, %esp

# Prompt user for element index
2:		push	$prompt
		call	printf
		add		$4, %esp

		lea		-4(%ebp), %eax	# EAX = address of local int
		push	%eax
		push	$inputFmt
		call	scanf
		add		$8, %esp
		cmp		$1, %eax		# EAX = return value of scanf
		je		3f

		call	dump_line		# dump rest of line and start over
		jmp		2b				# if input invalid

3:		mov		-4(%ebp), %esi
		push	array(,%esi,4)
		push	%esi
		push	$secondMsg		# print out value of element
		call	printf
		add		$12, %esp

		push	$thirdMsg		# print out elements 20-29
		call	puts
		add		$4, %esp

		push	$10
		push	$array+20*4		# address of array[20]
		call	print_array
		add		$8, %esp


		pop		%esi
		pop		%ebx
		mov		$0, %eax	# return back to C
		leave
		ret
		.endfunc
		.globl	asm_main

		.section	.data
# ------------------------------------------------------------------------------
outFmt:		.asciz		"%-5d %5d\n"

		.section	.text
		.func	print_array
		.type	print_array, @function
# ------------------------------------------------------------------------------
print_array:
# extern "C" void print_array (const int *a, int n);
# Description:	C-callable routine that prints out elements of a int array as
#				signed integers.
# @param:	a 	pointer to array to print out (+8)
# @param:	n	number of integers to print out (+12)
		enter	$0, $0
		push	%esi
		push	%ebx

		xor		%esi, %esi				# ESI = 0
		mov		12(%ebp), %ecx			# ECX = n
		mov		8(%ebp), %ebx			# EBX = address of array
1:		push	%ecx					# printf might change ECX!
		push	(%ebx,%esi,4)			# push	array[ESI]
		push	%esi
		push	$outFmt
		call	printf
		add		$12, %esp

		inc		%esi
		pop		%ecx
		loop	1b

		pop		%ebx	
		pop		%esi
		leave
		ret
		.endfunc
		.end
		
