	.file	"adjust_light_secure.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	isLowLight
	.type	isLowLight, @function
isLowLight:
	slt	a0,a0,a1
	ret
	.size	isLowLight, .-isLowLight
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"Adjusting light brightness to %d%%.\n"
	.text
	.align	1
	.globl	adjustLightBrightness
	.type	adjustLightBrightness, @function
adjustLightBrightness:
	mv	a1,a0
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	tail	printf
	.size	adjustLightBrightness, .-adjustLightBrightness
	.align	1
	.globl	readAmbientLightLevel
	.type	readAmbientLightLevel, @function
readAmbientLightLevel:
	li	a0,30
	ret
	.size	readAmbientLightLevel, .-readAmbientLightLevel
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	lui	a0,%hi(.LC0)
	addi	sp,sp,-16
	li	a1,70
	addi	a0,a0,%lo(.LC0)
	sd	ra,8(sp)
	call	printf
	ld	ra,8(sp)
	li	a0,0
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
