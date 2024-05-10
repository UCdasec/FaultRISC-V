	.file	"rate_limiting_brute_force.c"
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
	.align	3
.LC5:
	.string	"Too many incorrect attempts."
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-112
	sd	ra,104(sp)
	sd	s0,96(sp)
	sd	s1,88(sp)
	sd	s2,80(sp)
	sd	s3,72(sp)
	li	s0,3
	lui	s2,%hi(.LC1)
	lui	s1,%hi(.LC2)
	lui	s3,%hi(.LC4)
.L6:
	addi	a0,s2,%lo(.LC1)
	call	printf
	addi	a1,sp,8
	addi	a0,s1,%lo(.LC2)
	call	scanf
	addi	a0,sp,8
	call	check_password
	bne	a0,zero,.L9
	addi	a0,s3,%lo(.LC4)
	call	puts
	li	a0,1
	call	sleep
	addiw	s0,s0,-1
	bne	s0,zero,.L6
	lui	a0,%hi(.LC5)
	addi	a0,a0,%lo(.LC5)
	call	puts
	li	a0,1
.L5:
	ld	ra,104(sp)
	ld	s0,96(sp)
	ld	s1,88(sp)
	ld	s2,80(sp)
	ld	s3,72(sp)
	addi	sp,sp,112
	jr	ra
.L9:
	lui	a0,%hi(.LC3)
	addi	a0,a0,%lo(.LC3)
	call	puts
	li	a0,0
	j	.L5
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
