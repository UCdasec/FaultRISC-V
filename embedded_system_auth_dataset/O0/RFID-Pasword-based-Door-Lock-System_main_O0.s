	.file	"main.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	PASS
	.section	.sdata,"aw"
	.align	3
	.type	PASS, @object
	.size	PASS, 4
PASS:
	.ascii	"123A"
	.globl	ID
	.align	3
	.type	ID, @object
	.size	ID, 5
ID:
	.ascii	"\261w\227\035L"
	.globl	a
	.section	.sbss,"aw",@nobits
	.type	a, @object
	.size	a, 1
a:
	.zero	1
	.globl	CardID
	.align	3
	.type	CardID, @object
	.size	CardID, 5
CardID:
	.zero	5
	.globl	szBuff
	.bss
	.align	3
	.type	szBuff, @object
	.size	szBuff, 100
szBuff:
	.zero	100
	.section	.rodata
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
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	call	GPIO_config
	call	TIMER_Configuration
	call	I2C_LCD_Configuration
	li	a0,2
	call	HD44780_Init
	call	HD44780_Clear
	call	TM_MFRC522_Init
.L34:
	li	a1,1024
	li	a5,1073811456
	addi	a0,a5,-2048
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
	li	a1,1
	li	a0,0
	call	HD44780_SetCursor
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	HD44780_PrintStr
	sb	zero,-17(s0)
	j	.L2
.L3:
	call	KEYPAD_Read
	mv	a5,a0
	sb	a5,-17(s0)
