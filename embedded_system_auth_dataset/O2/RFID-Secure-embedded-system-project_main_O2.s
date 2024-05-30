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
	addiw	a0,a0,-10
	sext.w	a4,a0
	li	a5,27
	bne	a1,zero,.L2
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
.L2:
	bleu	a4,a5,.L53
.L1:
	ret
.L53:
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
.L4:
	lbu	a5,43(zero)
	andi	a5,a5,127
	sb	a5,43(zero)
	ret
.L51:
	lbu	a5,37(zero)
	ori	a5,a5,1
	sb	a5,37(zero)
	ret
.L50:
	lbu	a5,37(zero)
	ori	a5,a5,2
	sb	a5,37(zero)
	ret
.L49:
	lbu	a5,37(zero)
	ori	a5,a5,4
	sb	a5,37(zero)
	ret
.L48:
	lbu	a5,37(zero)
	ori	a5,a5,8
	sb	a5,37(zero)
	ret
.L47:
	lbu	a5,37(zero)
	ori	a5,a5,16
	sb	a5,37(zero)
	ret
.L46:
	lbu	a5,37(zero)
	ori	a5,a5,32
	sb	a5,37(zero)
	ret
.L45:
	lbu	a5,37(zero)
	ori	a5,a5,64
	sb	a5,37(zero)
	ret
.L44:
	lbu	a5,37(zero)
	ori	a5,a5,128
	sb	a5,37(zero)
	ret
.L43:
	lbu	a5,40(zero)
	ori	a5,a5,1
	sb	a5,40(zero)
	ret
.L42:
	lbu	a5,40(zero)
	ori	a5,a5,2
	sb	a5,40(zero)
	ret
.L41:
	lbu	a5,40(zero)
	ori	a5,a5,4
	sb	a5,40(zero)
	ret
.L40:
	lbu	a5,40(zero)
	ori	a5,a5,8
	sb	a5,40(zero)
	ret
.L39:
	lbu	a5,40(zero)
	ori	a5,a5,16
	sb	a5,40(zero)
	ret
.L38:
	lbu	a5,40(zero)
	ori	a5,a5,32
	sb	a5,40(zero)
	ret
.L37:
	lbu	a5,40(zero)
	ori	a5,a5,64
	sb	a5,40(zero)
	ret
.L36:
	lbu	a5,43(zero)
	ori	a5,a5,1
	sb	a5,43(zero)
	ret
.L35:
	lbu	a5,43(zero)
	ori	a5,a5,2
	sb	a5,43(zero)
	ret
.L34:
	lbu	a5,43(zero)
	ori	a5,a5,4
	sb	a5,43(zero)
	ret
.L33:
	lbu	a5,43(zero)
	ori	a5,a5,8
	sb	a5,43(zero)
	ret
.L32:
	lbu	a5,43(zero)
	ori	a5,a5,16
	sb	a5,43(zero)
	ret
.L31:
	lbu	a5,43(zero)
	ori	a5,a5,32
	sb	a5,43(zero)
	ret
.L30:
	lbu	a5,43(zero)
	ori	a5,a5,64
	sb	a5,43(zero)
	ret
.L28:
	lbu	a5,43(zero)
	ori	a5,a5,128
	sb	a5,43(zero)
	ret
.L27:
	lbu	a5,37(zero)
	andi	a5,a5,254
	sb	a5,37(zero)
	ret
.L26:
	lbu	a5,37(zero)
	andi	a5,a5,253
	sb	a5,37(zero)
	ret
.L25:
	lbu	a5,37(zero)
	andi	a5,a5,251
	sb	a5,37(zero)
	ret
.L24:
	lbu	a5,37(zero)
	andi	a5,a5,247
	sb	a5,37(zero)
	ret
.L23:
	lbu	a5,37(zero)
	andi	a5,a5,239
	sb	a5,37(zero)
	ret
.L22:
	lbu	a5,37(zero)
	andi	a5,a5,223
	sb	a5,37(zero)
	ret
.L21:
	lbu	a5,37(zero)
	andi	a5,a5,191
	sb	a5,37(zero)
	ret
.L20:
	lbu	a5,37(zero)
	andi	a5,a5,127
	sb	a5,37(zero)
	ret
.L19:
	lbu	a5,40(zero)
	andi	a5,a5,254
	sb	a5,40(zero)
	ret
.L18:
	lbu	a5,40(zero)
	andi	a5,a5,253
	sb	a5,40(zero)
	ret
.L17:
	lbu	a5,40(zero)
	andi	a5,a5,251
	sb	a5,40(zero)
	ret
.L16:
	lbu	a5,40(zero)
	andi	a5,a5,247
	sb	a5,40(zero)
	ret
.L15:
	lbu	a5,40(zero)
	andi	a5,a5,239
	sb	a5,40(zero)
	ret
