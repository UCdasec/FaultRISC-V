	.file	"main.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	pinChange
	.type	pinChange, @function
pinChange:
	bne	a1,zero,.L2
	addiw	a0,a0,-10
	sext.w	a4,a0
	li	a5,27
	bgtu	a4,a5,.L1
	slli	a5,a0,32
	srli	a0,a5,30
	lui	a5,%hi(.L5)
	addi	a5,a5,%lo(.L5)
	add	a0,a0,a5
	lw	a5,0(a0)
	jr	a5
	.section	.rodata
	.align	2
	.align	2
.L5:
	.word	.L27
	.word	.L26
	.word	.L25
	.word	.L24
	.word	.L23
	.word	.L22
	.word	.L21
	.word	.L20
	.word	.L1
	.word	.L1
	.word	.L19
	.word	.L18
	.word	.L17
	.word	.L16
	.word	.L15
	.word	.L14
	.word	.L13
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L12
	.word	.L11
	.word	.L10
	.word	.L9
	.word	.L8
	.word	.L7
	.word	.L6
	.word	.L4
	.text
.L27:
	li	a4,37
	lbu	a5,0(a4)
	andi	a5,a5,254
	sb	a5,0(a4)
	ret
.L26:
	li	a4,37
	lbu	a5,0(a4)
	andi	a5,a5,253
	sb	a5,0(a4)
	ret
.L25:
	li	a4,37
	lbu	a5,0(a4)
	andi	a5,a5,251
	sb	a5,0(a4)
	ret
.L24:
	li	a4,37
	lbu	a5,0(a4)
	andi	a5,a5,247
	sb	a5,0(a4)
	ret
.L23:
	li	a4,37
	lbu	a5,0(a4)
	andi	a5,a5,239
	sb	a5,0(a4)
	ret
.L22:
	li	a4,37
	lbu	a5,0(a4)
	andi	a5,a5,223
	sb	a5,0(a4)
	ret
.L21:
	li	a4,37
	lbu	a5,0(a4)
	andi	a5,a5,191
	sb	a5,0(a4)
	ret
.L20:
	li	a4,37
	lbu	a5,0(a4)
	andi	a5,a5,127
	sb	a5,0(a4)
	ret
.L19:
	li	a4,40
	lbu	a5,0(a4)
	andi	a5,a5,254
	sb	a5,0(a4)
	ret
.L18:
	li	a4,40
	lbu	a5,0(a4)
	andi	a5,a5,253
	sb	a5,0(a4)
	ret
.L17:
	li	a4,40
	lbu	a5,0(a4)
	andi	a5,a5,251
	sb	a5,0(a4)
	ret
.L16:
	li	a4,40
	lbu	a5,0(a4)
	andi	a5,a5,247
	sb	a5,0(a4)
	ret
.L15:
	li	a4,40
	lbu	a5,0(a4)
	andi	a5,a5,239
	sb	a5,0(a4)
	ret
.L14:
	li	a4,40
	lbu	a5,0(a4)
	andi	a5,a5,223
	sb	a5,0(a4)
	ret
.L13:
	li	a4,40
	lbu	a5,0(a4)
	andi	a5,a5,191
	sb	a5,0(a4)
	ret
.L12:
	li	a4,43
	lbu	a5,0(a4)
	andi	a5,a5,254
	sb	a5,0(a4)
	ret
.L11:
	li	a4,43
	lbu	a5,0(a4)
	andi	a5,a5,253
	sb	a5,0(a4)
	ret
.L10:
	li	a4,43
	lbu	a5,0(a4)
	andi	a5,a5,251
	sb	a5,0(a4)
	ret
.L9:
	li	a4,43
	lbu	a5,0(a4)
	andi	a5,a5,247
	sb	a5,0(a4)
	ret
.L8:
	li	a4,43
	lbu	a5,0(a4)
	andi	a5,a5,239
	sb	a5,0(a4)
	ret
