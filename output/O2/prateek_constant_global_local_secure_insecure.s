	.file	"prateek_constant_global_local_secure_insecure.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC1:
	.string	"%d"
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sd	s0,0(sp)
	lui	s0,%hi(.LC1)
	li	a1,16
	addi	a0,s0,%lo(.LC1)
	sd	ra,8(sp)
	call	printf
	lui	a5,%hi(global_insecure)
	lw	a1,%lo(global_insecure)(a5)
	addi	a0,s0,%lo(.LC1)
	call	printf
	ld	ra,8(sp)
	ld	s0,0(sp)
	li	a0,0
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.text
	.align	1
	.globl	printNumber
	.type	printNumber, @function
printNumber:
	mv	a1,a0
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	tail	printf
	.size	printNumber, .-printNumber
	.globl	global_insecure
	.globl	global_secure
	.section	.sdata,"aw"
	.align	2
	.type	global_insecure, @object
	.size	global_insecure, 4
global_insecure:
	.word	1
	.type	global_secure, @object
	.size	global_secure, 4
global_secure:
	.word	255
	.ident	"GCC: () 13.2.0"
