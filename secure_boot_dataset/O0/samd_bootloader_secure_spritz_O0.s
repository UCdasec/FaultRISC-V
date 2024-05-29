	.file	"spritz.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	spritz_initialize_state
	.type	spritz_initialize_state, @function
spritz_initialize_state:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	sb	zero,256(a5)
	ld	a5,-40(s0)
	sb	zero,257(a5)
	ld	a5,-40(s0)
	sb	zero,258(a5)
	ld	a5,-40(s0)
	sb	zero,259(a5)
	ld	a5,-40(s0)
	sb	zero,260(a5)
	ld	a5,-40(s0)
	li	a4,1
	sb	a4,261(a5)
	sw	zero,-20(s0)
	j	.L2
.L3:
	lw	a5,-20(s0)
	andi	a4,a5,0xff
	ld	a3,-40(s0)
	lw	a5,-20(s0)
	add	a5,a3,a5
	sb	a4,0(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L2:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,255
	ble	a4,a5,.L3
	nop
	nop
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	spritz_initialize_state, .-spritz_initialize_state
	.align	1
	.globl	spritz_absorb
	.type	spritz_absorb, @function
spritz_absorb:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	mv	a5,a2
	sw	a5,-52(s0)
	sw	zero,-20(s0)
	j	.L5
.L6:
	lwu	a5,-20(s0)
	ld	a4,-48(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	sext.w	a5,a5
	mv	a1,a5
	ld	a0,-40(s0)
	call	spritz_absorb_byte
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L5:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-52(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bltu	a4,a5,.L6
	nop
	nop
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	spritz_absorb, .-spritz_absorb
	.align	1
	.globl	spritz_absorb_byte
	.type	spritz_absorb_byte, @function
spritz_absorb_byte:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	mv	a5,a1
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	andi	a5,a5,15
	sext.w	a5,a5
	mv	a1,a5
	ld	a0,-24(s0)
	call	spritz_absorb_nibble
	lw	a5,-28(s0)
	sraiw	a5,a5,4
	sext.w	a5,a5
	mv	a1,a5
	ld	a0,-24(s0)
	call	spritz_absorb_nibble
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	spritz_absorb_byte, .-spritz_absorb_byte
	.align	1
	.globl	spritz_absorb_nibble
	.type	spritz_absorb_nibble, @function
spritz_absorb_nibble:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	sw	a5,-44(s0)
	ld	a5,-40(s0)
	lbu	a5,260(a5)
	mv	a4,a5
	li	a5,128
	bne	a4,a5,.L9
	ld	a0,-40(s0)
	call	spritz_shuffle
.L9:
	ld	a5,-40(s0)
	lbu	a5,260(a5)
	sext.w	a5,a5
	ld	a4,-40(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	sw	a5,-20(s0)
	lw	a5,-44(s0)
	addiw	a5,a5,128
	sext.w	a4,a5
	ld	a5,-40(s0)
	lbu	a5,260(a5)
	sext.w	a5,a5
	ld	a3,-40(s0)
	add	a4,a3,a4
	lbu	a4,0(a4)
	ld	a3,-40(s0)
	add	a5,a3,a5
	sb	a4,0(a5)
	lw	a5,-44(s0)
	addiw	a5,a5,128
	sext.w	a5,a5
	lw	a4,-20(s0)
	andi	a4,a4,0xff
	ld	a3,-40(s0)
	add	a5,a3,a5
	sb	a4,0(a5)
	ld	a5,-40(s0)
	lbu	a5,260(a5)
	addiw	a5,a5,1
	andi	a4,a5,0xff
	ld	a5,-40(s0)
	sb	a4,260(a5)
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	spritz_absorb_nibble, .-spritz_absorb_nibble
	.align	1
	.globl	spritz_absorb_stop
	.type	spritz_absorb_stop, @function
spritz_absorb_stop:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	lbu	a5,260(a5)
	mv	a4,a5
	li	a5,128
	bne	a4,a5,.L11
	ld	a0,-24(s0)
	call	spritz_shuffle
.L11:
	ld	a5,-24(s0)
	lbu	a5,260(a5)
	addiw	a5,a5,1
	andi	a4,a5,0xff
	ld	a5,-24(s0)
	sb	a4,260(a5)
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	spritz_absorb_stop, .-spritz_absorb_stop
	.align	1
	.globl	spritz_shuffle
	.type	spritz_shuffle, @function
spritz_shuffle:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	ld	a0,-24(s0)
	call	spritz_whip
	ld	a0,-24(s0)
	call	spritz_crush
	ld	a0,-24(s0)
	call	spritz_whip
	ld	a0,-24(s0)
	call	spritz_crush
	ld	a0,-24(s0)
	call	spritz_whip
	ld	a5,-24(s0)
	sb	zero,260(a5)
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	spritz_shuffle, .-spritz_shuffle
	.align	1
	.globl	spritz_whip
	.type	spritz_whip, @function
spritz_whip:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sw	zero,-20(s0)
	j	.L14
.L15:
	ld	a0,-40(s0)
	call	spritz_update
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L14:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,511
	ble	a4,a5,.L15
	ld	a5,-40(s0)
	lbu	a5,261(a5)
	addiw	a5,a5,2
	andi	a4,a5,0xff
	ld	a5,-40(s0)
	sb	a4,261(a5)
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	spritz_whip, .-spritz_whip
	.align	1
	.globl	spritz_crush
	.type	spritz_crush, @function
spritz_crush:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sw	zero,-20(s0)
	j	.L17
.L19:
	li	a5,255
	lw	a4,-20(s0)
	subw	a5,a5,a4
	sw	a5,-24(s0)
	ld	a4,-40(s0)
	lw	a5,-20(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	sw	a5,-28(s0)
	ld	a4,-40(s0)
	lw	a5,-24(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	sw	a5,-32(s0)
	lw	a5,-28(s0)
	mv	a4,a5
	lw	a5,-32(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	ble	a4,a5,.L18
	lw	a5,-32(s0)
	andi	a4,a5,0xff
	ld	a3,-40(s0)
	lw	a5,-20(s0)
	add	a5,a3,a5
	sb	a4,0(a5)
	lw	a5,-28(s0)
	andi	a4,a5,0xff
	ld	a3,-40(s0)
	lw	a5,-24(s0)
	add	a5,a3,a5
	sb	a4,0(a5)
.L18:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L17:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,127
	ble	a4,a5,.L19
	nop
	nop
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	spritz_crush, .-spritz_crush
	.align	1
	.globl	spritz_squeeze
	.type	spritz_squeeze, @function
spritz_squeeze:
	addi	sp,sp,-80
	sd	ra,72(sp)
	sd	s0,64(sp)
	sd	s1,56(sp)
	addi	s0,sp,80
	sd	a0,-56(s0)
	sd	a1,-64(s0)
	mv	a5,a2
	sw	a5,-68(s0)
	ld	a5,-56(s0)
	lbu	a5,260(a5)
	beq	a5,zero,.L21
	ld	a0,-56(s0)
	call	spritz_shuffle
.L21:
	sw	zero,-36(s0)
	j	.L22
.L23:
	lwu	a5,-36(s0)
	ld	a4,-64(s0)
	add	s1,a4,a5
	ld	a0,-56(s0)
	call	spritz_drip
	mv	a5,a0
	sb	a5,0(s1)
	lw	a5,-36(s0)
	addiw	a5,a5,1
	sw	a5,-36(s0)
.L22:
	lw	a5,-36(s0)
	mv	a4,a5
	lw	a5,-68(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bltu	a4,a5,.L23
	nop
	nop
	ld	ra,72(sp)
	ld	s0,64(sp)
	ld	s1,56(sp)
	addi	sp,sp,80
	jr	ra
	.size	spritz_squeeze, .-spritz_squeeze
	.align	1
	.globl	spritz_drip
	.type	spritz_drip, @function
spritz_drip:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	lbu	a5,260(a5)
	beq	a5,zero,.L25
	ld	a0,-24(s0)
	call	spritz_shuffle
.L25:
	ld	a0,-24(s0)
	call	spritz_update
	ld	a0,-24(s0)
	call	spritz_output
	mv	a5,a0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	spritz_drip, .-spritz_drip
	.align	1
	.globl	spritz_update
	.type	spritz_update, @function
spritz_update:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	lbu	a4,256(a5)
	ld	a5,-40(s0)
	lbu	a5,261(a5)
	addw	a5,a4,a5
	andi	a4,a5,0xff
	ld	a5,-40(s0)
	sb	a4,256(a5)
	ld	a5,-40(s0)
	lbu	a4,257(a5)
	ld	a5,-40(s0)
	lbu	a5,256(a5)
	sext.w	a5,a5
	ld	a3,-40(s0)
	add	a5,a3,a5
	lbu	a5,0(a5)
	addw	a5,a4,a5
	sb	a5,-17(s0)
	ld	a5,-40(s0)
	lbu	a4,258(a5)
	lbu	a5,-17(s0)
	sext.w	a5,a5
	ld	a3,-40(s0)
	add	a5,a3,a5
	lbu	a5,0(a5)
	addw	a5,a4,a5
	andi	a4,a5,0xff
	ld	a5,-40(s0)
	sb	a4,257(a5)
	ld	a5,-40(s0)
	lbu	a4,256(a5)
	ld	a5,-40(s0)
	lbu	a5,258(a5)
	addw	a5,a4,a5
	andi	a4,a5,0xff
	ld	a5,-40(s0)
	lbu	a5,257(a5)
	sext.w	a5,a5
	ld	a3,-40(s0)
	add	a5,a3,a5
	lbu	a5,0(a5)
	addw	a5,a4,a5
	andi	a4,a5,0xff
	ld	a5,-40(s0)
	sb	a4,258(a5)
	ld	a5,-40(s0)
	lbu	a5,256(a5)
	sext.w	a5,a5
	ld	a4,-40(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	sb	a5,-17(s0)
	ld	a5,-40(s0)
	lbu	a5,257(a5)
	sext.w	a4,a5
	ld	a5,-40(s0)
	lbu	a5,256(a5)
	sext.w	a5,a5
	ld	a3,-40(s0)
	add	a4,a3,a4
	lbu	a4,0(a4)
	ld	a3,-40(s0)
	add	a5,a3,a5
	sb	a4,0(a5)
	ld	a5,-40(s0)
	lbu	a5,257(a5)
	sext.w	a5,a5
	ld	a4,-40(s0)
	add	a5,a4,a5
	lbu	a4,-17(s0)
	sb	a4,0(a5)
	nop
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	spritz_update, .-spritz_update
	.align	1
	.globl	spritz_output
	.type	spritz_output, @function
spritz_output:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	lbu	a4,259(a5)
	ld	a5,-40(s0)
	lbu	a5,258(a5)
	addw	a5,a4,a5
	sb	a5,-17(s0)
	ld	a5,-40(s0)
	lbu	a4,256(a5)
	lbu	a5,-17(s0)
	sext.w	a5,a5
	ld	a3,-40(s0)
	add	a5,a3,a5
	lbu	a5,0(a5)
	addw	a5,a4,a5
	sb	a5,-17(s0)
	ld	a5,-40(s0)
	lbu	a4,257(a5)
	lbu	a5,-17(s0)
	sext.w	a5,a5
	ld	a3,-40(s0)
	add	a5,a3,a5
	lbu	a5,0(a5)
	addw	a5,a4,a5
	sb	a5,-17(s0)
	lbu	a5,-17(s0)
	sext.w	a5,a5
	ld	a4,-40(s0)
	add	a5,a4,a5
	lbu	a4,0(a5)
	ld	a5,-40(s0)
	sb	a4,259(a5)
	ld	a5,-40(s0)
	lbu	a5,259(a5)
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	spritz_output, .-spritz_output
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
