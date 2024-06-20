	.file	"main.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	message_handle
	.type	message_handle, @function
message_handle:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	sd	s1,8(sp)
	mv	s1,a1
	mv	s0,a2
	li	a5,78
	beq	a0,a5,.L2
	bgtu	a0,a5,.L3
	li	a5,68
	beq	a0,a5,.L4
	li	a5,77
	bne	a0,a5,.L16
	li	a5,2
	li	a0,1
	beq	a2,a5,.L17
.L6:
	ld	ra,24(sp)
	ld	s0,16(sp)
	ld	s1,8(sp)
	addi	sp,sp,32
	jr	ra
.L16:
	li	a0,1
	j	.L6
.L3:
	li	a5,88
	bne	a0,a5,.L18
	li	a0,1
	bne	a2,zero,.L6
 #APP
# 120 "main.c" 1
	reset
# 0 "" 2
 #NO_APP
	li	a0,0
	j	.L6
.L18:
	li	a0,1
	j	.L6
.L17:
	li	a2,2
	li	a0,4096
	addi	a0,a0,-2
	call	write_flash
	li	a0,0
	j	.L6
.L2:
	li	a5,64
	li	a0,1
	bne	a2,a5,.L6
	li	a2,64
	li	a0,4096
	addi	a0,a0,-66
	call	write_flash
	li	a0,0
	j	.L6
.L4:
	li	a5,3
	li	a0,1
	bleu	a2,a5,.L6
	lbu	a5,1(a1)
	slliw	a5,a5,8
	lbu	a4,2(a1)
	or	a5,a5,a4
	slli	a5,a5,48
	srli	a5,a5,48
	addi	a2,a2,-3
	add	a3,a5,a2
	li	a4,4096
	addi	a4,a4,-67
	li	a0,2
	bgtu	a3,a4,.L6
	bne	a5,zero,.L8
	li	a2,4
	addi	a1,a1,3
	li	a0,4
	call	write_flash
	li	a5,11
	li	a0,0
	bleu	s0,a5,.L6
	addi	a2,s0,-11
	addi	a1,s1,11
	li	a0,8
	call	write_flash
	li	a0,0
	j	.L6
.L8:
	addi	a1,a1,3
	mv	a0,a5
	call	write_flash
	li	a0,0
	j	.L6
	.size	message_handle, .-message_handle
	.align	1
	.globl	fw_receive
	.type	fw_receive, @function
fw_receive:
	addi	sp,sp,-144
	sd	ra,136(sp)
	sd	s0,128(sp)
	sd	s1,120(sp)
	sd	s2,112(sp)
	sd	s3,104(sp)
	sd	s4,96(sp)
	sd	s5,88(sp)
	li	s1,0
	li	s0,0
	li	s2,92
	li	s4,70
	li	s3,64
	li	s5,10
	j	.L20
.L35:
	li	s1,0
	li	s0,0
	j	.L20
.L36:
	beq	s1,zero,.L34
	addi	a5,s0,80
	add	a5,a5,sp
	sb	s2,-72(a5)
.L29:
	addi	s0,s0,1
	li	s1,0
	beq	s0,s4,.L35
.L20:
	li	a2,1
	li	a1,0
	addi	a0,sp,7
	call	uart_get_byte
	lbu	a5,7(sp)
	beq	a5,s2,.L36
	addi	a4,s0,80
	add	a4,a4,sp
	sb	a5,-72(a4)
	bne	s1,zero,.L29
	beq	a5,s3,.L37
	beq	a5,s5,.L38
.L27:
	addi	s0,s0,1
	bne	s0,s4,.L20
	li	s0,0
	j	.L20
.L34:
	li	s1,1
	j	.L20
.L37:
	bne	s0,zero,.L39
	addi	s0,s0,1
	j	.L20
.L39:
	sb	s3,8(sp)
	li	s0,1
	j	.L20
.L38:
	lbu	a5,8(sp)
	bne	a5,s3,.L27
	li	a5,1
	bleu	s0,a5,.L28
	addi	a2,s0,-2
	addi	a1,sp,10
	lbu	a0,9(sp)
	call	message_handle
	bne	a0,zero,.L32
.L28:
	mv	a0,s4
	call	uart_write_byte
	li	s0,0
	j	.L20
.L32:
	ld	ra,136(sp)
	ld	s0,128(sp)
	ld	s1,120(sp)
	ld	s2,112(sp)
	ld	s3,104(sp)
	ld	s4,96(sp)
	ld	s5,88(sp)
	addi	sp,sp,144
	jr	ra
	.size	fw_receive, .-fw_receive
	.align	1
	.globl	signature_valid
	.type	signature_valid, @function
