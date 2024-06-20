	.file	"bootloader.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	bootloader
	.hidden	bootloader
	.type	bootloader, @function
bootloader:
	addi	sp,sp,-688
	sd	s0,672(sp)
	lla	s0,boot_image_header
	ld	a2,0(s0)
	li	a0,1
	li	a1,131072
	addi	a2,a2,136
	slli	a0,a0,31
	sd	ra,680(sp)
	call	sha512
	li	a5,16777216
	ld	a1,0(a5)
	ld	a2,8(a5)
	ld	a3,16(a5)
	ld	a5,24(a5)
	li	a4,16777216
	sd	a1,0(sp)
	sd	a5,24(sp)
	sd	a2,8(sp)
	sd	a3,16(sp)
	li	a5,16777216
	addi	a4,a4,32
.L2:
	sb	zero,0(a5)
	addi	a5,a5,1
	bne	a5,a4,.L2
	addi	a0,sp,256
	call	sha512_init
	li	a2,32
	mv	a1,sp
	addi	a0,sp,256
	call	sha512_update
	ld	a1,0(s0)
	li	a2,64
	addi	a0,sp,256
	addi	a1,a1,136
	call	sha512_update
	addi	a1,sp,64
	addi	a0,sp,256
	call	sha512_final
	addi	a5,sp,64
	addi	a4,sp,32
	addi	a2,sp,96
.L3:
	ld	a3,0(a5)
	addi	a5,a5,8
	addi	a4,a4,8
	sd	a3,-8(a4)
	bne	a5,a2,.L3
	addi	a0,sp,128
	mv	a1,sp
	call	ed25519_create_privkey
	ld	a0,0(s0)
	lw	a5,32(a0)
	beq	a5,zero,.L10
	addi	a0,a0,232
	addi	a1,sp,32
	call	ed25519_create_privkey
	ld	a0,0(s0)
	lw	a5,132(a0)
	beq	a5,zero,.L11
.L5:
	addi	a0,sp,464
	call	sha512_init
	ld	a1,0(s0)
	li	a2,32
	addi	a0,sp,464
	addi	a1,a1,200
	call	sha512_update
	ld	a1,0(s0)
	li	a2,64
	addi	a0,sp,464
	addi	a1,a1,136
	call	sha512_update
	addi	a1,sp,192
	addi	a0,sp,464
	call	sha512_final
	ld	a0,0(s0)
	addi	a4,sp,128
	addi	a1,sp,192
	addi	a3,a0,36
	li	a2,64
	addi	a0,a0,296
	call	ed25519_sign
	ld	ra,680(sp)
	ld	s0,672(sp)
	addi	sp,sp,688
	jr	ra
.L10:
	addi	a1,sp,128
	addi	a0,a0,36
	call	ed25519_compute_pubkey
	ld	a0,0(s0)
	li	a5,1
	addi	a1,sp,32
	sw	a5,32(a0)
	addi	a0,a0,232
	call	ed25519_create_privkey
	ld	a0,0(s0)
	lw	a5,132(a0)
	bne	a5,zero,.L5
.L11:
	addi	a1,a0,232
	addi	a0,a0,200
	call	ed25519_compute_pubkey
	ld	a5,0(s0)
	li	a4,1
	sw	a4,132(a5)
	j	.L5
	.size	bootloader, .-bootloader
	.hidden	boot_image_header
	.globl	boot_image_header
	.section	.sdata,"aw"
	.align	3
	.type	boot_image_header, @object
	.size	boot_image_header, 8
boot_image_header:
	.dword	2147680256
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
