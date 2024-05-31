	.file	"controller_utility_functions.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	alarminterruptHandler
	.type	alarminterruptHandler, @function
alarminterruptHandler:
	lui	a4,%hi(counter.0)
	lbu	a5,%lo(counter.0)(a4)
	addiw	a5,a5,1
	andi	a5,a5,0xff
	sb	a5,%lo(counter.0)(a4)
	li	a4,60
	bgtu	a5,a4,.L7
	ret
.L7:
	addi	sp,sp,-16
	sd	ra,8(sp)
	lui	a0,%hi(alarmTimer)
	addi	a0,a0,%lo(alarmTimer)
	call	TIMER_stop
	li	a0,77
	call	UART_transmit
	lui	a5,%hi(counter.0)
	sb	zero,%lo(counter.0)(a5)
	li	a1,0
	lui	a0,%hi(alarm)
	addi	a0,a0,%lo(alarm)
	call	DIO_writeChannel
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	alarminterruptHandler, .-alarminterruptHandler
	.align	1
	.globl	CONT_opendoor
	.type	CONT_opendoor, @function
CONT_opendoor:
	lui	a5,%hi(door_state)
	lbu	a4,%lo(door_state)(a5)
	li	a5,1
	beq	a4,a5,.L11
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	li	a1,0
	lui	s0,%hi(motor1)
	addi	a0,s0,%lo(motor1)
	call	MOTOR_changeDirection
	lui	a0,%hi(motortimer)
	addi	a0,a0,%lo(motortimer)
	call	TIMER_start
	li	a1,250
	addi	a0,s0,%lo(motor1)
	call	MOTOR_start
	lui	a5,%hi(door_state)
	li	a4,1
	sb	a4,%lo(door_state)(a5)
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
.L11:
	ret
	.size	CONT_opendoor, .-CONT_opendoor
	.align	1
	.globl	CONT_closedoor
	.type	CONT_closedoor, @function
CONT_closedoor:
	lui	a5,%hi(door_state)
	lbu	a5,%lo(door_state)(a5)
	bne	a5,zero,.L20
	ret
.L20:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	li	a1,1
	lui	s0,%hi(motor1)
	addi	a0,s0,%lo(motor1)
	call	MOTOR_changeDirection
	lui	a0,%hi(motortimer)
	addi	a0,a0,%lo(motortimer)
	call	TIMER_start
	li	a1,250
	addi	a0,s0,%lo(motor1)
	call	MOTOR_start
	lui	a5,%hi(door_state)
	sb	zero,%lo(door_state)(a5)
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	CONT_closedoor, .-CONT_closedoor
	.align	1
	.globl	keepOpeninterruptHandler
	.type	keepOpeninterruptHandler, @function
keepOpeninterruptHandler:
	lui	a4,%hi(counter.1)
	lbu	a5,%lo(counter.1)(a4)
	addiw	a5,a5,1
	andi	a5,a5,0xff
	sb	a5,%lo(counter.1)(a4)
	li	a4,5
	bgtu	a5,a4,.L27
	ret
.L27:
	addi	sp,sp,-16
	sd	ra,8(sp)
	lui	a0,%hi(keepOpenTimer)
	addi	a0,a0,%lo(keepOpenTimer)
	call	TIMER_stop
	lui	a5,%hi(counter.1)
	sb	zero,%lo(counter.1)(a5)
	call	CONT_closedoor
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	keepOpeninterruptHandler, .-keepOpeninterruptHandler
	.align	1
	.globl	CONT_keepOpen
	.type	CONT_keepOpen, @function
CONT_keepOpen:
	addi	sp,sp,-16
	sd	ra,8(sp)
	lui	a0,%hi(keepOpenTimer)
	addi	a0,a0,%lo(keepOpenTimer)
	call	TIMER_start
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	CONT_keepOpen, .-CONT_keepOpen
	.align	1
	.globl	motorTimerInterruptHandler
	.type	motorTimerInterruptHandler, @function
