			.section	.text
			.func		asm_copy
			.type		asm_copy, @function
# -----------------------------------------------------------------------------
asm_copy:
# extern "C" void asm_copy (void* dest, const void* src, unsigned sz);
# Description:	Copies a block of memory
# @param:		dest	pointer to buffer to copy to (+8)
# @param:		src		pointer to buffer to copy from (+12)
# @param:		sz		number of bytes to copy	(+16)
# @return:		None
		enter 	$0, $0
		push	%esi
		push	%edi

		mov		12(%ebp), %esi
		mov		8(%ebp),  %edi
		mov		16(%ebp), %ecx

		cld				# clear direction flag
		rep		movsb

		pop		%edi
		pop		%esi
		leave
		ret
		.endfunc
		.globl	asm_copy

		.func		asm_find
		.type		asm_find, @function
# ------------------------------------------------------------------------------
asm_find:
# extern "C" void* asm_find (const void* src, char target, unsigned sz);
# Description:	Searches memory for a given byte.
# @param:		src		pointer to search for		(+8)
# @param:		target	byte value to search for	(+12)
# @param:		sz		number of bytes in buffer	(+16)
# @return:		If target is found, pointer to first occurrence of target in
#				buffer is returned.
#				ELSE  NULL is returned.
		enter	$0, $0
		push	%edi

		mov		12(%ebp), %eax		# AL has value to search for
		mov		8(%ebp),  %edi		
		mov		16(%ebp), %ecx
		cld

		repne	scasb				# scan until ECX == 0 or [ES:EDI] == AL
	
		je		found_it			# if ZF set, then found value
		mov		$0, %eax			# if not found, return NULL pointer
		jmp		quit
found_it:	mov	%edi, %eax
		dec		%eax				# if found return (DI - 1)
quit:	
		pop		%edi
		leave	
		ret
		.endfunc
		.globl	asm_find


		.func	asm_strlen
		.type	asm_strlen, @function
# -----------------------------------------------------------------------------
asm_strlen:
# extern "C" unsigned asm_strlen (const char* src);
# Description:	return the size of a string.
# @param:		src		pointer to string (+8)
# @return:		number of chars in string (not counting, ending 0)
		enter	$0, $0
		push	%edi

		mov		8(%ebp), %edi		# EDI = points to src
		mov		$0xFFFFFFFF, %ecx	# ECX = use the largest posible
		xor		%al, %al			# AL = 0
		cld	

		repnz	scasb				# scan for terminating 0

# repnz will go one step too far, so length is FFFFFFFE - ECX
# not FFFFFFFF - ECX
		mov		$0xFFFFFFFE, %eax
		sub		%ecx, %eax			# length = 0FFFFFFFE - ECX
		pop		%edi
		leave
		ret
		.endfunc
		.globl	asm_strlen

		
		.func	asm_strcpy
		.type	asm_strcpy, @function
# ------------------------------------------------------------------------------
asm_strcpy:
# extern "C" void asm_strcpy (char *dest, const char* src);
# Description:	copies a string
# @param:	dest	pointer to string to copy to (+8)
# @param:	src		pointer to string to copy from (+12)
# @return:	None
		enter	$0, $0
		push	%esi
		push	%edi

		mov		8(%ebp), %edi
		mov		12(%ebp),%esi
		cld
cploop:
		lodsb					# load AL & inc SI
		stosb					# store AL & inc DI
		or		%al, %al		# set condition flags
		jnz		cploop			# if not past terminating 0, continue

		pop		%edi
		pop		%esi
		leave
		ret
		.endfunc
		.globl	asm_strcpy
		.end
		
