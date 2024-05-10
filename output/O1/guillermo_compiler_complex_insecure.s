	.file	"guillermo_compiler_complex_insecure.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	foo
	.type	foo, @function
foo:
	lw	a5,0(a0)
	addiw	a5,a5,1
	sext.w	a4,a5
	sw	a5,0(a0)
	addi	a0,a4,-1
	snez	a0,a0
	ret
	.size	foo, .-foo
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"Access granted."
	.align	3
.LC1:
	.string	"Access denied."
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	call	getchar
	sw	a0,12(sp)
	addi	a0,sp,12
	call	foo
	li	a5,1
	bne	a0,a5,.L3
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	puts
	li	a0,0
.L4:
	ld	ra,24(sp)
	addi	sp,sp,32
	jr	ra
.L3:
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	puts
	li	a0,1
	j	.L4
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
