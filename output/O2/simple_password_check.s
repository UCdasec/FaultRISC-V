	.file	"simple_password_check.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"secure123"
	.text
	.align	1
	.globl	check_password
	.type	check_password, @function
check_password:
	lui	a1,%hi(.LC0)
	addi	sp,sp,-16
	addi	a1,a1,%lo(.LC0)
	sd	ra,8(sp)
	call	strcmp
	ld	ra,8(sp)
	seqz	a0,a0
	addi	sp,sp,16
	jr	ra
	.size	check_password, .-check_password
	.section	.rodata.str1.8
	.align	3
.LC1:
	.string	"Enter password: "
	.align	3
.LC2:
	.string	"%49s"
	.align	3
.LC4:
	.string	"Access granted."
	.align	3
.LC5:
	.string	"Access denied."
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	lui	a0,%hi(.LC1)
	addi	sp,sp,-80
	addi	a0,a0,%lo(.LC1)
	sd	ra,72(sp)
	call	printf
	lui	a0,%hi(.LC2)
	addi	a1,sp,8
	addi	a0,a0,%lo(.LC2)
	call	scanf
	li	a5,6578176
	addi	a5,a5,715
	slli	a5,a5,14
	addi	a5,a5,-1733
	slli	a5,a5,12
	addi	a5,a5,-1253
	ld	a4,8(sp)
	slli	a5,a5,13
	addi	a5,a5,1395
	beq	a4,a5,.L11
.L5:
	lui	a0,%hi(.LC5)
	addi	a0,a0,%lo(.LC5)
	call	puts
.L8:
	ld	ra,72(sp)
	li	a0,0
	addi	sp,sp,80
	jr	ra
.L11:
	lhu	a4,16(sp)
	li	a5,51
	bne	a4,a5,.L5
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	call	puts
	j	.L8
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
