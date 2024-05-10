	.file	"harris_branch_complex_secure.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"%x, %x, %x, %x, %x"
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	li	a3,4096
	li	a2,4096
	li	a1,45056
	lui	a0,%hi(.LC0)
	addi	sp,sp,-16
	li	a5,13
	li	a4,192
	addi	a3,a3,-1280
	addi	a2,a2,-256
	addi	a1,a1,-1075
	addi	a0,a0,%lo(.LC0)
	sd	ra,8(sp)
	call	printf
	ld	ra,8(sp)
	li	a0,0
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