.L14:
	lbu	a5,40(zero)
	andi	a5,a5,223
	sb	a5,40(zero)
	ret
.L13:
	lbu	a5,40(zero)
	andi	a5,a5,191
	sb	a5,40(zero)
	ret
.L12:
	lbu	a5,43(zero)
	andi	a5,a5,254
	sb	a5,43(zero)
	ret
.L11:
	lbu	a5,43(zero)
	andi	a5,a5,253
	sb	a5,43(zero)
	ret
.L10:
	lbu	a5,43(zero)
	andi	a5,a5,251
	sb	a5,43(zero)
	ret
.L9:
	lbu	a5,43(zero)
	andi	a5,a5,247
	sb	a5,43(zero)
	ret
.L8:
	lbu	a5,43(zero)
	andi	a5,a5,239
	sb	a5,43(zero)
	ret
.L7:
	lbu	a5,43(zero)
	andi	a5,a5,223
	sb	a5,43(zero)
	ret
.L6:
	lbu	a5,43(zero)
	andi	a5,a5,191
	sb	a5,43(zero)
	ret
	.size	pinChange, .-pinChange
	.align	1
	.globl	Lcd8_Port
	.type	Lcd8_Port, @function
Lcd8_Port:
	andi	a5,a0,1
	beq	a5,zero,.L55
	lbu	a5,43(zero)
	ori	a5,a5,1
	sb	a5,43(zero)
	andi	a5,a0,2
	beq	a5,zero,.L57
.L72:
	lbu	a5,43(zero)
	ori	a5,a5,2
	sb	a5,43(zero)
	andi	a5,a0,4
	beq	a5,zero,.L59
.L73:
	lbu	a5,43(zero)
	ori	a5,a5,4
	sb	a5,43(zero)
	andi	a5,a0,8
	beq	a5,zero,.L61
.L74:
	lbu	a5,43(zero)
	ori	a5,a5,8
	sb	a5,43(zero)
	andi	a5,a0,16
	beq	a5,zero,.L63
.L75:
	lbu	a5,43(zero)
	ori	a5,a5,16
	sb	a5,43(zero)
	andi	a5,a0,32
	beq	a5,zero,.L65
.L76:
	lbu	a5,43(zero)
	ori	a5,a5,32
	sb	a5,43(zero)
	andi	a5,a0,64
	beq	a5,zero,.L67
.L77:
	lbu	a5,43(zero)
	slliw	a0,a0,24
	sraiw	a0,a0,24
	ori	a5,a5,64
	sb	a5,43(zero)
	lbu	a5,43(zero)
	blt	a0,zero,.L71
.L69:
	andi	a5,a5,127
	sb	a5,43(zero)
	ret
.L55:
	lbu	a5,43(zero)
	andi	a5,a5,254
	sb	a5,43(zero)
	andi	a5,a0,2
	bne	a5,zero,.L72
.L57:
	lbu	a5,43(zero)
	andi	a5,a5,253
	sb	a5,43(zero)
	andi	a5,a0,4
	bne	a5,zero,.L73
.L59:
	lbu	a5,43(zero)
	andi	a5,a5,251
	sb	a5,43(zero)
	andi	a5,a0,8
	bne	a5,zero,.L74
.L61:
	lbu	a5,43(zero)
	andi	a5,a5,247
	sb	a5,43(zero)
	andi	a5,a0,16
	bne	a5,zero,.L75
.L63:
	lbu	a5,43(zero)
	andi	a5,a5,239
	sb	a5,43(zero)
	andi	a5,a0,32
	bne	a5,zero,.L76
.L65:
	lbu	a5,43(zero)
	andi	a5,a5,223
	sb	a5,43(zero)
	andi	a5,a0,64
	bne	a5,zero,.L77
.L67:
	lbu	a5,43(zero)
	slliw	a0,a0,24
	sraiw	a0,a0,24
	andi	a5,a5,191
	sb	a5,43(zero)
	lbu	a5,43(zero)
	bge	a0,zero,.L69
.L71:
	ori	a5,a5,128
	sb	a5,43(zero)
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
	li	a0,16384
	addi	a0,a0,-384
	ori	a5,a5,1
	sb	a5,0(s0)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s0)
	ld	s0,0(sp)
	ld	ra,8(sp)
	addi	sp,sp,16
	tail	__builtin_avr_delay_cycles
	.size	Lcd8_Cmd, .-Lcd8_Cmd
	.align	1
	.globl	Lcd8_Clear
	.type	Lcd8_Clear, @function
