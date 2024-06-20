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
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-128
	sd	ra,120(sp)
	sd	s0,112(sp)
	sd	s1,104(sp)
	sd	s2,96(sp)
	sd	s3,88(sp)
	sd	s4,80(sp)
	sd	s5,72(sp)
	sd	s6,64(sp)
	sd	s7,56(sp)
	sd	s8,48(sp)
	sd	s9,40(sp)
	sd	s10,32(sp)
	sd	s11,24(sp)
	call	GPIO_config
	call	TIMER_Configuration
	call	I2C_LCD_Configuration
	li	a0,2
	call	HD44780_Init
	call	HD44780_Clear
	call	TM_MFRC522_Init
	lui	s5,%hi(CardID)
	lui	s6,%hi(a)
	j	.L26
.L39:
	li	s3,50
	lui	s9,%hi(.LC5)
	lui	s8,%hi(.LC6)
	li	s4,12
	lui	s7,%hi(PASS)
	li	s10,48
	lui	s11,%hi(.LC12)
	j	.L15
.L6:
	addi	s1,s1,1
	addi	a5,a5,1
	beq	s1,a1,.L35
.L7:
	lbu	a3,0(s1)
	lbu	a4,0(a5)
	bne	a3,a4,.L6
	addiw	a2,a2,1
	andi	a2,a2,0xff
	mv	a0,a6
	j	.L6
.L35:
	beq	a0,zero,.L8
	sb	a2,%lo(a)(s6)
.L8:
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
	lbu	a4,%lo(a)(s6)
	li	a5,4
	beq	a4,a5,.L36
	beq	s3,s10,.L37
	addi	a0,s11,%lo(.LC12)
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
	call	Delay_Ms
	addiw	s3,s3,-1
	andi	s3,s3,0xff
.L15:
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
	addi	a0,s9,%lo(.LC5)
	call	HD44780_PrintStr
	li	a1,1
	li	a0,4
	call	HD44780_SetCursor
	addi	a0,s8,%lo(.LC6)
	call	HD44780_PrintStr
	addi	s1,sp,8
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
	li	a1,1
	mv	a0,s0
	call	HD44780_SetCursor
	li	a0,42
	call	HD44780_PrintSpecialChar
	addiw	s0,s0,2
	andi	s0,s0,0xff
	addi	s2,s2,1
	bne	s0,s4,.L5
	li	a0,500
	call	Delay_Ms
	sb	zero,%lo(a)(s6)
	addi	a5,s7,%lo(PASS)
	addi	a1,s1,4
	li	a0,0
	li	a2,0
	li	a6,1
	j	.L7
.L36:
	lui	a0,%hi(.LC7)
	addi	a0,a0,%lo(.LC7)
	call	HD44780_PrintStr
	li	a1,1024
	li	a0,1073811456
	addi	a0,a0,-2048
	call	GPIO_SetBits
	li	a0,200
	call	Delay_Ms
	li	a1,1024
	li	a0,1073811456
	addi	a0,a0,-2048
	call	GPIO_ResetBits
	li	a0,200
	call	Delay_Ms
	li	a1,1024
	li	a0,1073811456
	addi	a0,a0,-2048
	call	GPIO_SetBits
	li	a0,200
	call	Delay_Ms
	li	a1,1024
	li	a0,1073811456
	addi	a0,a0,-2048
	call	GPIO_ResetBits
	li	a0,1000
	call	Delay_Ms
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
	lui	a0,%hi(.LC8)
	addi	a0,a0,%lo(.LC8)
	call	HD44780_PrintStr
	li	a1,256
	li	a0,1073811456
	addi	a0,a0,-2048
	call	GPIO_SetBits
	li	a1,512
	li	a0,1073811456
	addi	a0,a0,-2048
	call	GPIO_ResetBits
	li	a0,4096
	addi	a0,a0,-1096
	call	Delay_Ms
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
	lui	a0,%hi(.LC9)
	addi	a0,a0,%lo(.LC9)
	call	HD44780_PrintStr
	li	a1,256
	li	a0,1073811456
	addi	a0,a0,-2048
	call	GPIO_ResetBits
	li	a1,512
	li	a0,1073811456
	addi	a0,a0,-2048
	call	GPIO_ResetBits
	li	a0,2000
	call	Delay_Ms
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
	lui	a0,%hi(.LC10)
	addi	a0,a0,%lo(.LC10)
	call	HD44780_PrintStr
	li	a1,256
	li	a0,1073811456
	addi	a0,a0,-2048
	call	GPIO_ResetBits
	li	a1,512
	li	a0,1073811456
	addi	a0,a0,-2048
	call	GPIO_SetBits
	li	a0,4096
	addi	a0,a0,-1096
	call	Delay_Ms
	li	a1,512
	li	a0,1073811456
	addi	a0,a0,-2048
	call	GPIO_ResetBits
	j	.L26
