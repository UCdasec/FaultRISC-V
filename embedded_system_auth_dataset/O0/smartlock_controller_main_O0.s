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
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	lui	a5,%hi(uart)
	addi	a0,a5,%lo(uart)
	call	UART_init
	lui	a5,%hi(motor1)
	addi	a0,a5,%lo(motor1)
	call	MOTOR_init
	lui	a5,%hi(alarm)
	addi	a0,a5,%lo(alarm)
	call	DIO_initChannel
	li	a5,95
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,95
	ori	a4,a4,-128
	andi	a4,a4,0xff
	sb	a4,0(a5)
	call	CONT_firstRunCheck
	mv	a5,a0
	beq	a5,zero,.L2
	call	CONT_setPassword
.L2:
	li	a0,77
	call	CONT_sendMSG
.L13:
	lui	a5,%hi(recieved_data)
	lbu	a5,%lo(recieved_data)(a5)
	andi	a5,a5,0xff
	sext.w	a5,a5
	mv	a3,a5
	li	a4,117
	beq	a3,a4,.L3
	mv	a3,a5
	li	a4,117
	bgt	a3,a4,.L14
	mv	a3,a5
	li	a4,116
	beq	a3,a4,.L5
	mv	a3,a5
	li	a4,116
	bgt	a3,a4,.L14
	mv	a3,a5
	li	a4,97
	beq	a3,a4,.L15
	mv	a4,a5
	li	a5,99
	beq	a4,a5,.L7
	j	.L14
.L3:
	li	a0,103
	call	CONT_getAndCompPassword
	mv	a5,a0
	beq	a5,zero,.L9
	li	a0,77
	call	CONT_sendMSG
	call	CONT_opendoor
	j	.L10
.L9:
	call	CONT_startAlarm
	li	a0,120
	call	CONT_sendMSG
.L10:
	lui	a5,%hi(recieved_data)
	sb	zero,%lo(recieved_data)(a5)
	j	.L8
.L5:
	li	a0,111
	call	CONT_getAndCompPassword
	mv	a5,a0
	beq	a5,zero,.L11
	call	CONT_setPassword
	li	a0,77
	call	CONT_sendMSG
	j	.L12
.L11:
	call	CONT_startAlarm
	li	a0,120
	call	CONT_sendMSG
.L12:
	lui	a5,%hi(recieved_data)
	sb	zero,%lo(recieved_data)(a5)
	j	.L8
.L7:
	call	CONT_closedoor
	li	a0,77
	call	CONT_sendMSG
	lui	a5,%hi(recieved_data)
	sb	zero,%lo(recieved_data)(a5)
	j	.L8
.L14:
	nop
	j	.L13
.L15:
	nop
.L8:
	j	.L13
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
