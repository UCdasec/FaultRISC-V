	.file	"keypair.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	ed25519_compute_pubkey
	.hidden	ed25519_compute_pubkey
	.type	ed25519_compute_pubkey, @function
ed25519_compute_pubkey:
	addi	sp,sp,-176
	sd	s0,160(sp)
	mv	s0,a0
	mv	a0,sp
	sd	ra,168(sp)
	call	ge_scalarmult_base
	mv	a1,sp
	mv	a0,s0
	call	ge_p3_tobytes
	ld	ra,168(sp)
	ld	s0,160(sp)
	addi	sp,sp,176
	jr	ra
	.size	ed25519_compute_pubkey, .-ed25519_compute_pubkey
	.align	2
	.globl	ed25519_create_privkey
	.hidden	ed25519_create_privkey
	.type	ed25519_create_privkey, @function
ed25519_create_privkey:
	addi	sp,sp,-16
	sd	s0,0(sp)
	mv	s0,a0
	mv	a2,s0
	mv	a0,a1
	li	a1,32
	sd	ra,8(sp)
	call	sha512
	lbu	a5,31(s0)
	lbu	a4,0(s0)
	andi	a5,a5,63
	andi	a4,a4,-8
	ori	a5,a5,64
	sb	a4,0(s0)
	sb	a5,31(s0)
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	ed25519_create_privkey, .-ed25519_create_privkey
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