motorTimerInterruptHandler:
	lui	a4,%hi(counter.2)
	lbu	a5,%lo(counter.2)(a4)
	addiw	a5,a5,1
	andi	a5,a5,0xff
	sb	a5,%lo(counter.2)(a4)
	li	a4,2
	bgtu	a5,a4,.L36
	ret
.L36:
	addi	sp,sp,-16
	sd	ra,8(sp)
	lui	a0,%hi(motor1)
	addi	a0,a0,%lo(motor1)
	call	MOTOR_stop
	lui	a0,%hi(motortimer)
	addi	a0,a0,%lo(motortimer)
	call	TIMER_stop
	lui	a5,%hi(counter.2)
	sb	zero,%lo(counter.2)(a5)
	lui	a5,%hi(door_state)
	lbu	a4,%lo(door_state)(a5)
	li	a5,1
	beq	a4,a5,.L37
.L30:
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
.L37:
	call	CONT_keepOpen
	j	.L30
	.size	motorTimerInterruptHandler, .-motorTimerInterruptHandler
	.align	1
	.globl	CONT_startAlarm
	.type	CONT_startAlarm, @function
CONT_startAlarm:
	addi	sp,sp,-16
	sd	ra,8(sp)
	li	a1,1
	lui	a0,%hi(alarm)
	addi	a0,a0,%lo(alarm)
	call	DIO_writeChannel
	lui	a0,%hi(alarmTimer)
	addi	a0,a0,%lo(alarmTimer)
	call	TIMER_start
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	CONT_startAlarm, .-CONT_startAlarm
	.align	1
	.globl	CONT_sendMSG
	.type	CONT_sendMSG, @function
CONT_sendMSG:
	lui	a5,%hi(recieved_data)
	sb	zero,%lo(recieved_data)(a5)
	lbu	a5,%lo(recieved_data)(a5)
	andi	a5,a5,0xff
	li	a4,97
	beq	a5,a4,.L45
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	sd	s1,24(sp)
	sd	s2,16(sp)
	sd	s3,8(sp)
	mv	s0,a0
	li	s1,999424
	addi	s1,s1,576
	lui	s3,%hi(recieved_data)
	li	s2,97
.L42:
	mv	a0,s0
	call	UART_transmit
	mv	a0,s1
	call	__builtin_avr_delay_cycles
	lbu	a5,%lo(recieved_data)(s3)
	andi	a5,a5,0xff
	bne	a5,s2,.L42
	ld	ra,40(sp)
	ld	s0,32(sp)
	ld	s1,24(sp)
	ld	s2,16(sp)
	ld	s3,8(sp)
	addi	sp,sp,48
	jr	ra
.L45:
	ret
	.size	CONT_sendMSG, .-CONT_sendMSG
	.align	1
	.globl	CONT_firstRunCheck
	.type	CONT_firstRunCheck, @function
CONT_firstRunCheck:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sb	zero,15(sp)
	li	a2,1
	addi	a1,sp,15
	li	a0,0
	call	EEPROM_readData
	lbu	a4,15(sp)
	li	a5,255
	li	a0,0
	beq	a4,a5,.L52
.L49:
	ld	ra,24(sp)
	addi	sp,sp,32
	jr	ra
.L52:
	li	a0,102
	call	CONT_sendMSG
	li	a0,999424
	addi	a0,a0,576
	call	__builtin_avr_delay_cycles
	li	a0,1
	j	.L49
	.size	CONT_firstRunCheck, .-CONT_firstRunCheck
	.align	1
	.globl	CONT_getPassword
	.type	CONT_getPassword, @function
CONT_getPassword:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	sd	s1,8(sp)
	mv	s1,a0
	mv	a0,a1
	call	CONT_sendMSG
	li	s0,95
	lbu	a5,0(s0)
	andi	a5,a5,127
	sb	a5,0(s0)
	li	a1,5
	mv	a0,s1
	call	UART_receiveString
	lbu	a5,0(s0)
	ori	a5,a5,128
	sb	a5,0(s0)
	ld	ra,24(sp)
	ld	s0,16(sp)
	ld	s1,8(sp)
	addi	sp,sp,32
	jr	ra
	.size	CONT_getPassword, .-CONT_getPassword
	.align	1
	.globl	CONT_password_match
	.type	CONT_password_match, @function
