	.file	"controller_main.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	sd	s1,24(sp)
	sd	s2,16(sp)
	sd	s3,8(sp)
	lui	a0,%hi(uart)
	addi	a0,a0,%lo(uart)
	call	UART_init
	lui	a0,%hi(motor1)
	addi	a0,a0,%lo(motor1)
	call	MOTOR_init
	lui	a0,%hi(alarm)
	addi	a0,a0,%lo(alarm)
	call	DIO_initChannel
	li	a4,95
	lbu	a5,0(a4)
	ori	a5,a5,128
	sb	a5,0(a4)
	call	CONT_firstRunCheck
	bne	a0,zero,.L14
.L2:
	li	a0,77
	call	CONT_sendMSG
	lui	s0,%hi(recieved_data)
	li	s1,116
	li	s2,117
	li	s3,99
	j	.L7
.L14:
	call	CONT_setPassword
	j	.L2
.L5:
	li	a0,103
	call	CONT_getAndCompPassword
	beq	a0,zero,.L8
	li	a0,77
	call	CONT_sendMSG
	call	CONT_opendoor
.L9:
	sb	zero,%lo(recieved_data)(s0)
.L7:
	lbu	a5,%lo(recieved_data)(s0)
	andi	a5,a5,0xff
	beq	a5,s1,.L4
	beq	a5,s2,.L5
	bne	a5,s3,.L7
	call	CONT_closedoor
	li	a0,77
	call	CONT_sendMSG
	sb	zero,%lo(recieved_data)(s0)
	j	.L7
.L8:
	call	CONT_startAlarm
	li	a0,120
	call	CONT_sendMSG
	j	.L9
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
.L11:
	call	CONT_startAlarm
	li	a0,120
	call	CONT_sendMSG
	j	.L12
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
