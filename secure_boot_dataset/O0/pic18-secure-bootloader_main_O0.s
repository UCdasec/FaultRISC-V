	.file	"main.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	mcu_errs
	.section	.sdata,"aw"
	.align	3
	.type	mcu_errs, @object
	.size	mcu_errs, 3
mcu_errs:
	.ascii	"FIA"
	.globl	ec_pub_key
	.section	.rodata
	.align	3
	.type	ec_pub_key, @object
	.size	ec_pub_key, 64
ec_pub_key:
	.string	"\31606|\301n\260\214_\016\260,\021O\217x\b\205\354\317\333s\310\332m\232"
	.ascii	"j3\225\242 \313\335\262\235\227\240\\\017\017Off(\322\346)>;"
	.ascii	"(rF\353\331\237\240\342\232\250\246\236\374,"
	.text
	.align	1
	.globl	message_handle
	.type	message_handle, @function
message_handle:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	mv	a5,a0
	sd	a1,-48(s0)
	sd	a2,-56(s0)
	sb	a5,-33(s0)
	sh	zero,-18(s0)
	lbu	a5,-33(s0)
	sext.w	a5,a5
	mv	a3,a5
	li	a4,88
	beq	a3,a4,.L2
	mv	a3,a5
	li	a4,88
	bgt	a3,a4,.L3
	mv	a3,a5
	li	a4,78
	beq	a3,a4,.L4
	mv	a3,a5
	li	a4,78
	bgt	a3,a4,.L3
	mv	a3,a5
	li	a4,68
	beq	a3,a4,.L5
	mv	a4,a5
	li	a5,77
	bne	a4,a5,.L3
	ld	a4,-56(s0)
	li	a5,2
	beq	a4,a5,.L6
	li	a5,1
	j	.L7
.L6:
	li	a2,2
	ld	a1,-48(s0)
	li	a5,4096
	addi	a0,a5,-2
	call	write_flash
	j	.L8
.L4:
	ld	a4,-56(s0)
	li	a5,64
	beq	a4,a5,.L9
	li	a5,1
	j	.L7
.L9:
	li	a2,64
	ld	a1,-48(s0)
	li	a5,4096
	addi	a0,a5,-66
	call	write_flash
	j	.L8
.L5:
	ld	a4,-56(s0)
	li	a5,3
	bgtu	a4,a5,.L10
	li	a5,1
	j	.L7
.L10:
	ld	a5,-48(s0)
	addi	a5,a5,1
	lbu	a5,0(a5)
	slliw	a5,a5,16
	sraiw	a5,a5,16
	slliw	a5,a5,8
	slliw	a4,a5,16
	sraiw	a4,a4,16
	ld	a5,-48(s0)
	addi	a5,a5,2
	lbu	a5,0(a5)
	slliw	a5,a5,16
	sraiw	a5,a5,16
	or	a5,a4,a5
	slliw	a5,a5,16
	sraiw	a5,a5,16
	sh	a5,-18(s0)
	lhu	a4,-18(s0)
	ld	a5,-56(s0)
	add	a5,a4,a5
	addi	a4,a5,-3
	li	a5,4096
	addi	a5,a5,-67
	bleu	a4,a5,.L11
	li	a5,2
	j	.L7
.L11:
	lhu	a5,-18(s0)
	sext.w	a5,a5
	bne	a5,zero,.L12
	ld	a5,-48(s0)
	addi	a5,a5,3
	li	a2,4
	mv	a1,a5
	li	a0,4
	call	write_flash
	ld	a4,-56(s0)
	li	a5,11
	bleu	a4,a5,.L15
	ld	a5,-48(s0)
	addi	a4,a5,11
	ld	a5,-56(s0)
	addi	a5,a5,-11
	mv	a2,a5
	mv	a1,a4
	li	a0,8
	call	write_flash
	j	.L15
.L12:
	ld	a5,-48(s0)
	addi	a4,a5,3
	ld	a5,-56(s0)
	addi	a3,a5,-3
	lhu	a5,-18(s0)
	mv	a2,a3
	mv	a1,a4
	mv	a0,a5
	call	write_flash
	j	.L8
.L2:
	ld	a5,-56(s0)
	beq	a5,zero,.L14
	li	a5,1
	j	.L7
.L14:
 #APP
# 120 "main.c" 1
	reset