.L7:
	li	a4,43
	lbu	a5,0(a4)
	andi	a5,a5,223
	sb	a5,0(a4)
	ret
.L6:
	li	a4,43
	lbu	a5,0(a4)
	andi	a5,a5,191
	sb	a5,0(a4)
	ret
.L4:
	li	a4,43
	lbu	a5,0(a4)
	andi	a5,a5,127
	sb	a5,0(a4)
	ret
.L2:
	addiw	a0,a0,-10
	sext.w	a4,a0
	li	a5,27
	bgtu	a4,a5,.L1
	slli	a5,a0,32
	srli	a0,a5,30
	lui	a5,%hi(.L29)
	addi	a5,a5,%lo(.L29)
	add	a0,a0,a5
	lw	a5,0(a0)
	jr	a5
	.section	.rodata
	.align	2
	.align	2
.L29:
	.word	.L51
	.word	.L50
	.word	.L49
	.word	.L48
	.word	.L47
	.word	.L46
	.word	.L45
	.word	.L44
	.word	.L1
	.word	.L1
	.word	.L43
	.word	.L42
	.word	.L41
	.word	.L40
	.word	.L39
	.word	.L38
	.word	.L37
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L36
	.word	.L35
	.word	.L34
	.word	.L33
	.word	.L32
	.word	.L31
	.word	.L30
	.word	.L28
	.text
.L51:
	li	a4,37
	lbu	a5,0(a4)
	ori	a5,a5,1
	sb	a5,0(a4)
	ret
.L50:
	li	a4,37
	lbu	a5,0(a4)
	ori	a5,a5,2
	sb	a5,0(a4)
	ret
.L49:
	li	a4,37
	lbu	a5,0(a4)
	ori	a5,a5,4
	sb	a5,0(a4)
	ret
.L48:
	li	a4,37
	lbu	a5,0(a4)
	ori	a5,a5,8
	sb	a5,0(a4)
	ret
.L47:
	li	a4,37
	lbu	a5,0(a4)
	ori	a5,a5,16
	sb	a5,0(a4)
	ret
.L46:
	li	a4,37
	lbu	a5,0(a4)
	ori	a5,a5,32
	sb	a5,0(a4)
	ret
.L45:
	li	a4,37
	lbu	a5,0(a4)
	ori	a5,a5,64
	sb	a5,0(a4)
	ret
.L44:
	li	a4,37
	lbu	a5,0(a4)
	ori	a5,a5,128
	sb	a5,0(a4)
	ret
.L43:
	li	a4,40
	lbu	a5,0(a4)
	ori	a5,a5,1
	sb	a5,0(a4)
	ret
.L42:
	li	a4,40
	lbu	a5,0(a4)
	ori	a5,a5,2
	sb	a5,0(a4)
	ret
.L41:
	li	a4,40
	lbu	a5,0(a4)
	ori	a5,a5,4
	sb	a5,0(a4)
	ret
.L40:
	li	a4,40
	lbu	a5,0(a4)
	ori	a5,a5,8
	sb	a5,0(a4)
	ret
.L39:
	li	a4,40
	lbu	a5,0(a4)
	ori	a5,a5,16
	sb	a5,0(a4)
	ret
.L38:
	li	a4,40
	lbu	a5,0(a4)
	ori	a5,a5,32
	sb	a5,0(a4)
	ret
.L37:
	li	a4,40
	lbu	a5,0(a4)
	ori	a5,a5,64
	sb	a5,0(a4)
	ret
.L36:
	li	a4,43
	lbu	a5,0(a4)
	ori	a5,a5,1
	sb	a5,0(a4)
	ret
.L35:
	li	a4,43
	lbu	a5,0(a4)
	ori	a5,a5,2
	sb	a5,0(a4)
	ret
.L34:
	li	a4,43
	lbu	a5,0(a4)
	ori	a5,a5,4
	sb	a5,0(a4)
	ret
.L33:
	li	a4,43
	lbu	a5,0(a4)
	ori	a5,a5,8
	sb	a5,0(a4)
	ret
