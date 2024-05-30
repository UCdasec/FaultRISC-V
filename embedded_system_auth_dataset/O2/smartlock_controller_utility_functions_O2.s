	.file	"controller_utility_functions.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	motorTimerInterruptHandler
	.type	motorTimerInterruptHandler, @function
motorTimerInterruptHandler:
	addi	sp,sp,-16
	sd	s0,0(sp)
	lui	s0,%hi(counter.2)
	lbu	a5,%lo(counter.2)(s0)
	sd	ra,8(sp)
	li	a4,2
	addiw	a5,a5,1
	andi	a5,a5,0xff
	sb	a5,%lo(counter.2)(s0)
	bgtu	a5,a4,.L7
.L1:
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
.L7:
	lui	a0,%hi(motor1)
	addi	a0,a0,%lo(motor1)
	call	MOTOR_stop
	lui	a0,%hi(motortimer)
	addi	a0,a0,%lo(motortimer)
	call	TIMER_stop
	lui	a5,%hi(door_state)
	lbu	a4,%lo(door_state)(a5)
	sb	zero,%lo(counter.2)(s0)
	li	a5,1
	bne	a4,a5,.L1
	ld	s0,0(sp)
	ld	ra,8(sp)
	lui	a0,%hi(keepOpenTimer)
	addi	a0,a0,%lo(keepOpenTimer)
	addi	sp,sp,16
	tail	TIMER_start
	.size	motorTimerInterruptHandler, .-motorTimerInterruptHandler
	.align	1
	.globl	keepOpeninterruptHandler
	.type	keepOpeninterruptHandler, @function
keepOpeninterruptHandler:
	addi	sp,sp,-32
	sd	s0,16(sp)
	lui	s0,%hi(counter.1)
	lbu	a5,%lo(counter.1)(s0)
	sd	ra,24(sp)
	li	a4,5
	addiw	a5,a5,1
	andi	a5,a5,0xff
	sb	a5,%lo(counter.1)(s0)
	bgtu	a5,a4,.L17
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
.L17:
	lui	a0,%hi(keepOpenTimer)
	addi	a0,a0,%lo(keepOpenTimer)
	sd	s1,8(sp)
	call	TIMER_stop
	lui	s1,%hi(door_state)
	lbu	a5,%lo(door_state)(s1)
	sb	zero,%lo(counter.1)(s0)
	bne	a5,zero,.L18
	ld	ra,24(sp)
	ld	s0,16(sp)
	ld	s1,8(sp)
	addi	sp,sp,32
	jr	ra
.L18:
	lui	s0,%hi(motor1)
	li	a1,1
	addi	a0,s0,%lo(motor1)
	call	MOTOR_changeDirection
	lui	a0,%hi(motortimer)
	addi	a0,a0,%lo(motortimer)
	call	TIMER_start
	addi	a0,s0,%lo(motor1)
	li	a1,250
	call	MOTOR_start
	ld	ra,24(sp)
	ld	s0,16(sp)
	sb	zero,%lo(door_state)(s1)
	ld	s1,8(sp)
	addi	sp,sp,32
	jr	ra
	.size	keepOpeninterruptHandler, .-keepOpeninterruptHandler
	.align	1
	.globl	alarminterruptHandler
	.type	alarminterruptHandler, @function
alarminterruptHandler:
	addi	sp,sp,-16
	sd	s0,0(sp)
	lui	s0,%hi(counter.0)
	lbu	a5,%lo(counter.0)(s0)
	sd	ra,8(sp)
	li	a4,60
	addiw	a5,a5,1
	andi	a5,a5,0xff
	sb	a5,%lo(counter.0)(s0)
	bgtu	a5,a4,.L22
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
.L22:
	lui	a0,%hi(alarmTimer)
	addi	a0,a0,%lo(alarmTimer)
	call	TIMER_stop
	li	a0,77
	call	UART_transmit
	sb	zero,%lo(counter.0)(s0)
	ld	s0,0(sp)
	ld	ra,8(sp)
	lui	a0,%hi(alarm)
	li	a1,0
	addi	a0,a0,%lo(alarm)
	addi	sp,sp,16
	tail	DIO_writeChannel
	.size	alarminterruptHandler, .-alarminterruptHandler
	.align	1
	.globl	CONT_opendoor
	.type	CONT_opendoor, @function
