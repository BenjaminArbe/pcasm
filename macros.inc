
		.macro dump_regs label
			push	\label
			call	sub_dump_regs
		.endm

		.macro dump_mem	label start_address paragraphs
			push	\label
			push	\start_address
			push	\paragraphs
			call	sub_dump_mem
		.endm
		
		.macro dump_stack label	below above
			push	\above
			push	\below
			push	\label
			call	sub_dump_stack
		.endm

		.macro dump_math label
			push	\label
			call	sub_dump_math
		.endm
