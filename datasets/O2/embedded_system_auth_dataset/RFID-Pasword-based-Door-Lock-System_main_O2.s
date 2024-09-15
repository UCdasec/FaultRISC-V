	.file	"main.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"BTL TKHTN"
	.align	3
.LC1:
	.string	"Door Lock System"
	.align	3
.LC2:
	.string	"Choose Mode Open"
	.align	3
.LC3:
	.string	"1.Enter PassWord"
	.align	3
.LC4:
	.string	"2.Scan Your Card"
	.align	3
.LC5:
	.string	"Enter PassWord"
	.align	3
.LC6:
	.string	"_ _ _ _"
	.align	3
.LC7:
	.string	"Correct Pass"
	.align	3
.LC8:
	.string	"Door opening..."
	.align	3
.LC9:
	.string	"Welcome Back !"
	.align	3
.LC10:
	.string	"Door closing..."
	.align	3
.LC11:
	.string	"Try again in:"
	.align	3
.LC12:
	.string	"Incorrect Pass"
	.align	3
.LC13:
	.string	"time left"
	.align	3
.LC14:
	.string	"Scan your card"
	.align	3
.LC15:
	.string	"ID:%02X%02X%02X%02X%02X"
	.align	3
.LC16:
	.string	"Correct ID"
	.align	3
.LC17:
	.string	"Incorrect ID"
	.align	3
.LC18:
	.string	"time scan left"
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-160
	sd	ra,152(sp)
	sd	s1,136(sp)
	sd	s4,112(sp)
	sd	s5,104(sp)
	sd	s6,96(sp)
	sd	s7,88(sp)
	sd	s8,80(sp)
	sd	s9,72(sp)
	sd	s10,64(sp)
	sd	s0,144(sp)
	sd	s2,128(sp)
	sd	s3,120(sp)
	sd	s11,56(sp)
	call	GPIO_config
	call	TIMER_Configuration
	call	I2C_LCD_Configuration
	li	a0,2
	call	HD44780_Init
	call	HD44780_Clear
	call	TM_MFRC522_Init
	lui	a5,%hi(PASS)
	addi	a5,a5,%lo(PASS)
	sd	a5,8(sp)
	lui	a5,%hi(ID)
	lui	s6,%hi(CardID)
	li	s1,1073811456
	addi	a5,a5,%lo(ID)
	lui	s8,%hi(CardID+5)
	lui	s7,%hi(a)
	addi	s9,s6,%lo(CardID)
	sd	a5,24(sp)
	addi	s8,s8,%lo(CardID+5)
	addi	s1,s1,-2048
	li	s5,1
	li	s10,48
	addi	s4,sp,44
.L23:
	li	a1,1024
	mv	a0,s1
	call	GPIO_ResetBits
	call	HD44780_Clear
	li	a1,0
	li	a0,3
	call	HD44780_SetCursor
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	HD44780_PrintStr
	li	a0,500
	call	Delay_Ms
	li	a1,1
	li	a0,0
	call	HD44780_SetCursor
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	HD44780_PrintStr
	li	a0,1500
	call	Delay_Ms
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	HD44780_PrintStr
	li	a0,1500
	call	Delay_Ms
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	HD44780_PrintStr
	li	a0,0
	li	a1,1
	call	HD44780_SetCursor
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	HD44780_PrintStr
.L2:
	call	KEYPAD_Read
	beq	a0,zero,.L2
	li	a5,49
	mv	s0,a0
	beq	a0,a5,.L39
	li	a5,50
	bne	a0,a5,.L23
	li	s2,13
	li	s3,5
.L22:
	call	HD44780_Clear
	li	a0,0
	li	a1,0
	call	HD44780_SetCursor
	lui	a5,%hi(.LC14)
	addi	a0,a5,%lo(.LC14)
	call	HD44780_PrintStr
.L15:
	addi	a0,s6,%lo(CardID)
	call	TM_MFRC522_Check
	bne	a0,zero,.L15
	lbu	a6,4(s9)
	lbu	a5,3(s9)
	lbu	a4,2(s9)
	lbu	a3,1(s9)
	lbu	a2,%lo(CardID)(s6)
	lui	a0,%hi(.LANCHOR0)
	lui	a1,%hi(.LC15)
	mv	s11,a0
	addi	a1,a1,%lo(.LC15)
	addi	a0,a0,%lo(.LANCHOR0)
	call	sprintf
	li	a1,1
	li	a0,0
	call	HD44780_SetCursor
	addi	a0,s11,%lo(.LANCHOR0)
	call	HD44780_PrintStr
	li	a0,200
	call	Delay_Ms
	li	s11,3
.L16:
	li	a1,1
	andi	a0,s11,0xff
	call	HD44780_SetCursor
	li	a0,42
	call	HD44780_PrintSpecialChar
	li	a0,50
	addiw	s11,s11,1
	call	Delay_Ms
	bne	s11,s2,.L16
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
	ld	a4,24(sp)
	mv	a5,s9
	li	a1,0