.L32:
	li	a4,43
	lbu	a5,0(a4)
	ori	a5,a5,16
	sb	a5,0(a4)
	ret
.L31:
	li	a4,43
	lbu	a5,0(a4)
	ori	a5,a5,32
	sb	a5,0(a4)
	ret
.L30:
	li	a4,43
	lbu	a5,0(a4)
	ori	a5,a5,64
	sb	a5,0(a4)
	ret
.L28:
	li	a4,43
	lbu	a5,0(a4)
	ori	a5,a5,128
	sb	a5,0(a4)
.L1:
	ret
	.size	pinChange, .-pinChange
	.align	1
	.globl	Lcd8_Port
	.type	Lcd8_Port, @function
Lcd8_Port:
	andi	a5,a0,1
	beq	a5,zero,.L53
	li	a4,43
	lbu	a5,0(a4)
	ori	a5,a5,1
	sb	a5,0(a4)
.L54:
	andi	a5,a0,2
	beq	a5,zero,.L55
	li	a4,43
	lbu	a5,0(a4)
	ori	a5,a5,2
	sb	a5,0(a4)
.L56:
	andi	a5,a0,4
	beq	a5,zero,.L57
	li	a4,43
	lbu	a5,0(a4)
	ori	a5,a5,4
	sb	a5,0(a4)
.L58:
	andi	a5,a0,8
	beq	a5,zero,.L59
	li	a4,43
	lbu	a5,0(a4)
	ori	a5,a5,8
	sb	a5,0(a4)
.L60:
	andi	a5,a0,16
	beq	a5,zero,.L61
	li	a4,43
	lbu	a5,0(a4)
	ori	a5,a5,16
	sb	a5,0(a4)
.L62:
	andi	a5,a0,32
	beq	a5,zero,.L63
	li	a4,43
	lbu	a5,0(a4)
	ori	a5,a5,32
	sb	a5,0(a4)
.L64:
	andi	a5,a0,64
	beq	a5,zero,.L65
	li	a4,43
	lbu	a5,0(a4)
	ori	a5,a5,64
	sb	a5,0(a4)
.L66:
	slliw	a0,a0,24
	sraiw	a0,a0,24
	blt	a0,zero,.L69
	li	a4,43
	lbu	a5,0(a4)
	andi	a5,a5,127
	sb	a5,0(a4)
	ret
.L53:
	li	a4,43
	lbu	a5,0(a4)
	andi	a5,a5,254
	sb	a5,0(a4)
	j	.L54
.L55:
	li	a4,43
	lbu	a5,0(a4)
	andi	a5,a5,253
	sb	a5,0(a4)
	j	.L56
.L57:
	li	a4,43
	lbu	a5,0(a4)
	andi	a5,a5,251
	sb	a5,0(a4)
	j	.L58
.L59:
	li	a4,43
	lbu	a5,0(a4)
	andi	a5,a5,247
	sb	a5,0(a4)
	j	.L60
.L61:
	li	a4,43
	lbu	a5,0(a4)
	andi	a5,a5,239
	sb	a5,0(a4)
	j	.L62
.L63:
	li	a4,43
	lbu	a5,0(a4)
	andi	a5,a5,223
	sb	a5,0(a4)
	j	.L64
.L65:
	li	a4,43
	lbu	a5,0(a4)
	andi	a5,a5,191
	sb	a5,0(a4)
	j	.L66
.L69:
	li	a4,43
	lbu	a5,0(a4)
	ori	a5,a5,128
	sb	a5,0(a4)
	ret
	.size	Lcd8_Port, .-Lcd8_Port
	.align	1
	.globl	Lcd8_Cmd
	.type	Lcd8_Cmd, @function
Lcd8_Cmd:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	li	s0,37
	lbu	a5,0(s0)
	andi	a5,a5,253
	sb	a5,0(s0)
	call	Lcd8_Port
	lbu	a5,0(s0)
	ori	a5,a5,1
	sb	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	andi	a5,a5,254
	sb	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	call	__builtin_avr_delay_cycles
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	Lcd8_Cmd, .-Lcd8_Cmd
	.align	1
	.globl	Lcd8_Clear
	.type	Lcd8_Clear, @function
