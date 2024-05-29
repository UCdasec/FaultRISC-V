	.file	"data_encryption_xor.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	encrypt
	.type	encrypt, @function
encrypt:
	lbu	a5,0(a0)
	beq	a5,zero,.L1
.L3:
	xor	a5,a1,a5
	sb	a5,0(a0)
	lbu	a5,1(a0)
	addi	a0,a0,1
	bne	a5,zero,.L3
.L1:
	ret
	.size	encrypt, .-encrypt
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC1:
	.string	"Original message: %s\n"
	.align	3
.LC2:
	.string	"Encrypted message: %s\n"
	.align	3
.LC3:
	.string	"Decrypted message: %s\n"
	.align	3
.LC0:
	.string	"SensitiveData"
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	lui	a5,%hi(.LC0)
	addi	a5,a5,%lo(.LC0)
	ld	a3,0(a5)
	lw	a4,8(a5)
	lhu	a5,12(a5)
	addi	sp,sp,-32
	lui	a0,%hi(.LC1)
	mv	a1,sp
	addi	a0,a0,%lo(.LC1)
	sh	a5,12(sp)
	sd	ra,24(sp)
	sd	a3,0(sp)
	sw	a4,8(sp)
	call	printf
	lbu	a5,0(sp)
	beq	a5,zero,.L10
	mv	a4,sp
.L11:
	xori	a5,a5,-86
	sb	a5,0(a4)
	lbu	a5,1(a4)
	addi	a4,a4,1
	bne	a5,zero,.L11
.L10:
	lui	a0,%hi(.LC2)
	mv	a1,sp
	addi	a0,a0,%lo(.LC2)
	call	printf
	lbu	a5,0(sp)
	beq	a5,zero,.L12
	mv	a4,sp
.L13:
	xori	a5,a5,-86
	sb	a5,0(a4)
	lbu	a5,1(a4)
	addi	a4,a4,1
	bne	a5,zero,.L13
.L12:
	lui	a0,%hi(.LC3)
	mv	a1,sp
	addi	a0,a0,%lo(.LC3)
	call	printf
	ld	ra,24(sp)
	li	a0,0
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