.L18:
	lbu	a2,0(a5)
	lbu	a3,0(a4)
	addi	a5,a5,1
	addi	a4,a4,1
	beq	a2,a3,.L40
	bne	a5,s8,.L18
.L43:
	beq	a1,s3,.L41
	beq	s0,s10,.L42
	lui	a5,%hi(.LC17)
	addi	a0,a5,%lo(.LC17)
	call	HD44780_PrintStr
	li	a1,1
	li	a0,0
	call	HD44780_SetCursor
	mv	a0,s0
	call	HD44780_PrintSpecialChar
	li	a1,1
	li	a0,2
	call	HD44780_SetCursor
	lui	a5,%hi(.LC18)
	addi	a0,a5,%lo(.LC18)
	call	HD44780_PrintStr
	li	a0,1500
	addiw	s0,s0,-1
	call	Delay_Ms
	andi	s0,s0,0xff
	j	.L22
.L40:
	addiw	a1,a1,1
	andi	a1,a1,0xff
	bne	a5,s8,.L18
	j	.L43
.L39:
	li	s3,50
	li	s11,12
	sd	s1,16(sp)
.L14:
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	HD44780_PrintStr
	li	a1,1
	li	a0,4
	call	HD44780_SetCursor
	lui	a5,%hi(.LC6)
	addi	a0,a5,%lo(.LC6)
	addi	s1,sp,40
	call	HD44780_PrintStr
	mv	s2,s1
	li	s0,4
.L5:
	li	a1,1
	mv	a0,s0
	call	HD44780_SetCursor
.L4:
	call	KEYPAD_Read
	beq	a0,zero,.L4
	sb	a0,0(s2)
	call	HD44780_PrintSpecialChar
	li	a0,200
	call	Delay_Ms
	mv	a0,s0
	li	a1,1
	call	HD44780_SetCursor
	addiw	s0,s0,2
	li	a0,42
	andi	s0,s0,0xff
	call	HD44780_PrintSpecialChar
	addi	s2,s2,1
	bne	s0,s11,.L5
	li	a0,500
	call	Delay_Ms
	ld	a5,8(sp)
	sb	zero,%lo(a)(s7)
	li	a0,0
	li	a1,0
.L7:
	lbu	a3,0(s1)
	lbu	a4,0(a5)
	addi	s1,s1,1
	addi	a5,a5,1
	beq	a3,a4,.L44
	bne	s4,s1,.L7
.L47:
	beq	a0,zero,.L8
	sb	a1,%lo(a)(s7)
.L8:
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
	lbu	a4,%lo(a)(s7)
	li	a5,4
	beq	a4,a5,.L45
	beq	s3,s10,.L46
	lui	a5,%hi(.LC12)
	addi	a0,a5,%lo(.LC12)
	call	HD44780_PrintStr
	li	a1,1
	li	a0,0
	call	HD44780_SetCursor
	mv	a0,s3
	call	HD44780_PrintSpecialChar
	li	a1,1
	li	a0,2
	call	HD44780_SetCursor
	lui	a5,%hi(.LC13)
	addi	a0,a5,%lo(.LC13)
	call	HD44780_PrintStr
	li	a0,1000
	addiw	s3,s3,-1
	call	Delay_Ms
	andi	s3,s3,0xff
	j	.L14
.L44:
	addiw	a1,a1,1
	andi	a1,a1,0xff
	li	a0,1
	bne	s4,s1,.L7
	j	.L47
.L46:
	ld	s1,16(sp)
	li	a1,1024
	li	s2,10
	mv	a0,s1
	call	GPIO_SetBits
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
	lui	a5,%hi(.LC11)
	addi	a0,a5,%lo(.LC11)
	call	HD44780_PrintStr
	li	a0,500
	call	Delay_Ms
	li	a1,0
	li	a0,13
	call	HD44780_SetCursor
	li	a0,49
	call	HD44780_PrintSpecialChar
	li	a1,0
	li	a0,14
	call	HD44780_SetCursor
	li	a0,48
	call	HD44780_PrintSpecialChar
	li	a1,0
	li	a0,15
	call	HD44780_SetCursor
	li	a0,115
	call	HD44780_PrintSpecialChar
	li	a0,1000
	call	Delay_Ms
.L12:
	li	a1,0
	li	a0,13
	call	HD44780_SetCursor
	li	a0,32
	call	HD44780_PrintSpecialChar
	li	a1,0
	li	a0,14
	call	HD44780_SetCursor
	addiw	s2,s2,-1
	addiw	a0,s2,48
	andi	a0,a0,0xff
	call	HD44780_PrintSpecialChar
	li	a1,0
	li	a0,15
	call	HD44780_SetCursor
	li	a0,115
	call	HD44780_PrintSpecialChar
	li	a0,1000
	call	Delay_Ms
	bne	s2,s5,.L12
	li	a1,1024
	mv	a0,s1
	call	GPIO_ResetBits
	j	.L23
