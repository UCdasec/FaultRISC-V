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
	sgt	a0,a1,a0
	ret
	.size	isTemperatureHigh, .-isTemperatureHigh
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"Cooling system activated!"
	.text
	.align	1
	.globl	startCoolingSystem
	.type	startCoolingSystem, @function
startCoolingSystem:
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	tail	puts
	.size	startCoolingSystem, .-startCoolingSystem
	.align	1
	.globl	readTemperature
	.type	readTemperature, @function
readTemperature:
	li	a0,30
	ret
	.size	readTemperature, .-readTemperature
	.section	.rodata.str1.8
	.align	3
.LC1:
	.string	"Temperature is high!"
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	lui	a0,%hi(.LC1)
	addi	sp,sp,-16
	addi	a0,a0,%lo(.LC1)
	sd	ra,8(sp)
	call	puts
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	puts
	ld	ra,8(sp)
	li	a0,0
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