CONT_opendoor:
	addi	sp,sp,-32
	sd	s0,16(sp)
	lui	s0,%hi(door_state)
	lbu	a5,%lo(door_state)(s0)
	sd	s1,8(sp)
	sd	ra,24(sp)
	li	s1,1
	beq	a5,s1,.L23
	sd	s2,0(sp)
	lui	s2,%hi(motor1)
	li	a1,0
	addi	a0,s2,%lo(motor1)
	call	MOTOR_changeDirection
	lui	a0,%hi(motortimer)
	addi	a0,a0,%lo(motortimer)
	call	TIMER_start
	addi	a0,s2,%lo(motor1)
	li	a1,250
	call	MOTOR_start
	ld	s2,0(sp)
	sb	s1,%lo(door_state)(s0)
.L23:
	ld	ra,24(sp)
	ld	s0,16(sp)
	ld	s1,8(sp)
	addi	sp,sp,32
	jr	ra
	.size	CONT_opendoor, .-CONT_opendoor
	.align	1
	.globl	CONT_closedoor
	.type	CONT_closedoor, @function
CONT_closedoor:
	addi	sp,sp,-32
	sd	s0,16(sp)
	lui	s0,%hi(door_state)
	lbu	a5,%lo(door_state)(s0)
	sd	ra,24(sp)
	beq	a5,zero,.L26
	sd	s1,8(sp)
	lui	s1,%hi(motor1)
	li	a1,1
	addi	a0,s1,%lo(motor1)
	call	MOTOR_changeDirection
	lui	a0,%hi(motortimer)
	addi	a0,a0,%lo(motortimer)
	call	TIMER_start
	addi	a0,s1,%lo(motor1)
	li	a1,250
	call	MOTOR_start
	ld	s1,8(sp)
	sb	zero,%lo(door_state)(s0)
.L26:
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	CONT_closedoor, .-CONT_closedoor
	.align	1
	.globl	CONT_keepOpen
	.type	CONT_keepOpen, @function
CONT_keepOpen:
	lui	a0,%hi(keepOpenTimer)
	addi	a0,a0,%lo(keepOpenTimer)
	tail	TIMER_start
	.size	CONT_keepOpen, .-CONT_keepOpen
	.align	1
	.globl	CONT_startAlarm
	.type	CONT_startAlarm, @function
CONT_startAlarm:
	lui	a0,%hi(alarm)
	addi	sp,sp,-16
	addi	a0,a0,%lo(alarm)
	li	a1,1
	sd	ra,8(sp)
	call	DIO_writeChannel
	ld	ra,8(sp)
	lui	a0,%hi(alarmTimer)
	addi	a0,a0,%lo(alarmTimer)
	addi	sp,sp,16
	tail	TIMER_start
	.size	CONT_startAlarm, .-CONT_startAlarm
	.align	1
	.globl	CONT_getAndCompPassword
	.type	CONT_getAndCompPassword, @function
CONT_getAndCompPassword:
	addi	sp,sp,-96
	sd	s3,56(sp)
	li	a2,1
	addi	a1,sp,8
	mv	s3,a0
	li	a0,0
	sd	ra,88(sp)
	sd	s0,80(sp)
	sd	s1,72(sp)
	sd	s2,64(sp)
	sd	s4,48(sp)
	sd	s5,40(sp)
	sw	zero,0(sp)
	sb	zero,4(sp)
	sw	zero,8(sp)
	sb	zero,12(sp)
	call	EEPROM_readData
	li	a2,1
	addi	a1,sp,9
	li	a0,1
	call	EEPROM_readData
	li	a2,1
	addi	a1,sp,10
	li	a0,2
	call	EEPROM_readData
	li	a2,1
	addi	a1,sp,11
	li	a0,3
	call	EEPROM_readData
	li	a2,1
	addi	a1,sp,12
	li	a0,4
	li	s1,999424
	call	EEPROM_readData
	li	s4,3
	lui	s0,%hi(recieved_data)
	addi	s5,sp,5
	li	s2,97
	addi	s1,s1,576
.L41:
	sb	zero,%lo(recieved_data)(s0)
	lbu	a5,%lo(recieved_data)(s0)
	beq	a5,s2,.L36