Lcd8_Clear:
	addi	sp,sp,-16
	sd	s0,0(sp)
	sd	ra,8(sp)
	li	s0,37
	lbu	a4,0(s0)
	li	a5,43
	li	a0,16384
	andi	a4,a4,253
	sb	a4,0(s0)
	lbu	a4,0(a5)
	addi	a0,a0,-384
	ori	a4,a4,1
	sb	a4,0(a5)
	lbu	a4,0(a5)
	andi	a4,a4,253
	sb	a4,0(a5)
	lbu	a4,0(a5)
	andi	a4,a4,251
	sb	a4,0(a5)
	lbu	a4,0(a5)
	andi	a4,a4,247
	sb	a4,0(a5)
	lbu	a4,0(a5)
	andi	a4,a4,239
	sb	a4,0(a5)
	lbu	a4,0(a5)
	andi	a4,a4,223
	sb	a4,0(a5)
	lbu	a4,0(a5)
	andi	a4,a4,191
	sb	a4,0(a5)
	lbu	a4,0(a5)
	andi	a4,a4,127
	sb	a4,0(a5)
	lbu	a5,0(s0)
	ori	a5,a5,1
	sb	a5,0(s0)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s0)
	ld	s0,0(sp)
	ld	ra,8(sp)
	addi	sp,sp,16
	tail	__builtin_avr_delay_cycles
	.size	Lcd8_Clear, .-Lcd8_Clear
	.align	1
	.globl	Lcd8_Set_Cursor
	.type	Lcd8_Set_Cursor, @function
Lcd8_Set_Cursor:
	addi	sp,sp,-16
	sd	ra,8(sp)
	li	a5,1
	beq	a0,a5,.L87
	li	a5,2
	beq	a0,a5,.L88
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
.L87:
	lbu	a5,37(zero)
	addiw	a1,a1,-128
.L86:
	andi	a5,a5,253
	andi	a0,a1,0xff
	sb	a5,37(zero)
	call	Lcd8_Port
	lbu	a5,37(zero)
	li	a0,16384
	addi	a0,a0,-384
	ori	a5,a5,1
	sb	a5,37(zero)
	call	__builtin_avr_delay_cycles
	lbu	a5,37(zero)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,37(zero)
	ld	ra,8(sp)
	addi	sp,sp,16
	tail	__builtin_avr_delay_cycles
.L88:
	lbu	a5,37(zero)
	addiw	a1,a1,-64
	j	.L86
	.size	Lcd8_Set_Cursor, .-Lcd8_Set_Cursor
	.align	1
	.globl	Lcd8_Init
	.type	Lcd8_Init, @function
Lcd8_Init:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	li	s0,37
	lbu	a5,0(s0)
	li	a0,319488
	addi	a0,a0,512
	andi	a5,a5,253
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,254
	sb	a5,0(s0)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	li	a0,48
	andi	a5,a5,253
	sb	a5,0(s0)
	call	Lcd8_Port
	lbu	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	ori	a5,a5,1
	sb	a5,0(s0)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s0)
	call	__builtin_avr_delay_cycles
	li	a0,81920
	addi	a0,a0,-1920
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	li	a0,48
	andi	a5,a5,253
	sb	a5,0(s0)
	call	Lcd8_Port
	lbu	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	ori	a5,a5,1
	sb	a5,0(s0)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s0)
	call	__builtin_avr_delay_cycles
	li	a0,16384
	addi	a0,a0,-384
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	li	a0,48
	andi	a5,a5,253
	sb	a5,0(s0)
	call	Lcd8_Port
	lbu	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	ori	a5,a5,1
	sb	a5,0(s0)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s0)
	call	__builtin_avr_delay_cycles
	li	a0,159744
	addi	a0,a0,256
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	li	a0,56
	andi	a5,a5,253
	sb	a5,0(s0)
	call	Lcd8_Port
	lbu	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	ori	a5,a5,1
	sb	a5,0(s0)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s0)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	li	a0,12
	andi	a5,a5,253
	sb	a5,0(s0)
	call	Lcd8_Port
	lbu	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	ori	a5,a5,1
	sb	a5,0(s0)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s0)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	li	a0,1
	andi	a5,a5,253
	sb	a5,0(s0)
	call	Lcd8_Port
	lbu	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	ori	a5,a5,1
	sb	a5,0(s0)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s0)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	li	a0,6
	andi	a5,a5,253
	sb	a5,0(s0)
	call	Lcd8_Port
	lbu	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	ori	a5,a5,1
	sb	a5,0(s0)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s0)
	ld	s0,0(sp)
	ld	ra,8(sp)
	addi	sp,sp,16
	tail	__builtin_avr_delay_cycles
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
	li	a0,16384
	addi	a0,a0,-384
	ori	a5,a5,1
	sb	a5,0(s0)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s0)
	ld	s0,0(sp)
	ld	ra,8(sp)
	addi	sp,sp,16
	tail	__builtin_avr_delay_cycles
	.size	Lcd8_Write_Char, .-Lcd8_Write_Char
	.align	1
	.globl	Lcd8_Write_String
	.type	Lcd8_Write_String, @function
