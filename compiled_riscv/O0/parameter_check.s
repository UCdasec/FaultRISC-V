	.file	"parameter_check.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata
	.align	3
.LC0:
	.string	"r"
	.align	3
.LC1:
	.string	"data.txt"
	.align	3
.LC2:
	.string	"Error opening file!"
	.align	3
.LC3:
	.string	"%d"
	.align	3
.LC4:
	.string	"Condition 1 is true"
	.align	3
.LC5:
	.string	"Both Condition 1 and Condition 2 are true"
	.align	3
.LC6:
	.string	"Condition 1 is false"
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	lui	a5,%hi(.LC0)
	addi	a1,a5,%lo(.LC0)
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	fopen
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	bne	a5,zero,.L2
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	puts
	li	a5,1
	j	.L6
.L2:
	addi	a5,s0,-28
	mv	a2,a5
	lui	a5,%hi(.LC3)
	addi	a1,a5,%lo(.LC3)
	ld	a0,-24(s0)
	call	fscanf
	ld	a0,-24(s0)
	call	fclose
	lw	a5,-28(s0)
	mv	a0,a5
	call	checkCondition1
	mv	a5,a0
	beq	a5,zero,.L4
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	puts
	lw	a5,-28(s0)
	mv	a0,a5
	call	checkCondition2
	mv	a5,a0
	beq	a5,zero,.L5
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	puts
	j	.L5
.L4:
	lui	a5,%hi(.LC6)
	addi	a0,a5,%lo(.LC6)
	call	puts
.L5:
	li	a5,0
.L6:
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.section	.rodata
	.align	3
.LC7:
	.string	"Enter the threshold for Condition 1: "
	.align	3
.LC8:
	.string	"Checking Condition 1 with threshold %d\n"
	.text
	.align	1
	.globl	checkCondition1
	.type	checkCondition1, @function
checkCondition1:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	mv	a5,a0
	sw	a5,-36(s0)
	lui	a5,%hi(.LC7)
	addi	a0,a5,%lo(.LC7)
	call	printf
	addi	a5,s0,-20
	mv	a1,a5
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	scanf
	lw	a5,-20(s0)
	mv	a1,a5
	lui	a5,%hi(.LC8)
	addi	a0,a5,%lo(.LC8)
	call	printf
	lw	a4,-20(s0)
	lw	a5,-36(s0)
	sext.w	a5,a5
	sgt	a5,a5,a4
	andi	a5,a5,0xff
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	checkCondition1, .-checkCondition1
	.section	.rodata
	.align	3
.LC9:
	.string	"Enter the threshold for Condition 2: "
	.align	3
.LC10:
	.string	"Checking Condition 2 with threshold %d\n"
	.text
	.align	1
	.globl	checkCondition2
	.type	checkCondition2, @function
checkCondition2:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	mv	a5,a0
	sw	a5,-36(s0)
	lui	a5,%hi(.LC9)
	addi	a0,a5,%lo(.LC9)
	call	printf
	addi	a5,s0,-20
	mv	a1,a5
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	scanf
	lw	a5,-20(s0)
	mv	a1,a5
	lui	a5,%hi(.LC10)
	addi	a0,a5,%lo(.LC10)
	call	printf
	lw	a4,-20(s0)
	lw	a5,-36(s0)
	sext.w	a5,a5
	slt	a5,a5,a4
	andi	a5,a5,0xff
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	checkCondition2, .-checkCondition2
	.ident	"GCC: () 13.2.0"
