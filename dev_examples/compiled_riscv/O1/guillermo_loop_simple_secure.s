	.file	"guillermo_loop_simple_secure.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	faultDetect
	.type	faultDetect, @function
faultDetect:
	ret
	.size	faultDetect, .-faultDetect
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"i = %d\n"
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	sd	s1,8(sp)
	sd	s2,0(sp)
	li	s0,0
	lui	s2,%hi(.LC0)
	li	s1,10
.L3:
	mv	a1,s0
	addi	a0,s2,%lo(.LC0)
	call	printf
	addiw	s0,s0,1
	bne	s0,s1,.L3
	li	a0,0
	ld	ra,24(sp)
	ld	s0,16(sp)
	ld	s1,8(sp)
	ld	s2,0(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
