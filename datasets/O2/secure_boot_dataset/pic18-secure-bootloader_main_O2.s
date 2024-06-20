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
	sd	s0,16(sp)
	sd	ra,24(sp)
	li	a5,78
	mv	s0,a2
	beq	a0,a5,.L2
	bgtu	a0,a5,.L3
	li	a5,68
	beq	a0,a5,.L4
	li	a5,77
	bne	a0,a5,.L18
	li	a5,2
	li	a0,1
	beq	a2,a5,.L20
.L6:
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
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
	ld	ra,24(sp)
	ld	s0,16(sp)
	li	a0,1
	addi	sp,sp,32
	jr	ra
.L2:
	li	a5,64
	li	a0,1
	bne	a2,a5,.L6
	li	a0,4096
	addi	a0,a0,-66
	call	write_flash
	li	a0,0
	j	.L6
.L4:
	li	a5,3
	li	a0,1
	bleu	a2,a5,.L6
	sd	s1,8(sp)
	lbu	a5,2(a1)
	lbu	a4,1(a1)
	addi	a2,a2,-3
	slli	a5,a5,8
	or	a5,a5,a4
	srliw	a3,a5,8
	slliw	a4,a5,8
	or	a4,a4,a3
	slli	a4,a4,48
	srli	a4,a4,48
	li	a3,4096
	mv	s1,a1
	addi	a3,a3,-67
	add	a1,a4,a2
	li	a0,2
	bgtu	a1,a3,.L17
	addi	a1,s1,3
	bne	a5,zero,.L9
	li	a2,4
	li	a0,4
	call	write_flash
	li	a5,11
	bgtu	s0,a5,.L10
	ld	s1,8(sp)
	li	a0,0
	j	.L6
.L20:
	li	a0,4096
	addi	a0,a0,-2
	call	write_flash
	li	a0,0
	j	.L6
.L9:
	mv	a0,a4
	call	write_flash
	li	a0,0
	ld	s1,8(sp)
	j	.L6
.L10:
	addi	a1,s1,11
	addi	a2,s0,-11
	li	a0,8
	call	write_flash
	li	a0,0
	ld	s1,8(sp)
	j	.L6
.L17:
	ld	s1,8(sp)
	j	.L6
	.size	message_handle, .-message_handle
	.align	1
	.globl	fw_receive
	.type	fw_receive, @function
fw_receive:
	addi	sp,sp,-144
	sd	s0,128(sp)
	sd	s1,120(sp)
	sd	s2,112(sp)
	sd	s3,104(sp)
	sd	s4,96(sp)
	sd	s5,88(sp)
	sd	ra,136(sp)
	li	s1,0
	li	s0,0
	li	s2,92
	li	s4,70
	li	s3,64
	li	s5,10
.L22:
	li	a2,1
	li	a1,0
	addi	a0,sp,7
	call	uart_get_byte
	lbu	a5,7(sp)
	beq	a5,s2,.L42
.L24:
	addi	a4,s0,80
	add	a4,a4,sp
	sb	a5,-72(a4)
	bne	s1,zero,.L26
	beq	a5,s3,.L43
	beq	a5,s5,.L44
.L31:
	addi	s0,s0,1
	bne	s0,s4,.L22
.L23:
	li	a2,1
	li	a1,0
	addi	a0,sp,7
	call	uart_get_byte
	lbu	a5,7(sp)
	li	s1,0
	li	s0,0
	bne	a5,s2,.L24
.L42:
	beq	s1,zero,.L33
	addi	a5,s0,80
	add	a5,a5,sp
	sb	s2,-72(a5)
.L26:
	addi	s0,s0,1
	li	s1,0
	bne	s0,s4,.L22
	j	.L23
.L43:
	bne	s0,zero,.L45
	li	s0,1
	j	.L22
.L45:
	sb	s3,8(sp)
	li	s0,1
	j	.L22
.L44:
	lbu	a5,8(sp)
	bne	a5,s3,.L31
	li	a5,1
	bleu	s0,a5,.L32
	lbu	a0,9(sp)
	addi	a2,s0,-2
	addi	a1,sp,10
	call	message_handle
	bne	a0,zero,.L40
.L32:
	li	a0,70
	call	uart_write_byte
	j	.L23
.L33:
	li	s1,1
	j	.L22
