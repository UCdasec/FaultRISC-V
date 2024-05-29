	.file	"guillermo_practical_pin_check.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"r"
	.align	3
.LC1:
	.string	"/path/to/saved/pins"
	.align	3
.LC2:
	.string	"%5s"
	.text
	.align	1
	.globl	import_data
	.type	import_data, @function
import_data:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	mv	s0,a0
	lui	a1,%hi(.LC0)
	addi	a1,a1,%lo(.LC0)
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	fopen
	beq	a0,zero,.L3
	mv	a2,s0
	lui	a1,%hi(.LC2)
	addi	a1,a1,%lo(.LC2)
	call	fscanf
	slti	a0,a0,4
.L2:
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
.L3:
	li	a0,1
	j	.L2
	.size	import_data, .-import_data
	.align	1
	.globl	verify_pin
	.type	verify_pin, @function
verify_pin:
	lbu	a5,0(a0)
	beq	a5,zero,.L7
.L6:
	lbu	a4,0(a1)
	beq	a4,zero,.L12
	bne	a4,a5,.L10
	addi	a0,a0,1
	addi	a1,a1,1
	lbu	a5,0(a0)
	bne	a5,zero,.L6
.L7:
	lbu	a0,0(a1)
	seqz	a0,a0
	ret
.L12:
	li	a0,0
	ret
.L10:
	li	a0,0
	ret
	.size	verify_pin, .-verify_pin
	.section	.rodata.str1.8
	.align	3
.LC3:
	.string	"Failed to import data"
	.align	3
.LC4:
	.string	"Bad input..."
	.align	3
.LC5:
	.string	"Incorrect PIN"
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	mv	a0,sp
	call	import_data
	li	a5,1
	beq	a0,a5,.L20
	addi	a1,sp,8
	lui	a0,%hi(.LC2)
	addi	a0,a0,%lo(.LC2)
	call	scanf
	li	a5,4
	ble	a0,a5,.L21
	mv	a1,sp
	addi	a0,sp,8
	call	verify_pin
	mv	a4,a0
	li	a5,1
	li	a0,0
	bne	a4,a5,.L17
	lui	a0,%hi(.LC5)
	addi	a0,a0,%lo(.LC5)
	call	puts
	j	.L15
.L20:
	lui	a0,%hi(.LC3)
	addi	a0,a0,%lo(.LC3)
	call	puts
	j	.L15
.L21:
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	call	puts
.L15:
	li	a0,1
.L17:
	ld	ra,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
