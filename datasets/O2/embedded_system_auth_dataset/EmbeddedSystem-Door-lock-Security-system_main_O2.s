	.file	"main.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
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
	.section	.text.startup,"ax",@progbits
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
	call	GPIO_Init
	call	LCD_Init
	call	interrupt_Init
 #APP
# 22 "main.c" 1
	sei
# 0 "" 2
 #NO_APP
	li	a1,0
	li	a0,10
	call	EEPROM_write
	li	a5,858927104
	addi	a5,a5,304
	sw	a5,8(sp)
	addi	s1,sp,8
	li	s0,0
	li	s2,4
.L2:
	lbu	a1,0(s1)
	mv	a0,s0
	addiw	s0,s0,1
	call	EEPROM_write
	addi	s1,s1,1
	bne	s0,s2,.L2
	li	a1,0
	li	a0,15
	call	GPIO_Write
	li	a1,0
	li	a0,0
	call	LCD_SetCursPos
	lui	s8,%hi(.LC0)
	addi	a0,s8,%lo(.LC0)
	call	LCD_DispString
	li	a0,10
	call	EEPROM_read
	li	a5,2
	mv	s0,a0
	bleu	a0,a5,.L13
	lui	s10,%hi(.LC1)
	lui	s9,%hi(.LC2)
	lui	s7,%hi(.LC3)
.L4:
	li	s2,0
	li	s4,0
.L6:
	call	LCD_Clear
	li	a1,0
	li	a0,0
	call	LCD_SetCursPos
	addi	a0,s7,%lo(.LC3)
	call	LCD_DispString
	li	s1,2
.L11:
	li	a0,10
	call	EEPROM_read
	mv	s0,a0
	bgtu	a0,s1,.L11
.L3:
	li	s3,70
	li	s5,61
	li	s6,2
.L12:
	call	getkey
	mv	s1,a0
	beq	a0,s3,.L7
.L21:
	sext.w	s11,s2
	li	a1,1
	mv	a0,s11
	call	LCD_SetCursPos
	mv	a0,s1
	call	LCD_DispChar
	addi	a5,s11,16
	add	s11,a5,sp
	lbu	a5,-8(s11)
	bne	a5,s1,.L8
	addiw	s4,s4,1
	andi	s4,s4,0xff
.L8:
	addiw	s2,s2,1
	andi	s2,s2,0xff
	beq	s1,s5,.L20
	li	a0,10
	call	EEPROM_read
	mv	s0,a0
	bgtu	a0,s6,.L6
	call	getkey
	mv	s1,a0
	bne	a0,s3,.L21
.L7:
	li	a0,10
	call	EEPROM_read
	li	a5,2
	mv	s0,a0
	bleu	a0,a5,.L12
	j	.L6
.L20:
	li	a5,5
	bne	s2,a5,.L10
	li	a5,4
	beq	s4,a5,.L22
.L10:
	call	LCD_Clear
	li	a1,0
	li	a0,0
	call	LCD_SetCursPos
	addi	a0,s9,%lo(.LC2)
	call	LCD_DispString
	addiw	a1,s0,1
	andi	a1,a1,0xff
	li	a0,10
	call	EEPROM_write
	li	a0,79998976
	addi	a0,a0,1024
	call	Delay
	call	LCD_Clear
	li	a1,0
	li	a0,0
	call	LCD_SetCursPos
	addi	a0,s8,%lo(.LC0)
	call	LCD_DispString
	li	a0,10
	call	EEPROM_read
	li	a5,2
	mv	s0,a0
	bgtu	a0,a5,.L4
	li	s2,0
	li	s4,0
	j	.L12
.L22:
	call	LCD_Clear
	li	a1,0
	li	a0,0
	call	LCD_SetCursPos
	addi	a0,s10,%lo(.LC1)
	call	LCD_DispString
	li	a1,255
	li	a0,15
	call	GPIO_Write
	li	a0,10
	call	EEPROM_read
	li	a5,2
	mv	s0,a0
	li	s2,4
	bleu	a0,a5,.L12
	j	.L6
.L13:
	li	s2,0
	li	s4,0
	lui	s10,%hi(.LC1)
	lui	s9,%hi(.LC2)
	lui	s7,%hi(.LC3)
	j	.L3
	.size	main, .-main
	.section	.rodata.str1.8
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
	call	LCD_Clear
	li	a1,0
	li	a0,0
	call	LCD_SetCursPos
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	call	LCD_DispString
	li	a1,0
	li	a0,10
	call	EEPROM_write
	li	a0,79998976
	addi	a0,a0,1024
	call	Delay
	call	main
	.size	INT0_vect, .-INT0_vect
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
