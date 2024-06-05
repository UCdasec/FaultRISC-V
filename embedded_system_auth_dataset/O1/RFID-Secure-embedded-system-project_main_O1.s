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
	blt	a5,zero,.L5
.L3:
	ret
.L5:
	lbu	a0,198(zero)
	andi	a0,a0,0xff
	ret
	.size	USART_Receive, .-USART_Receive
	.align	1
	.globl	USART_Transmit
	.type	USART_Transmit, @function
USART_Transmit:
.L7:
	lbu	a5,192(zero)
	andi	a5,a5,32
	beq	a5,zero,.L7
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
	j	.L12
.L17:
	call	SWseriale_read
	call	USART_Transmit
	j	.L13
.L18:
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
.L12:
	call	SWseriale_available
	bne	a0,zero,.L17
.L13:
	call	USART_Receive
	sb	a0,%lo(rx)(s1)
	beq	a0,s2,.L18
	bne	a0,s3,.L12
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
	j	.L12
	.size	main, .-main
	.globl	rx
	.section	.sbss,"aw",@nobits
	.type	rx, @object
	.size	rx, 1
rx:
	.zero	1
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
