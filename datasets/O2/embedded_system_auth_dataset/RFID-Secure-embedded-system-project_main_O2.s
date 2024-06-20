	.file	"main.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
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
	blt	a5,zero,.L6
	ret
.L6:
	lbu	a0,198(zero)
	andi	a0,a0,0xff
	ret
	.size	USART_Receive, .-USART_Receive
	.align	1
	.globl	USART_Transmit
	.type	USART_Transmit, @function
USART_Transmit:
.L8:
	lbu	a5,192(zero)
	andi	a5,a5,32
	beq	a5,zero,.L8
	andi	a0,a0,0xff
	sb	a0,198(zero)
	ret
	.size	USART_Transmit, .-USART_Transmit
	.align	1
	.globl	Gate
	.type	Gate, @function
Gate:
	addi	sp,sp,-48
	lui	a5,%hi(.LC0)
	fsd	fs0,8(sp)
	fld	fs0,%lo(.LC0)(a5)
	sd	ra,40(sp)
	sd	s0,32(sp)
	fmv.d	fa0,fs0
	sd	s1,24(sp)
	fsd	fs1,0(sp)
	li	s0,40
	li	s1,1
	sb	s1,0(s0)
	call	_delay_us
	lui	a5,%hi(.LC1)
	fld	fs1,%lo(.LC1)(a5)
	sb	zero,0(s0)
	fmv.d	fa0,fs1
	call	_delay_ms
	lui	a5,%hi(.LC2)
	fld	fa0,%lo(.LC2)(a5)
	sb	s1,0(s0)
	call	_delay_us
	fmv.d	fa0,fs1
	sb	zero,0(s0)
	call	_delay_ms
	fmv.d	fa0,fs0
	sb	s1,0(s0)
	sb	zero,0(s0)
	sb	s1,0(s0)
	call	_delay_us
	sb	zero,0(s0)
	ld	ra,40(sp)
	ld	s0,32(sp)
	ld	s1,24(sp)
	fld	fs0,8(sp)
	fld	fs1,0(sp)
	addi	sp,sp,48
	jr	ra
	.size	Gate, .-Gate
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC3:
	.string	"Swipe the Card"
	.align	3
.LC4:
	.string	"Access Grant"
	.align	3
.LC6:
	.string	"Access Denied"
	.section	.text.startup,"ax",@progbits
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
	fsd	fs0,8(sp)
	fsd	fs1,0(sp)
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
	li	a1,0
	li	a0,1
	call	Lcd4_Set_Cursor
	lui	a0,%hi(.LC3)
	addi	a0,a0,%lo(.LC3)
	call	Lcd4_Write_String
	lui	a5,%hi(.LC7)
	fld	fs1,%lo(.LC7)(a5)
	lui	a5,%hi(.LC5)
	fld	fs0,%lo(.LC5)(a5)
	li	a5,1
	sb	a5,39(zero)
	sb	zero,40(zero)
	lui	s0,%hi(rx)
	lui	s3,%hi(.LC4)
	lui	s4,%hi(.LC6)
	li	s2,75
	li	s5,88
	li	s1,79
.L14:
	call	SWseriale_available
	bne	a0,zero,.L26
.L15:
	lbu	a5,192(zero)
	slliw	a5,a5,24
	sraiw	a5,a5,24
	blt	a5,zero,.L17
.L27:
	sb	zero,%lo(rx)(s0)
	call	SWseriale_available
	beq	a0,zero,.L15
.L26:
	call	SWseriale_read
.L16:
	lbu	a5,192(zero)
	andi	a5,a5,32
	beq	a5,zero,.L16
	sb	a0,198(zero)
	lbu	a5,192(zero)
	slliw	a5,a5,24
	sraiw	a5,a5,24
	bge	a5,zero,.L27
.L17:
	lbu	a5,198(zero)
	andi	a5,a5,0xff
	sb	a5,%lo(rx)(s0)
	bne	a5,s2,.L19
	addi	a0,s3,%lo(.LC4)
	call	Lcd4_Write_String
	lbu	a5,37(zero)
	fmv.d	fa0,fs0
	ori	a5,a5,32
	sb	a5,37(zero)
	call	_delay_ms
	lbu	a5,37(zero)
	fmv.d	fa0,fs0
	andi	a5,a5,223
	sb	a5,37(zero)
	call	_delay_ms
	sb	s1,%lo(rx)(s0)
	call	Gate
	call	Lcd4_Clear
	j	.L14
.L19:
	bne	a5,s5,.L14
	addi	a0,s4,%lo(.LC6)
	call	Lcd4_Write_String
	lbu	a5,37(zero)
	fmv.d	fa0,fs1
	ori	a5,a5,32
	sb	a5,37(zero)
	call	_delay_ms
	lbu	a5,37(zero)
	fmv.d	fa0,fs0
	andi	a5,a5,223
	sb	a5,37(zero)
	call	_delay_ms
	sb	s1,%lo(rx)(s0)
	call	Lcd4_Clear
	j	.L14
	.size	main, .-main
	.globl	rx
	.section	.srodata.cst8,"aM",@progbits,8
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
	.section	.sbss,"aw",@nobits
	.type	rx, @object
	.size	rx, 1
rx:
	.zero	1
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
