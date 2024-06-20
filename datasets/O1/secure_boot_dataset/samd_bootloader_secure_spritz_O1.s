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
	sb	zero,256(a0)
	sb	zero,257(a0)
	sb	zero,258(a0)
	sb	zero,259(a0)
	sb	zero,260(a0)
	li	a5,1
	sb	a5,261(a0)
	li	a5,0
	li	a3,256
.L2:
	add	a4,a0,a5
	sb	a5,0(a4)
	addi	a5,a5,1
	bne	a5,a3,.L2
	ret
	.size	spritz_initialize_state, .-spritz_initialize_state
	.align	1
	.globl	spritz_crush
	.type	spritz_crush, @function
spritz_crush:
	addi	a5,a0,255
	addi	a2,a0,127
	j	.L6
.L5:
	addi	a0,a0,1
	addi	a5,a5,-1
	beq	a5,a2,.L8
.L6:
	lbu	a4,0(a0)
	lbu	a3,0(a5)
	bleu	a4,a3,.L5
	sb	a3,0(a0)
	sb	a4,0(a5)
	j	.L5
.L8:
	ret
	.size	spritz_crush, .-spritz_crush
	.align	1
	.globl	spritz_update
	.type	spritz_update, @function
spritz_update:
	lbu	a5,256(a0)
	lbu	a4,261(a0)
	addw	a5,a5,a4
	andi	a5,a5,0xff
	sb	a5,256(a0)
	add	a2,a0,a5
	lbu	a3,0(a2)
	lbu	a6,258(a0)
	lbu	a4,257(a0)
	addw	a4,a4,a3
	andi	a4,a4,0xff
	add	a4,a0,a4
	lbu	a4,0(a4)
	addw	a4,a4,a6
	andi	a4,a4,0xff
	sb	a4,257(a0)
	add	a4,a0,a4
	lbu	a1,0(a4)
	addw	a5,a5,a6
	addw	a5,a5,a1
	sb	a5,258(a0)
	sb	a1,0(a2)
	sb	a3,0(a4)
	ret
	.size	spritz_update, .-spritz_update
	.align	1
	.globl	spritz_whip
	.type	spritz_whip, @function
spritz_whip:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	sd	s1,8(sp)
	mv	s1,a0
	li	s0,512
.L11:
	mv	a0,s1
	call	spritz_update
	addiw	s0,s0,-1
	bne	s0,zero,.L11
	lbu	a5,261(s1)
	addiw	a5,a5,2
	sb	a5,261(s1)
	ld	ra,24(sp)
	ld	s0,16(sp)
	ld	s1,8(sp)
	addi	sp,sp,32
	jr	ra
	.size	spritz_whip, .-spritz_whip
	.align	1
	.globl	spritz_shuffle
	.type	spritz_shuffle, @function
spritz_shuffle:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	mv	s0,a0
	call	spritz_whip
	mv	a0,s0
	call	spritz_crush
	mv	a0,s0
	call	spritz_whip
	mv	a0,s0
	call	spritz_crush
	mv	a0,s0
	call	spritz_whip
	sb	zero,260(s0)
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	spritz_shuffle, .-spritz_shuffle
	.align	1
	.globl	spritz_absorb_nibble
	.type	spritz_absorb_nibble, @function
spritz_absorb_nibble:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	sd	s1,8(sp)
	mv	s1,a0
	mv	s0,a1
	lbu	a4,260(a0)
	li	a5,128
	beq	a4,a5,.L19
.L17:
	lbu	a5,260(s1)
	add	a4,s1,a5
	lbu	a3,0(a4)
	addiw	a1,s0,128
	add	a1,s1,a1
	lbu	a2,0(a1)
	sb	a2,0(a4)
	sb	a3,0(a1)
	addiw	a5,a5,1
	sb	a5,260(s1)
	ld	ra,24(sp)
	ld	s0,16(sp)
	ld	s1,8(sp)
	addi	sp,sp,32
	jr	ra
.L19:
	call	spritz_shuffle
	j	.L17
	.size	spritz_absorb_nibble, .-spritz_absorb_nibble
	.align	1
	.globl	spritz_absorb_byte
	.type	spritz_absorb_byte, @function