Lcd8_Clear:
	addi	sp,sp,-16
	sd	ra,8(sp)
	li	a0,1
	call	Lcd8_Cmd
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	Lcd8_Clear, .-Lcd8_Clear
	.align	1
	.globl	Lcd8_Set_Cursor
	.type	Lcd8_Set_Cursor, @function
Lcd8_Set_Cursor:
	addi	sp,sp,-16
	sd	ra,8(sp)
	li	a5,1
	beq	a0,a5,.L78
	li	a5,2
	beq	a0,a5,.L79
.L74:
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
.L78:
	addiw	a1,a1,-128
	andi	a0,a1,0xff
	call	Lcd8_Cmd
	j	.L74
.L79:
	addiw	a1,a1,-64
	andi	a0,a1,0xff
	call	Lcd8_Cmd
	j	.L74
	.size	Lcd8_Set_Cursor, .-Lcd8_Set_Cursor
	.align	1
	.globl	Lcd8_Init
	.type	Lcd8_Init, @function
Lcd8_Init:
	addi	sp,sp,-16
	sd	ra,8(sp)
	li	a5,37
	lbu	a4,0(a5)
	andi	a4,a4,253
	sb	a4,0(a5)
	lbu	a4,0(a5)
	andi	a4,a4,254
	sb	a4,0(a5)
	li	a0,319488
	addi	a0,a0,512
	call	__builtin_avr_delay_cycles
	li	a0,48
	call	Lcd8_Cmd
	li	a0,81920
	addi	a0,a0,-1920
	call	__builtin_avr_delay_cycles
	li	a0,48
	call	Lcd8_Cmd
	li	a0,16384
	addi	a0,a0,-384
	call	__builtin_avr_delay_cycles
	li	a0,48
	call	Lcd8_Cmd
	li	a0,159744
	addi	a0,a0,256
	call	__builtin_avr_delay_cycles
	li	a0,56
	call	Lcd8_Cmd
	li	a0,12
	call	Lcd8_Cmd
	li	a0,1
	call	Lcd8_Cmd
	li	a0,6
	call	Lcd8_Cmd
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	Lcd8_Init, .-Lcd8_Init
	.align	1
	.globl	Lcd8_Write_Char
	.type	Lcd8_Write_Char, @function
Lcd8_Write_Char:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	li	s0,37
	lbu	a5,0(s0)
	ori	a5,a5,2
	sb	a5,0(s0)
	call	Lcd8_Port
	lbu	a5,0(s0)
	ori	a5,a5,1
	sb	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	andi	a5,a5,254
	sb	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	call	__builtin_avr_delay_cycles
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	Lcd8_Write_Char, .-Lcd8_Write_Char
	.align	1
	.globl	Lcd8_Write_String
	.type	Lcd8_Write_String, @function
Lcd8_Write_String:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	mv	s0,a0
	lbu	a0,0(a0)
	beq	a0,zero,.L84
	addi	s0,s0,1
.L86:
	call	Lcd8_Write_Char
	addi	s0,s0,1
	lbu	a0,-1(s0)
	bne	a0,zero,.L86
.L84:
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	Lcd8_Write_String, .-Lcd8_Write_String
	.align	1
	.globl	Lcd8_Shift_Right
	.type	Lcd8_Shift_Right, @function
Lcd8_Shift_Right:
	addi	sp,sp,-16
	sd	ra,8(sp)
	li	a0,28
	call	Lcd8_Cmd
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	Lcd8_Shift_Right, .-Lcd8_Shift_Right
	.align	1
	.globl	Lcd8_Shift_Left
	.type	Lcd8_Shift_Left, @function
