	.file	"controller_utility_functions.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.local	door_state
	.comm	door_state,1,1
	.align	1
	.globl	motorTimerInterruptHandler
	.type	motorTimerInterruptHandler, @function
motorTimerInterruptHandler:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	lui	a5,%hi(counter.2)
	lbu	a5,%lo(counter.2)(a5)
	addiw	a5,a5,1
	andi	a4,a5,0xff
	lui	a5,%hi(counter.2)
	sb	a4,%lo(counter.2)(a5)
	lui	a5,%hi(counter.2)
	lbu	a5,%lo(counter.2)(a5)
	mv	a4,a5
	li	a5,2
	bleu	a4,a5,.L3
	lui	a5,%hi(motor1)
	addi	a0,a5,%lo(motor1)
	call	MOTOR_stop
	lui	a5,%hi(motortimer)
	addi	a0,a5,%lo(motortimer)
	call	TIMER_stop
	lui	a5,%hi(counter.2)
	sb	zero,%lo(counter.2)(a5)
	lui	a5,%hi(door_state)
	lbu	a5,%lo(door_state)(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L3
	call	CONT_keepOpen
.L3:
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	motorTimerInterruptHandler, .-motorTimerInterruptHandler
	.align	1
	.globl	keepOpeninterruptHandler
	.type	keepOpeninterruptHandler, @function
keepOpeninterruptHandler:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	lui	a5,%hi(counter.1)
	lbu	a5,%lo(counter.1)(a5)
	addiw	a5,a5,1
	andi	a4,a5,0xff
	lui	a5,%hi(counter.1)
	sb	a4,%lo(counter.1)(a5)
	lui	a5,%hi(counter.1)
	lbu	a5,%lo(counter.1)(a5)
	mv	a4,a5
	li	a5,5
	bleu	a4,a5,.L6
	lui	a5,%hi(keepOpenTimer)
	addi	a0,a5,%lo(keepOpenTimer)
	call	TIMER_stop
	lui	a5,%hi(counter.1)
	sb	zero,%lo(counter.1)(a5)
	call	CONT_closedoor
.L6:
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	keepOpeninterruptHandler, .-keepOpeninterruptHandler
	.align	1
	.globl	alarminterruptHandler
	.type	alarminterruptHandler, @function
alarminterruptHandler:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	lui	a5,%hi(counter.0)
	lbu	a5,%lo(counter.0)(a5)
	addiw	a5,a5,1
	andi	a4,a5,0xff
	lui	a5,%hi(counter.0)
	sb	a4,%lo(counter.0)(a5)
	lui	a5,%hi(counter.0)
	lbu	a5,%lo(counter.0)(a5)
	mv	a4,a5
	li	a5,60
	bleu	a4,a5,.L9
	lui	a5,%hi(alarmTimer)
	addi	a0,a5,%lo(alarmTimer)
	call	TIMER_stop
	li	a0,77
	call	UART_transmit
	lui	a5,%hi(counter.0)
	sb	zero,%lo(counter.0)(a5)
	li	a1,0
	lui	a5,%hi(alarm)
	addi	a0,a5,%lo(alarm)
	call	DIO_writeChannel
.L9:
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	alarminterruptHandler, .-alarminterruptHandler
	.align	1
	.globl	CONT_opendoor
	.type	CONT_opendoor, @function
CONT_opendoor:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	lui	a5,%hi(door_state)
	lbu	a5,%lo(door_state)(a5)
	mv	a4,a5
	li	a5,1
	beq	a4,a5,.L13
	li	a1,0
	lui	a5,%hi(motor1)
	addi	a0,a5,%lo(motor1)
	call	MOTOR_changeDirection
	lui	a5,%hi(motortimer)
	addi	a0,a5,%lo(motortimer)
	call	TIMER_start
	li	a1,250
	lui	a5,%hi(motor1)
	addi	a0,a5,%lo(motor1)
	call	MOTOR_start
	lui	a5,%hi(door_state)
	li	a4,1
	sb	a4,%lo(door_state)(a5)
	j	.L10
.L13:
	nop
.L10:
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	CONT_opendoor, .-CONT_opendoor
	.align	1
	.globl	CONT_closedoor
	.type	CONT_closedoor, @function
CONT_closedoor:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	lui	a5,%hi(door_state)
	lbu	a5,%lo(door_state)(a5)
	beq	a5,zero,.L17
	li	a1,1
	lui	a5,%hi(motor1)
	addi	a0,a5,%lo(motor1)
	call	MOTOR_changeDirection
	lui	a5,%hi(motortimer)
	addi	a0,a5,%lo(motortimer)
	call	TIMER_start
	li	a1,250
	lui	a5,%hi(motor1)
	addi	a0,a5,%lo(motor1)
	call	MOTOR_start
	lui	a5,%hi(door_state)
	sb	zero,%lo(door_state)(a5)
	j	.L14
.L17:
	nop
.L14:
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	CONT_closedoor, .-CONT_closedoor
	.align	1
	.globl	CONT_keepOpen
	.type	CONT_keepOpen, @function
CONT_keepOpen:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	lui	a5,%hi(keepOpenTimer)
	addi	a0,a5,%lo(keepOpenTimer)
	call	TIMER_start
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	CONT_keepOpen, .-CONT_keepOpen
	.align	1
	.globl	CONT_startAlarm
	.type	CONT_startAlarm, @function
CONT_startAlarm:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	li	a1,1
	lui	a5,%hi(alarm)
	addi	a0,a5,%lo(alarm)
	call	DIO_writeChannel
	lui	a5,%hi(alarmTimer)
	addi	a0,a5,%lo(alarmTimer)
	call	TIMER_start
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	CONT_startAlarm, .-CONT_startAlarm
	.align	1
	.globl	CONT_getAndCompPassword
	.type	CONT_getAndCompPassword, @function
CONT_getAndCompPassword:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	mv	a5,a0
	sb	a5,-33(s0)
	sw	zero,-24(s0)
	sb	zero,-20(s0)
	sw	zero,-32(s0)
	sb	zero,-28(s0)
	sb	zero,-17(s0)
	addi	a5,s0,-32
	li	a2,1
	mv	a1,a5
	li	a0,0
	call	EEPROM_readData
	addi	a5,s0,-32
	addi	a5,a5,1
	li	a2,1
	mv	a1,a5
	li	a0,1
	call	EEPROM_readData
	addi	a5,s0,-32
	addi	a5,a5,2
	li	a2,1
	mv	a1,a5
	li	a0,2
	call	EEPROM_readData
	addi	a5,s0,-32
	addi	a5,a5,3
	li	a2,1
	mv	a1,a5
	li	a0,3
	call	EEPROM_readData
	addi	a5,s0,-32
	addi	a5,a5,4
	li	a2,1
	mv	a1,a5
	li	a0,4
	call	EEPROM_readData
	sb	zero,-17(s0)
	j	.L21
.L24:
	lbu	a4,-33(s0)
	addi	a5,s0,-24
	mv	a1,a4
	mv	a0,a5
	call	CONT_getPassword
	addi	a4,s0,-32
	addi	a5,s0,-24
	mv	a1,a4
	mv	a0,a5
	call	CONT_password_match
	mv	a5,a0
	beq	a5,zero,.L22
	li	a5,1
	j	.L25
.L22:
	lbu	a5,-17(s0)
	addiw	a5,a5,1
	sb	a5,-17(s0)
.L21:
	lbu	a5,-17(s0)
	andi	a4,a5,0xff
	li	a5,2
	bleu	a4,a5,.L24
	li	a5,0
.L25:
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	CONT_getAndCompPassword, .-CONT_getAndCompPassword
	.align	1
	.globl	CONT_setPassword
	.type	CONT_setPassword, @function
CONT_setPassword:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sw	zero,-24(s0)
	sb	zero,-20(s0)
	sw	zero,-32(s0)
	sb	zero,-28(s0)
.L27:
	addi	a5,s0,-24
	li	a1,115
	mv	a0,a5
	call	CONT_getPassword
	addi	a5,s0,-32
	li	a1,114
	mv	a0,a5
	call	CONT_getPassword
	addi	a4,s0,-32
	addi	a5,s0,-24
	mv	a1,a4
	mv	a0,a5
	call	CONT_password_match
	mv	a5,a0
	beq	a5,zero,.L27
	addi	a5,s0,-24
	mv	a0,a5
	call	CONT_updatePassword
	li	a0,77
	call	CONT_sendMSG
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	CONT_setPassword, .-CONT_setPassword
	.align	1
	.globl	CONT_sendMSG
	.type	CONT_sendMSG, @function
CONT_sendMSG:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	mv	a5,a0
	sb	a5,-49(s0)
	lui	a5,%hi(recieved_data)
	sb	zero,%lo(recieved_data)(a5)
	j	.L29
.L38:
	lbu	a5,-49(s0)
	mv	a0,a5
	call	UART_transmit
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	fsd	fa5,-24(s0)
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-32(s0)
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L41
	li	a5,1
	sh	a5,-34(s0)
	j	.L32
.L41:
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L42
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC4)
	fld	fa5,%lo(.LC4)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-34(s0)
	j	.L35
