
		.equ	CF_MASK, 0x00000001
		.equ	PF_MASK, 0x00000004
		.equ	AF_MASK, 0x00000010
		.equ	ZF_MASK, 0x00000040
		.equ	SF_MASK, 0x00000080
		.equ	DF_MASK, 0x00000400
		.equ	OF_MASK, 0x00000800

		.section	.data
int_format:		.asciz	"%d"		
str_format:		.asciz	"%s"

# EFLAGS:
cf_flag:		.asciz	"CF"		# Carry flag
zf_flag:		.asciz	"ZF"		# Zero flag
sf_flag:		.asciz	"SF"		# Sign flag
pf_flag:		.asciz	"PF"		# Parity flag
of_flag:		.asciz	"OF"		# Overflow flag
df_flag:		.asciz	"DF"		# Direction flag
af_flag:		.asciz	"AF"		# Auxiliary flag
uf_flag:		.asciz	"  "		# Unset flag

# Register Dump format string:
reg_format:		.ascii	"Register Dump # %d\n"
				.ascii	"EAX = %.8X EBX = %.8X ECX = %.8X EDX = %.8X\n"
				.ascii	"ESI = %.8X EDI = %.8X EBP = %.8X ESP = %.8X\n"
				.asciz	"EIP = %.8X EFLAGS = %.8X %s %s %s %s %s %s %s\n"

# Memory Dump formats string:
mem_format1:	.asciz	"Memory Dump # %d Address = %.8X\n"
mem_format2:	.asciz	"%.8X "
mem_format3:	.asciz	"%.2X "

# Stack Dump formats string:
stack_format:	.ascii	"Stack Dump # %d\n"
				.asciz	"EBP = %.8X  ESP = %.8X\n"
stack_line_fmt:	.asciz	"%+4d  %.8X  %.8X\n"

# Math Dump formats string:
math_format1:	.ascii	"Math Coprocessor Dump # %d Control Word = %.4X"
				.asciz	" Status Word = %.4X\n"
valid_st_format:	.asciz "ST%d: %.10g\n"
inval_st_format:	.asciz "ST%d: Invalid ST\n"
empty_st_format:	.asciz "ST%d: Empty\n"


		.section	.text

		.func read_int
		.type read_int, @function
# ------------------------------------------------------------------------------
read_int:
# Description:	reads an integer from the keyboard and stores it into the EAX
# Return:		return the integer.
		enter	$4, $0
		pusha
		pushf

		lea		-4(%ebp), %eax
		push	%eax
		push	$int_format
		call	scanf
		add		$8, %esp

		popf
		popa
		mov		-4(%ebp), %eax
		leave
		ret
		.endfunc

		.globl	read_int

		.func	print_int
		.type	print_int, @function
# ------------------------------------------------------------------------------
print_int:
# Description:	prints out to the screen the value of the integer stored in EAX
# Return:		None
		enter	$0, $0
		pusha
		pushf

		push	%eax
		push	$int_format
		call	printf
		add		$8, %esp
		
		popf	
		popa
		leave
		ret
		.endfunc

		.globl	print_int
							

		.func	print_string
		.type	print_string, @function
# ------------------------------------------------------------------------------
print_string:
# Description:	prints out to the screen the contents of the string at the
#				stored in EAX. The string must be a C-type string.
# Return:		None
		enter	$0, $0
		pusha
		pushf

		push	%eax
		push	$str_format
		call	printf
		add		$8, %esp
		
		popf
		popa
		leave
		ret
		.endfunc

		.globl	print_string

		.func	print_nl
		.type	print_nl, @function
# ------------------------------------------------------------------------------
print_nl:
# Description:	prints out to the screen a new line character.
# Return:		None
		enter	$0, $0
		pusha
		pushf

		push	$10
		call	putchar
		add		$4, %esp

		popf
		popa
		leave
		ret

		.endfunc
		.globl	print_nl

		.func	read_char
		.type	read_char, @function
# -----------------------------------------------------------------------------
read_char:
# Description:	Reads a single character from the keyboard and stores it 
#				into the EAX register.
# Return:		Returns the character typed.
		enter	$4, $0
		pusha	
		pushf
		
		call	getchar
		mov		%eax, -4(%ebp)
		leave
		ret

		.endfunc
		.globl	read_char

		.func	print_char
		.type	print_char, @function
# -----------------------------------------------------------------------------
print_char:
# Description:	Prints out to the screen the character whose ASCII value is
#				stored in AL.
# Return:		None
		enter	$0, $0
		pusha
		pushf

		push	%eax
		call	putchar
		add		$4, %esp

		popf
		popa
		leave
		ret

		.endfunc
		.globl	print_char

		.func	sub_dump_regs
		.type	sub_dump_regs, @function