.L42:
	li	a1,1024
	mv	a0,s1
	call	GPIO_SetBits
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
	lui	a5,%hi(.LC11)
	addi	a0,a5,%lo(.LC11)
	call	HD44780_PrintStr
	li	a0,500
	call	Delay_Ms
	li	a1,0
	li	a0,13
	call	HD44780_SetCursor
	li	a0,49
	call	HD44780_PrintSpecialChar
	li	a1,0
	li	a0,14
	call	HD44780_SetCursor
	li	a0,48
	call	HD44780_PrintSpecialChar
	li	a1,0
	li	a0,15
	call	HD44780_SetCursor
	li	a0,115
	call	HD44780_PrintSpecialChar
	li	a0,1000
	call	Delay_Ms
	li	s2,10
.L21:
	li	a1,0
	li	a0,13
	call	HD44780_SetCursor
	li	a0,32
	call	HD44780_PrintSpecialChar
	li	a1,0
	li	a0,14
	call	HD44780_SetCursor
	addiw	s2,s2,-1
	addiw	a0,s2,48
	andi	a0,a0,0xff
	call	HD44780_PrintSpecialChar
	li	a1,0
	li	a0,15
	call	HD44780_SetCursor
	li	a0,115
	call	HD44780_PrintSpecialChar
	li	a0,1000
	call	Delay_Ms
	bne	s2,s5,.L21
	li	a1,1024
	mv	a0,s1
	call	GPIO_ResetBits
	j	.L23
.L45:
	lui	a5,%hi(.LC7)
	ld	s1,16(sp)
	addi	a0,a5,%lo(.LC7)
	call	HD44780_PrintStr
	li	a1,1024
	mv	a0,s1
	call	GPIO_SetBits
	li	a0,200
	call	Delay_Ms
	li	a1,1024
	mv	a0,s1
	call	GPIO_ResetBits
	li	a0,200
	call	Delay_Ms
	li	a1,1024
	mv	a0,s1
	call	GPIO_SetBits
	li	a0,200
	call	Delay_Ms
	li	a1,1024
	mv	a0,s1
	call	GPIO_ResetBits
	li	a0,1000
	call	Delay_Ms
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
	lui	a5,%hi(.LC8)
	addi	a0,a5,%lo(.LC8)
	call	HD44780_PrintStr
	li	a1,256
	mv	a0,s1
	call	GPIO_SetBits
	li	a1,512
	mv	a0,s1
	call	GPIO_ResetBits
	li	a0,4096
	addi	a0,a0,-1096
	call	Delay_Ms
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
.L37:
	lui	a5,%hi(.LC9)
	addi	a0,a5,%lo(.LC9)
	call	HD44780_PrintStr
	mv	a0,s1
	li	a1,256
	call	GPIO_ResetBits
	li	a1,512
	mv	a0,s1
	call	GPIO_ResetBits
	li	a0,2000
	call	Delay_Ms
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
	lui	a5,%hi(.LC10)
	addi	a0,a5,%lo(.LC10)
	call	HD44780_PrintStr
	mv	a0,s1
	li	a1,256
	call	GPIO_ResetBits
	li	a1,512
	mv	a0,s1
	call	GPIO_SetBits
	li	a0,4096
	addi	a0,a0,-1096
	call	Delay_Ms
	li	a1,512
	mv	a0,s1
	call	GPIO_ResetBits
	j	.L23
.L41:
	lui	a5,%hi(.LC16)
	addi	a0,a5,%lo(.LC16)
	call	HD44780_PrintStr
	li	a1,1024
	mv	a0,s1
	call	GPIO_SetBits
	li	a0,200
	call	Delay_Ms
	li	a1,1024
	mv	a0,s1
	call	GPIO_ResetBits
	li	a0,200
	call	Delay_Ms
	li	a1,1024
	mv	a0,s1
	call	GPIO_SetBits
	li	a0,200
	call	Delay_Ms
	li	a1,1024
	mv	a0,s1
	call	GPIO_ResetBits
	li	a0,1000
	call	Delay_Ms
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
	lui	a5,%hi(.LC8)
	addi	a0,a5,%lo(.LC8)
	call	HD44780_PrintStr
	mv	a0,s1
	li	a1,256
	call	GPIO_SetBits
	li	a1,512
	mv	a0,s1
	call	GPIO_ResetBits
	li	a0,4096
	addi	a0,a0,-1096
	call	Delay_Ms
	call	HD44780_Clear
	j	.L37
	.size	main, .-main
	.globl	szBuff
	.globl	CardID
	.globl	a
	.globl	ID
	.globl	PASS
	.bss
	.align	3
	.set	.LANCHOR0,. + 0
	.type	szBuff, @object
	.size	szBuff, 100
szBuff:
	.zero	100
	.section	.sbss,"aw",@nobits
	.align	3
	.type	CardID, @object
	.size	CardID, 5
CardID:
	.zero	5
	.type	a, @object
	.size	a, 1
a:
	.zero	1
	.section	.sdata,"aw"
	.align	3
	.type	ID, @object
	.size	ID, 5
ID:
	.ascii	"\261w\227\035L"
	.zero	3
	.type	PASS, @object
	.size	PASS, 4
PASS:
	.ascii	"123A"
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
