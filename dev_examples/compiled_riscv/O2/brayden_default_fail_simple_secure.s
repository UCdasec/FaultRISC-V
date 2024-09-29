	.file	"brayden_default_fail_simple_secure.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"One"
	.align	3
.LC1:
	.string	"Two"
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sd	ra,8(sp)
	li	a5,1
	beq	a0,a5,.L6
	li	a5,2
	beq	a0,a5,.L7
.L3:
	ld	ra,8(sp)
	li	a0,0
	addi	sp,sp,16
	jr	ra
.L6:
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	printf
	j	.L3
.L7:
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	printf
	j	.L3
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