# 0 "" 2
 #NO_APP
	j	.L8
.L3:
	li	a5,1
	j	.L7
.L15:
	nop
.L8:
	li	a5,0
.L7:
	mv	a0,a5
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	message_handle, .-message_handle
	.align	1
	.globl	fw_receive
	.type	fw_receive, @function
fw_receive:
	addi	sp,sp,-112
	sd	ra,104(sp)
	sd	s0,96(sp)
	addi	s0,sp,112
	sd	zero,-24(s0)
	sb	zero,-25(s0)
.L25:
	addi	a5,s0,-105
	li	a2,1
	li	a1,0
	mv	a0,a5
	call	uart_get_byte
	lbu	a5,-105(s0)
	mv	a4,a5
	li	a5,92
	bne	a4,a5,.L17
	lbu	a5,-25(s0)
	xori	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L17
	li	a5,1
	sb	a5,-25(s0)
	j	.L18
.L17:
	lbu	a4,-105(s0)
	ld	a5,-24(s0)
	addi	a5,a5,-16
	add	a5,a5,s0
	sb	a4,-88(a5)
	lbu	a5,-25(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L19
	sb	zero,-25(s0)
	ld	a5,-24(s0)
	addi	a5,a5,1
	sd	a5,-24(s0)
	ld	a4,-24(s0)
	li	a5,70
	bne	a4,a5,.L27
	sd	zero,-24(s0)
	j	.L27
.L19:
	lbu	a5,-105(s0)
	mv	a4,a5
	li	a5,64
	bne	a4,a5,.L21
	ld	a5,-24(s0)
	beq	a5,zero,.L21
	li	a5,1
	sd	a5,-24(s0)
	li	a5,64
	sb	a5,-104(s0)
	j	.L18
.L21:
	ld	a5,-24(s0)
	addi	a5,a5,-16
	add	a5,a5,s0
	lbu	a5,-88(a5)
	mv	a4,a5
	li	a5,10
	bne	a4,a5,.L22
	lbu	a5,-104(s0)
	mv	a4,a5
	li	a5,64
	bne	a4,a5,.L22
	ld	a4,-24(s0)
	li	a5,1
	bleu	a4,a5,.L23
	lbu	a3,-103(s0)
	addi	a5,s0,-104
	addi	a5,a5,2
	ld	a4,-24(s0)
	addi	a4,a4,-2
	mv	a2,a4
	mv	a1,a5
	mv	a0,a3
	call	message_handle
	mv	a5,a0
	sw	a5,-32(s0)
	lw	a5,-32(s0)
	sext.w	a5,a5
	beq	a5,zero,.L23
	lw	a5,-32(s0)
	j	.L26
.L23:
	sd	zero,-24(s0)
	li	a0,70
	call	uart_write_byte
	j	.L18
.L22:
	ld	a5,-24(s0)
	addi	a5,a5,1
	sd	a5,-24(s0)
	ld	a4,-24(s0)
	li	a5,70
	bne	a4,a5,.L25
	sd	zero,-24(s0)
	j	.L25
.L27:
	nop
.L18:
	j	.L25
.L26:
	mv	a0,a5
	ld	ra,104(sp)
	ld	s0,96(sp)
	addi	sp,sp,112
	jr	ra
	.size	fw_receive, .-fw_receive
	.align	1
	.globl	signature_valid
	.type	signature_valid, @function
signature_valid:
	addi	sp,sp,-352
	sd	ra,344(sp)
	sd	s0,336(sp)
	addi	s0,sp,352
	sh	zero,-18(s0)
	sh	zero,-20(s0)
	call	uECC_secp256k1
	sd	a0,-32(s0)
	addi	a5,s0,-248
	mv	a0,a5
	call	sha256_init
	addi	a5,s0,-40
	li	a2,2
	mv	a1,a5
	li	a5,4096
	addi	a0,a5,-2
	call	read_flash
	lbu	a5,-40(s0)
	slliw	a5,a5,16
	sraiw	a5,a5,16
	slliw	a5,a5,8
	slliw	a4,a5,16
	sraiw	a4,a4,16
	lbu	a5,-39(s0)
	slliw	a5,a5,16
	sraiw	a5,a5,16
	or	a5,a4,a5
	slliw	a5,a5,16
	sraiw	a5,a5,16
	sh	a5,-18(s0)
	addi	a4,s0,-344
	lhu	a5,-20(s0)
	li	a2,64
	mv	a1,a4
	mv	a0,a5
	call	read_flash
	lhu	a5,-18(s0)
	addiw	a5,a5,-64
	sh	a5,-18(s0)
	lhu	a5,-20(s0)
	addiw	a5,a5,64
	sh	a5,-20(s0)
	lbu	a5,-340(s0)
	sb	a5,-344(s0)
	lbu	a5,-339(s0)
	sb	a5,-343(s0)
	lbu	a5,-338(s0)
	sb	a5,-342(s0)
	lbu	a5,-337(s0)
	sb	a5,-341(s0)
	addi	a5,s0,-344
	addi	a5,a5,4
	li	a2,4
	li	a1,255
	mv	a0,a5
	call	memset
	addi	a4,s0,-344
	addi	a5,s0,-248
	li	a2,64
	mv	a1,a4
	mv	a0,a5
	call	sha256_update
	j	.L29
.L30:
	addi	a4,s0,-344
	lhu	a5,-20(s0)
	li	a2,64
	mv	a1,a4
	mv	a0,a5
	call	read_flash
	lhu	a5,-18(s0)
	addiw	a5,a5,-64
	sh	a5,-18(s0)
	lhu	a5,-20(s0)
	addiw	a5,a5,64
	sh	a5,-20(s0)
	addi	a4,s0,-344
	addi	a5,s0,-248
	li	a2,64
	mv	a1,a4
	mv	a0,a5
	call	sha256_update
.L29:
	lhu	a5,-18(s0)
	sext.w	a4,a5
	li	a5,63
	bgtu	a4,a5,.L30
	lhu	a5,-18(s0)
	sext.w	a5,a5
	beq	a5,zero,.L31
	lhu	a3,-18(s0)
	addi	a4,s0,-344
	lhu	a5,-20(s0)
	mv	a2,a3
	mv	a1,a4
	mv	a0,a5
	call	read_flash
	lhu	a3,-18(s0)
	addi	a4,s0,-344
	addi	a5,s0,-248
	mv	a2,a3
	mv	a1,a4
	mv	a0,a5
	call	sha256_update
.L31:
	addi	a4,s0,-280
	addi	a5,s0,-248
	mv	a1,a4
	mv	a0,a5
	call	sha256_final
	addi	a5,s0,-104
	li	a2,64
	mv	a1,a5
	li	a5,4096
	addi	a0,a5,-66
	call	read_flash
	addi	a3,s0,-104
	addi	a5,s0,-280
	ld	a4,-32(s0)
	li	a2,32
	mv	a1,a5
	lui	a5,%hi(ec_pub_key)
	addi	a0,a5,%lo(ec_pub_key)
	call	uECC_verify
	mv	a5,a0
	mv	a0,a5
	ld	ra,344(sp)
	ld	s0,336(sp)
	addi	sp,sp,352
	jr	ra
	.size	signature_valid, .-signature_valid
	.section	.rodata
	.align	3
.LC0:
	.string	"@BTL\n"
	.align	3
.LC1:
	.string	"@OK\n"
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	call	mcu_init
	call	uart_init
	li	a5,61440
	addi	a2,a5,-1440
	li	a1,5
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	uart_expect_msg
	mv	a5,a0
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	sext.w	a5,a5
	beq	a5,zero,.L34
	call	signature_valid
	mv	a5,a0
	beq	a5,zero,.L35
	li	a0,83
	call	uart_write_byte
 #APP
# 282 "main.c" 1
	goto 4
# 0 "" 2
 #NO_APP
	j	.L34
.L35:
	li	a0,75
	call	uart_write_byte
 #APP
# 285 "main.c" 1
	reset
# 0 "" 2
 #NO_APP
.L34:
	li	a0,4096
	call	erase_flash
	li	a1,4
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	uart_send_buf
	call	fw_receive
	mv	a5,a0
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	sext.w	a5,a5
	beq	a5,zero,.L36
	lui	a5,%hi(mcu_errs)
	lwu	a4,-24(s0)
	addi	a5,a5,%lo(mcu_errs)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a0,a5
	call	uart_write_byte
.L36:
 #APP
# 298 "main.c" 1
	reset
# 0 "" 2
 #NO_APP
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
