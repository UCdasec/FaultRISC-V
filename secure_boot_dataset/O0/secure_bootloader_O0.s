	.file	"bootloader.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.type	hash, @function
hash:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	sd	a2,-40(s0)
	ld	a5,-40(s0)
	mv	a2,a5
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	sha512
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	hash, .-hash
	.align	2
	.type	hash_init, @function
hash_init:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	ld	a0,-24(s0)
	call	sha512_init
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	hash_init, .-hash_init
	.align	2
	.type	hash_extend, @function
hash_extend:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	sd	a2,-40(s0)
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	sha512_update
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	hash_extend, .-hash_extend
	.align	2
	.type	hash_finalize, @function
hash_finalize:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	ld	a5,-32(s0)
	mv	a1,a5
	ld	a0,-24(s0)
	call	sha512_final
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	hash_finalize, .-hash_finalize
	.align	2
	.type	create_secret_signing_key, @function
create_secret_signing_key:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	ld	a5,-32(s0)
	ld	a4,-24(s0)
	mv	a1,a4
	mv	a0,a5
	call	ed25519_create_privkey
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	create_secret_signing_key, .-create_secret_signing_key
	.align	2
	.type	compute_public_signing_key, @function
compute_public_signing_key:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	ld	a5,-32(s0)
	ld	a4,-24(s0)
	mv	a1,a4
	mv	a0,a5
	call	ed25519_compute_pubkey
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	compute_public_signing_key, .-compute_public_signing_key
	.align	2
	.type	sign, @function
sign:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	sd	a2,-40(s0)
	sd	a3,-48(s0)
	sd	a4,-56(s0)
	ld	a5,-56(s0)
	ld	a3,-40(s0)
	ld	a4,-48(s0)
	ld	a2,-32(s0)
	ld	a1,-24(s0)
	mv	a0,a5
	call	ed25519_sign
	nop
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	sign, .-sign
	.align	2
	.type	platform_read_device_secret, @function
platform_read_device_secret:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	li	a2,32
	li	a1,16777216
	ld	a0,-24(s0)
	call	memcpy
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	platform_read_device_secret, .-platform_read_device_secret
	.align	2
	.type	platform_hide_device_secret, @function
platform_hide_device_secret:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sw	zero,-20(s0)
	j	.L10
.L11:
	lwu	a4,-20(s0)
	li	a5,16777216
	add	a5,a4,a5
	sb	zero,0(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L10:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,31
	bleu	a4,a5,.L11
	nop
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	platform_hide_device_secret, .-platform_hide_device_secret
	.hidden	boot_image_header
	.globl	boot_image_header
	.section	.sdata,"aw"
	.align	3
	.type	boot_image_header, @object
	.size	boot_image_header, 8
boot_image_header:
	.dword	2147680256
	.text
	.align	2
	.globl	bootloader
	.hidden	bootloader
	.type	bootloader, @function
bootloader:
	addi	sp,sp,-704
	sd	ra,696(sp)
	sd	s0,688(sp)
	addi	s0,sp,704
	lla	a5,boot_image_header
	ld	a5,0(a5)
	addi	a5,a5,136
	mv	a2,a5
	li	a1,131072
	li	a5,1
	slli	a0,a5,31
	call	hash
	addi	a5,s0,-56
	mv	a0,a5
	call	platform_read_device_secret
	call	platform_hide_device_secret
	addi	a5,s0,-360
	mv	a0,a5
	call	hash_init
	addi	a4,s0,-56
	addi	a5,s0,-360
	li	a2,32
	mv	a1,a4
	mv	a0,a5
	call	hash_extend
	lla	a5,boot_image_header
	ld	a5,0(a5)
	addi	a4,a5,136
	addi	a5,s0,-360
	li	a2,64
	mv	a1,a4
	mv	a0,a5
	call	hash_extend
	addi	a4,s0,-152
	addi	a5,s0,-360
	mv	a1,a4
	mv	a0,a5
	call	hash_finalize
	sw	zero,-20(s0)
	j	.L13
.L14:
	lw	a5,-20(s0)
	addi	a5,a5,-16
	add	a5,a5,s0
	lbu	a4,-136(a5)
	lw	a5,-20(s0)
	addi	a5,a5,-16
	add	a5,a5,s0
	sb	a4,-72(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L13:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,31
	ble	a4,a5,.L14
	addi	a4,s0,-424
	addi	a5,s0,-56
	mv	a1,a4
	mv	a0,a5
	call	create_secret_signing_key
	lla	a5,boot_image_header
	ld	a5,0(a5)
	lw	a5,32(a5)
	bne	a5,zero,.L15
	lla	a5,boot_image_header
	ld	a5,0(a5)
	addi	a4,a5,36
	addi	a5,s0,-424
	mv	a1,a4
	mv	a0,a5
	call	compute_public_signing_key
	lla	a5,boot_image_header
	ld	a5,0(a5)
	li	a4,1
	sw	a4,32(a5)
.L15:
	lla	a5,boot_image_header
	ld	a5,0(a5)
	addi	a4,a5,232
	addi	a5,s0,-88
	mv	a1,a4
	mv	a0,a5
	call	create_secret_signing_key
	lla	a5,boot_image_header
	ld	a5,0(a5)
	lw	a5,132(a5)
	bne	a5,zero,.L16
	lla	a5,boot_image_header
	ld	a5,0(a5)
	addi	a4,a5,232
	lla	a5,boot_image_header
	ld	a5,0(a5)
	addi	a5,a5,200
	mv	a1,a5
	mv	a0,a4
	call	compute_public_signing_key
	lla	a5,boot_image_header
	ld	a5,0(a5)
	li	a4,1
	sw	a4,132(a5)
.L16:
	addi	a5,s0,-632
	mv	a0,a5
	call	hash_init
	lla	a5,boot_image_header
	ld	a5,0(a5)
	addi	a4,a5,200
	addi	a5,s0,-632
	li	a2,32
	mv	a1,a4
	mv	a0,a5
	call	hash_extend
	lla	a5,boot_image_header
	ld	a5,0(a5)
	addi	a4,a5,136
	addi	a5,s0,-632
	li	a2,64
	mv	a1,a4
	mv	a0,a5
	call	hash_extend
	addi	a4,s0,-696
	addi	a5,s0,-632
	mv	a1,a4
	mv	a0,a5
	call	hash_finalize
	lla	a5,boot_image_header
	ld	a5,0(a5)
	addi	a2,a5,36
	lla	a5,boot_image_header
	ld	a5,0(a5)
	addi	a4,a5,296
	addi	a3,s0,-424
	addi	a5,s0,-696
	li	a1,64
	mv	a0,a5
	call	sign
	nop
	ld	ra,696(sp)
	ld	s0,688(sp)
	addi	sp,sp,704
	jr	ra
	.size	bootloader, .-bootloader
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
