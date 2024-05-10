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
	addi	sp,sp,-16
	sd	ra,8(sp)
	lui	a1,%hi(.LC0)
	addi	a1,a1,%lo(.LC0)
	call	strcmp
	seqz	a0,a0
	ld	ra,8(sp)
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
.LC3:
	.string	"Access granted."
	.align	3
.LC4:
	.string	"Access denied."
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-80
	sd	ra,72(sp)
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	printf
	addi	a1,sp,8
	lui	a0,%hi(.LC2)
	addi	a0,a0,%lo(.LC2)
	call	scanf
	addi	a0,sp,8
	call	check_password
	beq	a0,zero,.L4
	lui	a0,%hi(.LC3)
	addi	a0,a0,%lo(.LC3)
	call	puts
.L5:
	li	a0,0
	ld	ra,72(sp)
	addi	sp,sp,80
	jr	ra
.L4:
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	call	puts
	j	.L5
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
