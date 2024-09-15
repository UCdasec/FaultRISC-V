	.file	"HMI_utility_functions.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	select
	.type	select, @function
select:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	lui	a5,%hi(pos)
	lbu	a4,%lo(pos)(a5)
	addiw	a4,a4,-1
	slli	a4,a4,4
	lui	a5,%hi(.LANCHOR0)
	addi	a5,a5,%lo(.LANCHOR0)
	add	a5,a5,a4
	lbu	a0,8(a5)
	call	UART_transmit
	li	a1,1
	lui	s0,%hi(buzzer)
	addi	a0,s0,%lo(buzzer)
	call	DIO_writeChannel
	li	a0,49152
	addi	a0,a0,848
	call	__builtin_avr_delay_cycles
	li	a1,0
	addi	a0,s0,%lo(buzzer)
	call	DIO_writeChannel
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	select, .-select
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"lw msktak"
	.align	3
.LC1:
	.string	"H........"
	.text
	.align	1
	.globl	HMI_alarm
	.type	HMI_alarm, @function
HMI_alarm:
	addi	sp,sp,-16
	sd	ra,8(sp)
	call	LCD_clearScreen
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	LCD_displayString
	li	a1,0
	li	a0,1
	call	LCD_goTo
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	LCD_displayString
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	HMI_alarm, .-HMI_alarm
	.align	1
	.globl	HMI_askForPassword
	.type	HMI_askForPassword, @function
HMI_askForPassword:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	sd	s1,40(sp)
	sd	s2,32(sp)
	sd	s3,24(sp)
	mv	s0,a0
	call	LCD_clearScreen
	mv	a0,s0
	call	LCD_displayString
	li	a1,4
	li	a0,2
	call	LCD_goTo
	addi	s0,sp,8
	addi	s3,sp,13
	lui	s1,%hi(buzzer)
	li	s2,49152
	addi	s2,s2,848
.L7:
	call	KEYPAD_getCharacter
	sb	a0,0(s0)
	li	a0,42
	call	LCD_characterDisplay
	li	a1,1
	addi	a0,s1,%lo(buzzer)
	call	DIO_writeChannel
	mv	a0,s2
	call	__builtin_avr_delay_cycles
	li	a1,0
	addi	a0,s1,%lo(buzzer)
	call	DIO_writeChannel
.L6:
	call	KEYPAD_keyRelaesed
	beq	a0,zero,.L6
	addi	s0,s0,1
	bne	s0,s3,.L7
	li	a1,5
	addi	a0,sp,8
	call	UART_transmitString
	ld	ra,56(sp)
	ld	s0,48(sp)
	ld	s1,40(sp)
	ld	s2,32(sp)
	ld	s3,24(sp)
	addi	sp,sp,64
	jr	ra
	.size	HMI_askForPassword, .-HMI_askForPassword
	.section	.rodata.str1.8
	.align	3
.LC2:
	.string	"  "
	.align	3
.LC3:
	.string	"->"
	.text
	.align	1
	.globl	HMI_moveArrow
	.type	HMI_moveArrow, @function
HMI_moveArrow:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	sd	s1,8(sp)
	mv	s0,a0
	li	a1,0
	li	a0,1
	call	LCD_goTo
	lui	s1,%hi(.LC2)
	addi	a0,s1,%lo(.LC2)
	call	LCD_displayString
	li	a1,0
	li	a0,2
	call	LCD_goTo
	addi	a0,s1,%lo(.LC2)
	call	LCD_displayString
	li	a1,0
	li	a0,3
	call	LCD_goTo
	addi	a0,s1,%lo(.LC2)
	call	LCD_displayString
	li	a5,3
	bleu	s0,a5,.L12
	lui	a5,%hi(page)
	lbu	a5,%lo(page)(a5)
	subw	a0,s0,a5
	li	a1,0
	andi	a0,a0,0xff
	call	LCD_goTo
	lui	a0,%hi(.LC3)
	addi	a0,a0,%lo(.LC3)
	call	LCD_displayString
.L11:
	ld	ra,24(sp)
	ld	s0,16(sp)
	ld	s1,8(sp)
	addi	sp,sp,32
	jr	ra