Lcd8_Shift_Left:
	addi	sp,sp,-16
	sd	ra,8(sp)
	li	a0,24
	call	Lcd8_Cmd
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	Lcd8_Shift_Left, .-Lcd8_Shift_Left
	.align	1
	.globl	Lcd4_Port
	.type	Lcd4_Port, @function
Lcd4_Port:
	andi	a5,a0,1
	beq	a5,zero,.L94
	li	a4,43
	lbu	a5,0(a4)
	ori	a5,a5,16
	sb	a5,0(a4)
.L95:
	andi	a5,a0,2
	beq	a5,zero,.L96
	li	a4,43
	lbu	a5,0(a4)
	ori	a5,a5,32
	sb	a5,0(a4)
.L97:
	andi	a5,a0,4
	beq	a5,zero,.L98
	li	a4,43
	lbu	a5,0(a4)
	ori	a5,a5,64
	sb	a5,0(a4)
.L99:
	andi	a0,a0,8
	beq	a0,zero,.L100
	li	a4,43
	lbu	a5,0(a4)
	ori	a5,a5,128
	sb	a5,0(a4)
	ret
.L94:
	li	a4,43
	lbu	a5,0(a4)
	andi	a5,a5,239
	sb	a5,0(a4)
	j	.L95
.L96:
	li	a4,43
	lbu	a5,0(a4)
	andi	a5,a5,223
	sb	a5,0(a4)
	j	.L97
.L98:
	li	a4,43
	lbu	a5,0(a4)
	andi	a5,a5,191
	sb	a5,0(a4)
	j	.L99
.L100:
	li	a4,43
	lbu	a5,0(a4)
	andi	a5,a5,127
	sb	a5,0(a4)
	ret
	.size	Lcd4_Port, .-Lcd4_Port
	.align	1
	.globl	Lcd4_Cmd
	.type	Lcd4_Cmd, @function
Lcd4_Cmd:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	li	s0,37
	lbu	a5,0(s0)
	andi	a5,a5,253
	sb	a5,0(s0)
	call	Lcd4_Port
	lbu	a5,0(s0)
	ori	a5,a5,1
	sb	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	andi	a5,a5,254
	sb	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	call	__builtin_avr_delay_cycles
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	Lcd4_Cmd, .-Lcd4_Cmd
	.align	1
	.globl	Lcd4_Clear
	.type	Lcd4_Clear, @function
Lcd4_Clear:
	addi	sp,sp,-16
	sd	ra,8(sp)
	li	a0,0
	call	Lcd4_Cmd
	li	a0,1
	call	Lcd4_Cmd
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	Lcd4_Clear, .-Lcd4_Clear
	.align	1
	.globl	Lcd4_Set_Cursor
	.type	Lcd4_Set_Cursor, @function
Lcd4_Set_Cursor:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	mv	s0,a1
	li	a5,1
	beq	a0,a5,.L110
	li	a5,2
	beq	a0,a5,.L111
.L106:
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
.L110:
	xori	a0,a1,128
	srli	a0,a0,4
	call	Lcd4_Cmd
	andi	a0,s0,15
	call	Lcd4_Cmd
	j	.L106
.L111:
	addiw	a0,a1,-64
	srli	a0,a0,4
	andi	a0,a0,15
	call	Lcd4_Cmd
	andi	a0,s0,15
	call	Lcd4_Cmd
	j	.L106
	.size	Lcd4_Set_Cursor, .-Lcd4_Set_Cursor
	.align	1
	.globl	Lcd4_Init
	.type	Lcd4_Init, @function