spritz_absorb_byte:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	sd	s1,8(sp)
	mv	s1,a0
	mv	s0,a1
	andi	a1,a1,15
	call	spritz_absorb_nibble
	sraiw	a1,s0,4
	mv	a0,s1
	call	spritz_absorb_nibble
	ld	ra,24(sp)
	ld	s0,16(sp)
	ld	s1,8(sp)
	addi	sp,sp,32
	jr	ra
	.size	spritz_absorb_byte, .-spritz_absorb_byte
	.align	1
	.globl	spritz_absorb
	.type	spritz_absorb, @function
spritz_absorb:
	beq	a2,zero,.L27
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	sd	s1,8(sp)
	sd	s2,0(sp)
	mv	s2,a0
	mv	s0,a1
	slli	a2,a2,32
	srli	a2,a2,32
	add	s1,a1,a2
.L24:
	lbu	a1,0(s0)
	mv	a0,s2
	call	spritz_absorb_byte
	addi	s0,s0,1
	bne	s0,s1,.L24
	ld	ra,24(sp)
	ld	s0,16(sp)
	ld	s1,8(sp)
	ld	s2,0(sp)
	addi	sp,sp,32
	jr	ra
.L27:
	ret
	.size	spritz_absorb, .-spritz_absorb
	.align	1
	.globl	spritz_absorb_stop
	.type	spritz_absorb_stop, @function
spritz_absorb_stop:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	mv	s0,a0
	lbu	a4,260(a0)
	li	a5,128
	beq	a4,a5,.L33
.L31:
	lbu	a5,260(s0)
	addiw	a5,a5,1
	sb	a5,260(s0)
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
.L33:
	call	spritz_shuffle
	j	.L31
	.size	spritz_absorb_stop, .-spritz_absorb_stop
	.align	1
	.globl	spritz_output
	.type	spritz_output, @function
spritz_output:
	mv	a5,a0
	lbu	a4,259(a0)
	lbu	a3,258(a0)
	addw	a4,a4,a3
	andi	a4,a4,0xff
	add	a4,a0,a4
	lbu	a3,0(a4)
	lbu	a4,256(a0)
	addw	a4,a4,a3
	andi	a4,a4,0xff
	add	a4,a0,a4
	lbu	a3,0(a4)
	lbu	a4,257(a0)
	addw	a4,a4,a3
	andi	a4,a4,0xff
	add	a4,a0,a4
	lbu	a0,0(a4)
	sb	a0,259(a5)
	ret
	.size	spritz_output, .-spritz_output
	.align	1
	.globl	spritz_drip
	.type	spritz_drip, @function
spritz_drip:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	mv	s0,a0
	lbu	a5,260(a0)
	bne	a5,zero,.L38
.L36:
	mv	a0,s0
	call	spritz_update
	mv	a0,s0
	call	spritz_output
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
.L38:
	call	spritz_shuffle
	j	.L36
	.size	spritz_drip, .-spritz_drip
	.align	1
	.globl	spritz_squeeze
	.type	spritz_squeeze, @function
spritz_squeeze:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s1,24(sp)
	sd	s2,16(sp)
	sd	s3,8(sp)
	mv	s2,a0
	mv	s1,a1
	mv	s3,a2
	lbu	a5,260(a0)
	bne	a5,zero,.L45
.L40:
	beq	s3,zero,.L39
	sd	s0,32(sp)
	mv	s0,s1
	slli	s3,s3,32
	srli	s3,s3,32
	add	s1,s1,s3
.L42:
	mv	a0,s2
	call	spritz_drip
	sb	a0,0(s0)
	addi	s0,s0,1
	bne	s0,s1,.L42
	ld	s0,32(sp)
.L39:
	ld	ra,40(sp)
	ld	s1,24(sp)
	ld	s2,16(sp)
	ld	s3,8(sp)
	addi	sp,sp,48
	jr	ra
.L45:
	call	spritz_shuffle
	j	.L40
	.size	spritz_squeeze, .-spritz_squeeze
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
