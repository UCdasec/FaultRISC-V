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
	j	.L4
.L3:
	addi	a0,a0,1
	lbu	a5,0(a0)
	beq	a5,zero,.L1
.L4:
	addiw	a4,a5,-65
	andi	a4,a4,0xff
	bgtu	a4,a3,.L3
	addiw	a5,a5,-65
	addw	a5,a5,a1
	remw	a5,a5,a2
	addiw	a5,a5,65
	sb	a5,0(a0)
	j	.L3
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
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-1856
	sd	ra,1848(sp)
	sd	s0,1840(sp)
	li	t0,-8192
	add	sp,sp,t0
	lui	a1,%hi(.LC0)
	addi	a1,a1,%lo(.LC0)
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	fopen
	beq	a0,zero,.L11
	mv	s0,a0
	li	a0,-8192
	addi	a0,a0,-1816
	mv	a2,s0
	li	a1,8192
	addi	a1,a1,1808
	li	a5,8192
	addi	a5,a5,1824
	add	a5,a5,a0
	addi	a4,sp,16
	add	a0,a5,a4
	call	fgets
	beq	a0,zero,.L12
	mv	a0,s0
	call	fclose
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	call	printf
	li	s0,8192
	addi	a5,s0,1836
	add	a1,a5,sp
	lui	a0,%hi(.LC5)
	addi	a0,a0,%lo(.LC5)
	call	scanf
	li	a5,-8192
	addi	a5,a5,-1816
	addi	a3,s0,1824
	add	a3,a3,a5
	addi	a5,sp,16
	add	a5,a3,a5
	sd	a5,8(sp)
	addi	a5,s0,1820
	addi	a4,sp,16
	add	a5,a5,a4
	lw	a1,0(a5)
	ld	a0,8(sp)
	call	caesarCipher
	ld	a1,8(sp)
	lui	a0,%hi(.LC6)
	addi	a0,a0,%lo(.LC6)
	call	printf
	li	a0,0
.L8:
	li	t0,8192
	add	sp,sp,t0
	ld	ra,1848(sp)
	ld	s0,1840(sp)
	addi	sp,sp,1856
	jr	ra
.L11:
	lui	a0,%hi(.LC2)
	addi	a0,a0,%lo(.LC2)
	call	puts
	li	a0,1
	j	.L8
.L12:
	lui	a0,%hi(.LC3)
	addi	a0,a0,%lo(.LC3)
	call	puts
	mv	a0,s0
	call	fclose
	li	a0,1
	j	.L8
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