Lcd8_Write_String:
	addi	sp,sp,-32
	sd	s0,16(sp)
	sd	ra,24(sp)
	mv	s0,a0
	lbu	a0,0(a0)
	beq	a0,zero,.L93
	sd	s1,8(sp)
	li	s1,16384
	addi	s0,s0,1
	addi	s1,s1,-384
.L95:
	lbu	a5,37(zero)
	addi	s0,s0,1
	ori	a5,a5,2
	sb	a5,37(zero)
	call	Lcd8_Port
	lbu	a5,37(zero)
	mv	a0,s1
	ori	a5,a5,1
	sb	a5,37(zero)
	call	__builtin_avr_delay_cycles
	lbu	a5,37(zero)
	mv	a0,s1
	andi	a5,a5,254
	sb	a5,37(zero)
	call	__builtin_avr_delay_cycles
	lbu	a0,-1(s0)
	bne	a0,zero,.L95
	ld	s1,8(sp)
.L93:
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	Lcd8_Write_String, .-Lcd8_Write_String
	.align	1
	.globl	Lcd8_Shift_Right
	.type	Lcd8_Shift_Right, @function
Lcd8_Shift_Right:
	addi	sp,sp,-16
	sd	s0,0(sp)
	sd	ra,8(sp)
	li	s0,37
	lbu	a4,0(s0)
	li	a5,43
	li	a0,16384
	andi	a4,a4,253
	sb	a4,0(s0)
	lbu	a4,0(a5)
	addi	a0,a0,-384
	andi	a4,a4,254
	sb	a4,0(a5)
	lbu	a4,0(a5)
	andi	a4,a4,253
	sb	a4,0(a5)
	lbu	a4,0(a5)
	ori	a4,a4,4
	sb	a4,0(a5)
	lbu	a4,0(a5)
	ori	a4,a4,8
	sb	a4,0(a5)
	lbu	a4,0(a5)
	ori	a4,a4,16
	sb	a4,0(a5)
	lbu	a4,0(a5)
	andi	a4,a4,223
	sb	a4,0(a5)
	lbu	a4,0(a5)
	andi	a4,a4,191
	sb	a4,0(a5)
	lbu	a4,0(a5)
	andi	a4,a4,127
	sb	a4,0(a5)
	lbu	a5,0(s0)
	ori	a5,a5,1
	sb	a5,0(s0)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s0)
	ld	s0,0(sp)
	ld	ra,8(sp)
	addi	sp,sp,16
	tail	__builtin_avr_delay_cycles
	.size	Lcd8_Shift_Right, .-Lcd8_Shift_Right
	.align	1
	.globl	Lcd8_Shift_Left
	.type	Lcd8_Shift_Left, @function
Lcd8_Shift_Left:
	addi	sp,sp,-16
	sd	s0,0(sp)
	sd	ra,8(sp)
	li	s0,37
	lbu	a4,0(s0)
	li	a5,43
	li	a0,16384
	andi	a4,a4,253
	sb	a4,0(s0)
	lbu	a4,0(a5)
	addi	a0,a0,-384
	andi	a4,a4,254
	sb	a4,0(a5)
	lbu	a4,0(a5)
	andi	a4,a4,253
	sb	a4,0(a5)
	lbu	a4,0(a5)
	andi	a4,a4,251
	sb	a4,0(a5)
	lbu	a4,0(a5)
	ori	a4,a4,8
	sb	a4,0(a5)
	lbu	a4,0(a5)
	ori	a4,a4,16
	sb	a4,0(a5)
	lbu	a4,0(a5)
	andi	a4,a4,223
	sb	a4,0(a5)
	lbu	a4,0(a5)
	andi	a4,a4,191
	sb	a4,0(a5)
	lbu	a4,0(a5)
	andi	a4,a4,127
	sb	a4,0(a5)
	lbu	a5,0(s0)
	ori	a5,a5,1
	sb	a5,0(s0)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s0)
	ld	s0,0(sp)
	ld	ra,8(sp)
	addi	sp,sp,16
	tail	__builtin_avr_delay_cycles
	.size	Lcd8_Shift_Left, .-Lcd8_Shift_Left
	.align	1
	.globl	Lcd4_Port
	.type	Lcd4_Port, @function
Lcd4_Port:
	andi	a5,a0,1
	beq	a5,zero,.L106
	lbu	a5,43(zero)
	ori	a5,a5,16
	sb	a5,43(zero)
	andi	a5,a0,2
	beq	a5,zero,.L108
.L114:
	lbu	a5,43(zero)
	ori	a5,a5,32
	sb	a5,43(zero)
	andi	a5,a0,4
	beq	a5,zero,.L110
