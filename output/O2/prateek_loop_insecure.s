	.file	"prateek_loop_insecure.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"Fault Detected\n"
	.text
	.align	1
	.globl	faultDetect
	.type	faultDetect, @function
faultDetect:
	lui	a5,%hi(_impure_ptr)
	ld	a5,%lo(_impure_ptr)(a5)
	lui	a0,%hi(.LC0)
	addi	sp,sp,-16
	ld	a3,24(a5)
	li	a2,15
	li	a1,1
	addi	a0,a0,%lo(.LC0)
	sd	ra,8(sp)
	call	fwrite
	li	a0,1
	call	exit
	.size	faultDetect, .-faultDetect
	.section	.rodata.str1.8
	.align	3
.LC1:
	.string	"Enter the number of iterations: "
	.align	3
.LC2:
	.string	"%d"
	.align	3
.LC3:
	.string	"Task %d completed\n"
	.align	3
.LC4:
	.string	"End of program"
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	lui	a0,%hi(.LC1)
	addi	sp,sp,-48
	addi	a0,a0,%lo(.LC1)
	sd	ra,40(sp)
	call	printf
	lui	a0,%hi(.LC2)
	addi	a1,sp,12
	addi	a0,a0,%lo(.LC2)
	call	scanf
	lw	a5,12(sp)
	ble	a5,zero,.L5
	sd	s0,32(sp)
	sd	s1,24(sp)
	li	s0,0
	lui	s1,%hi(.LC3)
.L6:
	addiw	s0,s0,1
	mv	a1,s0
	addi	a0,s1,%lo(.LC3)
	call	printf
	lw	a5,12(sp)
	bgt	a5,s0,.L6
	ld	s0,32(sp)
	ld	s1,24(sp)
.L5:
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	call	puts
	ld	ra,40(sp)
	li	a0,0
	addi	sp,sp,48
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
