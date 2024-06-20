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
	li	a5,1
	sb	a5,261(a0)
	sb	zero,256(a0)
	sb	zero,257(a0)
	sb	zero,258(a0)
	sb	zero,259(a0)
	sb	zero,260(a0)
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
	.globl	spritz_whip
	.type	spritz_whip, @function
spritz_whip:
	lbu	a4,256(a0)
	lbu	t4,261(a0)
	lbu	a5,257(a0)
	lbu	a6,258(a0)
	li	t3,512
.L6:
	addw	a4,a4,t4
	andi	a2,a4,0xff
	add	a2,a0,a2
	lbu	a7,0(a2)
	andi	a4,a4,0xff
	addw	a1,a6,a4
	addw	a5,a7,a5
	andi	a5,a5,0xff
	add	a5,a0,a5
	lbu	a5,0(a5)
	addiw	t3,t3,-1
	addw	a5,a5,a6
	andi	a3,a5,0xff
	add	a3,a0,a3
	lbu	t1,0(a3)
	andi	a5,a5,0xff
	sb	t1,0(a2)
	addw	a1,a1,t1
	sb	a7,0(a3)
	andi	a6,a1,0xff
	bne	t3,zero,.L6
	sb	a5,257(a0)
	sb	a6,258(a0)
	sb	t1,0(a2)
	sb	a7,0(a3)
	addiw	t4,t4,2
	sb	t4,261(a0)
	ret
	.size	spritz_whip, .-spritz_whip
	.align	1
	.globl	spritz_shuffle
	.type	spritz_shuffle, @function
spritz_shuffle:
	addi	sp,sp,-48
	sd	s3,8(sp)
	mv	s3,a0
	sd	s0,32(sp)
	sd	s1,24(sp)
	sd	s2,16(sp)
	sd	ra,40(sp)
	addi	s0,s3,255
	call	spritz_whip
	mv	s1,s3
	addi	s2,s3,127
	mv	a5,s0
	mv	a4,s3
.L10:
	lbu	a3,0(a4)
	lbu	a2,0(a5)
	bleu	a3,a2,.L9
	sb	a2,0(a4)
	sb	a3,0(a5)
.L9:
	addi	a5,a5,-1
	addi	a4,a4,1
	bne	a5,s2,.L10
	mv	a0,s3
	call	spritz_whip
.L12:
	lbu	a5,0(s1)
	lbu	a4,0(s0)
	bleu	a5,a4,.L11
	sb	a4,0(s1)
	sb	a5,0(s0)
.L11:
	addi	s0,s0,-1
	addi	s1,s1,1
	bne	s0,s2,.L12
	mv	a0,s3
	call	spritz_whip
	sb	zero,260(s3)
	ld	ra,40(sp)
	ld	s0,32(sp)
	ld	s1,24(sp)
	ld	s2,16(sp)
	ld	s3,8(sp)
	addi	sp,sp,48
	jr	ra
	.size	spritz_shuffle, .-spritz_shuffle
	.align	1
	.globl	spritz_absorb_nibble
	.type	spritz_absorb_nibble, @function
spritz_absorb_nibble:
	lbu	a5,260(a0)
	addi	sp,sp,-32
	sd	s1,16(sp)
	sd	ra,24(sp)
	li	a4,128
	mv	s1,a0
	beq	a5,a4,.L19
.L17:
	addiw	a1,a1,128
	add	a1,s1,a1
	lbu	a2,0(a1)
	add	a4,s1,a5
	lbu	a3,0(a4)
	sb	a2,0(a4)
	addiw	a5,a5,1
	sb	a3,0(a1)
	sb	a5,260(s1)
	ld	ra,24(sp)
	ld	s1,16(sp)
	addi	sp,sp,32
	jr	ra
.L19:
	sd	a1,8(sp)
	call	spritz_shuffle
	lbu	a5,260(s1)
	ld	a1,8(sp)
	j	.L17
	.size	spritz_absorb_nibble, .-spritz_absorb_nibble
	.align	1
	.globl	spritz_absorb_stop
	.type	spritz_absorb_stop, @function
spritz_absorb_stop:
	lbu	a5,260(a0)
	addi	sp,sp,-16
	sd	s0,0(sp)
	sd	ra,8(sp)
	li	a4,128
	mv	s0,a0
	beq	a5,a4,.L23
	addiw	a5,a5,1
	sb	a5,260(s0)
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
.L23:
	call	spritz_shuffle
	lbu	a5,260(s0)
	addiw	a5,a5,1
	sb	a5,260(s0)
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	spritz_absorb_stop, .-spritz_absorb_stop
	.align	1
	.globl	spritz_absorb
	.type	spritz_absorb, @function
