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
	lbu	a4,0(a0)
	mv	a5,a0
	li	a0,0
	beq	a4,zero,.L4
.L3:
	addi	a5,a5,1
	addw	a0,a4,a0
	lbu	a4,0(a5)
	andi	a0,a0,0xff
	bne	a4,zero,.L3
	ret
.L4:
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
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	lui	a5,%hi(.LC0)
	addi	a5,a5,%lo(.LC0)
	lhu	a4,12(a5)
	ld	a2,0(a5)
	lw	a3,8(a5)
	lbu	a5,14(a5)
	addi	sp,sp,-32
	sd	s0,16(sp)
	sh	a4,12(sp)
	sb	a5,14(sp)
	sd	ra,24(sp)
	sd	a2,0(sp)
	sw	a3,8(sp)
	mv	a4,sp
	li	s0,0
	li	a5,73
.L8:
	addi	a4,a4,1
	addw	s0,a5,s0
	lbu	a5,0(a4)
	andi	s0,s0,0xff
	bne	a5,zero,.L8
	lui	a0,%hi(.LC1)
	mv	a1,sp
	addi	a0,a0,%lo(.LC1)
	call	printf
	lui	a0,%hi(.LC2)
	mv	a1,s0
	addi	a0,a0,%lo(.LC2)
	call	printf
	ld	ra,24(sp)
	ld	s0,16(sp)
	li	a0,0
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
