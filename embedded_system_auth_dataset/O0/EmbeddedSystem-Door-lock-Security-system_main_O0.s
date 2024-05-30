	.file	"main.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata
	.align	3
.LC0:
	.string	"Enter Password"
	.align	3
.LC1:
	.string	"Right Password"
	.align	3
.LC2:
	.string	"Wrong Password"
	.align	3
.LC3:
	.string	"Blocked Password"
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	call	GPIO_Init
	call	LCD_Init
	call	interrupt_Init
 #APP
# 22 "main.c" 1
	sei
# 0 "" 2
 #NO_APP
	sb	zero,-24(s0)
	lbu	a5,-24(s0)
	mv	a1,a5
	li	a0,10
	call	EEPROM_write
	li	a5,858927104
	addi	a5,a5,304
	sw	a5,-32(s0)
	sw	zero,-20(s0)
	j	.L2
.L3:
	lw	a4,-20(s0)
	lw	a5,-20(s0)
	addi	a5,a5,-16
	add	a5,a5,s0
	lbu	a5,-16(a5)
	mv	a1,a5
	mv	a0,a4
	call	EEPROM_write
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L2:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,3
	ble	a4,a5,.L3
	sb	zero,-21(s0)
	sb	zero,-22(s0)
	sb	zero,-23(s0)
	li	a1,0
	li	a0,15
	call	GPIO_Write
	li	a1,0
	li	a0,0
	call	LCD_SetCursPos
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	LCD_DispString
.L9:
	li	a0,10
	call	EEPROM_read
	mv	a5,a0
	sb	a5,-24(s0)
	lbu	a5,-24(s0)
	andi	a4,a5,0xff
	li	a5,2
	bgtu	a4,a5,.L4
	sb	zero,-23(s0)
	call	getkey
	mv	a5,a0
	sb	a5,-25(s0)
	lbu	a5,-25(s0)
	andi	a4,a5,0xff
	li	a5,70
	beq	a4,a5,.L9
	lbu	a5,-22(s0)
	sext.w	a5,a5
	li	a1,1
	mv	a0,a5
	call	LCD_SetCursPos
	lbu	a5,-25(s0)
	mv	a0,a5
	call	LCD_DispChar
	lbu	a5,-22(s0)
	sext.w	a5,a5
	addi	a5,a5,-16
	add	a5,a5,s0
	lbu	a4,-16(a5)
	lbu	a5,-25(s0)
	andi	a5,a5,0xff
	bne	a5,a4,.L6
	lbu	a5,-21(s0)
	addiw	a5,a5,1
	sb	a5,-21(s0)
.L6:
	lbu	a5,-22(s0)
	addiw	a5,a5,1
	sb	a5,-22(s0)
	lbu	a5,-25(s0)
	andi	a4,a5,0xff
	li	a5,61
	bne	a4,a5,.L9
	lbu	a5,-22(s0)
	andi	a4,a5,0xff
	li	a5,5
	bne	a4,a5,.L7
	lbu	a5,-22(s0)
	addiw	a5,a5,-1
	sb	a5,-22(s0)
	lbu	a5,-22(s0)
	mv	a4,a5
	lbu	a5,-21(s0)
	andi	a4,a4,0xff
	andi	a5,a5,0xff
	bne	a4,a5,.L7
	call	LCD_Clear
	li	a1,0
	li	a0,0
	call	LCD_SetCursPos
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	LCD_DispString
	li	a1,255
	li	a0,15
	call	GPIO_Write
	j	.L8
.L7:
	call	LCD_Clear
	li	a1,0
	li	a0,0
	call	LCD_SetCursPos
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	LCD_DispString
	sb	zero,-22(s0)
	sb	zero,-21(s0)
	lbu	a5,-24(s0)
	addiw	a5,a5,1
	sb	a5,-24(s0)
	lbu	a5,-24(s0)
	mv	a1,a5
	li	a0,10
	call	EEPROM_write
	li	a5,79998976
	addi	a0,a5,1024
	call	Delay
	call	LCD_Clear
	li	a1,0
	li	a0,0
	call	LCD_SetCursPos
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	LCD_DispString
	j	.L9
.L4:
	lbu	a5,-23(s0)
	andi	a5,a5,0xff
	bne	a5,zero,.L9
	call	LCD_Clear
	li	a1,0
	li	a0,0
	call	LCD_SetCursPos
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	LCD_DispString
	li	a5,1
	sb	a5,-23(s0)
.L8:
	j	.L9
	.size	main, .-main
	.section	.rodata
	.align	3
.LC4:
	.string	"System Reseted"
	.text
	.align	1
	.globl	INT0_vect
	.type	INT0_vect, @function
INT0_vect:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	call	LCD_Clear
	li	a1,0
	li	a0,0
	call	LCD_SetCursPos
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	LCD_DispString
	li	a1,0
	li	a0,10
	call	EEPROM_write
	li	a5,79998976
	addi	a0,a5,1024
	call	Delay
	call	main
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	INT0_vect, .-INT0_vect
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