spritz_absorb:
	beq	a2,zero,.L32
	addi	sp,sp,-64
	slli	a2,a2,32
	sd	s2,32(sp)
	sd	s3,24(sp)
	sd	s4,16(sp)
	sd	s5,8(sp)
	sd	ra,56(sp)
	sd	s0,48(sp)
	sd	s1,40(sp)
	srli	a2,a2,32
	lbu	a5,260(a0)
	mv	s2,a0
	mv	s3,a1
	add	s5,a1,a2
	li	s4,128
	j	.L28
.L27:
	addiw	a4,s0,128
	add	a4,s2,a4
	lbu	a1,0(a4)
	add	a3,s2,a5
	lbu	a2,0(a3)
	addiw	a5,a5,1
	sb	a1,0(a3)
	sb	a2,0(a4)
	andi	a5,a5,0xff
	sb	a5,260(s2)
	addi	s3,s3,1
	beq	s5,s3,.L35
.L28:
	lbu	a4,0(s3)
	sext.w	s0,a4
	andi	s1,a4,15
	beq	a5,s4,.L36
.L26:
	ori	a4,s1,128
	add	a4,s2,a4
	lbu	a1,0(a4)
	add	a3,s2,a5
	lbu	a2,0(a3)
	addiw	a5,a5,1
	sb	a1,0(a3)
	sb	a2,0(a4)
	andi	a5,a5,0xff
	sb	a5,260(s2)
	sraiw	s0,s0,4
	bne	a5,s4,.L27
	mv	a0,s2
	call	spritz_shuffle
	lbu	a5,260(s2)
	j	.L27
.L36:
	mv	a0,s2
	call	spritz_shuffle
	lbu	a5,260(s2)
	j	.L26
.L35:
	ld	ra,56(sp)
	ld	s0,48(sp)
	ld	s1,40(sp)
	ld	s2,32(sp)
	ld	s3,24(sp)
	ld	s4,16(sp)
	ld	s5,8(sp)
	addi	sp,sp,64
	jr	ra
.L32:
	ret
	.size	spritz_absorb, .-spritz_absorb
	.align	1
	.globl	spritz_absorb_byte
	.type	spritz_absorb_byte, @function
spritz_absorb_byte:
	addi	sp,sp,-32
	sd	s0,16(sp)
	sd	s1,8(sp)
	sd	s2,0(sp)
	sd	ra,24(sp)
	lbu	a5,260(a0)
	li	a4,128
	mv	s1,a0
	mv	s0,a1
	andi	s2,a1,15
	beq	a5,a4,.L41
.L38:
	addi	a4,s2,128
	add	a4,s1,a4
	lbu	a1,0(a4)
	add	a3,s1,a5
	lbu	a2,0(a3)
	addiw	a5,a5,1
	sb	a1,0(a3)
	sb	a2,0(a4)
	andi	a5,a5,0xff
	sb	a5,260(s1)
	li	a4,128
	sraiw	s0,s0,4
	beq	a5,a4,.L42
.L39:
	addiw	s0,s0,128
	add	s0,s1,s0
	lbu	a2,0(s0)
	add	a4,s1,a5
	lbu	a3,0(a4)
	sb	a2,0(a4)
	addiw	a5,a5,1
	sb	a3,0(s0)
	sb	a5,260(s1)
	ld	ra,24(sp)
	ld	s0,16(sp)
	ld	s1,8(sp)
	ld	s2,0(sp)
	addi	sp,sp,32
	jr	ra
.L41:
	call	spritz_shuffle
	lbu	a5,260(s1)
	j	.L38
.L42:
	mv	a0,s1
	call	spritz_shuffle
	lbu	a5,260(s1)
	j	.L39
	.size	spritz_absorb_byte, .-spritz_absorb_byte
	.align	1
	.globl	spritz_crush
	.type	spritz_crush, @function
spritz_crush:
	addi	a5,a0,255
	addi	a2,a0,127
.L45:
	lbu	a4,0(a0)
	lbu	a3,0(a5)
	bleu	a4,a3,.L44
	sb	a3,0(a0)
	sb	a4,0(a5)
.L44:
	addi	a5,a5,-1
	addi	a0,a0,1
	bne	a5,a2,.L45
	ret
	.size	spritz_crush, .-spritz_crush
	.align	1
	.globl	spritz_squeeze
	.type	spritz_squeeze, @function
spritz_squeeze:
	addi	sp,sp,-32
	sd	s0,16(sp)
	sd	s1,8(sp)
	sd	s2,0(sp)
	sd	ra,24(sp)
	lbu	a5,260(a0)
	mv	s0,a0
	mv	s1,a1
	mv	s2,a2
	bne	a5,zero,.L63
.L48:
	beq	s2,zero,.L47
	slli	s2,s2,32
	srli	s2,s2,32
	add	s2,s1,s2
	j	.L51