Lcd4_Init:
	addi	sp,sp,-16
	sd	ra,8(sp)
	li	a0,0
	call	Lcd4_Port
	li	a0,319488
	addi	a0,a0,512
	call	__builtin_avr_delay_cycles
	li	a0,3
	call	Lcd4_Cmd
	li	a0,81920
	addi	a0,a0,-1920
	call	__builtin_avr_delay_cycles
	li	a0,3
	call	Lcd4_Cmd
	li	a0,176128
	addi	a0,a0,-128
	call	__builtin_avr_delay_cycles
	li	a0,3
	call	Lcd4_Cmd
	li	a0,2
	call	Lcd4_Cmd
	li	a0,2
	call	Lcd4_Cmd
	li	a0,8
	call	Lcd4_Cmd
	li	a0,0
	call	Lcd4_Cmd
	li	a0,12
	call	Lcd4_Cmd
	li	a0,0
	call	Lcd4_Cmd
	li	a0,6
	call	Lcd4_Cmd
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	Lcd4_Init, .-Lcd4_Init
	.align	1
	.globl	Lcd4_Write_Char
	.type	Lcd4_Write_Char, @function
Lcd4_Write_Char:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	sd	s1,8(sp)
	mv	s1,a0
	li	s0,37
	lbu	a5,0(s0)
	ori	a5,a5,2
	sb	a5,0(s0)
	srli	a0,a0,4
	call	Lcd4_Port
	lbu	a5,0(s0)
	ori	a5,a5,1
	sb	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	andi	a5,a5,254
	sb	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	call	__builtin_avr_delay_cycles
	andi	a0,s1,15
	call	Lcd4_Port
	lbu	a5,0(s0)
	ori	a5,a5,1
	sb	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	andi	a5,a5,254
	sb	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	call	__builtin_avr_delay_cycles
	ld	ra,24(sp)
	ld	s0,16(sp)
	ld	s1,8(sp)
	addi	sp,sp,32
	jr	ra
	.size	Lcd4_Write_Char, .-Lcd4_Write_Char
	.align	1
	.globl	Lcd4_Write_String
	.type	Lcd4_Write_String, @function
Lcd4_Write_String:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	mv	s0,a0
	lbu	a0,0(a0)
	beq	a0,zero,.L116
	addi	s0,s0,1
.L118:
	call	Lcd4_Write_Char
	addi	s0,s0,1
	lbu	a0,-1(s0)
	bne	a0,zero,.L118
.L116:
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	Lcd4_Write_String, .-Lcd4_Write_String
	.align	1
	.globl	Lcd4_Shift_Right
	.type	Lcd4_Shift_Right, @function
Lcd4_Shift_Right:
	addi	sp,sp,-16
	sd	ra,8(sp)
	li	a0,1
	call	Lcd4_Cmd
	li	a0,12
	call	Lcd4_Cmd
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	Lcd4_Shift_Right, .-Lcd4_Shift_Right
	.align	1
	.globl	Lcd4_Shift_Left
	.type	Lcd4_Shift_Left, @function
Lcd4_Shift_Left:
	addi	sp,sp,-16
	sd	ra,8(sp)
	li	a0,1
	call	Lcd4_Cmd
	li	a0,8
	call	Lcd4_Cmd
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	Lcd4_Shift_Left, .-Lcd4_Shift_Left
	.align	1
	.globl	Config_USART
	.type	Config_USART, @function
Config_USART:
	li	a5,103
	sb	a5,196(zero)
	sb	zero,197(zero)
	li	a5,193
	lbu	a4,0(a5)
	ori	a4,a4,8
	sb	a4,0(a5)
	lbu	a4,0(a5)
	ori	a4,a4,16
	sb	a4,0(a5)
	li	a4,194
	lbu	a5,0(a4)
	ori	a5,a5,6
	sb	a5,0(a4)
	ret
	.size	Config_USART, .-Config_USART
	.align	1
	.globl	USART_Receive
	.type	USART_Receive, @function
USART_Receive:
	lbu	a5,192(zero)
	slliw	a5,a5,24
	sraiw	a5,a5,24
	li	a0,0
	blt	a5,zero,.L129
.L127:
	ret
.L129:
	lbu	a0,198(zero)
	andi	a0,a0,0xff
	ret
	.size	USART_Receive, .-USART_Receive
	.align	1
	.globl	USART_Transmit
	.type	USART_Transmit, @function