.L37:
	mv	a0,s3
	call	UART_transmit
	mv	a0,s1
	call	__builtin_avr_delay_cycles
	lbu	a5,%lo(recieved_data)(s0)
	bne	a5,s2,.L37
.L36:
	lbu	a5,95(zero)
	li	a1,5
	mv	a0,sp
	andi	a5,a5,127
	sb	a5,95(zero)
	call	UART_receiveString
	lbu	a3,95(zero)
	mv	a5,sp
	addi	a4,sp,8
	ori	a3,a3,128
	sb	a3,95(zero)
.L43:
	lbu	a2,0(a5)
	lbu	a3,0(a4)
	addi	a5,a5,1
	addi	a4,a4,1
	bne	a2,a3,.L49
	bne	a5,s5,.L43
	li	s4,1
.L42:
	ld	ra,88(sp)
	ld	s0,80(sp)
	ld	s1,72(sp)
	ld	s2,64(sp)
	ld	s3,56(sp)
	ld	s5,40(sp)
	mv	a0,s4
	ld	s4,48(sp)
	addi	sp,sp,96
	jr	ra
.L49:
	sb	zero,%lo(recieved_data)(s0)
	lbu	a4,%lo(recieved_data)(s0)
	li	a5,97
	beq	a4,a5,.L39
	sd	s6,32(sp)
	li	s6,999424
	sd	s7,24(sp)
	addi	s6,s6,576
	li	s7,97
.L40:
	li	a0,110
	call	UART_transmit
	mv	a0,s6
	call	__builtin_avr_delay_cycles
	lbu	a5,%lo(recieved_data)(s0)
	bne	a5,s7,.L40
	ld	s6,32(sp)
	ld	s7,24(sp)
.L39:
	addiw	s4,s4,-1
	mv	a0,s1
	andi	s4,s4,0xff
	call	__builtin_avr_delay_cycles
	bne	s4,zero,.L41
	j	.L42
	.size	CONT_getAndCompPassword, .-CONT_getAndCompPassword
	.align	1
	.globl	CONT_setPassword
	.type	CONT_setPassword, @function
CONT_setPassword:
	addi	sp,sp,-64
	sd	s2,32(sp)
	li	s2,999424
	sd	s0,48(sp)
	sd	s1,40(sp)
	sd	s3,24(sp)
	sd	ra,56(sp)
	sw	zero,0(sp)
	sb	zero,4(sp)
	sw	zero,8(sp)
	sb	zero,12(sp)
	lui	s0,%hi(recieved_data)
	addi	s3,sp,5
	li	s1,97
	addi	s2,s2,576
.L58:
	sb	zero,%lo(recieved_data)(s0)
	lbu	a5,%lo(recieved_data)(s0)
	beq	a5,s1,.L51
.L52:
	li	a0,115
	call	UART_transmit
	mv	a0,s2
	call	__builtin_avr_delay_cycles
	lbu	a5,%lo(recieved_data)(s0)
	bne	a5,s1,.L52
.L51:
	lbu	a5,95(zero)
	li	a1,5
	mv	a0,sp
	andi	a5,a5,127
	sb	a5,95(zero)
	call	UART_receiveString
	lbu	a5,95(zero)
	ori	a5,a5,128
	sb	a5,95(zero)
	sb	zero,%lo(recieved_data)(s0)
	lbu	a5,%lo(recieved_data)(s0)
	beq	a5,s1,.L53
.L54:
	li	a0,114
	call	UART_transmit
	mv	a0,s2
	call	__builtin_avr_delay_cycles
	lbu	a5,%lo(recieved_data)(s0)
	bne	a5,s1,.L54
.L53:
	lbu	a5,95(zero)
	li	a1,5
	addi	a0,sp,8
	andi	a5,a5,127
	sb	a5,95(zero)
	call	UART_receiveString
	lbu	a3,95(zero)
	mv	a5,sp
	addi	a4,sp,8
	ori	a3,a3,128
	sb	a3,95(zero)
.L59:
	lbu	a2,0(a5)
	lbu	a3,0(a4)
	addi	a5,a5,1
	addi	a4,a4,1
	bne	a2,a3,.L74
	bne	s3,a5,.L59
	li	a2,5
	mv	a1,sp
	li	a0,0
	call	EEPROM_writeData
	sb	zero,%lo(recieved_data)(s0)
	lbu	a4,%lo(recieved_data)(s0)
	li	s1,999424
	li	a5,97
	addi	s1,s1,576
	li	s2,97
	beq	a4,a5,.L64