.L36:
	li	a5,25
	sh	a5,-36(s0)
	nop
	lhu	a5,-34(s0)
	addiw	a5,a5,-1
	sh	a5,-34(s0)
.L35:
	lhu	a5,-34(s0)
	sext.w	a5,a5
	bne	a5,zero,.L36
	j	.L29
.L42:
	fld	fa5,-32(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-34(s0)
.L32:
	lhu	a5,-34(s0)
	sh	a5,-38(s0)
	nop
.L29:
	lui	a5,%hi(recieved_data)
	lbu	a5,%lo(recieved_data)(a5)
	andi	a5,a5,0xff
	mv	a4,a5
	li	a5,97
	bne	a4,a5,.L38
	nop
	nop
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	CONT_sendMSG, .-CONT_sendMSG
	.align	1
	.globl	CONT_firstRunCheck
	.type	CONT_firstRunCheck, @function
CONT_firstRunCheck:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sb	zero,-39(s0)
	addi	a5,s0,-39
	li	a2,1
	mv	a1,a5
	li	a0,0
	call	EEPROM_readData
	lbu	a5,-39(s0)
	mv	a4,a5
	li	a5,255
	bne	a4,a5,.L44
	li	a0,102
	call	CONT_sendMSG
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	fsd	fa5,-24(s0)
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-32(s0)
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L57
	li	a5,1
	sh	a5,-34(s0)
	j	.L47
.L57:
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L58
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC4)
	fld	fa5,%lo(.LC4)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-34(s0)
	j	.L50
