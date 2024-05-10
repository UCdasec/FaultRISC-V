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
	addi	a0,a0,1
	lbu	a5,0(a0)
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
	lw	a4,8(a5)
	sw	a4,8(sp)
	lhu	a5,12(a5)
	sh	a5,12(sp)
	mv	a1,sp
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	printf
	li	a1,170
	mv	a0,sp
	call	encrypt
	mv	a1,sp
	lui	a0,%hi(.LC2)
	addi	a0,a0,%lo(.LC2)
	call	printf
	li	a1,170
	mv	a0,sp
	call	encrypt
	mv	a1,sp
	lui	a0,%hi(.LC3)
	addi	a0,a0,%lo(.LC3)
	call	printf
	li	a0,0
	ld	ra,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