.L61:
	li	a0,112
	call	UART_transmit
	mv	a0,s1
	call	__builtin_avr_delay_cycles
	lbu	a5,%lo(recieved_data)(s0)
	bne	a5,s2,.L61
.L64:
	li	a0,999424
	addi	a0,a0,576
	call	__builtin_avr_delay_cycles
	sb	zero,%lo(recieved_data)(s0)
	sb	zero,%lo(recieved_data)(s0)
	lbu	a4,%lo(recieved_data)(s0)
	li	a5,97
	beq	a4,a5,.L50
	li	s1,999424
	addi	s1,s1,576
	li	s2,97
.L63:
	li	a0,77
	call	UART_transmit
	mv	a0,s1
	call	__builtin_avr_delay_cycles
	lbu	a5,%lo(recieved_data)(s0)
	bne	a5,s2,.L63
.L50:
	ld	ra,56(sp)
	ld	s0,48(sp)
	ld	s1,40(sp)
	ld	s2,32(sp)
	ld	s3,24(sp)
	addi	sp,sp,64
	jr	ra
.L74:
	sb	zero,%lo(recieved_data)(s0)
	lbu	a5,%lo(recieved_data)(s0)
	beq	a5,s1,.L56
.L57:
	li	a0,110
	call	UART_transmit
	mv	a0,s2
	call	__builtin_avr_delay_cycles
	lbu	a5,%lo(recieved_data)(s0)
	bne	a5,s1,.L57
.L56:
	mv	a0,s2
	call	__builtin_avr_delay_cycles
	j	.L58
	.size	CONT_setPassword, .-CONT_setPassword
	.align	1
	.globl	CONT_sendMSG
	.type	CONT_sendMSG, @function
CONT_sendMSG:
	addi	sp,sp,-48
	sd	s1,24(sp)
	lui	s1,%hi(recieved_data)
	sb	zero,%lo(recieved_data)(s1)
	lbu	a4,%lo(recieved_data)(s1)
	sd	ra,40(sp)
	li	a5,97
	beq	a4,a5,.L75
	sd	s2,16(sp)
	li	s2,999424
	sd	s0,32(sp)
	sd	s3,8(sp)
	mv	s0,a0
	addi	s2,s2,576
	li	s3,97
.L77:
	mv	a0,s0
	call	UART_transmit
	mv	a0,s2
	call	__builtin_avr_delay_cycles
	lbu	a5,%lo(recieved_data)(s1)
	bne	a5,s3,.L77
	ld	s0,32(sp)
	ld	s2,16(sp)
	ld	s3,8(sp)
.L75:
	ld	ra,40(sp)
	ld	s1,24(sp)
	addi	sp,sp,48
	jr	ra
	.size	CONT_sendMSG, .-CONT_sendMSG
	.align	1
	.globl	CONT_firstRunCheck
	.type	CONT_firstRunCheck, @function
CONT_firstRunCheck:
	addi	sp,sp,-48
	li	a2,1
	addi	a1,sp,15
	li	a0,0
	sd	ra,40(sp)
	sb	zero,15(sp)
	call	EEPROM_readData
	lbu	a4,15(sp)
	li	a5,255
	li	a0,0
	beq	a4,a5,.L88
	ld	ra,40(sp)
	addi	sp,sp,48
	jr	ra
.L88:
	sd	s0,32(sp)
	lui	s0,%hi(recieved_data)
	sb	zero,%lo(recieved_data)(s0)
	lbu	a4,%lo(recieved_data)(s0)
	li	a5,97
	beq	a4,a5,.L82
	sd	s1,24(sp)
	li	s1,999424
	sd	s2,16(sp)
	addi	s1,s1,576
	li	s2,97
.L83:
	li	a0,102
	call	UART_transmit
	mv	a0,s1
	call	__builtin_avr_delay_cycles
	lbu	a5,%lo(recieved_data)(s0)
	bne	a5,s2,.L83
	ld	s1,24(sp)
	ld	s2,16(sp)
