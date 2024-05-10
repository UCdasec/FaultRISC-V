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
	sd	s0,0(sp)
	lui	a1,%hi(.LC0)
	mv	s0,a0
	lui	a0,%hi(.LC1)
	addi	a1,a1,%lo(.LC0)
	addi	a0,a0,%lo(.LC1)
	sd	ra,8(sp)
	call	fopen
	beq	a0,zero,.L3
	lui	a1,%hi(.LC2)
	mv	a2,s0
	addi	a1,a1,%lo(.LC2)
	call	fscanf
	ld	ra,8(sp)
	ld	s0,0(sp)
	slti	a0,a0,4
	addi	sp,sp,16
	jr	ra
.L3:
	ld	ra,8(sp)
	ld	s0,0(sp)
	li	a0,1
	addi	sp,sp,16
	jr	ra
	.size	import_data, .-import_data
	.align	1
	.globl	verify_pin
	.type	verify_pin, @function
verify_pin:
	j	.L16
.L17:
	lbu	a4,0(a1)
	addi	a0,a0,1
	addi	a1,a1,1
	beq	a4,zero,.L11
	bne	a4,a5,.L11
.L16:
	lbu	a5,0(a0)
	bne	a5,zero,.L17
	lbu	a0,0(a1)
	seqz	a0,a0
	ret
.L11:
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
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	addi	a0,sp,8
	sd	s0,16(sp)
	sd	ra,24(sp)
	li	s0,1
	call	import_data
	beq	a0,s0,.L25
	lui	a0,%hi(.LC2)
	mv	a1,sp
	addi	a0,a0,%lo(.LC2)
	call	scanf
	li	a5,4
	ble	a0,a5,.L26
	addi	a1,sp,8
	mv	a0,sp
	call	verify_pin
	mv	a5,a0
	li	a0,0
	beq	a5,s0,.L27
.L22:
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
.L26:
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	call	puts
	li	a0,1
	j	.L22
.L25:
	lui	a0,%hi(.LC3)
	addi	a0,a0,%lo(.LC3)
	call	puts
	li	a0,1
	j	.L22
.L27:
	lui	a0,%hi(.LC5)
	addi	a0,a0,%lo(.LC5)
	call	puts
	li	a0,1
	j	.L22
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
