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
	beq	a1,zero,.L1
	mv	a5,a0
	add	a0,a0,a1
.L3:
	sb	zero,0(a5)
	addi	a5,a5,1
	bne	a5,a0,.L3
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
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	lui	a5,%hi(.LC0)
	addi	a5,a5,%lo(.LC0)
	ld	a4,0(a5)
	sd	a4,0(sp)
	lhu	a4,8(a5)
	sh	a4,8(sp)
	lbu	a5,10(a5)
	sb	a5,10(sp)
	mv	a1,sp
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	printf
	mv	a0,sp
	call	strlen
	mv	a1,a0
	mv	a0,sp
	call	secure_wipe
	mv	a1,sp
	lui	a0,%hi(.LC2)
	addi	a0,a0,%lo(.LC2)
	call	printf
	li	a0,0
	ld	ra,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
