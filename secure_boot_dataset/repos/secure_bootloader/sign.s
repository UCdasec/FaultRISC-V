	.file	"sign.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	ed25519_sign
	.hidden	ed25519_sign
	.type	ed25519_sign, @function
ed25519_sign:
	addi	sp,sp,-544
	sd	s0,528(sp)
	mv	s0,a0
	addi	a0,sp,288
	sd	ra,536(sp)
	sd	s1,520(sp)
	sd	s2,512(sp)
	mv	s1,a4
	sd	s3,504(sp)
	sd	s4,496(sp)
	mv	s2,a1
	mv	s4,a3
	mv	s3,a2
	call	sha512_init
	addi	a1,s1,32
	li	a2,32
	addi	a0,sp,288
	call	sha512_update
	mv	a2,s3
	mv	a1,s2
	addi	a0,sp,288
	call	sha512_update
	addi	a1,sp,64
	addi	a0,sp,288
	call	sha512_final
	addi	a0,sp,64
	call	sc_reduce
	addi	a1,sp,64
	addi	a0,sp,128
	call	ge_scalarmult_base
	addi	a1,sp,128
	mv	a0,s0
	call	ge_p3_tobytes
	addi	a0,sp,288
	call	sha512_init
	mv	a1,s0
	li	a2,32
	addi	a0,sp,288
	call	sha512_update
	mv	a1,s4
	li	a2,32
	addi	a0,sp,288
	call	sha512_update
	mv	a2,s3
	mv	a1,s2
	addi	a0,sp,288
	call	sha512_update
	mv	a1,sp
	addi	a0,sp,288
	call	sha512_final
	mv	a0,sp
	call	sc_reduce
	addi	a3,sp,64
	mv	a2,s1
	mv	a1,sp
	addi	a0,s0,32
	call	sc_muladd
	ld	ra,536(sp)
	ld	s0,528(sp)
	ld	s1,520(sp)
	ld	s2,512(sp)
	ld	s3,504(sp)
	ld	s4,496(sp)
	addi	sp,sp,544
	jr	ra
	.size	ed25519_sign, .-ed25519_sign
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
