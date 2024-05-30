	.file	"HMI_utility_functions.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.sdata,"aw"
	.type	pos, @object
	.size	pos, 1
pos:
	.byte	1
	.local	page
	.comm	page,1,1
	.section	.rodata
	.align	3
.LC0:
	.string	"open door"
	.align	3
.LC1:
	.string	"close door"
	.align	3
.LC2:
	.string	"reset password"
	.align	3
.LC3:
	.string	"future option"
	.data
	.align	3
	.type	list, @object
	.size	list, 96
list:
	.dword	.LC0
	.byte	117
	.zero	7
	.dword	.LC1
	.byte	99
	.zero	7
	.dword	.LC2
	.byte	116
	.zero	7
	.dword	.LC3
	.byte	0
	.zero	7
	.dword	.LC3
	.byte	0
	.zero	7
	.dword	.LC3
	.byte	0
	.zero	7
	.text
	.align	1
	.globl	movedown
	.type	movedown, @function
movedown:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	lui	a5,%hi(pos)
	lbu	a5,%lo(pos)(a5)
	andi	a5,a5,0xff
	mv	a4,a5
	li	a5,5
	bgtu	a4,a5,.L17
	lui	a5,%hi(pos)
	lbu	a5,%lo(pos)(a5)
	andi	a5,a5,0xff
	addiw	a5,a5,1
	andi	a4,a5,0xff
	lui	a5,%hi(pos)
	sb	a4,%lo(pos)(a5)
	lui	a5,%hi(pos)
	lbu	a5,%lo(pos)(a5)
	andi	a5,a5,0xff
	mv	a4,a5
	li	a5,3
	bleu	a4,a5,.L4
	lui	a5,%hi(page)
	lbu	a5,%lo(page)(a5)
	andi	a5,a5,0xff
	addiw	a5,a5,1
	andi	a4,a5,0xff
	lui	a5,%hi(page)
	sb	a4,%lo(page)(a5)
.L4:
	call	HMI_displayMainMenu
	li	a1,1
	lui	a5,%hi(buzzer)
	addi	a0,a5,%lo(buzzer)
	call	DIO_writeChannel
	lui	a5,%hi(.LC4)
	fld	fa5,%lo(.LC4)(a5)
	fsd	fa5,-24(s0)
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC5)
	fld	fa5,%lo(.LC5)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-32(s0)
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC6)
	fld	fa5,%lo(.LC6)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L15
	li	a5,1
	sh	a5,-34(s0)
	j	.L7
.L15:
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC7)
	fld	fa5,%lo(.LC7)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L16
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC8)
	fld	fa5,%lo(.LC8)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-34(s0)
	j	.L10
.L11:
	li	a5,25
	sh	a5,-36(s0)
	nop
	lhu	a5,-34(s0)
	addiw	a5,a5,-1
	sh	a5,-34(s0)
.L10:
	lhu	a5,-34(s0)
	sext.w	a5,a5
	bne	a5,zero,.L11
	j	.L12
.L16:
	fld	fa5,-32(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-34(s0)
.L7:
	lhu	a5,-34(s0)
	sh	a5,-38(s0)
	nop
.L12:
	li	a1,0
	lui	a5,%hi(buzzer)
	addi	a0,a5,%lo(buzzer)
	call	DIO_writeChannel
	j	.L1
.L17:
	nop
.L1:
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	movedown, .-movedown
	.align	1
	.globl	moveup
	.type	moveup, @function
moveup:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	lui	a5,%hi(pos)
	lbu	a5,%lo(pos)(a5)
	andi	a5,a5,0xff
	mv	a4,a5
	li	a5,1
	bleu	a4,a5,.L34
	lui	a5,%hi(pos)
	lbu	a5,%lo(pos)(a5)
	andi	a5,a5,0xff
	addiw	a5,a5,-1
	andi	a4,a5,0xff
	lui	a5,%hi(pos)
	sb	a4,%lo(pos)(a5)
	lui	a5,%hi(page)
	lbu	a5,%lo(page)(a5)
	andi	a4,a5,0xff
	lui	a5,%hi(pos)
	lbu	a5,%lo(pos)(a5)
	andi	a5,a5,0xff
	bltu	a4,a5,.L21
	lui	a5,%hi(page)
	lbu	a5,%lo(page)(a5)
	andi	a5,a5,0xff
	addiw	a5,a5,-1
	andi	a4,a5,0xff
	lui	a5,%hi(page)
	sb	a4,%lo(page)(a5)
.L21:
	call	HMI_displayMainMenu
	li	a1,1
	lui	a5,%hi(buzzer)
	addi	a0,a5,%lo(buzzer)
	call	DIO_writeChannel
	lui	a5,%hi(.LC4)
	fld	fa5,%lo(.LC4)(a5)
	fsd	fa5,-24(s0)
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC5)
	fld	fa5,%lo(.LC5)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-32(s0)
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC6)
	fld	fa5,%lo(.LC6)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L32
	li	a5,1
	sh	a5,-34(s0)
	j	.L24