CONT_password_match:
	mv	a5,a0
	addi	a0,a0,5
.L58:
	lbu	a3,0(a5)
	lbu	a4,0(a1)
	bne	a3,a4,.L64
	addi	a5,a5,1
	addi	a1,a1,1
	bne	a5,a0,.L58
	li	a0,1
	ret
.L64:
	addi	sp,sp,-16
	sd	ra,8(sp)
	li	a0,110
	call	CONT_sendMSG
	li	a0,999424
	addi	a0,a0,576
	call	__builtin_avr_delay_cycles
	li	a0,0
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	CONT_password_match, .-CONT_password_match
	.align	1
	.globl	CONT_getAndCompPassword
	.type	CONT_getAndCompPassword, @function
CONT_getAndCompPassword:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	sd	s1,24(sp)
	mv	s1,a0
	sw	zero,8(sp)
	sb	zero,12(sp)
	sw	zero,0(sp)
	sb	zero,4(sp)
	li	a2,1
	mv	a1,sp
	li	a0,0
	call	EEPROM_readData
	li	a2,1
	addi	a1,sp,1
	li	a0,1
	call	EEPROM_readData
	li	a2,1
	addi	a1,sp,2
	li	a0,2
	call	EEPROM_readData
	li	a2,1
	addi	a1,sp,3
	li	a0,3
	call	EEPROM_readData
	li	a2,1
	addi	a1,sp,4
	li	a0,4
	call	EEPROM_readData
	li	s0,3
.L67:
	mv	a1,s1
	addi	a0,sp,8
	call	CONT_getPassword
	mv	a1,sp
	addi	a0,sp,8
	call	CONT_password_match
	bne	a0,zero,.L68
	addiw	s0,s0,-1
	andi	s0,s0,0xff
	bne	s0,zero,.L67
.L66:
	mv	a0,s0
	ld	ra,40(sp)
	ld	s0,32(sp)
	ld	s1,24(sp)
	addi	sp,sp,48
	jr	ra
.L68:
	li	s0,1
	j	.L66
	.size	CONT_getAndCompPassword, .-CONT_getAndCompPassword
	.align	1
	.globl	CONT_updatePassword
	.type	CONT_updatePassword, @function
CONT_updatePassword:
	addi	sp,sp,-16
	sd	ra,8(sp)
	mv	a1,a0
	li	a2,5
	li	a0,0
	call	EEPROM_writeData
	li	a0,112
	call	CONT_sendMSG
	li	a0,999424
	addi	a0,a0,576
	call	__builtin_avr_delay_cycles
	lui	a5,%hi(recieved_data)
	sb	zero,%lo(recieved_data)(a5)
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	CONT_updatePassword, .-CONT_updatePassword
	.align	1
	.globl	CONT_setPassword
	.type	CONT_setPassword, @function
CONT_setPassword:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sw	zero,8(sp)
	sb	zero,12(sp)
	sw	zero,0(sp)
	sb	zero,4(sp)
.L74:
	li	a1,115
	addi	a0,sp,8
	call	CONT_getPassword
	li	a1,114
	mv	a0,sp
	call	CONT_getPassword
	mv	a1,sp
	addi	a0,sp,8
	call	CONT_password_match
	beq	a0,zero,.L74
	addi	a0,sp,8
	call	CONT_updatePassword
	li	a0,77
	call	CONT_sendMSG
	ld	ra,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	CONT_setPassword, .-CONT_setPassword
	.section	.sbss,"aw",@nobits
	.type	counter.0, @object
	.size	counter.0, 1
counter.0:
	.zero	1
	.type	counter.1, @object
	.size	counter.1, 1
counter.1:
	.zero	1
	.type	counter.2, @object
	.size	counter.2, 1
counter.2:
	.zero	1
	.type	door_state, @object
	.size	door_state, 1
door_state:
	.zero	1
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
