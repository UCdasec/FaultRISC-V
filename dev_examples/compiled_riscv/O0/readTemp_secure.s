	.file	"readTemp_secure.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	isTemperatureHigh
	.type	isTemperatureHigh, @function
isTemperatureHigh:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	mv	a5,a0
	mv	a4,a1
	sw	a5,-20(s0)
	mv	a5,a4
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	mv	a4,a5
	lw	a5,-20(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	sgt	a5,a4,a5
	andi	a5,a5,0xff
	sext.w	a5,a5
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	isTemperatureHigh, .-isTemperatureHigh
	.section	.rodata
	.align	3
.LC0:
	.string	"Cooling system activated!"
	.text
	.align	1
	.globl	startCoolingSystem
	.type	startCoolingSystem, @function
startCoolingSystem:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	puts
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	startCoolingSystem, .-startCoolingSystem
	.align	1
	.globl	readTemperature
	.type	readTemperature, @function
readTemperature:
	addi	sp,sp,-16
	sd	s0,8(sp)
	addi	s0,sp,16
	li	a5,30
	mv	a0,a5
	ld	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	readTemperature, .-readTemperature
	.section	.rodata
	.align	3
.LC1:
	.string	"Temperature is high!"
	.align	3
.LC2:
	.string	"Temperature is within normal range."
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	li	a5,25
	sw	a5,-20(s0)
	call	readTemperature
	mv	a5,a0
	sw	a5,-24(s0)
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	mv	a1,a4
	mv	a0,a5
	call	isTemperatureHigh
	mv	a5,a0
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	sext.w	a5,a5
	beq	a5,zero,.L7
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	puts
	call	startCoolingSystem
	j	.L8
.L7:
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	puts
.L8:
	li	a5,0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