# -----------------------------------------------------------------------------
sub_dump_regs:
# Description:	This function is used by macro 'dump_regs', which prints out
#				the values of the registers(in hex).  It  also  displays the
# 				bits set in EFLAGS.
# @param:		an integer argument that is printed out, an is used to
#				distinguish the output of different dump_regs commands.
# Return:		None
		enter	$4, $0
		pusha
		pushf
		mov		(%esp), %eax		# read EFLAGS back off stack
		mov		%eax, -4(%ebp)		# save flags

		# Show which EFLAGS are set:
		test	$CF_MASK, %eax
		jz		cf_off
		lea		cf_flag, %eax
		jmp		push_cf
cf_off:	lea		uf_flag, %eax
push_cf:	push	%eax
		
		testl	$PF_MASK, -4(%ebp)
		jz		pf_off
		lea		pf_flag, %eax
		jmp		push_pf
pf_off:	lea		uf_flag, %eax
push_pf:	push	%eax

		testl	$AF_MASK, -4(%ebp)
		jz		af_off
		lea		af_flag, %eax
		jmp		push_af
af_off:	lea		uf_flag, %eax
push_af:	push	%eax

		testl	$ZF_MASK, -4(%ebp)
		jz		zf_off
		lea		zf_flag, %eax
		jmp		push_zf
zf_off:	lea		uf_flag, %eax
push_zf:	push	%eax

		testl	$SF_MASK, -4(%ebp)
		jz		sf_off
		lea		sf_flag, %eax
		jmp		push_sf
sf_off:	lea		uf_flag, %eax
push_sf:	push	%eax

		testl	$DF_MASK, -4(%ebp)
		jz		df_off
		lea		df_flag, %eax
		jmp		push_df
df_off:	lea		uf_flag, %eax
push_df:	push	%eax

		testl	$OF_MASK, -4(%ebp)
		jz		of_off
		lea		of_flag, %eax
		jmp		push_of
of_off:	lea		uf_flag, %eax
push_of:	push	%eax

		push	-4(%ebp)		# EFLAGS
		mov		4(%ebp), %eax
		sub		$9, %eax		# EIP on stack is 10 bytes ahead of orig
		push	%eax			# EIP
		lea		12(%ebp), %eax
		push	%eax			# original ESP
		push	(%ebp)			# original EBP
		push	%edi
		push	%esi
		push	%edx
		push	%ecx
		push	%ebx
		push	-8(%ebp)		# original	EAX
		push	8(%ebp)			# # of dump
		push	$reg_format
		call	printf
		add		$76, %esp

		popf
		popa
		leave
		ret		$4

		.endfunc
		.globl	sub_dump_regs

		.func	sub_dump_mem
		.type	sub_dump_mem, @function
# -----------------------------------------------------------------------------
sub_dump_mem:
# Description:	Prints out the values of a region of memory (in hex) and also as
#				ASCII characters.
# @param:+16	an integer used to label the ouput just as dump_regs param.
# @param:+12	the address to display. Can be a label.
# @param:+8		a number of 16-byte paragraphs to display after the address.
# return:		None.
		enter	$0, $0
		pusha
		pushf

		push	12(%ebp)
		push	16(%ebp)
		push	$mem_format1
		call	printf
		add		$12, %esp
		mov		12(%ebp), %esi			# address
		and		$0xFFFFFFF0, %esi		# move to start of paragraph
		mov		8(%ebp), %ecx
		inc		%ecx
mem_outer_loop:
		push	%ecx
		push	%esi
		push	$mem_format2
		call	printf
		add		$8, %esp

		xor		%ebx, %ebx
mem_hex_loop:
		xor		%eax, %eax
		movb	(%esi,%ebx,1), %al
		push	%eax
		push	$mem_format3
		call	printf
		add		$8, %esp
		inc		%ebx
		cmp		$16, %ebx
		jl		mem_hex_loop

		mov		$'"', %eax
		call	print_char
		xor		%ebx, %ebx
mem_char_loop:
		xor		%eax, %eax
		mov		(%esi,%ebx,1), %al
		cmp		$32, %al
		jl		non_printable
		cmp		$126, %al
		jg		non_printable
		jmp		mem_char_loop_continue
non_printable:
		mov		$'.', %eax
mem_char_loop_continue:
		call	print_char

		inc		%ebx
		cmp		$16, %ebx
		jl		mem_char_loop

		mov		$'"', %eax
		call	print_char
		call	print_nl

		add		$16, %esi
		pop		%ecx
		loop	mem_outer_loop
		
		popf
		popa
		leave
		ret		$12

		.endfunc
		.globl	sub_dump_mem

		.func	sub_dump_stack
		.type	sub_dump_stack, @function
