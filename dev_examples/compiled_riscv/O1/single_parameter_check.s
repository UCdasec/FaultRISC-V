	.file	"single_parameter_check.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"Enter the threshold for Condition 1: "
	.align	3
.LC1:
	.string	"%d"
	.align	3
.LC2:
	.string	"Checking Condition 1 with threshold %d\n"
	.text
	.align	1
	.globl	checkCondition1
	.type	checkCondition1, @function
checkCondition1:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	mv	s0,a0
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	printf
	addi	a1,sp,12
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	scanf
	lw	a1,12(sp)
	lui	a0,%hi(.LC2)
	addi	a0,a0,%lo(.LC2)
	call	printf
	lw	a0,12(sp)
	slt	a0,a0,s0
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	checkCondition1, .-checkCondition1
	.section	.rodata.str1.8
	.align	3
.LC3:
	.string	"r"
	.align	3
.LC4:
	.string	"data.txt"
	.align	3
.LC5:
	.string	"Error opening file!"
	.align	3
.LC6:
	.string	"Condition 1 is true"
	.align	3
.LC7:
	.string	"Condition 1 is false"
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	lui	a1,%hi(.LC3)
	addi	a1,a1,%lo(.LC3)
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	call	fopen
	beq	a0,zero,.L8
	sd	s0,16(sp)
	mv	s0,a0
	addi	a2,sp,12
	lui	a1,%hi(.LC1)
	addi	a1,a1,%lo(.LC1)
	call	fscanf
	mv	a0,s0
	call	fclose
	lw	a0,12(sp)
	call	checkCondition1
	beq	a0,zero,.L6
	lui	a0,%hi(.LC6)
	addi	a0,a0,%lo(.LC6)
	call	puts
	li	a0,0
	ld	s0,16(sp)
.L5:
	ld	ra,24(sp)
	addi	sp,sp,32
	jr	ra
.L8:
	lui	a0,%hi(.LC5)
	addi	a0,a0,%lo(.LC5)
	call	puts
	li	a0,1
	j	.L5
.L6:
	lui	a0,%hi(.LC7)
	addi	a0,a0,%lo(.LC7)
	call	puts
	li	a0,0
	ld	s0,16(sp)
	j	.L5
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