.L12:
	li	a1,0
	mv	a0,s0
	call	LCD_goTo
	lui	a0,%hi(.LC3)
	addi	a0,a0,%lo(.LC3)
	call	LCD_displayString
	j	.L11
	.size	HMI_moveArrow, .-HMI_moveArrow
	.section	.rodata.str1.8
	.align	3
.LC4:
	.string	"select :"
	.text
	.align	1
	.globl	HMI_displayMainMenu
	.type	HMI_displayMainMenu, @function
HMI_displayMainMenu:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	sd	s1,24(sp)
	sd	s2,16(sp)
	sd	s3,8(sp)
	call	LCD_clearScreen
	li	a1,0
	li	a0,0
	call	LCD_goTo
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	call	LCD_displayString
	li	s0,0
	lui	s3,%hi(page)
	lui	s1,%hi(.LANCHOR0)
	addi	s1,s1,%lo(.LANCHOR0)
	li	s2,3
.L16:
	addiw	a0,s0,1
	li	a1,2
	andi	a0,a0,0xff
	call	LCD_goTo
	lbu	a5,%lo(page)(s3)
	addw	a5,a5,s0
	slli	a5,a5,4
	add	a5,s1,a5
	ld	a0,0(a5)
	call	LCD_displayString
	addiw	s0,s0,1
	bne	s0,s2,.L16
	li	a1,15
	li	a0,0
	call	LCD_goTo
	lui	s0,%hi(pos)
	lbu	a0,%lo(pos)(s0)
	call	LCD_displayNumber
	lbu	a0,%lo(pos)(s0)
	lui	a5,%hi(page)
	lbu	a5,%lo(page)(a5)
	subw	a0,a0,a5
	andi	a0,a0,0xff
	call	HMI_moveArrow
	ld	ra,40(sp)
	ld	s0,32(sp)
	ld	s1,24(sp)
	ld	s2,16(sp)
	ld	s3,8(sp)
	addi	sp,sp,48
	jr	ra
	.size	HMI_displayMainMenu, .-HMI_displayMainMenu
	.align	1
	.globl	movedown
	.type	movedown, @function
movedown:
	lui	a5,%hi(pos)
	lbu	a5,%lo(pos)(a5)
	andi	a5,a5,0xff
	li	a4,5
	bgtu	a5,a4,.L23
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	lui	a4,%hi(pos)
	lbu	a5,%lo(pos)(a4)
	addiw	a5,a5,1
	andi	a5,a5,0xff
	sb	a5,%lo(pos)(a4)
	lbu	a5,%lo(pos)(a4)
	andi	a5,a5,0xff
	li	a4,3
	bleu	a5,a4,.L21
	lui	a4,%hi(page)
	lbu	a5,%lo(page)(a4)
	addiw	a5,a5,1
	andi	a5,a5,0xff
	sb	a5,%lo(page)(a4)
.L21:
	call	HMI_displayMainMenu
	li	a1,1
	lui	s0,%hi(buzzer)
	addi	a0,s0,%lo(buzzer)
	call	DIO_writeChannel
	li	a0,49152
	addi	a0,a0,848
	call	__builtin_avr_delay_cycles
	li	a1,0
	addi	a0,s0,%lo(buzzer)
	call	DIO_writeChannel
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
.L23:
	ret
	.size	movedown, .-movedown
	.align	1
	.globl	moveup
	.type	moveup, @function
moveup:
	lui	a5,%hi(pos)
	lbu	a5,%lo(pos)(a5)
	andi	a5,a5,0xff
	li	a4,1
	bleu	a5,a4,.L30
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	lui	a4,%hi(pos)
	lbu	a5,%lo(pos)(a4)
	addiw	a5,a5,-1
	andi	a5,a5,0xff
	sb	a5,%lo(pos)(a4)
	lui	a5,%hi(page)
	lbu	a5,%lo(page)(a5)
	lbu	a4,%lo(pos)(a4)
	andi	a5,a5,0xff
	bltu	a5,a4,.L28
	lui	a4,%hi(page)
	lbu	a5,%lo(page)(a4)
	addiw	a5,a5,-1
	andi	a5,a5,0xff
	sb	a5,%lo(page)(a4)