.L115:
	lbu	a5,43(zero)
	andi	a0,a0,8
	ori	a5,a5,64
	sb	a5,43(zero)
	lbu	a5,43(zero)
	beq	a0,zero,.L112
.L116:
	ori	a5,a5,128
	sb	a5,43(zero)
	ret
.L106:
	lbu	a5,43(zero)
	andi	a5,a5,239
	sb	a5,43(zero)
	andi	a5,a0,2
	bne	a5,zero,.L114
.L108:
	lbu	a5,43(zero)
	andi	a5,a5,223
	sb	a5,43(zero)
	andi	a5,a0,4
	bne	a5,zero,.L115
.L110:
	lbu	a5,43(zero)
	andi	a0,a0,8
	andi	a5,a5,191
	sb	a5,43(zero)
	lbu	a5,43(zero)
	bne	a0,zero,.L116
.L112:
	andi	a5,a5,127
	sb	a5,43(zero)
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
	li	a0,16384
	addi	a0,a0,-384
	ori	a5,a5,1
	sb	a5,0(s0)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s0)
	ld	s0,0(sp)
	ld	ra,8(sp)
	addi	sp,sp,16
	tail	__builtin_avr_delay_cycles
	.size	Lcd4_Cmd, .-Lcd4_Cmd
	.align	1
	.globl	Lcd4_Clear
	.type	Lcd4_Clear, @function
Lcd4_Clear:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	sd	s1,8(sp)
	li	s1,37
	lbu	a5,0(s1)
	li	s0,43
	li	a0,16384
	andi	a5,a5,253
	sb	a5,0(s1)
	lbu	a5,0(s0)
	addi	a0,a0,-384
	andi	a5,a5,239
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,223
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,191
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,127
	sb	a5,0(s0)
	lbu	a5,0(s1)
	ori	a5,a5,1
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,253
	sb	a5,0(s1)
	lbu	a5,0(s0)
	ori	a5,a5,16
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,223
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,191
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,127
	sb	a5,0(s0)
	lbu	a5,0(s1)
	ori	a5,a5,1
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s1)
	ld	s0,16(sp)
	ld	ra,24(sp)
	ld	s1,8(sp)
	addi	sp,sp,32
	tail	__builtin_avr_delay_cycles
	.size	Lcd4_Clear, .-Lcd4_Clear
	.align	1
	.globl	Lcd4_Set_Cursor
	.type	Lcd4_Set_Cursor, @function
Lcd4_Set_Cursor:
	addi	sp,sp,-16
	sd	s0,0(sp)
	sd	ra,8(sp)
	li	a5,1
	mv	s0,a1
	beq	a0,a5,.L126
	li	a5,2
	beq	a0,a5,.L127
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
.L126:
	lbu	a5,37(zero)
	xori	a0,a1,128
	srli	a0,a0,4
	andi	a5,a5,253
	sb	a5,37(zero)
.L125:
	call	Lcd4_Port
	lbu	a5,37(zero)
	li	a0,16384
	addi	a0,a0,-384
	ori	a5,a5,1
	sb	a5,37(zero)
	call	__builtin_avr_delay_cycles
	lbu	a5,37(zero)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,37(zero)
	call	__builtin_avr_delay_cycles
	lbu	a5,37(zero)
	andi	a0,s0,15
	andi	a5,a5,253
	sb	a5,37(zero)
	call	Lcd4_Port
	lbu	a5,37(zero)
	li	a0,16384
	addi	a0,a0,-384
	ori	a5,a5,1
	sb	a5,37(zero)
	call	__builtin_avr_delay_cycles
	lbu	a5,37(zero)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,37(zero)
	ld	s0,0(sp)
	ld	ra,8(sp)
	addi	sp,sp,16
	tail	__builtin_avr_delay_cycles
.L127:
	lbu	a5,37(zero)
	addiw	a0,a1,-64
	srli	a0,a0,4
	andi	a5,a5,253
	sb	a5,37(zero)
	andi	a0,a0,15
	j	.L125
	.size	Lcd4_Set_Cursor, .-Lcd4_Set_Cursor
	.align	1
	.globl	Lcd4_Init
	.type	Lcd4_Init, @function