.L51:
	li	a5,25
	sh	a5,-36(s0)
	nop
	lhu	a5,-34(s0)
	addiw	a5,a5,-1
	sh	a5,-34(s0)
.L50:
	lhu	a5,-34(s0)
	sext.w	a5,a5
	bne	a5,zero,.L51
	j	.L52
.L58:
	fld	fa5,-32(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-34(s0)
.L47:
	lhu	a5,-34(s0)
	sh	a5,-38(s0)
	nop
.L52:
	li	a5,1
	j	.L54
.L44:
	li	a5,0
.L54:
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	CONT_firstRunCheck, .-CONT_firstRunCheck
	.align	1
	.globl	CONT_getPassword
	.type	CONT_getPassword, @function
CONT_getPassword:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	mv	a5,a1
	sb	a5,-25(s0)
	lbu	a5,-25(s0)
	mv	a0,a5
	call	CONT_sendMSG
	li	a5,95
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,95
	andi	a4,a4,127
	andi	a4,a4,0xff
	sb	a4,0(a5)
	li	a1,5
	ld	a0,-24(s0)
	call	UART_receiveString
	li	a5,95
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,95
	ori	a4,a4,-128
	andi	a4,a4,0xff
	sb	a4,0(a5)
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	CONT_getPassword, .-CONT_getPassword
	.align	1
	.globl	CONT_password_match
	.type	CONT_password_match, @function
CONT_password_match:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-56(s0)
	sd	a1,-64(s0)
	sb	zero,-17(s0)
	sb	zero,-17(s0)
	j	.L61
.L72:
	lbu	a5,-17(s0)
	ld	a4,-56(s0)
	add	a5,a4,a5
	lbu	a3,0(a5)
	lbu	a5,-17(s0)
	ld	a4,-64(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a3
	beq	a4,a5,.L62
	li	a0,110
	call	CONT_sendMSG
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	fsd	fa5,-32(s0)
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-40(s0)
	fld	fa4,-40(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L75
	li	a5,1
	sh	a5,-42(s0)
	j	.L65
.L75:
	fld	fa4,-40(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L76
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC4)
	fld	fa5,%lo(.LC4)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-42(s0)
	j	.L68
.L69:
	li	a5,25
	sh	a5,-44(s0)
	nop
	lhu	a5,-42(s0)
	addiw	a5,a5,-1
	sh	a5,-42(s0)
.L68:
	lhu	a5,-42(s0)
	sext.w	a5,a5
	bne	a5,zero,.L69
	j	.L70
.L76:
	fld	fa5,-40(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-42(s0)
.L65:
	lhu	a5,-42(s0)
	sh	a5,-46(s0)
	nop
.L70:
	li	a5,0
	j	.L71
.L62:
	lbu	a5,-17(s0)
	addiw	a5,a5,1
	sb	a5,-17(s0)
.L61:
	lbu	a5,-17(s0)
	andi	a4,a5,0xff
	li	a5,4
	bleu	a4,a5,.L72
	li	a5,1
.L71:
	mv	a0,a5
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	CONT_password_match, .-CONT_password_match
	.align	1
	.globl	CONT_updatePassword
	.type	CONT_updatePassword, @function
CONT_updatePassword:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-56(s0)
	li	a2,5
	ld	a1,-56(s0)
	li	a0,0
	call	EEPROM_writeData
	li	a0,112
	call	CONT_sendMSG
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	fsd	fa5,-24(s0)
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-32(s0)
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L88
	li	a5,1
	sh	a5,-34(s0)
	j	.L80
.L88:
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L89
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC4)
	fld	fa5,%lo(.LC4)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-34(s0)
	j	.L83
.L84:
	li	a5,25
	sh	a5,-36(s0)
	nop
	lhu	a5,-34(s0)
	addiw	a5,a5,-1
	sh	a5,-34(s0)
.L83:
	lhu	a5,-34(s0)
	sext.w	a5,a5
	bne	a5,zero,.L84
	j	.L85
.L89:
	fld	fa5,-32(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-34(s0)
.L80:
	lhu	a5,-34(s0)
	sh	a5,-38(s0)
	nop
.L85:
	lui	a5,%hi(recieved_data)
	sb	zero,%lo(recieved_data)(a5)
	nop
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	CONT_updatePassword, .-CONT_updatePassword
	.local	counter.2
	.comm	counter.2,1,1
	.local	counter.1
	.comm	counter.1,1,1
	.local	counter.0
	.comm	counter.0,1,1
	.section	.rodata
	.align	3
.LC0:
	.word	0
	.word	1083129856
	.align	3
.LC1:
	.word	0
	.word	1081032704
	.align	3
.LC2:
	.word	0
	.word	1072693248
	.align	3
.LC3:
	.word	0
	.word	1089470432
	.align	3
.LC4:
	.word	0
	.word	1076101120
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
