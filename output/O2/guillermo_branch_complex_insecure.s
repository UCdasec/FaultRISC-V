	.file	"guillermo_branch_complex_insecure.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"Condition is true."
	.align	3
.LC1:
	.string	"Another condition is false."
	.text
	.align	1
	.globl	basic_comp
	.type	basic_comp, @function
basic_comp:
	lui	a0,%hi(.LC0)
	addi	sp,sp,-16
	addi	a0,a0,%lo(.LC0)
	sd	ra,8(sp)
	call	puts
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	puts
	ld	ra,8(sp)
	li	a0,0
	addi	sp,sp,16
	jr	ra
	.size	basic_comp, .-basic_comp
	.section	.rodata.str1.8
	.align	3
.LC2:
	.string	"Both condition and x < y are true."
	.align	3
.LC3:
	.string	"Either anotherCondition or z > y is true."
	.align	3
.LC4:
	.string	"x is not equal to y."
	.text
	.align	1
	.globl	advanced_comp
	.type	advanced_comp, @function
advanced_comp:
	lui	a0,%hi(.LC2)
	addi	sp,sp,-16
	addi	a0,a0,%lo(.LC2)
	sd	ra,8(sp)
	call	puts
	lui	a0,%hi(.LC3)
	addi	a0,a0,%lo(.LC3)
	call	puts
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	call	puts
	ld	ra,8(sp)
	li	a0,0
	addi	sp,sp,16
	jr	ra
	.size	advanced_comp, .-advanced_comp
	.ident	"GCC: () 13.2.0"