Lcd4_Init:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	sd	s1,8(sp)
	li	s0,43
	lbu	a5,0(s0)
	li	a0,319488
	addi	a0,a0,512
	andi	a5,a5,239
	sb	a5,0(s0)
	lbu	a5,0(s0)
	li	s1,37
	andi	a5,a5,223
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,191
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,127
	sb	a5,0(s0)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,253
	sb	a5,0(s1)
	lbu	a5,0(s0)
	ori	a5,a5,16
	sb	a5,0(s0)
	lbu	a5,0(s0)
	ori	a5,a5,32
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,191
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,127
	sb	a5,0(s0)
	lbu	a5,0(s1)
	ori	a5,a5,1
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	li	a0,81920
	addi	a0,a0,-1920
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,253
	sb	a5,0(s1)
	lbu	a5,0(s0)
	ori	a5,a5,16
	sb	a5,0(s0)
	lbu	a5,0(s0)
	ori	a5,a5,32
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,191
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,127
	sb	a5,0(s0)
	lbu	a5,0(s1)
	ori	a5,a5,1
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	li	a0,176128
	addi	a0,a0,-128
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,253
	sb	a5,0(s1)
	lbu	a5,0(s0)
	ori	a5,a5,16
	sb	a5,0(s0)
	lbu	a5,0(s0)
	ori	a5,a5,32
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,191
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,127
	sb	a5,0(s0)
	lbu	a5,0(s1)
	ori	a5,a5,1
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,253
	sb	a5,0(s1)
	lbu	a5,0(s0)
	andi	a5,a5,239
	sb	a5,0(s0)
	lbu	a5,0(s0)
	ori	a5,a5,32
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,191
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,127
	sb	a5,0(s0)
	lbu	a5,0(s1)
	ori	a5,a5,1
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,253
	sb	a5,0(s1)
	lbu	a5,0(s0)
	andi	a5,a5,239
	sb	a5,0(s0)
	lbu	a5,0(s0)
	ori	a5,a5,32
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,191
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,127
	sb	a5,0(s0)
	lbu	a5,0(s1)
	ori	a5,a5,1
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,253
	sb	a5,0(s1)
	lbu	a5,0(s0)
	andi	a5,a5,239
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,223
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,191
	sb	a5,0(s0)
	lbu	a5,0(s0)
	ori	a5,a5,128
	sb	a5,0(s0)
	lbu	a5,0(s1)
	ori	a5,a5,1
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,253
	sb	a5,0(s1)
	lbu	a5,0(s0)
	andi	a5,a5,239
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,223
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,191
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,127
	sb	a5,0(s0)
	lbu	a5,0(s1)
	ori	a5,a5,1
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,253
	sb	a5,0(s1)
	lbu	a5,0(s0)
	andi	a5,a5,239
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,223
	sb	a5,0(s0)
	lbu	a5,0(s0)
	ori	a5,a5,64
	sb	a5,0(s0)
	lbu	a5,0(s0)
	ori	a5,a5,128
	sb	a5,0(s0)
	lbu	a5,0(s1)
	ori	a5,a5,1
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,253
	sb	a5,0(s1)
	lbu	a5,0(s0)
	andi	a5,a5,239
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,223
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,191
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,127
	sb	a5,0(s0)
	lbu	a5,0(s1)
	ori	a5,a5,1
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,253
	sb	a5,0(s1)
	lbu	a5,0(s0)
	andi	a5,a5,239
	sb	a5,0(s0)
	lbu	a5,0(s0)
	ori	a5,a5,32
	sb	a5,0(s0)
	lbu	a5,0(s0)
	ori	a5,a5,64
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,127
	sb	a5,0(s0)
	lbu	a5,0(s1)
	ori	a5,a5,1
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s1)
	ld	s0,16(sp)
	ld	ra,24(sp)
	ld	s1,8(sp)
	addi	sp,sp,32
	tail	__builtin_avr_delay_cycles
	.size	Lcd4_Init, .-Lcd4_Init
	.align	1
	.globl	Lcd4_Write_Char
	.type	Lcd4_Write_Char, @function
Lcd4_Write_Char:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	sd	s1,8(sp)
	li	s0,37
	lbu	a5,0(s0)
	mv	s1,a0
	srli	a0,a0,4
	ori	a5,a5,2
	sb	a5,0(s0)
	call	Lcd4_Port
	lbu	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	ori	a5,a5,1
	sb	a5,0(s0)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s0)
	call	__builtin_avr_delay_cycles
	andi	a0,s1,15
	call	Lcd4_Port
	lbu	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	ori	a5,a5,1
	sb	a5,0(s0)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s0)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s0)
	ld	s0,16(sp)
	ld	ra,24(sp)
	ld	s1,8(sp)
	addi	sp,sp,32
	tail	__builtin_avr_delay_cycles
	.size	Lcd4_Write_Char, .-Lcd4_Write_Char
	.align	1
	.globl	Lcd4_Write_String
	.type	Lcd4_Write_String, @function
Lcd4_Write_String:
	addi	sp,sp,-16
	sd	s0,0(sp)
	sd	ra,8(sp)
	mv	s0,a0
	lbu	a0,0(a0)
	beq	a0,zero,.L132
	addi	s0,s0,1
.L134:
	call	Lcd4_Write_Char
	lbu	a0,0(s0)
	addi	s0,s0,1
	bne	a0,zero,.L134