.L82:
	li	a0,999424
	addi	a0,a0,576
	call	__builtin_avr_delay_cycles
	ld	ra,40(sp)
	ld	s0,32(sp)
	li	a0,1
	addi	sp,sp,48
	jr	ra
	.size	CONT_firstRunCheck, .-CONT_firstRunCheck
	.align	1
	.globl	CONT_getPassword
	.type	CONT_getPassword, @function
CONT_getPassword:
	addi	sp,sp,-48
	sd	s1,24(sp)
	lui	s1,%hi(recieved_data)
	sb	zero,%lo(recieved_data)(s1)
	lbu	a4,%lo(recieved_data)(s1)
	sd	s4,0(sp)
	sd	ra,40(sp)
	li	a5,97
	mv	s4,a0
	beq	a4,a5,.L90
	sd	s2,16(sp)
	li	s2,999424
	sd	s0,32(sp)
	sd	s3,8(sp)
	mv	s0,a1
	addi	s2,s2,576
	li	s3,97
.L91:
	mv	a0,s0
	call	UART_transmit
	mv	a0,s2
	call	__builtin_avr_delay_cycles
	lbu	a5,%lo(recieved_data)(s1)
	bne	a5,s3,.L91
	ld	s0,32(sp)
	ld	s2,16(sp)
	ld	s3,8(sp)
.L90:
	lbu	a5,95(zero)
	mv	a0,s4
	li	a1,5
	andi	a5,a5,127
	sb	a5,95(zero)
	call	UART_receiveString
	lbu	a5,95(zero)
	ori	a5,a5,128
	sb	a5,95(zero)
	ld	ra,40(sp)
	ld	s1,24(sp)
	ld	s4,0(sp)
	addi	sp,sp,48
	jr	ra
	.size	CONT_getPassword, .-CONT_getPassword
	.align	1
	.globl	CONT_password_match
	.type	CONT_password_match, @function
CONT_password_match:
	addi	a3,a0,5
.L99:
	lbu	a4,0(a0)
	lbu	a5,0(a1)
	addi	a0,a0,1
	addi	a1,a1,1
	bne	a4,a5,.L106
	bne	a0,a3,.L99
	li	a0,1
	ret
.L106:
	addi	sp,sp,-32
	sd	s0,16(sp)
	lui	s0,%hi(recieved_data)
	sb	zero,%lo(recieved_data)(s0)
	lbu	a4,%lo(recieved_data)(s0)
	sd	ra,24(sp)
	li	a5,97
	beq	a4,a5,.L96
	sd	s1,8(sp)
	li	s1,999424
	sd	s2,0(sp)
	addi	s1,s1,576
	li	s2,97
.L97:
	li	a0,110
	call	UART_transmit
	mv	a0,s1
	call	__builtin_avr_delay_cycles
	lbu	a5,%lo(recieved_data)(s0)
	bne	a5,s2,.L97
	ld	s1,8(sp)
	ld	s2,0(sp)
.L96:
	li	a0,999424
	addi	a0,a0,576
	call	__builtin_avr_delay_cycles
	ld	ra,24(sp)
	ld	s0,16(sp)
	li	a0,0
	addi	sp,sp,32
	jr	ra
	.size	CONT_password_match, .-CONT_password_match
	.align	1
	.globl	CONT_updatePassword
	.type	CONT_updatePassword, @function
CONT_updatePassword:
	addi	sp,sp,-32
	sd	s0,16(sp)
	mv	a1,a0
	lui	s0,%hi(recieved_data)
	li	a2,5
	li	a0,0
	sd	ra,24(sp)
	call	EEPROM_writeData
	sb	zero,%lo(recieved_data)(s0)
	lbu	a4,%lo(recieved_data)(s0)
	li	a5,97
	beq	a4,a5,.L108
	sd	s1,8(sp)
	li	s1,999424
	sd	s2,0(sp)
	addi	s1,s1,576
	li	s2,97
.L109:
	li	a0,112
	call	UART_transmit
	mv	a0,s1
	call	__builtin_avr_delay_cycles
	lbu	a5,%lo(recieved_data)(s0)
	bne	a5,s2,.L109
	ld	s1,8(sp)
	ld	s2,0(sp)
.L108:
	li	a0,999424
	addi	a0,a0,576
	call	__builtin_avr_delay_cycles
	ld	ra,24(sp)
	sb	zero,%lo(recieved_data)(s0)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	CONT_updatePassword, .-CONT_updatePassword
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