.L37:
	li	a1,1024
	li	a0,1073811456
	addi	a0,a0,-2048
	call	GPIO_SetBits
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
	lui	a0,%hi(.LC11)
	addi	a0,a0,%lo(.LC11)
	call	HD44780_PrintStr
	li	a0,500
	call	Delay_Ms
	li	s0,10
	li	s1,9
	li	s2,1
	li	s3,10
	j	.L14
.L38:
	li	a1,0
	li	a0,13
	call	HD44780_SetCursor
	divw	a0,s0,s3
	addiw	a0,a0,48
	andi	a0,a0,0xff
	call	HD44780_PrintSpecialChar
	li	a1,0
	li	a0,14
	call	HD44780_SetCursor
	remw	a0,s0,s3
	addiw	a0,a0,48
	andi	a0,a0,0xff
	call	HD44780_PrintSpecialChar
	li	a1,0
	li	a0,15
	call	HD44780_SetCursor
	li	a0,115
	call	HD44780_PrintSpecialChar
	li	a0,1000
	call	Delay_Ms
.L13:
	addiw	s0,s0,-1
.L14:
	bgt	s0,s1,.L38
	li	a1,0
	li	a0,13
	call	HD44780_SetCursor
	li	a0,32
	call	HD44780_PrintSpecialChar
	li	a1,0
	li	a0,14
	call	HD44780_SetCursor
	addiw	a0,s0,48
	andi	a0,a0,0xff
	call	HD44780_PrintSpecialChar
	li	a1,0
	li	a0,15
	call	HD44780_SetCursor
	li	a0,115
	call	HD44780_PrintSpecialChar
	li	a0,1000
	call	Delay_Ms
	bne	s0,s2,.L13
	li	a1,1024
	li	a0,1073811456
	addi	a0,a0,-2048
	call	GPIO_ResetBits
.L26:
	li	a1,1024
	li	a0,1073811456
	addi	a0,a0,-2048
	call	GPIO_ResetBits
	call	HD44780_Clear
	li	a1,0
	li	a0,3
	call	HD44780_SetCursor
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	HD44780_PrintStr
	li	a0,500
	call	Delay_Ms
	li	a1,1
	li	a0,0
	call	HD44780_SetCursor
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	HD44780_PrintStr
	li	a0,1500
	call	Delay_Ms
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
	lui	a0,%hi(.LC2)
	addi	a0,a0,%lo(.LC2)
	call	HD44780_PrintStr
	li	a0,1500
	call	Delay_Ms
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
	lui	a0,%hi(.LC3)
	addi	a0,a0,%lo(.LC3)
	call	HD44780_PrintStr
	li	a1,1
	li	a0,0
	call	HD44780_SetCursor
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	call	HD44780_PrintStr
.L2:
	call	KEYPAD_Read
	mv	s0,a0
	beq	a0,zero,.L2
	li	a5,49
	beq	a0,a5,.L39
	li	a5,50
	bne	a0,a5,.L26
	lui	s8,%hi(.LC14)
	lui	s2,%hi(.LANCHOR0)
	lui	s7,%hi(.LC15)
	li	s4,3
	lui	s3,%hi(ID)
	j	.L25
.L18:
	addi	a5,a5,1
	addi	a4,a4,1
	beq	a5,a0,.L40
.L19:
	lbu	a2,0(a5)
	lbu	a3,0(a4)
	bne	a2,a3,.L18
	addiw	a1,a1,1
	andi	a1,a1,0xff
	j	.L18
.L40:
	li	a5,5
	beq	a1,a5,.L41
	li	a5,48
	beq	s0,a5,.L42
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
	call	Delay_Ms
	addiw	s0,s0,-1
	andi	s0,s0,0xff
.L25:
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
	addi	a0,s8,%lo(.LC14)
	call	HD44780_PrintStr
.L16:
	addi	a0,s5,%lo(CardID)
	call	TM_MFRC522_Check
	bne	a0,zero,.L16
	addi	a3,s5,%lo(CardID)
	lbu	a6,4(a3)
	lbu	a5,3(a3)
	lbu	a4,2(a3)
	lbu	a3,1(a3)
	lbu	a2,%lo(CardID)(s5)
	addi	a1,s7,%lo(.LC15)
	addi	a0,s2,%lo(.LANCHOR0)
	call	sprintf
	li	a1,1
	li	a0,0
	call	HD44780_SetCursor
	addi	a0,s2,%lo(.LANCHOR0)
	call	HD44780_PrintStr
	li	a0,200
	call	Delay_Ms
	mv	s1,s4
	li	s9,13
