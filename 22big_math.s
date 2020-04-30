			.equ	size_offset, 		0
			.equ	number_offset, 		4

			.equ	EXIT_OK, 			0
			.equ	EXIT_OVERFLOW, 		1
			.equ	EXIT_SIZE_MISMATCH,	2

			.section	.text
			.func		add_big_ints
			.type		add_big_ints, @function
# ------------------------------------------------------------------------------
add_big_ints:
# extern "C" int add_big_ints (Big_int& res, const Big_int& op1, const Big_int& op2);
# Descritpion:	Adds two Big_int's.
# @param:		res	is where the result goes (+8)
# @param:		op1 is the first operand (+12)
# @param:		op2 is the second operand (+16)
# @return:		0  	success
#				1	overflow
#				2	size mismatch (can operate on operands of the same size only)
			enter	$0,	$0
			push	%ebx
			push	%esi
			push	%edi

# First  set up ESI to point op1
#				EDI to point op2
#				EBX to point res
			mov		12(%ebp), %esi
			mov		16(%ebp), %edi
			mov		 8(%ebp), %ebx

# Make sure that all 3 Big_int's have the same size:
			mov		size_offset(%esi), %eax
			cmp		size_offset(%edi), %eax
			jne		sizes_not_equal				# op1.size_ != op2.size_
			cmp		size_offset(%ebx), %eax
			jne		sizes_not_equal				# op1.size_ != res.size_
			
			mov		%eax, %ecx					# ECX = size of Big_int's

# Now, set registers to point to their respective arrays
#		ESI = op1.number_
#		EDI = op2.number_
#		EBX = res.number_
			mov		number_offset(%esi), %esi
			mov		number_offset(%edi), %edi
			mov		number_offset(%ebx), %ebx

			clc									# clear carry flag
			xor		%edx, %edx

# Addition loop:
add_loop:	mov		(%edi,%edx,4), %eax
			adc		(%esi,%edx,4), %eax
			mov		%eax, (%ebx,%edx,4)
			inc		%edx						# does not alter carry flag
			loop	add_loop

			jc		overflow
ok_done:
			xor		%eax, %eax					# return value = EXIT_OK
			jmp		done
overflow:
			mov		$EXIT_OVERFLOW, %eax
			jmp		done

sizes_not_equal:
			mov		$EXIT_SIZE_MISMATCH, %eax
done:			pop		%edi
			pop		%esi
			pop		%ebx
			leave
			ret
			.endfunc
			.globl	add_big_ints

			.section	.text
			.func		sub_big_ints
			.type		sub_big_ints, @function
# ------------------------------------------------------------------------------
sub_big_ints:
# extern "C" int sub_big_ints (Big_int& res, const Big_int& op1, const Big_int& op2);
# Descritpion:	Adds two Big_int's.
# @param:		res	is where the result goes (+8)
# @param:		op1 is the first operand (+12)
# @param:		op2 is the second operand (+16)
# @return:		0  	success
#				1	overflow
#				2	size mismatch (can operate on operands of the same size only)
			enter	$0,	$0
			push	%ebx
			push	%esi
			push	%edi

# First  set up ESI to point op1
#				EDI to point op2
#				EBX to point res
			mov		12(%ebp), %esi
			mov		16(%ebp), %edi
			mov		 8(%ebp), %ebx

# Make sure that all 3 Big_int's have the same size:
			mov		size_offset(%esi), %eax
			cmp		size_offset(%edi), %eax
			jne		sizes_not_equal				# op1.size_ != op2.size_
			cmp		size_offset(%ebx), %eax
			jne		ssizes_not_equal			# op1.size_ != res.size_
			
			mov		%eax, %ecx					# ECX = size of Big_int's

# Now, set registers to point to their respective arrays
#		ESI = op1.number_
#		EDI = op2.number_
#		EBX = res.number_
			mov		number_offset(%esi), %esi
			mov		number_offset(%edi), %edi
			mov		number_offset(%ebx), %ebx

			clc									# clear carry flag
			xor		%edx, %edx

# Substraction loop:
sub_loop:	mov		(%esi,%edx,4), %eax
			sbb		(%edi,%edx,4), %eax
			mov		%eax, (%ebx,%edx,4)
			inc		%edx						# does not alter carry flag
			loop	sub_loop

			jc		soverflow
sok_done:
			xor		%eax, %eax					# return value = EXIT_OK
			jmp		sdone
soverflow:
			mov		$EXIT_OVERFLOW, %eax
			jmp		sdone

ssizes_not_equal:
			mov		$EXIT_SIZE_MISMATCH, %eax
sdone:			pop		%edi
			pop		%esi
			pop		%ebx
			leave
			ret
			.endfunc
			.globl	sub_big_ints

			.end			