.L132:
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	Lcd4_Write_String, .-Lcd4_Write_String
	.align	1
	.globl	Lcd4_Shift_Right
	.type	Lcd4_Shift_Right, @function
Lcd4_Shift_Right:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	sd	s1,8(sp)
	li	s1,37
	lbu	a5,0(s1)
	li	s0,43
	li	a0,16384
	andi	a5,a5,253
	sb	a5,0(s1)
	lbu	a5,0(s0)
	addi	a0,a0,-384
	ori	a5,a5,16
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,223
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,191
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,127
	sb	a5,0(s0)
	lbu	a5,0(s1)
	ori	a5,a5,1
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,253
	sb	a5,0(s1)
	lbu	a5,0(s0)
	andi	a5,a5,239
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,223
	sb	a5,0(s0)
	lbu	a5,0(s0)
	ori	a5,a5,64
	sb	a5,0(s0)
	lbu	a5,0(s0)
	ori	a5,a5,128
	sb	a5,0(s0)
	lbu	a5,0(s1)
	ori	a5,a5,1
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s1)
	ld	s0,16(sp)
	ld	ra,24(sp)
	ld	s1,8(sp)
	addi	sp,sp,32
	tail	__builtin_avr_delay_cycles
	.size	Lcd4_Shift_Right, .-Lcd4_Shift_Right
	.align	1
	.globl	Lcd4_Shift_Left
	.type	Lcd4_Shift_Left, @function
Lcd4_Shift_Left:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	sd	s1,8(sp)
	li	s1,37
	lbu	a5,0(s1)
	li	s0,43
	li	a0,16384
	andi	a5,a5,253
	sb	a5,0(s1)
	lbu	a5,0(s0)
	addi	a0,a0,-384
	ori	a5,a5,16
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,223
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,191
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,127
	sb	a5,0(s0)
	lbu	a5,0(s1)
	ori	a5,a5,1
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,253
	sb	a5,0(s1)
	lbu	a5,0(s0)
	andi	a5,a5,239
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,223
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a5,a5,191
	sb	a5,0(s0)
	lbu	a5,0(s0)
	ori	a5,a5,128
	sb	a5,0(s0)
	lbu	a5,0(s1)
	ori	a5,a5,1
	sb	a5,0(s1)
	call	__builtin_avr_delay_cycles
	lbu	a5,0(s1)
	li	a0,16384
	addi	a0,a0,-384
	andi	a5,a5,254
	sb	a5,0(s1)
	ld	s0,16(sp)
	ld	ra,24(sp)
	ld	s1,8(sp)
	addi	sp,sp,32
	tail	__builtin_avr_delay_cycles
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
	li	a3,194
	ori	a4,a4,8
	sb	a4,0(a5)
	lbu	a4,0(a5)
	ori	a4,a4,16
	sb	a4,0(a5)
	lbu	a5,0(a3)
	ori	a5,a5,6
	sb	a5,0(a3)
	ret
	.size	Config_USART, .-Config_USART
	.align	1
	.globl	USART_Receive
	.type	USART_Receive, @function
USART_Receive:
	lbu	a5,192(zero)
	li	a0,0
	slliw	a5,a5,24
	sraiw	a5,a5,24
	blt	a5,zero,.L148
	ret
.L148:
	lbu	a0,198(zero)
	andi	a0,a0,0xff
	ret
	.size	USART_Receive, .-USART_Receive
	.align	1
	.globl	USART_Transmit
	.type	USART_Transmit, @function
USART_Transmit:
.L150:
	lbu	a5,192(zero)
	andi	a5,a5,32
	beq	a5,zero,.L150
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
	li	a0,16384
	sb	s1,0(s0)
	addi	a0,a0,-384
	call	__builtin_avr_delay_cycles
	li	a0,32002048
	sb	zero,0(s0)
	addi	a0,a0,-2048
	call	__builtin_avr_delay_cycles
	li	a0,24576
	sb	s1,0(s0)
	addi	a0,a0,-576
	call	__builtin_avr_delay_cycles
	li	a0,32002048
	sb	zero,0(s0)
	addi	a0,a0,-2048
	call	__builtin_avr_delay_cycles
	sb	s1,0(s0)
	sb	zero,0(s0)
	li	a0,16384
	sb	s1,0(s0)
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
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-96
	sd	ra,88(sp)
	sd	s0,80(sp)
	sd	s1,72(sp)
	sd	s2,64(sp)
	sd	s3,56(sp)
	sd	s4,48(sp)
	sd	s5,40(sp)
	sd	s6,32(sp)
	sd	s7,24(sp)
	sd	s8,16(sp)
	sd	s9,8(sp)
	lbu	a5,36(zero)
	ori	a5,a5,32
	sb	a5,36(zero)
	call	Config_USART
	lbu	a5,36(zero)
	ori	a5,a5,32
	sb	a5,36(zero)
 #APP
