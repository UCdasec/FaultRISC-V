	.file	"caesarCipher.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	caesarCipher
	.type	caesarCipher, @function
caesarCipher:
	lbu	a5,0(a0)
	beq	a5,zero,.L1
	li	a3,25
	li	a2,26
.L4:
	addiw	a5,a5,-65
	addw	a4,a5,a1
	andi	a5,a5,0xff
	bgtu	a5,a3,.L3
	remw	a4,a4,a2
	addiw	a4,a4,65
	sb	a4,0(a0)
.L3:
	lbu	a5,1(a0)
	addi	a0,a0,1
	bne	a5,zero,.L4
.L1:
	ret
	.size	caesarCipher, .-caesarCipher
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"r"
	.align	3
.LC1:
	.string	"text.txt"
	.align	3
.LC2:
	.string	"Unable to open the file."
	.align	3
.LC3:
	.string	"Unable to read from the file."
	.align	3
.LC4:
	.string	"Enter the Caesar cipher shift value: "
	.align	3
.LC5:
	.string	"%d"
	.align	3
.LC6:
	.string	"Caesar Cipher: %s\n"
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-1856
	li	t0,-8192
	lui	a1,%hi(.LC0)
	lui	a0,%hi(.LC1)
	sd	ra,1848(sp)
	sd	s0,1840(sp)
	addi	a1,a1,%lo(.LC0)
	add	sp,sp,t0
	addi	a0,a0,%lo(.LC1)
	call	fopen
	beq	a0,zero,.L16
	li	a5,-8192
	li	a4,8192
	addi	a5,a5,-1808
	addi	a4,a4,1824
	add	a4,a4,a5
	addi	a5,sp,16
	add	a5,a4,a5
	li	a1,8192
	mv	s0,a0
	mv	a2,a0
	addi	a1,a1,1808
	mv	a0,a5
	sd	a5,0(sp)
	call	fgets
	beq	a0,zero,.L17
	mv	a0,s0
	call	fclose
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	call	printf
	li	s0,8192
	li	a1,-8192
	addi	a1,a1,-1812
	addi	a5,s0,1824
	add	a5,a5,a1
	addi	a4,sp,16
	lui	a0,%hi(.LC5)
	add	a1,a5,a4
	addi	a0,a0,%lo(.LC5)
	call	scanf
	addi	a3,sp,16
	addi	a4,s0,1824
	add	a4,a4,a3
	li	a5,8192
	sub	a5,a4,a5
	lw	a1,-1812(a5)
	ld	a0,0(sp)
	sd	a5,8(sp)
	call	caesarCipher
	ld	a1,0(sp)
	lui	a0,%hi(.LC6)
	addi	a0,a0,%lo(.LC6)
	call	printf
	li	a0,0
.L14:
	li	t0,8192
	add	sp,sp,t0
	ld	ra,1848(sp)
	ld	s0,1840(sp)
	addi	sp,sp,1856
	jr	ra
.L16:
	lui	a0,%hi(.LC2)
	addi	a0,a0,%lo(.LC2)
	call	puts
	li	a0,1
	j	.L14
.L17:
	lui	a0,%hi(.LC3)
	addi	a0,a0,%lo(.LC3)
	call	puts
	mv	a0,s0
	call	fclose
	li	a0,1
	j	.L14
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