signature_valid:
	addi	sp,sp,-368
	sd	ra,360(sp)
	sd	s0,352(sp)
	sd	s1,344(sp)
	sd	s3,328(sp)
	call	uECC_secp256k1
	mv	s3,a0
	addi	a0,sp,104
	call	sha256_init
	li	a2,2
	addi	a1,sp,312
	li	a0,4096
	addi	a0,a0,-2
	call	read_flash
	lbu	s1,312(sp)
	slliw	s1,s1,8
	lbu	a5,313(sp)
	or	s1,s1,a5
	slli	s1,s1,48
	srli	s1,s1,48
	li	a2,64
	addi	a1,sp,8
	li	a0,0
	call	read_flash
	addiw	s0,s1,-64
	slli	s0,s0,48
	srli	s0,s0,48
	lbu	a5,12(sp)
	sb	a5,8(sp)
	lbu	a5,13(sp)
	sb	a5,9(sp)
	lbu	a5,14(sp)
	sb	a5,10(sp)
	lbu	a5,15(sp)
	sb	a5,11(sp)
	li	a5,-1
	sw	a5,12(sp)
	li	a2,64
	addi	a1,sp,8
	addi	a0,sp,104
	call	sha256_update
	sext.w	a4,s0
	li	a5,63
	bleu	a4,a5,.L44
	sd	s2,336(sp)
	li	s0,64
	li	s2,63
.L42:
	li	a2,64
	addi	a1,sp,8
	mv	a0,s0
	call	read_flash
	addiw	s0,s0,64
	slli	s0,s0,48
	srli	s0,s0,48
	li	a2,64
	addi	a1,sp,8
	addi	a0,sp,104
	call	sha256_update
	subw	a5,s1,s0
	slli	a5,a5,48
	srli	a5,a5,48
	bgtu	a5,s2,.L42
	addiw	s1,s1,-128
	slli	a5,s1,48
	srli	a5,a5,48
	andi	s0,s1,63
	andi	a5,a5,-64
	addiw	a5,a5,128
	slli	a0,a5,48
	srli	a0,a0,48
	ld	s2,336(sp)
.L41:
	bne	s0,zero,.L47
.L43:
	addi	a1,sp,72
	addi	a0,sp,104
	call	sha256_final
	li	a2,64
	addi	a1,sp,248
	li	a0,4096
	addi	a0,a0,-66
	call	read_flash
	mv	a4,s3
	addi	a3,sp,248
	li	a2,32
	addi	a1,sp,72
	lui	a0,%hi(.LANCHOR0)
	addi	a0,a0,%lo(.LANCHOR0)
	call	uECC_verify
	ld	ra,360(sp)
	ld	s0,352(sp)
	ld	s1,344(sp)
	ld	s3,328(sp)
	addi	sp,sp,368
	jr	ra
.L44:
	li	a0,64
	j	.L41
.L47:
	mv	a2,s0
	addi	a1,sp,8
	call	read_flash
	mv	a2,s0
	addi	a1,sp,8
	addi	a0,sp,104
	call	sha256_update
	j	.L43
	.size	signature_valid, .-signature_valid
	.section	.rodata.str1.8,"aMS",@progbits,1
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
	addi	sp,sp,-16
	sd	ra,8(sp)
	call	mcu_init
	call	uart_init
	li	a2,61440
	addi	a2,a2,-1440
	li	a1,5
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	uart_expect_msg
	bne	a0,zero,.L53
.L49:
	li	a0,4096
	call	erase_flash
	li	a1,4
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	uart_send_buf
	call	fw_receive
	bne	a0,zero,.L54
.L51:
 #APP
# 298 "main.c" 1
	reset
# 0 "" 2
 #NO_APP
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
.L53:
	call	signature_valid
	beq	a0,zero,.L50
	li	a0,83
	call	uart_write_byte
 #APP
# 282 "main.c" 1
	goto 4
# 0 "" 2
 #NO_APP
	j	.L49
.L50:
	li	a0,75
	call	uart_write_byte
 #APP
# 285 "main.c" 1
	reset
# 0 "" 2
 #NO_APP
	j	.L49
.L54:
	slli	a0,a0,32
	srli	a0,a0,32
	lui	a5,%hi(mcu_errs)
	addi	a5,a5,%lo(mcu_errs)
	add	a0,a0,a5
	lbu	a0,0(a0)
	call	uart_write_byte
	j	.L51
	.size	main, .-main
	.globl	ec_pub_key
	.globl	mcu_errs
	.section	.rodata
	.align	3
	.set	.LANCHOR0,. + 0
	.type	ec_pub_key, @object
	.size	ec_pub_key, 64
ec_pub_key:
	.string	"\31606|\301n\260\214_\016\260,\021O\217x\b\205\354\317\333s\310\332m\232"
	.ascii	"j3\225\242 \313\335\262\235\227\240\\\017\017Off(\322\346)>;"
	.ascii	"(rF\353\331\237\240\342\232\250\246\236\374,"
	.section	.sdata,"aw"
	.align	3
	.type	mcu_errs, @object
	.size	mcu_errs, 3
mcu_errs:
	.ascii	"FIA"
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
