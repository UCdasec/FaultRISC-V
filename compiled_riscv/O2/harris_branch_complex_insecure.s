	.file	"harris_branch_complex_insecure.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"Executing critical code... "
	.text
	.align	1
	.globl	basic_comp
	.type	basic_comp, @function
basic_comp:
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	tail	puts
	.size	basic_comp, .-basic_comp
	.section	.rodata.str1.8
	.align	3
.LC1:
	.string	"Exiting out... "
	.text
	.align	1
	.globl	branch_check
	.type	branch_check, @function
branch_check:
	addi	sp,sp,-16
	sd	ra,8(sp)
	li	a5,1
	beq	a0,a5,.L7
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	puts
	ld	ra,8(sp)
	li	a0,0
	addi	sp,sp,16
	jr	ra
.L7:
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	puts
	ld	ra,8(sp)
	li	a0,0
	addi	sp,sp,16
	jr	ra
	.size	branch_check, .-branch_check
	.section	.rodata.str1.8
	.align	3
.LC2:
	.string	"Both x < y and condition are false. "
	.align	3
.LC3:
	.string	"Either anothercondition or z > y is true but condition is false. "
	.text
	.align	1
	.globl	adv_comp
	.type	adv_comp, @function
adv_comp:
	addi	sp,sp,-16
	sd	s0,0(sp)
	lui	s0,%hi(.LC0)
	addi	a0,s0,%lo(.LC0)
	sd	ra,8(sp)
	call	puts
	lui	a0,%hi(.LC2)
	addi	a0,a0,%lo(.LC2)
	call	puts
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	puts
	addi	a0,s0,%lo(.LC0)
	call	puts
	ld	s0,0(sp)
	ld	ra,8(sp)
	lui	a0,%hi(.LC3)
	addi	a0,a0,%lo(.LC3)
	addi	sp,sp,16
	tail	puts
	.size	adv_comp, .-adv_comp
	.ident	"GCC: () 13.2.0"
