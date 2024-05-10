	.file	"data_integrity_checksum.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	calculate_checksum
	.type	calculate_checksum, @function
calculate_checksum:
	mv	a5,a0
	lbu	a4,0(a0)
	beq	a4,zero,.L4
	li	a0,0
.L3:
	addw	a0,a4,a0
	andi	a0,a0,0xff
	addi	a5,a5,1
	lbu	a4,0(a5)
	bne	a4,zero,.L3
	ret
.L4:
	mv	a0,a4
	ret
	.size	calculate_checksum, .-calculate_checksum
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC1:
	.string	"Data: %s\n"
	.align	3
.LC2:
	.string	"Checksum: %u\n"
	.align	3
.LC0:
	.string	"IntegrityCheck"
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	lui	a5,%hi(.LC0)
	addi	a5,a5,%lo(.LC0)
	ld	a4,0(a5)
	sd	a4,0(sp)
	lw	a4,8(a5)
	sw	a4,8(sp)
	lhu	a4,12(a5)
	sh	a4,12(sp)
	lbu	a5,14(a5)
	sb	a5,14(sp)
	mv	a0,sp
	call	calculate_checksum
	mv	s0,a0
	mv	a1,sp
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	printf
	sext.w	a1,s0
	lui	a0,%hi(.LC2)
	addi	a0,a0,%lo(.LC2)
	call	printf
	li	a0,0
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
