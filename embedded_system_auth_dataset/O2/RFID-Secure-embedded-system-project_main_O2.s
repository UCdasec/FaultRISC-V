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
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	Lcd4_Write_String
	li	a5,1
	sb	a5,39(zero)
	li	s5,48001024
	li	s1,3198976
	sb	zero,40(zero)
	lui	s0,%hi(rx)
	lui	s4,%hi(.LC1)
	lui	s6,%hi(.LC2)
	li	s3,75
	li	s7,88
	addi	s5,s5,-1024
	addi	s1,s1,1024
	li	s2,79
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
	bne	a5,s3,.L19
	addi	a0,s4,%lo(.LC1)
	call	Lcd4_Write_String
	lbu	a5,37(zero)
	mv	a0,s1
	ori	a5,a5,32
	sb	a5,37(zero)
	call	__builtin_avr_delay_cycles
	lbu	a5,37(zero)
	mv	a0,s1
	andi	a5,a5,223
	sb	a5,37(zero)
	call	__builtin_avr_delay_cycles
	sb	s2,%lo(rx)(s0)
	call	Gate
	call	Lcd4_Clear
	j	.L14
.L19:
	bne	a5,s7,.L14
	addi	a0,s6,%lo(.LC2)
	call	Lcd4_Write_String
	lbu	a5,37(zero)
	mv	a0,s5
	ori	a5,a5,32
	sb	a5,37(zero)
	call	__builtin_avr_delay_cycles
	lbu	a5,37(zero)
	mv	a0,s1
	andi	a5,a5,223
	sb	a5,37(zero)
	call	__builtin_avr_delay_cycles
	sb	s2,%lo(rx)(s0)
	call	Lcd4_Clear
	j	.L14
	.size	main, .-main
	.globl	rx
	.section	.sbss,"aw",@nobits
	.type	rx, @object
	.size	rx, 1
rx:
	.zero	1
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
