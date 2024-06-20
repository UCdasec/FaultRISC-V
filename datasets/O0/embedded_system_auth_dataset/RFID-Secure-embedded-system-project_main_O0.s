	.file	"main.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	rx
	.section	.sbss,"aw",@nobits
	.type	rx, @object
	.size	rx, 1
rx:
	.zero	1
	.text
	.align	1
	.globl	Config_USART
	.type	Config_USART, @function
Config_USART:
	addi	sp,sp,-16
	sd	s0,8(sp)
	addi	s0,sp,16
	li	a5,196
	li	a4,103
	sb	a4,0(a5)
	li	a5,197
	sb	zero,0(a5)
	li	a5,193
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,193
	ori	a4,a4,8
	andi	a4,a4,0xff
	sb	a4,0(a5)
	li	a5,193
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,193
	ori	a4,a4,16
	andi	a4,a4,0xff
	sb	a4,0(a5)
	li	a5,194
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,194
	ori	a4,a4,6
	andi	a4,a4,0xff
	sb	a4,0(a5)
	nop
	ld	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	Config_USART, .-Config_USART
	.align	1
	.globl	USART_Receive
	.type	USART_Receive, @function
USART_Receive:
	addi	sp,sp,-16
	sd	s0,8(sp)
	addi	s0,sp,16
	li	a5,192
	lbu	a5,0(a5)
	andi	a5,a5,0xff
	slliw	a5,a5,24
	sraiw	a5,a5,24
	bge	a5,zero,.L3
	li	a5,198
	lbu	a5,0(a5)
	andi	a5,a5,0xff
	j	.L4
.L3:
	li	a5,0
.L4:
	mv	a0,a5
	ld	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	USART_Receive, .-USART_Receive
	.align	1
	.globl	USART_Transmit
	.type	USART_Transmit, @function
USART_Transmit:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	nop
.L6:
	li	a5,192
	lbu	a5,0(a5)
	andi	a5,a5,0xff
	sext.w	a5,a5
	andi	a5,a5,32
	sext.w	a5,a5
	beq	a5,zero,.L6
	ld	a4,-24(s0)
	li	a5,198
	andi	a4,a4,0xff
	sb	a4,0(a5)
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	USART_Transmit, .-USART_Transmit
	.align	1
	.globl	Gate
	.type	Gate, @function
Gate:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	li	a5,40
	li	a4,1
	sb	a4,0(a5)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	fmv.d	fa0,fa5
	call	_delay_us
	li	a5,40
	sb	zero,0(a5)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmv.d	fa0,fa5
	call	_delay_ms
	li	a5,40
	li	a4,1
	sb	a4,0(a5)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fmv.d	fa0,fa5
	call	_delay_us
	li	a5,40
	sb	zero,0(a5)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmv.d	fa0,fa5
	call	_delay_ms
	li	a5,40
	li	a4,1
	sb	a4,0(a5)
	li	a5,40
	sb	zero,0(a5)
	li	a5,40
	li	a4,1
	sb	a4,0(a5)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	fmv.d	fa0,fa5
	call	_delay_us
	li	a5,40
	sb	zero,0(a5)
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	Gate, .-Gate
	.section	.rodata
	.align	3
.LC3:
	.string	"Swipe the Card"
	.align	3
.LC4:
	.string	"Access Grant"
	.align	3
.LC6:
	.string	"Access Denied"
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	li	a5,36
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,36
	ori	a4,a4,32
	andi	a4,a4,0xff
	sb	a4,0(a5)
	call	Config_USART
	li	a5,36
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,36
	ori	a4,a4,32
	andi	a4,a4,0xff
	sb	a4,0(a5)
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
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	Lcd4_Write_String
	li	a5,39
	li	a4,1
	sb	a4,0(a5)
	li	a5,40
	sb	zero,0(a5)
.L12:
	call	SWseriale_available
	mv	a5,a0
	beq	a5,zero,.L9
	call	SWseriale_read
	mv	a5,a0
	sb	a5,-17(s0)
	lbu	a5,-17(s0)
	mv	a0,a5
	call	USART_Transmit
.L9:
	call	USART_Receive
	mv	a5,a0
	mv	a4,a5
	lui	a5,%hi(rx)
	sb	a4,%lo(rx)(a5)
	lui	a5,%hi(rx)
	lbu	a5,%lo(rx)(a5)
	mv	a4,a5
	li	a5,75
	bne	a4,a5,.L10
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	Lcd4_Write_String
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	ori	a4,a4,32
	andi	a4,a4,0xff
	sb	a4,0(a5)
	lui	a5,%hi(.LC5)
	fld	fa5,%lo(.LC5)(a5)
	fmv.d	fa0,fa5
	call	_delay_ms
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	andi	a4,a4,-33
	andi	a4,a4,0xff
	sb	a4,0(a5)
	lui	a5,%hi(.LC5)
	fld	fa5,%lo(.LC5)(a5)
	fmv.d	fa0,fa5
	call	_delay_ms
	lui	a5,%hi(rx)
	li	a4,79
	sb	a4,%lo(rx)(a5)
	call	Gate
	call	Lcd4_Clear
	j	.L12
.L10:
	lui	a5,%hi(rx)
	lbu	a5,%lo(rx)(a5)
	mv	a4,a5
	li	a5,88
	bne	a4,a5,.L12
	lui	a5,%hi(.LC6)
	addi	a0,a5,%lo(.LC6)
	call	Lcd4_Write_String
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	ori	a4,a4,32
	andi	a4,a4,0xff
	sb	a4,0(a5)
	lui	a5,%hi(.LC7)
	fld	fa5,%lo(.LC7)(a5)
	fmv.d	fa0,fa5
	call	_delay_ms
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	andi	a4,a4,-33
	andi	a4,a4,0xff
	sb	a4,0(a5)
	lui	a5,%hi(.LC5)
	fld	fa5,%lo(.LC5)(a5)
	fmv.d	fa0,fa5
	call	_delay_ms
	lui	a5,%hi(rx)
	li	a4,79
	sb	a4,%lo(rx)(a5)
	call	Lcd4_Clear
	j	.L12
	.size	main, .-main
	.section	.rodata
	.align	3
.LC0:
	.word	0
	.word	1083129856
	.align	3
.LC1:
	.word	0
	.word	1084178432
	.align	3
.LC2:
	.word	0
	.word	1083666432
	.align	3
.LC5:
	.word	0
	.word	1080623104
	.align	3
.LC7:
	.word	0
	.word	1084715008
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