.L32:
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC7)
	fld	fa5,%lo(.LC7)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L33
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC8)
	fld	fa5,%lo(.LC8)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-34(s0)
	j	.L27
.L28:
	li	a5,25
	sh	a5,-36(s0)
	nop
	lhu	a5,-34(s0)
	addiw	a5,a5,-1
	sh	a5,-34(s0)
.L27:
	lhu	a5,-34(s0)
	sext.w	a5,a5
	bne	a5,zero,.L28
	j	.L29
.L33:
	fld	fa5,-32(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-34(s0)
.L24:
	lhu	a5,-34(s0)
	sh	a5,-38(s0)
	nop
.L29:
	li	a1,0
	lui	a5,%hi(buzzer)
	addi	a0,a5,%lo(buzzer)
	call	DIO_writeChannel
	j	.L18
.L34:
	nop
.L18:
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	moveup, .-moveup
	.align	1
	.globl	select
	.type	select, @function
select:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	lui	a5,%hi(pos)
	lbu	a5,%lo(pos)(a5)
	andi	a5,a5,0xff
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	lui	a4,%hi(list)
	addi	a4,a4,%lo(list)
	slli	a5,a5,4
	add	a5,a4,a5
	lbu	a5,8(a5)
	mv	a0,a5
	call	UART_transmit
	li	a1,1
	lui	a5,%hi(buzzer)
	addi	a0,a5,%lo(buzzer)
	call	DIO_writeChannel
	lui	a5,%hi(.LC4)
	fld	fa5,%lo(.LC4)(a5)
	fsd	fa5,-24(s0)
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC5)
	fld	fa5,%lo(.LC5)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-32(s0)
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC6)
	fld	fa5,%lo(.LC6)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L46
	li	a5,1
	sh	a5,-34(s0)
	j	.L38
.L46:
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC7)
	fld	fa5,%lo(.LC7)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L47
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC8)
	fld	fa5,%lo(.LC8)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-34(s0)
	j	.L41
.L42:
	li	a5,25
	sh	a5,-36(s0)
	nop
	lhu	a5,-34(s0)
	addiw	a5,a5,-1
	sh	a5,-34(s0)
.L41:
	lhu	a5,-34(s0)
	sext.w	a5,a5
	bne	a5,zero,.L42
	j	.L43
