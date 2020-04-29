			.section	.data
# ------------------------------------------------------------------------------
format:		.asciz		"%lf"			# format for fscanf()

			.section	.text
			.func		read_doubles
			.type		read_doubles, @function
# ------------------------------------------------------------------------------
read_doubles:
# extern "C" int read_doubles (FILE *fp, double *arrayp, int array_size);
# Description:	This function reads doubles from a text file into an array,
#				until EOF or array is full.
# @param:		fp 			- FILE pointer to read from. (+8)
# @param:		arrayp 		- pointer to double array to read into (+12)
# @param:		array_size 	- number of elements in array. (+16)
# @return:		number of doubles stored into the array (in EAX)
		
			enter	$8, $0			# one local double
			push	%esi

			mov		12(%ebp), %esi	# ESI = arrayp
			xor		%edx, %edx	 	# EDX = array index	

wloop:		cmp		16(%ebp), %edx	# is !(EDX < array_size) ?
			jnl		quit	

# Call fscanf() to read a double into our local variable:
# fscanf might change EDX so save it
			push	%edx
			lea		-8(%ebp), %eax
			push	%eax			# push	&temp
			push	$format			# push  &format
			push	8(%ebp)			# push FP
			call	fscanf
			add		$12, %esp
			pop		%edx			# restore EDX
			cmp		$1, %eax		# did fscanf return 1?
			jne		quit			# if not quit
			
# copy temp into arrayp[EDX]:
# (the 8-bytes of the double are copied by two 4-byte copies)
			mov		-8(%ebp), %eax
			mov		%eax, (%esi,%edx,8)		# first copy lowest 4 bytes
			mov		-4(%ebp), %eax
			mov		%eax, 4(%esi,%edx,8)	# next copy highest 4 bytes

			inc		%edx
			jmp		wloop

	
quit:		pop		%esi
			mov		%edx, %eax		# store return value into EAX
			leave
			ret
			.endfunc
			.globl	read_doubles
			.end