.L40:
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
	sd	s2,336(sp)
	call	uECC_secp256k1
	mv	s2,a0
	addi	a0,sp,176
	call	sha256_init
	li	a0,4096
	li	a2,2
	addi	a1,sp,8
	addi	a0,a0,-2
	call	read_flash
	lhu	s1,8(sp)
	li	a2,64
	addi	a1,sp,112
	slliw	a5,s1,8
	li	a0,0
	srli	s1,s1,8
	or	s1,s1,a5
	call	read_flash
	lw	a5,116(sp)
	slli	s1,s1,48
	srli	s1,s1,48
	sw	a5,112(sp)
	addiw	s0,s1,-64
	li	a5,-1
	li	a2,64
	addi	a1,sp,112
	addi	a0,sp,176
	sw	a5,116(sp)
	slli	s0,s0,48
	call	sha256_update
	srli	s0,s0,48
	li	a5,63
	bleu	s0,a5,.L50
	sd	s3,328(sp)
	li	s0,64
	li	s3,63
.L48:
	mv	a0,s0
	li	a2,64
	addi	a1,sp,112
	call	read_flash
	addiw	s0,s0,64
	li	a2,64
	addi	a1,sp,112
	addi	a0,sp,176
	slli	s0,s0,48
	srli	s0,s0,48
	call	sha256_update
	subw	a5,s1,s0
	slli	a5,a5,48
	srli	a5,a5,48
	bgtu	a5,s3,.L48
	addiw	s1,s1,-128
	slli	s1,s1,48
	srli	s1,s1,48
	srliw	a5,s1,6
	andi	a0,s1,-64
	slliw	a5,a5,6
	subw	s1,s1,a5
	addiw	a0,a0,128
	ld	s3,328(sp)
	slli	s0,s1,48
	slli	a0,a0,48
	srli	s0,s0,48
	srli	a0,a0,48
.L47:
	bne	s0,zero,.L56
.L49:
	addi	a1,sp,16
	addi	a0,sp,176
	call	sha256_final
	li	a0,4096
	addi	a1,sp,48
	li	a2,64
	addi	a0,a0,-66
	call	read_flash
	lui	a0,%hi(.LANCHOR0)
	mv	a4,s2
	addi	a3,sp,48
	addi	a1,sp,16
	li	a2,32
	addi	a0,a0,%lo(.LANCHOR0)
	call	uECC_verify
	ld	ra,360(sp)
	ld	s0,352(sp)
	ld	s1,344(sp)
	ld	s2,336(sp)
	addi	sp,sp,368
	jr	ra
.L56:
	mv	a2,s0
	addi	a1,sp,112
	call	read_flash
	mv	a2,s0
	addi	a1,sp,112
	addi	a0,sp,176
	call	sha256_update
	j	.L49
.L50:
	li	a0,64
	j	.L47
	.size	signature_valid, .-signature_valid
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"@BTL\n"
	.align	3
.LC1:
	.string	"@OK\n"
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sd	ra,8(sp)
	call	mcu_init
	call	uart_init
	li	a2,61440
	lui	a0,%hi(.LC0)
	addi	a2,a2,-1440
	li	a1,5
	addi	a0,a0,%lo(.LC0)
	call	uart_expect_msg
	bne	a0,zero,.L68
.L58:
	li	a0,4096
	call	erase_flash
	lui	a0,%hi(.LC1)
	li	a1,4
	addi	a0,a0,%lo(.LC1)
	call	uart_send_buf
	call	fw_receive
	bne	a0,zero,.L69
.L60:
 #APP
# 298 "main.c" 1
	reset
# 0 "" 2
 #NO_APP
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
.L68:
	call	signature_valid
	beq	a0,zero,.L59
	li	a0,83
	call	uart_write_byte
 #APP
# 282 "main.c" 1
	goto 4
# 0 "" 2
 #NO_APP
	j	.L58
.L69:
	slli	a0,a0,32
	lui	a5,%hi(mcu_errs)
	addi	a5,a5,%lo(mcu_errs)
	srli	a0,a0,32
	add	a0,a0,a5
	lbu	a0,0(a0)
	call	uart_write_byte
	j	.L60
.L59:
	li	a0,75
	call	uart_write_byte
 #APP
# 285 "main.c" 1
	reset
# 0 "" 2
 #NO_APP
	j	.L58
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