.L17:
	li	a1,1
	andi	a0,s1,0xff
	call	HD44780_SetCursor
	li	a0,42
	call	HD44780_PrintSpecialChar
	li	a0,50
	call	Delay_Ms
	addiw	s1,s1,1
	bne	s1,s9,.L17
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
	addi	a5,s5,%lo(CardID)
	addi	a4,s3,%lo(ID)
	addi	a0,a5,5
	li	a1,0
	j	.L19
.L41:
	lui	a0,%hi(.LC16)
	addi	a0,a0,%lo(.LC16)
	call	HD44780_PrintStr
	li	a1,1024
	li	a0,1073811456
	addi	a0,a0,-2048
	call	GPIO_SetBits
	li	a0,200
	call	Delay_Ms
	li	a1,1024
	li	a0,1073811456
	addi	a0,a0,-2048
	call	GPIO_ResetBits
	li	a0,200
	call	Delay_Ms
	li	a1,1024
	li	a0,1073811456
	addi	a0,a0,-2048
	call	GPIO_SetBits
	li	a0,200
	call	Delay_Ms
	li	a1,1024
	li	a0,1073811456
	addi	a0,a0,-2048
	call	GPIO_ResetBits
	li	a0,1000
	call	Delay_Ms
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
	lui	a0,%hi(.LC8)
	addi	a0,a0,%lo(.LC8)
	call	HD44780_PrintStr
	li	a1,256
	li	a0,1073811456
	addi	a0,a0,-2048
	call	GPIO_SetBits
	li	a1,512
	li	a0,1073811456
	addi	a0,a0,-2048
	call	GPIO_ResetBits
	li	a0,4096
	addi	a0,a0,-1096
	call	Delay_Ms
	call	HD44780_Clear
	lui	a0,%hi(.LC9)
	addi	a0,a0,%lo(.LC9)
	call	HD44780_PrintStr
	li	a1,256
	li	a0,1073811456
	addi	a0,a0,-2048
	call	GPIO_ResetBits
	li	a1,512
	li	a0,1073811456
	addi	a0,a0,-2048
	call	GPIO_ResetBits
	li	a0,2000
	call	Delay_Ms
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
	lui	a0,%hi(.LC10)
	addi	a0,a0,%lo(.LC10)
	call	HD44780_PrintStr
	li	a1,256
	li	a0,1073811456
	addi	a0,a0,-2048
	call	GPIO_ResetBits
	li	a1,512
	li	a0,1073811456
	addi	a0,a0,-2048
	call	GPIO_SetBits
	li	a0,4096
	addi	a0,a0,-1096
	call	Delay_Ms
	li	a1,512
	li	a0,1073811456
	addi	a0,a0,-2048
	call	GPIO_ResetBits
	j	.L26
.L42:
	li	a1,1024
	li	a0,1073811456
	addi	a0,a0,-2048
	call	GPIO_SetBits
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
	lui	a0,%hi(.LC11)
	addi	a0,a0,%lo(.LC11)
	call	HD44780_PrintStr
	li	a0,500
	call	Delay_Ms
	li	s0,10
	li	s1,9
	li	s2,1
	li	s3,10
	j	.L24
.L43:
	li	a1,0
	li	a0,13
	call	HD44780_SetCursor
	divw	a0,s0,s3
	addiw	a0,a0,48
	andi	a0,a0,0xff
	call	HD44780_PrintSpecialChar
	li	a1,0
	li	a0,14
	call	HD44780_SetCursor
	remw	a0,s0,s3
	addiw	a0,a0,48
	andi	a0,a0,0xff
	call	HD44780_PrintSpecialChar
	li	a1,0
	li	a0,15
	call	HD44780_SetCursor
	li	a0,115
	call	HD44780_PrintSpecialChar
	li	a0,1000
	call	Delay_Ms
.L23:
	addiw	s0,s0,-1
.L24:
	bgt	s0,s1,.L43
	li	a1,0
	li	a0,13
	call	HD44780_SetCursor
	li	a0,32
	call	HD44780_PrintSpecialChar
	li	a1,0
	li	a0,14
	call	HD44780_SetCursor
	addiw	a0,s0,48
	andi	a0,a0,0xff
	call	HD44780_PrintSpecialChar
	li	a1,0
	li	a0,15
	call	HD44780_SetCursor
	li	a0,115
	call	HD44780_PrintSpecialChar
	li	a0,1000
	call	Delay_Ms
	bne	s0,s2,.L23
	li	a1,1024
	li	a0,1073811456
	addi	a0,a0,-2048
	call	GPIO_ResetBits
	j	.L26
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
