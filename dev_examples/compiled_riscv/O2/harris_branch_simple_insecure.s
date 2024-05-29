	.file	"harris_branch_simple_insecure.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"Executing critical code... "
	.align	3
.LC1:
	.string	"Exiting out..."
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
	ld	ra,8(sp)
	li	a0,1
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
