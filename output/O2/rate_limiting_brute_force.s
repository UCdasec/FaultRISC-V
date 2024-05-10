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
	.align	3
.LC6:
	.string	"Too many incorrect attempts."
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-112
	sd	s0,96(sp)
	li	s0,6578176
	addi	s0,s0,715
	slli	s0,s0,14
	addi	s0,s0,-1733
	slli	s0,s0,12
	addi	s0,s0,-1253
	slli	s0,s0,13
	sd	s1,88(sp)
	sd	s2,80(sp)
	sd	s3,72(sp)
	sd	s4,64(sp)
	sd	ra,104(sp)
	li	s1,3
	lui	s4,%hi(.LC1)
	lui	s3,%hi(.LC2)
	addi	s0,s0,1395
	lui	s2,%hi(.LC5)
.L9:
	addi	a0,s4,%lo(.LC1)
	call	printf
	addi	a1,sp,8
	addi	a0,s3,%lo(.LC2)
	call	scanf
	ld	a5,8(sp)
	addi	a0,s2,%lo(.LC5)
	beq	a5,s0,.L13
.L10:
	call	puts
	li	a0,1
	addiw	s1,s1,-1
	call	sleep
	bne	s1,zero,.L9
	lui	a0,%hi(.LC6)
	addi	a0,a0,%lo(.LC6)
	call	puts
	li	s0,1
.L8:
	ld	ra,104(sp)
	mv	a0,s0
	ld	s0,96(sp)
	ld	s1,88(sp)
	ld	s2,80(sp)
	ld	s3,72(sp)
	ld	s4,64(sp)
	addi	sp,sp,112
	jr	ra
.L13:
	lhu	a4,16(sp)
	li	a5,51
	bne	a4,a5,.L10
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	li	s0,0
	call	puts
	j	.L8
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
