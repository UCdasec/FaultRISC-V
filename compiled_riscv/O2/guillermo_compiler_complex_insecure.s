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
	addiw	a4,a5,1
	mv	a5,a4
	addi	a4,a4,-1
	sw	a5,0(a0)
	snez	a0,a4
	ret
	.size	foo, .-foo
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"Access denied."
	.align	3
.LC1:
	.string	"Access granted."
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sd	ra,8(sp)
	call	getchar
	beq	a0,zero,.L7
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	puts
	li	a0,0
.L5:
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
.L7:
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	puts
	li	a0,1
	j	.L5
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