# 97 "main.c" 1
	sei
# 0 "" 2
 #NO_APP
	call	SWseriale_begin
	call	Lcd4_Init
	li	a0,8
	call	Lcd4_Cmd
	li	a0,0
	call	Lcd4_Cmd
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	Lcd4_Write_String
	li	a5,1
	sb	a5,39(zero)
	li	s7,48001024
	li	s3,3198976
	li	s1,16384
	lui	s6,%hi(.LC1+1)
	lui	s9,%hi(.LC2+1)
	sb	zero,40(zero)
	lui	s2,%hi(rx)
	addi	s6,s6,%lo(.LC1+1)
	addi	s9,s9,%lo(.LC2+1)
	li	s5,75
	li	s8,88
	addi	s7,s7,-1024
	addi	s3,s3,1024
	li	s4,79
	addi	s1,s1,-384
.L156:
	call	SWseriale_available
	bne	a0,zero,.L173
.L157:
	lbu	a5,192(zero)
	slliw	a5,a5,24
	sraiw	a5,a5,24
	blt	a5,zero,.L159
.L174:
	sb	zero,%lo(rx)(s2)
	call	SWseriale_available
	beq	a0,zero,.L157
.L173:
	call	SWseriale_read
.L158:
	lbu	a5,192(zero)
	andi	a5,a5,32
	beq	a5,zero,.L158
	sb	a0,198(zero)
	lbu	a5,192(zero)
	slliw	a5,a5,24
	sraiw	a5,a5,24
	bge	a5,zero,.L174
.L159:
	lbu	a5,198(zero)
	andi	a5,a5,0xff
	sb	a5,%lo(rx)(s2)
	bne	a5,s5,.L161
	mv	s0,s6
	li	a0,65
.L162:
	call	Lcd4_Write_Char
	lbu	a0,0(s0)
	addi	s0,s0,1
	bne	a0,zero,.L162
	lbu	a5,37(zero)
	mv	a0,s3
	ori	a5,a5,32
	sb	a5,37(zero)
	call	__builtin_avr_delay_cycles
	lbu	a5,37(zero)
	mv	a0,s3
	andi	a5,a5,223
	sb	a5,37(zero)
	call	__builtin_avr_delay_cycles
	sb	s4,%lo(rx)(s2)
	call	Gate
.L172:
	lbu	a5,37(zero)
	mv	a0,s1
	andi	a5,a5,253
	sb	a5,37(zero)
	lbu	a5,43(zero)
	andi	a5,a5,239
	sb	a5,43(zero)
	lbu	a5,43(zero)
	andi	a5,a5,223
	sb	a5,43(zero)
	lbu	a5,43(zero)
	andi	a5,a5,191
	sb	a5,43(zero)
	lbu	a5,43(zero)
	andi	a5,a5,127
	sb	a5,43(zero)
	lbu	a5,37(zero)
	ori	a5,a5,1
	sb	a5,37(zero)
	call	__builtin_avr_delay_cycles
	lbu	a5,37(zero)
	mv	a0,s1
	andi	a5,a5,254
	sb	a5,37(zero)
	call	__builtin_avr_delay_cycles
	lbu	a5,37(zero)
	mv	a0,s1
	andi	a5,a5,253
	sb	a5,37(zero)
	lbu	a5,43(zero)
	ori	a5,a5,16
	sb	a5,43(zero)
	lbu	a5,43(zero)
	andi	a5,a5,223
	sb	a5,43(zero)
	lbu	a5,43(zero)
	andi	a5,a5,191
	sb	a5,43(zero)
	lbu	a5,43(zero)
	andi	a5,a5,127
	sb	a5,43(zero)
	lbu	a5,37(zero)
	ori	a5,a5,1
	sb	a5,37(zero)
	call	__builtin_avr_delay_cycles
	lbu	a5,37(zero)
	mv	a0,s1
	andi	a5,a5,254
	sb	a5,37(zero)
	call	__builtin_avr_delay_cycles
	j	.L156
.L161:
	bne	a5,s8,.L156
	mv	s0,s9
	li	a0,65
.L163:
	call	Lcd4_Write_Char
	lbu	a0,0(s0)
	addi	s0,s0,1
	bne	a0,zero,.L163
	lbu	a5,37(zero)
	mv	a0,s7
	ori	a5,a5,32
	sb	a5,37(zero)
	call	__builtin_avr_delay_cycles
	lbu	a5,37(zero)
	mv	a0,s3
	andi	a5,a5,223
	sb	a5,37(zero)
	call	__builtin_avr_delay_cycles
	sb	s4,%lo(rx)(s2)
	j	.L172
	.size	main, .-main
	.globl	rx
	.section	.sbss,"aw",@nobits
	.type	rx, @object
	.size	rx, 1
rx:
	.zero	1
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