# -----------------------------------------------------------------------------
sub_dump_stack:
# Description:	Prints out the values of the STACK.
# @param:		an integer label(like dump-regs) (+8)
# @param:		a number of double words to display below the EBP (+12)
# @param:		a number of double words to display above the EBP (+16)
		enter	$0, $0
		pusha
		pushf

		lea		20(%ebp), %eax
		push	%eax				# original ESP
		push	(%ebp)				# original EBP
		push	8(%ebp)				# label
		push	$stack_format
		call	printf
		add		$16, %esp

		mov		(%ebp), %ebx		# EBX = original EBP
		mov		16(%ebp), %eax		# EAX = #dwords above EBP
		shl		$2, %eax			# EAX *= 4
		add		%eax, %ebx			# EBX = &highest dword in stack to display
		mov		16(%ebp), %edx		# EDX = #dwords above EBP
		mov		%edx, %ecx
		add		12(%ebx), %ecx
		inc		%ecx				# ECX = # of dwords to display
		inc		%ecx

st_line_loop:
		push	%edx
		push	%ecx				# save EDX & ECX
		
		push	(%ebx)				# value on stack
		push	%ebx				# address of value on stack
		mov		%edx, %eax
		sal		$2, %eax			# EAX = 4*EDX
		push	%eax				# offset from EBP
		push	$stack_line_fmt
		call	printf
		add		$16, %esp

		pop		%ecx
		pop		%edx

		sub		$4, %ebx
		dec		%edx
		loop	st_line_loop	
		
		popf
		popa
		leave
		ret		$12

		.endfunc
		.globl	sub_dump_stack

		.func	sub_dump_math
		.type	sub_dump_math, @function
# ---------------------------------------------------------------------------
sub_dump_math:
# Description:	prints out state of math coprocessor without modifying the
# 				coprocessor or regular processor state.
# @param:		dump number (+8)
# Local variables: 
#				ebp-108		start of fsave buffer
#				ebp-116		temp double
# Notes: 		this procedure uses the Pascal convention.
#				fsave buffer structure
#				ebp-108		control word
#				ebp-104		status word
#				ebp-100		tag word
#				ebp-80		ST0
#				ebp-70		ST1
#				ebp-60		ST2 ...
#				ebp-10		ST7
		enter	$116, $0
		pusha
		pushf

		fsave	-108(%ebp)			# save coprocessor state to memory
		mov		-104(%ebp), %eax	# status word
		and		$0xFFFF, %eax
		push	%eax
		mov		-108(%ebp), %eax	# control word
		and		$0xFFFF, %eax
		push	%eax
		push	8(%ebp)	
		push	$math_format1
		call	printf
		add		$16, %esp

# rotate tag word so that tags in same order as numbers are in the stack
		mov		-104(%ebp), %cx		# cx = status word
		shr		$11, %cx			# top of the stack in Bits 2, 1, 0
		and		$7, %cx				# cl = physical state of number on stack top
		mov		-100(%ebp), %bx		# bx = tag word
		shl		$1, %cl				# cl *= 2
		ror		%cl, %bx			# move top of stack tag to lowest bits

		mov		$0, %edi			# EDI = stack number of number
		lea		-80(%ebp), %esi		# ESI = address of ST0
		mov		$8, %ecx			# ECX = counter
tag_loop:
		push	%ecx
		mov		$3, %ax
		and		%bx, %ax			# AX = current tag
		or		%ax, %ax			# 00 -> valid number
		je		valid_st
		cmp		$1, %ax				# 01 -> zero
		je		zero_st
		cmp		$2, %ax				# 10 -> invalid number
		je		invalid_st
		push	%edi				# 11 -> empty
		push	$empty_st_format
		call	printf
		add		$8, %esp
		jmp		cont_tag_loop

zero_st:
		fldz
		jmp		print_real

valid_st:
		fldt	(%esi)
print_real:
		fstpl	-116(%ebp)
		push	-112(%ebp)
		push	-116(%ebp)
		push	%edi
		push	$valid_st_format
		call	printf
		add		$16, %esp
		jmp		cont_tag_loop

invalid_st:
		push	%edi
		push	$inval_st_format
		call	printf
		add		$8, %esp

cont_tag_loop:
		ror		$2, %bx				# move next tag into lowest bits
		inc		%edi
		add		$10, %esi			# move to next number on stack
		pop		%ecx
		loop	tag_loop
			
		frstor	-108(%ebp)			# restore coprocessor state

		popf
		popa
		leave
		ret		$4
		.endfunc
		.globl	sub_dump_math
		.end
		
