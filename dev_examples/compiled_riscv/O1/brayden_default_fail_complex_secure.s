	.file	"brayden_default_fail_complex_secure.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"Impossible"
	.align	3
.LC1:
	.string	"Too few args"
	.align	3
.LC2:
	.string	"Correct number of args"
	.align	3
.LC3:
	.string	"main.c"
	.align	3
.LC4:
	.string	"main"
	.align	3
.LC5:
	.string	"Loop"
	.align	3
.LC6:
	.string	"other.c"
	.align	3
.LC7:
	.string	"other"
	.align	3
.LC8:
	.string	"A"
	.align	3
.LC9:
	.string	"B"
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	mv	s0,a1
	li	a5,1
	beq	a0,a5,.L2
	li	a5,2
	beq	a0,a5,.L3
	bne	a0,zero,.L4
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	printf
.L4:
	ld	a4,0(s0)
	lui	a5,%hi(.LC3)
	addi	a5,a5,%lo(.LC3)
	beq	a4,a5,.L11
	lui	a5,%hi(.LC6)
	addi	a5,a5,%lo(.LC6)
	beq	a4,a5,.L12
.L7:
	li	a0,0
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
.L2:
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	printf
	j	.L4
.L3:
	lui	a0,%hi(.LC2)
	addi	a0,a0,%lo(.LC2)
	call	printf
	j	.L4
.L11:
	sd	s1,8(sp)
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	call	printf
	li	s0,10
	lui	s1,%hi(.LC5)
.L6:
	addi	a0,s1,%lo(.LC5)
	call	printf
	addiw	s0,s0,-1
	bne	s0,zero,.L6
	ld	s1,8(sp)
	j	.L7
.L12:
	lui	a0,%hi(.LC7)
	addi	a0,a0,%lo(.LC7)
	call	printf
	ld	a4,8(s0)
	lui	a5,%hi(.LC8)
	addi	a5,a5,%lo(.LC8)
	beq	a4,a5,.L13
	lui	a5,%hi(.LC9)
	addi	a5,a5,%lo(.LC9)
	bne	a4,a5,.L7
	li	a0,66
	call	putchar
	j	.L7
.L13:
	li	a0,65
	call	putchar
	j	.L7
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
