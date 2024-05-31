	.file	"controller_main.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	lui	a0,%hi(uart)
	addi	sp,sp,-48
	addi	a0,a0,%lo(uart)
	sd	ra,40(sp)
	sd	s0,32(sp)
	sd	s1,24(sp)
	sd	s2,16(sp)
	sd	s3,8(sp)
	call	UART_init
	lui	a0,%hi(motor1)
	addi	a0,a0,%lo(motor1)
	call	MOTOR_init
	lui	a0,%hi(alarm)
	addi	a0,a0,%lo(alarm)
	call	DIO_initChannel
	lbu	a5,95(zero)
	ori	a5,a5,128
	sb	a5,95(zero)
	call	CONT_firstRunCheck
	bne	a0,zero,.L18
.L2:
	li	a0,77
	call	CONT_sendMSG
	lui	s0,%hi(recieved_data)
	li	s1,116
	li	s2,117
	li	s3,99
.L7:
	lbu	a5,%lo(recieved_data)(s0)
	andi	a4,a5,0xff
	beq	a5,s1,.L4
.L19:
	beq	a4,s2,.L5
	bne	a4,s3,.L7
	call	CONT_closedoor
	li	a0,77
	call	CONT_sendMSG
	sb	zero,%lo(recieved_data)(s0)
	lbu	a5,%lo(recieved_data)(s0)
	andi	a4,a5,0xff
	bne	a5,s1,.L19
.L4:
	li	a0,111
	call	CONT_getAndCompPassword
	beq	a0,zero,.L11
	call	CONT_setPassword
	li	a0,77
	call	CONT_sendMSG
.L12:
	sb	zero,%lo(recieved_data)(s0)
	j	.L7
.L5:
	li	a0,103
	call	CONT_getAndCompPassword
	beq	a0,zero,.L11
	li	a0,77
	call	CONT_sendMSG
	call	CONT_opendoor
	j	.L12
.L11:
	call	CONT_startAlarm
	li	a0,120
	call	CONT_sendMSG
	j	.L12
.L18:
	call	CONT_setPassword
	j	.L2
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