USART_Transmit:
.L131:
	lbu	a5,192(zero)
	andi	a5,a5,32
	beq	a5,zero,.L131
	andi	a0,a0,0xff
	sb	a0,198(zero)
	ret
	.size	USART_Transmit, .-USART_Transmit
	.align	1
	.globl	Gate
	.type	Gate, @function
Gate:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	sd	s1,8(sp)
	li	s0,40
	li	s1,1
	sb	s1,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	call	__builtin_avr_delay_cycles
	sb	zero,0(s0)
	li	a0,32002048
	addi	a0,a0,-2048
	call	__builtin_avr_delay_cycles
	sb	s1,0(s0)
	li	a0,24576
	addi	a0,a0,-576
	call	__builtin_avr_delay_cycles
	sb	zero,0(s0)
	li	a0,32002048
	addi	a0,a0,-2048
	call	__builtin_avr_delay_cycles
	sb	s1,0(s0)
	sb	zero,0(s0)
	sb	s1,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	call	__builtin_avr_delay_cycles
	sb	zero,0(s0)
	ld	ra,24(sp)
	ld	s0,16(sp)
	ld	s1,8(sp)
	addi	sp,sp,32
	jr	ra
	.size	Gate, .-Gate
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"Swipe the Card"
	.align	3
.LC1:
	.string	"Access Grant"
	.align	3
.LC2:
	.string	"Access Denied"
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-80
	sd	ra,72(sp)
	sd	s0,64(sp)
	sd	s1,56(sp)
	sd	s2,48(sp)
	sd	s3,40(sp)
	sd	s4,32(sp)
	sd	s5,24(sp)
	sd	s6,16(sp)
	sd	s7,8(sp)
	li	s0,36
	lbu	a5,0(s0)
	ori	a5,a5,32
	sb	a5,0(s0)
	call	Config_USART
	lbu	a5,0(s0)
	ori	a5,a5,32
	sb	a5,0(s0)
 #APP
# 97 "main.c" 1
	sei
# 0 "" 2
 #NO_APP
	call	SWseriale_begin
	call	Lcd4_Init
	li	a1,0
	li	a0,1
	call	Lcd4_Set_Cursor
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	Lcd4_Write_String
	li	a5,1
	sb	a5,39(zero)
	sb	zero,40(zero)
	lui	s1,%hi(rx)
	li	s2,75
	li	s3,88
	lui	s7,%hi(.LC2)
	li	s6,48001024
	addi	s6,s6,-1024
	li	s4,79
	lui	s5,%hi(.LC1)
	j	.L136
.L141:
	call	SWseriale_read
	call	USART_Transmit
	j	.L137
.L142:
	addi	a0,s5,%lo(.LC1)
	call	Lcd4_Write_String
	li	s0,37
	lbu	a5,0(s0)
	ori	a5,a5,32
	sb	a5,0(s0)
	li	a0,3198976
	addi	a0,a0,1024
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	andi	a5,a5,223
	sb	a5,0(s0)
	li	a0,3198976
	addi	a0,a0,1024
	call	__builtin_avr_delay_cycles
	sb	s4,%lo(rx)(s1)
	call	Gate
	call	Lcd4_Clear
.L136:
	call	SWseriale_available
	bne	a0,zero,.L141
.L137:
	call	USART_Receive
	sb	a0,%lo(rx)(s1)
	beq	a0,s2,.L142
	bne	a0,s3,.L136
	addi	a0,s7,%lo(.LC2)
	call	Lcd4_Write_String
	li	s0,37
	lbu	a5,0(s0)
	ori	a5,a5,32
	sb	a5,0(s0)
	mv	a0,s6
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	andi	a5,a5,223
	sb	a5,0(s0)
	li	a0,3198976
	addi	a0,a0,1024
	call	__builtin_avr_delay_cycles
	sb	s4,%lo(rx)(s1)
	call	Lcd4_Clear
	j	.L136
	.size	main, .-main
	.globl	rx
	.section	.sbss,"aw",@nobits
	.type	rx, @object
	.size	rx, 1
rx:
	.zero	1
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
