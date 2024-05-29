	.file	"secure_data_wipe.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	secure_wipe
	.type	secure_wipe, @function
secure_wipe:
	mv	a2,a1
	beq	a1,zero,.L1
	li	a1,0
	tail	memset
.L1:
	ret
	.size	secure_wipe, .-secure_wipe
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC1:
	.string	"Before wipe: %s\n"
	.align	3
.LC2:
	.string	"After wipe: %s\n"
	.align	3
.LC0:
	.string	"VerySecret"
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	lui	a5,%hi(.LC0)
	addi	a5,a5,%lo(.LC0)
	ld	a3,0(a5)
	lhu	a4,8(a5)
	lbu	a5,10(a5)
	addi	sp,sp,-32
	lui	a0,%hi(.LC1)
	mv	a1,sp
	addi	a0,a0,%lo(.LC1)
	sd	ra,24(sp)
	sd	a3,0(sp)
	sh	a4,8(sp)
	sb	a5,10(sp)
	call	printf
	mv	a0,sp
	call	strlen
	beq	a0,zero,.L5
	li	a4,8
	mv	a5,sp
	bgeu	a0,a4,.L17
.L6:
	li	a4,4
	bgeu	a0,a4,.L18
.L7:
	li	a4,2
	bgeu	a0,a4,.L19
	bne	a0,zero,.L20
.L5:
	lui	a0,%hi(.LC2)
	mv	a1,sp
	addi	a0,a0,%lo(.LC2)
	call	printf
	ld	ra,24(sp)
	li	a0,0
	addi	sp,sp,32
	jr	ra
.L20:
	sb	zero,0(a5)
	j	.L5
.L19:
	sh	zero,0(a5)
	addi	a0,a0,-2
	addi	a5,a5,2
	beq	a0,zero,.L5
	j	.L20
.L18:
	sw	zero,0(a5)
	addi	a0,a0,-4
	addi	a5,a5,4
	j	.L7
.L17:
	sd	zero,0(sp)
	addi	a5,sp,8
	addi	a0,a0,-8
	j	.L6
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