.L2:
	lbu	a5,-17(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L3
	lbu	a5,-17(s0)
	andi	a4,a5,0xff
	li	a5,49
	bne	a4,a5,.L4
	li	a5,50
	sb	a5,-18(s0)
.L19:
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
	call	HD44780_PrintStr
	sw	zero,-24(s0)
	j	.L5
.L8:
	lw	a5,-24(s0)
	addiw	a5,a5,2
	sext.w	a5,a5
	andi	a5,a5,0xff
	slliw	a5,a5,1
	andi	a5,a5,0xff
	li	a1,1
	mv	a0,a5
	call	HD44780_SetCursor
	sb	zero,-17(s0)
	j	.L6
.L7:
	call	KEYPAD_Read
	mv	a5,a0
	sb	a5,-17(s0)
.L6:
	lbu	a5,-17(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L7
	lw	a5,-24(s0)
	addi	a5,a5,-16
	add	a5,a5,s0
	lbu	a4,-17(s0)
	sb	a4,-48(a5)
	lbu	a5,-17(s0)
	mv	a0,a5
	call	HD44780_PrintSpecialChar
	li	a0,200
	call	Delay_Ms
	lw	a5,-24(s0)
	addiw	a5,a5,2
	sext.w	a5,a5
	andi	a5,a5,0xff
	slliw	a5,a5,1
	andi	a5,a5,0xff
	li	a1,1
	mv	a0,a5
	call	HD44780_SetCursor
	li	a0,42
	call	HD44780_PrintSpecialChar
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
.L5:
	lw	a5,-24(s0)
	sext.w	a4,a5
	li	a5,3
	ble	a4,a5,.L8
	li	a0,500
	call	Delay_Ms
	lui	a5,%hi(a)
	sb	zero,%lo(a)(a5)
	sw	zero,-28(s0)
	j	.L9
.L11:
	lw	a5,-28(s0)
	addi	a5,a5,-16
	add	a5,a5,s0
	lbu	a3,-48(a5)
	lui	a5,%hi(PASS)
	lw	a4,-28(s0)
	addi	a5,a5,%lo(PASS)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a3
	bne	a4,a5,.L10
	lui	a5,%hi(a)
	lbu	a5,%lo(a)(a5)
	addiw	a5,a5,1
	andi	a4,a5,0xff
	lui	a5,%hi(a)
	sb	a4,%lo(a)(a5)
.L10:
	lw	a5,-28(s0)
	addiw	a5,a5,1
	sw	a5,-28(s0)
.L9:
	lw	a5,-28(s0)
	sext.w	a4,a5
	li	a5,3
	ble	a4,a5,.L11
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
	lui	a5,%hi(a)
	lbu	a5,%lo(a)(a5)
	mv	a4,a5
	li	a5,4
	bne	a4,a5,.L12
	lui	a5,%hi(.LC7)
	addi	a0,a5,%lo(.LC7)
	call	HD44780_PrintStr
	li	a1,1024
	li	a5,1073811456
	addi	a0,a5,-2048
	call	GPIO_SetBits
	li	a0,200
	call	Delay_Ms
	li	a1,1024
	li	a5,1073811456
	addi	a0,a5,-2048
	call	GPIO_ResetBits
	li	a0,200
	call	Delay_Ms
	li	a1,1024
	li	a5,1073811456
	addi	a0,a5,-2048
	call	GPIO_SetBits
	li	a0,200
	call	Delay_Ms
	li	a1,1024
	li	a5,1073811456
	addi	a0,a5,-2048
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
	li	a5,1073811456
	addi	a0,a5,-2048
	call	GPIO_SetBits
	li	a1,512
	li	a5,1073811456
	addi	a0,a5,-2048
	call	GPIO_ResetBits
	li	a5,4096
	addi	a0,a5,-1096
	call	Delay_Ms
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
	lui	a5,%hi(.LC9)
	addi	a0,a5,%lo(.LC9)
	call	HD44780_PrintStr
	li	a1,256
	li	a5,1073811456
	addi	a0,a5,-2048
	call	GPIO_ResetBits
	li	a1,512
	li	a5,1073811456
	addi	a0,a5,-2048
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
	li	a1,256
	li	a5,1073811456
	addi	a0,a5,-2048
	call	GPIO_ResetBits
	li	a1,512
	li	a5,1073811456
	addi	a0,a5,-2048
	call	GPIO_SetBits
	li	a5,4096
	addi	a0,a5,-1096
	call	Delay_Ms
	li	a1,512
	li	a5,1073811456
	addi	a0,a5,-2048
	call	GPIO_ResetBits
	j	.L20
.L12:
	lbu	a5,-18(s0)
	andi	a4,a5,0xff
	li	a5,48
	bne	a4,a5,.L14
	li	a1,1024
	li	a5,1073811456
	addi	a0,a5,-2048
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
	li	a5,10
	sw	a5,-32(s0)
	j	.L15
.L18:
	lw	a5,-32(s0)
	sext.w	a4,a5
	li	a5,9
	ble	a4,a5,.L16
	lw	a5,-32(s0)
	mv	a4,a5
	li	a5,10
	divw	a5,a4,a5
	sext.w	a5,a5
	sb	a5,-55(s0)
	lw	a5,-32(s0)
	mv	a4,a5
	li	a5,10
	remw	a5,a4,a5
	sext.w	a5,a5
	sb	a5,-56(s0)
	li	a1,0
	li	a0,13
	call	HD44780_SetCursor
	lbu	a5,-55(s0)
	addiw	a5,a5,48
	andi	a5,a5,0xff
	mv	a0,a5
	call	HD44780_PrintSpecialChar
	li	a1,0
	li	a0,14
	call	HD44780_SetCursor
	lbu	a5,-56(s0)
	addiw	a5,a5,48
	andi	a5,a5,0xff
	mv	a0,a5
	call	HD44780_PrintSpecialChar
	li	a1,0
	li	a0,15
	call	HD44780_SetCursor
	li	a0,115
	call	HD44780_PrintSpecialChar
	li	a0,1000
	call	Delay_Ms
	j	.L17
.L16:
	li	a1,0
	li	a0,13
	call	HD44780_SetCursor
	li	a0,32
	call	HD44780_PrintSpecialChar
	li	a1,0
	li	a0,14
	call	HD44780_SetCursor
	lw	a5,-32(s0)
	andi	a5,a5,0xff
	addiw	a5,a5,48
	andi	a5,a5,0xff
	mv	a0,a5
	call	HD44780_PrintSpecialChar
	li	a1,0
	li	a0,15
	call	HD44780_SetCursor
	li	a0,115
	call	HD44780_PrintSpecialChar
	li	a0,1000
	call	Delay_Ms
	lw	a5,-32(s0)
	sext.w	a4,a5
	li	a5,1
	bne	a4,a5,.L17
	li	a1,1024
	li	a5,1073811456
	addi	a0,a5,-2048
	call	GPIO_ResetBits
.L17:
	lw	a5,-32(s0)
	addiw	a5,a5,-1
	sw	a5,-32(s0)
.L15:
	lw	a5,-32(s0)
	sext.w	a5,a5
	bgt	a5,zero,.L18
	j	.L20
.L14:
	lui	a5,%hi(.LC12)
	addi	a0,a5,%lo(.LC12)
	call	HD44780_PrintStr
	li	a1,1
	li	a0,0
	call	HD44780_SetCursor
	lbu	a5,-18(s0)
	mv	a0,a5
	call	HD44780_PrintSpecialChar
	li	a1,1
	li	a0,2
	call	HD44780_SetCursor
	lui	a5,%hi(.LC13)
	addi	a0,a5,%lo(.LC13)
	call	HD44780_PrintStr
	li	a0,1000
	call	Delay_Ms
	lbu	a5,-18(s0)
	addiw	a5,a5,-1
	sb	a5,-18(s0)
	j	.L19
.L4:
	lbu	a5,-17(s0)
	andi	a4,a5,0xff
	li	a5,50
	bne	a4,a5,.L34
	li	a5,50
	sb	a5,-33(s0)
.L33:
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
	lui	a5,%hi(.LC14)
	addi	a0,a5,%lo(.LC14)
	call	HD44780_PrintStr
	nop
.L21:
	lui	a5,%hi(CardID)
	addi	a0,a5,%lo(CardID)
	call	TM_MFRC522_Check
	mv	a5,a0
	bne	a5,zero,.L21
	lui	a5,%hi(CardID)
	lbu	a5,%lo(CardID)(a5)
	sext.w	a2,a5
	lui	a5,%hi(CardID)
	addi	a5,a5,%lo(CardID)
	lbu	a5,1(a5)
	sext.w	a3,a5
	lui	a5,%hi(CardID)
	addi	a5,a5,%lo(CardID)
	lbu	a5,2(a5)
	sext.w	a4,a5
	lui	a5,%hi(CardID)
	addi	a5,a5,%lo(CardID)
	lbu	a5,3(a5)
	sext.w	a1,a5
	lui	a5,%hi(CardID)
	addi	a5,a5,%lo(CardID)
	lbu	a5,4(a5)
	sext.w	a5,a5
	mv	a6,a5
	mv	a5,a1
	lui	a1,%hi(.LC15)
	addi	a1,a1,%lo(.LC15)
	lui	a0,%hi(szBuff)
	addi	a0,a0,%lo(szBuff)
	call	sprintf
	li	a1,1
	li	a0,0
	call	HD44780_SetCursor
	lui	a5,%hi(szBuff)
	addi	a0,a5,%lo(szBuff)
	call	HD44780_PrintStr
	li	a0,200
	call	Delay_Ms
	li	a5,3
	sw	a5,-40(s0)
	j	.L22
.L23:
	lw	a5,-40(s0)
	andi	a5,a5,0xff
	li	a1,1
	mv	a0,a5
	call	HD44780_SetCursor
	li	a0,42
	call	HD44780_PrintSpecialChar
	li	a0,50
	call	Delay_Ms
	lw	a5,-40(s0)
	addiw	a5,a5,1
	sw	a5,-40(s0)
.L22:
	lw	a5,-40(s0)
	sext.w	a4,a5
	li	a5,12
	ble	a4,a5,.L23
	call	HD44780_Clear
	li	a1,0
	li	a0,0
	call	HD44780_SetCursor
	sb	zero,-41(s0)
	sw	zero,-48(s0)
	j	.L24
.L26:
	lui	a5,%hi(CardID)
	lw	a4,-48(s0)
	addi	a5,a5,%lo(CardID)
	add	a5,a4,a5
	lbu	a3,0(a5)
	lui	a5,%hi(ID)
	lw	a4,-48(s0)
	addi	a5,a5,%lo(ID)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a3
	bne	a4,a5,.L25
	lbu	a5,-41(s0)
	addiw	a5,a5,1
	sb	a5,-41(s0)
.L25:
	lw	a5,-48(s0)
	addiw	a5,a5,1
	sw	a5,-48(s0)
.L24:
	lw	a5,-48(s0)
	sext.w	a4,a5
	li	a5,4
	ble	a4,a5,.L26
	lbu	a5,-41(s0)
	andi	a4,a5,0xff
	li	a5,5
	bne	a4,a5,.L27
	lui	a5,%hi(.LC16)
	addi	a0,a5,%lo(.LC16)
	call	HD44780_PrintStr
	li	a1,1024
	li	a5,1073811456
	addi	a0,a5,-2048
	call	GPIO_SetBits
	li	a0,200
	call	Delay_Ms
	li	a1,1024
	li	a5,1073811456
	addi	a0,a5,-2048
	call	GPIO_ResetBits
	li	a0,200
	call	Delay_Ms
	li	a1,1024
	li	a5,1073811456
	addi	a0,a5,-2048
	call	GPIO_SetBits
	li	a0,200
	call	Delay_Ms
	li	a1,1024
	li	a5,1073811456
	addi	a0,a5,-2048
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
	li	a5,1073811456
	addi	a0,a5,-2048
	call	GPIO_SetBits
	li	a1,512
	li	a5,1073811456
	addi	a0,a5,-2048
	call	GPIO_ResetBits
	li	a5,4096
	addi	a0,a5,-1096
	call	Delay_Ms
	call	HD44780_Clear
	lui	a5,%hi(.LC9)
	addi	a0,a5,%lo(.LC9)
	call	HD44780_PrintStr
	li	a1,256
	li	a5,1073811456
	addi	a0,a5,-2048
	call	GPIO_ResetBits
	li	a1,512
	li	a5,1073811456
	addi	a0,a5,-2048
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
	li	a1,256
	li	a5,1073811456
	addi	a0,a5,-2048
	call	GPIO_ResetBits
	li	a1,512
	li	a5,1073811456
	addi	a0,a5,-2048
	call	GPIO_SetBits
	li	a5,4096
	addi	a0,a5,-1096
	call	Delay_Ms
	li	a1,512
	li	a5,1073811456
	addi	a0,a5,-2048
	call	GPIO_ResetBits
	j	.L20
.L27:
	lbu	a5,-33(s0)
	andi	a4,a5,0xff
	li	a5,48
	bne	a4,a5,.L28
	li	a1,1024
	li	a5,1073811456
	addi	a0,a5,-2048
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
	li	a5,10
	sw	a5,-52(s0)
	j	.L29
.L32:
	lw	a5,-52(s0)
	sext.w	a4,a5
	li	a5,9
	ble	a4,a5,.L30
	lw	a5,-52(s0)
	mv	a4,a5
	li	a5,10
	divw	a5,a4,a5
	sext.w	a5,a5
	sb	a5,-53(s0)
	lw	a5,-52(s0)
	mv	a4,a5
	li	a5,10
	remw	a5,a4,a5
	sext.w	a5,a5
	sb	a5,-54(s0)
	li	a1,0
	li	a0,13
	call	HD44780_SetCursor
	lbu	a5,-53(s0)
	addiw	a5,a5,48
	andi	a5,a5,0xff
	mv	a0,a5
	call	HD44780_PrintSpecialChar
	li	a1,0
	li	a0,14
	call	HD44780_SetCursor
	lbu	a5,-54(s0)
	addiw	a5,a5,48
	andi	a5,a5,0xff
	mv	a0,a5
	call	HD44780_PrintSpecialChar
	li	a1,0
	li	a0,15
	call	HD44780_SetCursor
	li	a0,115
	call	HD44780_PrintSpecialChar
	li	a0,1000
	call	Delay_Ms
	j	.L31
.L30:
	li	a1,0
	li	a0,13
	call	HD44780_SetCursor
	li	a0,32
	call	HD44780_PrintSpecialChar
	li	a1,0
	li	a0,14
	call	HD44780_SetCursor
	lw	a5,-52(s0)
	andi	a5,a5,0xff
	addiw	a5,a5,48
	andi	a5,a5,0xff
	mv	a0,a5
	call	HD44780_PrintSpecialChar
	li	a1,0
	li	a0,15
	call	HD44780_SetCursor
	li	a0,115
	call	HD44780_PrintSpecialChar
	li	a0,1000
	call	Delay_Ms
	lw	a5,-52(s0)
	sext.w	a4,a5
	li	a5,1
	bne	a4,a5,.L31
	li	a1,1024
	li	a5,1073811456
	addi	a0,a5,-2048
	call	GPIO_ResetBits
.L31:
	lw	a5,-52(s0)
	addiw	a5,a5,-1
	sw	a5,-52(s0)
.L29:
	lw	a5,-52(s0)
	sext.w	a5,a5
	bgt	a5,zero,.L32
	j	.L20
.L28:
	lui	a5,%hi(.LC17)
	addi	a0,a5,%lo(.LC17)
	call	HD44780_PrintStr
	li	a1,1
	li	a0,0
	call	HD44780_SetCursor
	lbu	a5,-33(s0)
	mv	a0,a5
	call	HD44780_PrintSpecialChar
	li	a1,1
	li	a0,2
	call	HD44780_SetCursor
	lui	a5,%hi(.LC18)
	addi	a0,a5,%lo(.LC18)
	call	HD44780_PrintStr
	li	a0,1500
	call	Delay_Ms
	lbu	a5,-33(s0)
	addiw	a5,a5,-1
	sb	a5,-33(s0)
	j	.L33
.L20:
	j	.L34
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