.L47:
	fld	fa5,-32(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-34(s0)
.L38:
	lhu	a5,-34(s0)
	sh	a5,-38(s0)
	nop
.L43:
	li	a1,0
	lui	a5,%hi(buzzer)
	addi	a0,a5,%lo(buzzer)
	call	DIO_writeChannel
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	select, .-select
	.section	.rodata
	.align	3
.LC9:
	.string	"lw msktak"
	.align	3
.LC10:
	.string	"H........"
	.text
	.align	1
	.globl	HMI_alarm
	.type	HMI_alarm, @function
HMI_alarm:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	call	LCD_clearScreen
	lui	a5,%hi(.LC9)
	addi	a0,a5,%lo(.LC9)
	call	LCD_displayString
	li	a1,0
	li	a0,1
	call	LCD_goTo
	lui	a5,%hi(.LC10)
	addi	a0,a5,%lo(.LC10)
	call	LCD_displayString
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	HMI_alarm, .-HMI_alarm
	.align	1
	.globl	HMI_askForPassword
	.type	HMI_askForPassword, @function
HMI_askForPassword:
	addi	sp,sp,-96
	sd	ra,88(sp)
	sd	s0,80(sp)
	sd	s1,72(sp)
	addi	s0,sp,96
	sd	a0,-88(s0)
	sb	zero,-33(s0)
	call	LCD_clearScreen
	ld	a0,-88(s0)
	call	LCD_displayString
	li	a1,4
	li	a0,2
	call	LCD_goTo
	j	.L50
.L60:
	lbu	a5,-33(s0)
	sext.w	s1,a5
	call	KEYPAD_getCharacter
	mv	a5,a0
	mv	a4,a5
	addi	a5,s1,-32
	add	a5,a5,s0
	sb	a4,-40(a5)
	li	a0,42
	call	LCD_characterDisplay
	li	a1,1
	lui	a5,%hi(buzzer)
	addi	a0,a5,%lo(buzzer)
	call	DIO_writeChannel
	lui	a5,%hi(.LC4)
	fld	fa5,%lo(.LC4)(a5)
	fsd	fa5,-48(s0)
	fld	fa4,-48(s0)
	lui	a5,%hi(.LC5)
	fld	fa5,%lo(.LC5)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-56(s0)
	fld	fa4,-56(s0)
	lui	a5,%hi(.LC6)
	fld	fa5,%lo(.LC6)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L63
	li	a5,1
	sh	a5,-58(s0)
	j	.L53
.L63:
	fld	fa4,-56(s0)
	lui	a5,%hi(.LC7)
	fld	fa5,%lo(.LC7)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L64
	fld	fa4,-48(s0)
	lui	a5,%hi(.LC8)
	fld	fa5,%lo(.LC8)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-58(s0)
	j	.L56
.L57:
	li	a5,25
	sh	a5,-60(s0)
	nop
	lhu	a5,-58(s0)
	addiw	a5,a5,-1
	sh	a5,-58(s0)
.L56:
	lhu	a5,-58(s0)
	sext.w	a5,a5
	bne	a5,zero,.L57
	j	.L58
.L64:
	fld	fa5,-56(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-58(s0)
.L53:
	lhu	a5,-58(s0)
	sh	a5,-62(s0)
	nop
.L58:
	li	a1,0
	lui	a5,%hi(buzzer)
	addi	a0,a5,%lo(buzzer)
	call	DIO_writeChannel
	lbu	a5,-33(s0)
	addiw	a5,a5,1
	sb	a5,-33(s0)
	nop
.L59:
	call	KEYPAD_keyRelaesed
	mv	a5,a0
	beq	a5,zero,.L59
.L50:
	lbu	a5,-33(s0)
	andi	a4,a5,0xff
	li	a5,4
	bleu	a4,a5,.L60
	addi	a5,s0,-72
	li	a1,5
	mv	a0,a5
	call	UART_transmitString
	nop
	ld	ra,88(sp)
	ld	s0,80(sp)
	ld	s1,72(sp)
	addi	sp,sp,96
	jr	ra
	.size	HMI_askForPassword, .-HMI_askForPassword
	.section	.rodata
	.align	3
.LC11:
	.string	"  "
	.align	3
.LC12:
	.string	"->"
	.text
	.align	1
	.globl	HMI_moveArrow
	.type	HMI_moveArrow, @function
HMI_moveArrow:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	mv	a5,a0
	sb	a5,-17(s0)
	lbu	a5,-17(s0)
	andi	a4,a5,0xff
	li	a5,3
	bleu	a4,a5,.L66
	lbu	a5,-17(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L69
.L66:
	li	a1,0
	li	a0,1
	call	LCD_goTo
	lui	a5,%hi(.LC11)
	addi	a0,a5,%lo(.LC11)
	call	LCD_displayString
	li	a1,0
	li	a0,2
	call	LCD_goTo
	lui	a5,%hi(.LC11)
	addi	a0,a5,%lo(.LC11)
	call	LCD_displayString
	li	a1,0
	li	a0,3
	call	LCD_goTo
	lui	a5,%hi(.LC11)
	addi	a0,a5,%lo(.LC11)
	call	LCD_displayString
	lbu	a5,-17(s0)
	andi	a4,a5,0xff
	li	a5,3
	bleu	a4,a5,.L68
	lui	a5,%hi(page)
	lbu	a5,%lo(page)(a5)
	andi	a5,a5,0xff
	lbu	a4,-17(s0)
	subw	a5,a4,a5
	andi	a5,a5,0xff
	li	a1,0
	mv	a0,a5
	call	LCD_goTo
	lui	a5,%hi(.LC12)
	addi	a0,a5,%lo(.LC12)
	call	LCD_displayString
	j	.L65
.L68:
	lbu	a5,-17(s0)
	li	a1,0
	mv	a0,a5
	call	LCD_goTo
	lui	a5,%hi(.LC12)
	addi	a0,a5,%lo(.LC12)
	call	LCD_displayString
	j	.L65
.L69:
	nop
.L65:
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	HMI_moveArrow, .-HMI_moveArrow
	.section	.rodata
	.align	3
.LC13:
	.string	"select :"
	.text
	.align	1
	.globl	HMI_displayMainMenu
	.type	HMI_displayMainMenu, @function
HMI_displayMainMenu:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sb	zero,-17(s0)
	call	LCD_clearScreen
	li	a1,0
	li	a0,0
	call	LCD_goTo
	lui	a5,%hi(.LC13)
	addi	a0,a5,%lo(.LC13)
	call	LCD_displayString
	sb	zero,-17(s0)
	j	.L71
.L72:
	lbu	a5,-17(s0)
	addiw	a5,a5,1
	andi	a5,a5,0xff
	li	a1,2
	mv	a0,a5
	call	LCD_goTo
	lui	a5,%hi(page)
	lbu	a5,%lo(page)(a5)
	andi	a5,a5,0xff
	sext.w	a4,a5
	lbu	a5,-17(s0)
	sext.w	a5,a5
	addw	a5,a4,a5
	sext.w	a5,a5
	lui	a4,%hi(list)
	addi	a4,a4,%lo(list)
	slli	a5,a5,4
	add	a5,a4,a5
	ld	a5,0(a5)
	mv	a0,a5
	call	LCD_displayString
	lbu	a5,-17(s0)
	addiw	a5,a5,1
	sb	a5,-17(s0)
.L71:
	lbu	a5,-17(s0)
	andi	a4,a5,0xff
	li	a5,2
	bleu	a4,a5,.L72
	li	a1,15
	li	a0,0
	call	LCD_goTo
	lui	a5,%hi(pos)
	lbu	a5,%lo(pos)(a5)
	andi	a5,a5,0xff
	mv	a0,a5
	call	LCD_displayNumber
	lui	a5,%hi(pos)
	lbu	a5,%lo(pos)(a5)
	andi	a4,a5,0xff
	lui	a5,%hi(page)
	lbu	a5,%lo(page)(a5)
	andi	a5,a5,0xff
	subw	a5,a4,a5
	andi	a5,a5,0xff
	mv	a0,a5
	call	HMI_moveArrow
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	HMI_displayMainMenu, .-HMI_displayMainMenu
	.section	.rodata
	.align	3
.LC14:
	.string	"welcome"
	.align	3
.LC15:
	.string	"yasta"
	.align	3
.LC16:
	.string	":)"
	.text
	.align	1
	.globl	HMI_firstTimeMSG
	.type	HMI_firstTimeMSG, @function
HMI_firstTimeMSG:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	call	LCD_clearScreen
	lui	a5,%hi(.LC14)
	addi	a0,a5,%lo(.LC14)
	call	LCD_displayString
	li	a1,0
	li	a0,1
	call	LCD_goTo
	lui	a5,%hi(.LC15)
	addi	a0,a5,%lo(.LC15)
	call	LCD_displayString
	li	a1,6
	li	a0,2
	call	LCD_goTo
	lui	a5,%hi(.LC16)
	addi	a0,a5,%lo(.LC16)
	call	LCD_displayString
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	HMI_firstTimeMSG, .-HMI_firstTimeMSG
	.section	.rodata
	.align	3
.LC17:
	.string	"no matching"
	.text
	.align	1
	.globl	HMI_matchError
	.type	HMI_matchError, @function
HMI_matchError:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	call	LCD_clearScreen
	lui	a5,%hi(.LC17)
	addi	a0,a5,%lo(.LC17)
	call	LCD_displayString
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	HMI_matchError, .-HMI_matchError
	.section	.rodata
	.align	3
.LC18:
	.string	"password"
	.align	3
.LC19:
	.string	"accepted"
	.text
	.align	1
	.globl	HMI_success
	.type	HMI_success, @function
HMI_success:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	call	LCD_clearScreen
	lui	a5,%hi(.LC18)
	addi	a0,a5,%lo(.LC18)
	call	LCD_displayString
	li	a1,0
	li	a0,1
	call	LCD_goTo
	lui	a5,%hi(.LC19)
	addi	a0,a5,%lo(.LC19)
	call	LCD_displayString
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	HMI_success, .-HMI_success
	.section	.rodata
	.align	3
.LC20:
	.string	"updated"
	.align	3
.LC21:
	.string	"successfully"
	.text
	.align	1
	.globl	HMI_updated
	.type	HMI_updated, @function
HMI_updated:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	call	LCD_clearScreen
	lui	a5,%hi(.LC18)
	addi	a0,a5,%lo(.LC18)
	call	LCD_displayString
	li	a1,0
	li	a0,1
	call	LCD_goTo
	lui	a5,%hi(.LC20)
	addi	a0,a5,%lo(.LC20)
	call	LCD_displayString
	li	a1,0
	li	a0,2
	call	LCD_goTo
	lui	a5,%hi(.LC21)
	addi	a0,a5,%lo(.LC21)
	call	LCD_displayString
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	HMI_updated, .-HMI_updated
	.section	.rodata
	.align	3
.LC4:
	.word	0
	.word	1078525952
	.align	3
.LC5:
	.word	0
	.word	1081032704
	.align	3
.LC6:
	.word	0
	.word	1072693248
	.align	3
.LC7:
	.word	0
	.word	1089470432
	.align	3
.LC8:
	.word	0
	.word	1076101120
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