.L28:
	call	HMI_displayMainMenu
	li	a1,1
	lui	s0,%hi(buzzer)
	addi	a0,s0,%lo(buzzer)
	call	DIO_writeChannel
	li	a0,49152
	addi	a0,a0,848
	call	__builtin_avr_delay_cycles
	li	a1,0
	addi	a0,s0,%lo(buzzer)
	call	DIO_writeChannel
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
.L30:
	ret
	.size	moveup, .-moveup
	.section	.rodata.str1.8
	.align	3
.LC5:
	.string	"welcome"
	.align	3
.LC6:
	.string	"yasta"
	.align	3
.LC7:
	.string	":)"
	.text
	.align	1
	.globl	HMI_firstTimeMSG
	.type	HMI_firstTimeMSG, @function
HMI_firstTimeMSG:
	addi	sp,sp,-16
	sd	ra,8(sp)
	call	LCD_clearScreen
	lui	a0,%hi(.LC5)
	addi	a0,a0,%lo(.LC5)
	call	LCD_displayString
	li	a1,0
	li	a0,1
	call	LCD_goTo
	lui	a0,%hi(.LC6)
	addi	a0,a0,%lo(.LC6)
	call	LCD_displayString
	li	a1,6
	li	a0,2
	call	LCD_goTo
	lui	a0,%hi(.LC7)
	addi	a0,a0,%lo(.LC7)
	call	LCD_displayString
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	HMI_firstTimeMSG, .-HMI_firstTimeMSG
	.section	.rodata.str1.8
	.align	3
.LC8:
	.string	"no matching"
	.text
	.align	1
	.globl	HMI_matchError
	.type	HMI_matchError, @function
HMI_matchError:
	addi	sp,sp,-16
	sd	ra,8(sp)
	call	LCD_clearScreen
	lui	a0,%hi(.LC8)
	addi	a0,a0,%lo(.LC8)
	call	LCD_displayString
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	HMI_matchError, .-HMI_matchError
	.section	.rodata.str1.8
	.align	3
.LC9:
	.string	"password"
	.align	3
.LC10:
	.string	"accepted"
	.text
	.align	1
	.globl	HMI_success
	.type	HMI_success, @function
HMI_success:
	addi	sp,sp,-16
	sd	ra,8(sp)
	call	LCD_clearScreen
	lui	a0,%hi(.LC9)
	addi	a0,a0,%lo(.LC9)
	call	LCD_displayString
	li	a1,0
	li	a0,1
	call	LCD_goTo
	lui	a0,%hi(.LC10)
	addi	a0,a0,%lo(.LC10)
	call	LCD_displayString
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	HMI_success, .-HMI_success
	.section	.rodata.str1.8
	.align	3
.LC11:
	.string	"updated"
	.align	3
.LC12:
	.string	"successfully"
	.text
	.align	1
	.globl	HMI_updated
	.type	HMI_updated, @function
HMI_updated:
	addi	sp,sp,-16
	sd	ra,8(sp)
	call	LCD_clearScreen
	lui	a0,%hi(.LC9)
	addi	a0,a0,%lo(.LC9)
	call	LCD_displayString
	li	a1,0
	li	a0,1
	call	LCD_goTo
	lui	a0,%hi(.LC11)
	addi	a0,a0,%lo(.LC11)
	call	LCD_displayString
	li	a1,0
	li	a0,2
	call	LCD_goTo
	lui	a0,%hi(.LC12)
	addi	a0,a0,%lo(.LC12)
	call	LCD_displayString
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	HMI_updated, .-HMI_updated
	.section	.rodata.str1.8
	.align	3
.LC13:
	.string	"open door"
	.align	3
.LC14:
	.string	"close door"
	.align	3
.LC15:
	.string	"reset password"
	.align	3
.LC16:
	.string	"future option"
	.section	.rodata
	.align	3
	.set	.LANCHOR0,. + 0
	.type	list, @object
	.size	list, 96
list:
	.dword	.LC13
	.byte	117
	.zero	7
	.dword	.LC14
	.byte	99
	.zero	7
	.dword	.LC15
	.byte	116
	.zero	7
	.dword	.LC16
	.byte	0
	.zero	7
	.dword	.LC16
	.byte	0
	.zero	7
	.dword	.LC16
	.byte	0
	.zero	7
	.section	.sbss,"aw",@nobits
	.type	page, @object
	.size	page, 1
page:
	.zero	1
	.section	.sdata,"aw"
	.type	pos, @object
	.size	pos, 1
pos:
	.byte	1
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
