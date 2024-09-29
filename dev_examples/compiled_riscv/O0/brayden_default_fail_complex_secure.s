	.file	"brayden_default_fail_complex_secure.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata
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
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	mv	a5,a0
	sd	a1,-48(s0)
	sw	a5,-36(s0)
	lw	a5,-36(s0)
	sext.w	a4,a5
	li	a5,2
	beq	a4,a5,.L2
	lw	a5,-36(s0)
	sext.w	a4,a5
	li	a5,2
	bgt	a4,a5,.L3
	lw	a5,-36(s0)
	sext.w	a5,a5
	beq	a5,zero,.L4
	lw	a5,-36(s0)
	sext.w	a4,a5
	li	a5,1
	beq	a4,a5,.L5
	j	.L3
.L4:
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	printf
	j	.L3
.L5:
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	printf
	j	.L3
.L2:
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	printf
	nop
.L3:
	ld	a5,-48(s0)
	ld	a4,0(a5)
	lui	a5,%hi(.LC3)
	addi	a5,a5,%lo(.LC3)
	bne	a4,a5,.L6
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	printf
	sw	zero,-20(s0)
	j	.L7
.L8:
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	printf
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L7:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,9
	ble	a4,a5,.L8
	j	.L9
.L6:
	ld	a5,-48(s0)
	ld	a4,0(a5)
	lui	a5,%hi(.LC6)
	addi	a5,a5,%lo(.LC6)
	bne	a4,a5,.L9
	lui	a5,%hi(.LC7)
	addi	a0,a5,%lo(.LC7)
	call	printf
	ld	a5,-48(s0)
	addi	a5,a5,8
	ld	a4,0(a5)
	lui	a5,%hi(.LC8)
	addi	a5,a5,%lo(.LC8)
	bne	a4,a5,.L10
	li	a0,65
	call	putchar
	j	.L9
.L10:
	ld	a5,-48(s0)
	addi	a5,a5,8
	ld	a4,0(a5)
	lui	a5,%hi(.LC9)
	addi	a5,a5,%lo(.LC9)
	bne	a4,a5,.L9
	li	a0,66
	call	putchar
.L9:
	li	a5,0
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
