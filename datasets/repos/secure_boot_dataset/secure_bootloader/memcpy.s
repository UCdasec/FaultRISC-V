	.file	"memcpy.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	memcpy
	.hidden	memcpy
	.type	memcpy, @function
memcpy:
	or	a5,a0,a1
	andi	a5,a5,7
	bne	a5,zero,.L8
	addi	a6,a2,-7
	add	a6,a0,a6
	bgeu	a0,a6,.L8
	mv	a5,a0
	mv	a4,a1
.L6:
	ld	a3,0(a4)
	addi	a5,a5,8
	addi	a4,a4,8
	sd	a3,-8(a5)
	bltu	a5,a6,.L6
	addi	a5,a2,-8
	andi	a5,a5,-8
	addi	a5,a5,8
	add	a1,a1,a5
	add	a2,a0,a2
	add	a5,a0,a5
	sub	a3,a2,a5
	add	a3,a1,a3
	bltu	a5,a2,.L7
.L13:
	ret
.L8:
	mv	a5,a0
	add	a2,a0,a2
	sub	a3,a2,a5
	add	a3,a1,a3
	bgeu	a5,a2,.L13
.L7:
	lbu	a4,0(a1)
	addi	a1,a1,1
	addi	a5,a5,1
	sb	a4,-1(a5)
	bne	a1,a3,.L7
	ret
	.size	memcpy, .-memcpy
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