.L50:
	lbu	a5,256(s0)
	lbu	a2,261(s0)
	lbu	a4,257(s0)
	lbu	a3,258(s0)
	addw	a5,a5,a2
	andi	a5,a5,0xff
	sb	a5,256(s0)
	add	a0,s0,a5
	lbu	a1,0(a0)
	addw	a2,a5,a3
	addi	s1,s1,1
	addw	a4,a4,a1
	andi	a4,a4,0xff
	add	a4,s0,a4
	lbu	a4,0(a4)
	addw	a4,a4,a3
	andi	a4,a4,0xff
	sb	a4,257(s0)
	add	a3,s0,a4
	lbu	a6,0(a3)
	addw	a2,a2,a6
	andi	a2,a2,0xff
	sb	a2,258(s0)
	sb	a6,0(a0)
	sb	a1,0(a3)
	lbu	a3,259(s0)
	addw	a3,a3,a2
	andi	a3,a3,0xff
	add	a3,s0,a3
	lbu	a3,0(a3)
	addw	a5,a3,a5
	andi	a5,a5,0xff
	add	a5,s0,a5
	lbu	a5,0(a5)
	addw	a5,a5,a4
	andi	a5,a5,0xff
	add	a5,s0,a5
	lbu	a5,0(a5)
	sb	a5,259(s0)
	sb	a5,-1(s1)
	beq	s2,s1,.L47
.L51:
	lbu	a5,260(s0)
	beq	a5,zero,.L50
	mv	a0,s0
	call	spritz_shuffle
	j	.L50
.L47:
	ld	ra,24(sp)
	ld	s0,16(sp)
	ld	s1,8(sp)
	ld	s2,0(sp)
	addi	sp,sp,32
	jr	ra
.L63:
	call	spritz_shuffle
	j	.L48
	.size	spritz_squeeze, .-spritz_squeeze
	.align	1
	.globl	spritz_drip
	.type	spritz_drip, @function
spritz_drip:
	addi	sp,sp,-16
	sd	s0,0(sp)
	sd	ra,8(sp)
	lbu	a5,260(a0)
	mv	s0,a0
	bne	a5,zero,.L70
.L65:
	lbu	a5,256(s0)
	lbu	a2,261(s0)
	lbu	a4,257(s0)
	lbu	a3,258(s0)
	addw	a5,a5,a2
	andi	a5,a5,0xff
	sb	a5,256(s0)
	add	a0,s0,a5
	lbu	a1,0(a0)
	addw	a2,a5,a3
	addw	a4,a4,a1
	andi	a4,a4,0xff
	add	a4,s0,a4
	lbu	a4,0(a4)
	addw	a4,a4,a3
	andi	a4,a4,0xff
	sb	a4,257(s0)
	add	a3,s0,a4
	lbu	a6,0(a3)
	addw	a2,a2,a6
	andi	a2,a2,0xff
	sb	a2,258(s0)
	sb	a6,0(a0)
	sb	a1,0(a3)
	lbu	a3,259(s0)
	addw	a3,a3,a2
	andi	a3,a3,0xff
	add	a3,s0,a3
	lbu	a3,0(a3)
	addw	a5,a3,a5
	andi	a5,a5,0xff
	add	a5,s0,a5
	lbu	a5,0(a5)
	addw	a5,a5,a4
	andi	a5,a5,0xff
	add	a5,s0,a5
	lbu	a0,0(a5)
	sb	a0,259(s0)
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
.L70:
	call	spritz_shuffle
	j	.L65
	.size	spritz_drip, .-spritz_drip
	.align	1
	.globl	spritz_update
	.type	spritz_update, @function
spritz_update:
	lbu	a5,256(a0)
	lbu	a3,261(a0)
	lbu	a4,257(a0)
	lbu	a1,258(a0)
	addw	a5,a5,a3
	andi	a5,a5,0xff
	sb	a5,256(a0)
	add	a2,a0,a5
	lbu	a3,0(a2)
	addw	a5,a5,a1
	addw	a4,a4,a3
	andi	a4,a4,0xff
	add	a4,a0,a4
	lbu	a4,0(a4)
	addw	a4,a4,a1
	andi	a4,a4,0xff
	sb	a4,257(a0)
	add	a4,a0,a4
	lbu	a1,0(a4)
	addw	a5,a5,a1
	sb	a5,258(a0)
	sb	a1,0(a2)
	sb	a3,0(a4)
	ret
	.size	spritz_update, .-spritz_update
	.align	1
	.globl	spritz_output
	.type	spritz_output, @function
spritz_output:
	lbu	a2,259(a0)
	lbu	a1,258(a0)
	lbu	a3,256(a0)
	lbu	a4,257(a0)
	addw	a2,a2,a1
	andi	a2,a2,0xff
	add	a2,a0,a2
	lbu	a2,0(a2)
	mv	a5,a0
	addw	a3,a3,a2
	andi	a3,a3,0xff
	add	a3,a0,a3
	lbu	a3,0(a3)
	addw	a4,a4,a3
	andi	a4,a4,0xff
	add	a4,a0,a4
	lbu	a0,0(a4)
	sb	a0,259(a5)
	ret
	.size	spritz_output, .-spritz_output
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
