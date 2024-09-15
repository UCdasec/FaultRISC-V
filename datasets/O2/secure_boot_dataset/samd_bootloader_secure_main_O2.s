	.file	"main.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.type	command_task, @function
command_task:
	addi	sp,sp,-352
	sd	s2,320(sp)
	lui	s2,%hi(.LANCHOR0)
	sd	s0,336(sp)
	addi	s0,s2,%lo(.LANCHOR0)
	lw	a4,0(s0)
	li	a5,2019913728
	sd	ra,344(sp)
	sd	s1,328(sp)
	addi	a5,a5,-959
	beq	a4,a5,.L2
	li	a4,1107300352
	addi	a4,a4,1024
.L3:
	ld	a5,24(a4)
	andi	a5,a5,1
	beq	a5,zero,.L3
	li	a5,81
	sh	a5,40(a4)
	lui	s1,%hi(uart_command)
.L4:
	ld	ra,344(sp)
	ld	s0,336(sp)
	sw	zero,%lo(uart_command)(s1)
	ld	s2,320(sp)
	ld	s1,328(sp)
	addi	sp,sp,352
	jr	ra
.L2:
	lui	s1,%hi(uart_command)
	lw	a5,%lo(uart_command)(s1)
	li	a4,160
	beq	a5,a4,.L54
	li	a4,161
	beq	a5,a4,.L55
	li	a4,162
	beq	a5,a4,.L56
	li	a4,1107300352
	li	a3,163
	addi	a4,a4,1024
	beq	a5,a3,.L57
.L20:
	ld	a5,24(a4)
	andi	a5,a5,1
	beq	a5,zero,.L20
	li	a5,82
	sh	a5,40(a4)
	j	.L4
.L55:
	lw	a5,4(s0)
	lui	a4,%hi(unlock_begin)
	lw	a4,%lo(unlock_begin)(a4)
	lui	a3,%hi(flash_addr)
	sw	a5,%lo(flash_addr)(a3)
	bgtu	a4,a5,.L10
	lui	a4,%hi(unlock_end)
	lw	a4,%lo(unlock_end)(a4)
	bleu	a4,a5,.L10
	sd	s5,296(sp)
	addi	s5,sp,24
	mv	a0,s5
	sd	s3,312(sp)
	call	spritz_initialize_state
	addi	s3,s0,296
	li	a2,16
	mv	a1,s3
	mv	a0,s5
	call	spritz_absorb
	li	a1,65
	mv	a0,s5
	call	spritz_absorb_byte
	li	a2,264
	addi	a1,s2,%lo(.LANCHOR0)
	mv	a0,s5
	call	spritz_absorb
	li	a2,16
	addi	a1,sp,8
	mv	a0,s5
	call	spritz_squeeze
	addi	a4,s0,264
	addi	a5,sp,8
	j	.L12
.L49:
	beq	s5,a5,.L58
.L12:
	lbu	a2,0(a4)
	lbu	a3,0(a5)
	addi	a4,a4,1
	addi	a5,a5,1
	beq	a2,a3,.L49
	li	a4,1107300352
	addi	a4,a4,1024
.L11:
	ld	a5,24(a4)
	andi	a5,a5,1
	beq	a5,zero,.L11
	li	a5,81
	ld	s3,312(sp)
	ld	s5,296(sp)
	sh	a5,40(a4)
	j	.L4
.L10:
	li	a4,1107300352
	addi	a4,a4,1024
.L38:
	ld	a5,24(a4)
	andi	a5,a5,1
	beq	a5,zero,.L38
	li	a5,81
	sh	a5,40(a4)
	j	.L4
.L54:
	sd	s3,312(sp)
	sd	s4,304(sp)
	lw	s3,8(s0)
	lw	s4,4(s0)
	andi	s3,s3,-256
	andi	s4,s4,-256
	addw	a5,s3,s4
	mv	s3,a5
	bgeu	s4,a5,.L6
	li	a4,262144
	bleu	a5,a4,.L59
.L6:
	lui	a5,%hi(unlock_end)
	li	a4,1107300352
	sw	zero,%lo(unlock_end)(a5)
	lui	a5,%hi(flash_verify_ok)
	sb	zero,%lo(flash_verify_ok)(a5)
	addi	a4,a4,1024
.L8:
	ld	a5,24(a4)
	andi	a5,a5,1
	beq	a5,zero,.L8
	li	a5,81
	ld	s3,312(sp)
	ld	s4,304(sp)
	sh	a5,40(a4)
	j	.L4
.L56:
	lui	a5,%hi(flash_verify_ok)
	lbu	a3,%lo(flash_verify_ok)(a5)
	li	a4,1107300352
	li	a5,84
	subw	a3,a5,a3
	addi	a4,a4,1024
.L19:
	ld	a5,24(a4)
	andi	a5,a5,1
	beq	a5,zero,.L19
	slli	a5,a3,48
	srli	a5,a5,48
	sh	a5,40(a4)
	j	.L4
.L59:
	addi	a0,sp,24
	call	spritz_initialize_state
	li	a2,16
	addi	a1,s0,280
	addi	a0,sp,24
	call	spritz_absorb
	li	a2,28
	addi	a1,s2,%lo(.LANCHOR0)
	addi	a0,sp,24
	call	spritz_absorb
	li	a2,16
	addi	a1,s0,296
	addi	a0,sp,24
	call	spritz_squeeze
	lui	a5,%hi(unlock_begin)
	sw	s4,%lo(unlock_begin)(a5)
	lui	a5,%hi(unlock_end)
	li	a4,1107300352
	sw	s3,%lo(unlock_end)(a5)
	li	a3,1
	lui	a5,%hi(flash_verify_ok)
	sb	a3,%lo(flash_verify_ok)(a5)
	addi	a4,a4,1024
.L7:
	ld	a5,24(a4)
	andi	a5,a5,1
	beq	a5,zero,.L7
	li	a5,80
	ld	s3,312(sp)
	ld	s4,304(sp)
	sh	a5,40(a4)
	j	.L4
.L58:
	mv	a0,s5
	sd	s4,304(sp)
	call	spritz_initialize_state
	li	a2,16
	mv	a1,s3
	mv	a0,s5
	call	spritz_absorb
	li	a1,69
	mv	a0,s5
	call	spritz_absorb_byte
	addi	a1,s2,%lo(.LANCHOR0)
	li	a2,8
	mv	a0,s5
	addi	s4,s0,8
	addi	s2,s0,312
	call	spritz_absorb
	addi	s0,s0,568
.L14:
	lbu	s3,0(s4)
	mv	a0,s5
	call	spritz_drip
	subw	s3,s3,a0
	sb	s3,0(s2)
	addi	s2,s2,1
	addi	s4,s4,1
	bne	s0,s2,.L14
	li	a4,1107300352
	lui	a5,%hi(flash_data_ready)
	li	a3,1
	sb	a3,%lo(flash_data_ready)(a5)
	addi	a4,a4,1024
.L15:
	ld	a5,24(a4)
	andi	a5,a5,1
	beq	a5,zero,.L15
	li	a5,80
	ld	s3,312(sp)
	ld	s4,304(sp)
	ld	s5,296(sp)
	sh	a5,40(a4)
	j	.L4
.L57:
	lw	a0,4(s0)
	lw	a1,8(s0)
	lw	a2,12(s0)
	lw	a3,16(s0)
	li	a4,536870912
	li	a5,1107300352
	sw	a0,0(a4)
	sw	a1,4(a4)
	sw	a2,8(a4)
	sw	a3,12(a4)
	addi	a5,a5,1024
.L21:
	ld	a4,24(a5)
	andi	a4,a4,1
	beq	a4,zero,.L21
	li	a4,1107300352
	li	a3,80
	sh	a3,40(a5)
	addi	a4,a4,1024
.L22:
	ld	a5,24(a4)
	srli	a5,a5,1
	andi	a5,a5,1
	beq	a5,zero,.L22
 #APP
# 445 "../include/core_cmInstr.h" 1
	dsb
# 0 "" 2
 #NO_APP
	li	a5,14680064
	addi	a5,a5,237
	li	a4,100270080
	slli	a5,a5,8
	addi	a4,a4,4
	sw	a4,12(a5)
 #APP
# 445 "../include/core_cmInstr.h" 1
	dsb
# 0 "" 2
 #NO_APP
.L23:
	j	.L23
	.size	command_task, .-command_task
	.align	1
	.type	uart_task.part.0, @function
uart_task.part.0:
	li	a5,1879076864
	slli	a5,a5,1
	li	a4,1107300352
	addi	a5,a5,16
	lhu	a3,1064(a4)
	lw	a5,0(a5)
	slli	a3,a3,48
	slli	a4,a5,47
	srli	a3,a3,48
	bge	a4,zero,.L72
	lui	a4,%hi(command.2)
.L61:
	sext.w	a5,a3
	lui	a3,%hi(ptr.1)
	sw	zero,%lo(ptr.1)(a3)
	lui	a3,%hi(.LANCHOR0)
	sb	zero,%lo(.LANCHOR0)(a3)
	sw	a5,%lo(command.2)(a4)
	li	a3,160
	beq	a5,a3,.L73
	li	a3,161
	beq	a5,a3,.L74
	li	a3,162
	beq	a5,a3,.L75
	li	a3,163
	beq	a5,a3,.L76
	lui	a3,%hi(size.0)
	sw	zero,%lo(size.0)(a3)
.L68:
	lui	a3,%hi(uart_command)
	sw	a5,%lo(uart_command)(a3)
	sw	zero,%lo(command.2)(a4)
.L70:
	li	a5,1879076864
	slli	a5,a5,1
	li	a4,798720
	sw	zero,16(a5)
	addi	a4,a4,1280
	sw	a4,20(a5)
	lw	a4,20(a5)
	sext.w	a4,a4
	sw	a4,24(a5)
	li	a4,5
	sw	a4,16(a5)
	ret
.L72:
	lui	a4,%hi(command.2)
	lw	a5,%lo(command.2)(a4)
	beq	a5,zero,.L61
	lui	a6,%hi(ptr.1)
	lui	a1,%hi(size.0)
	lw	a2,%lo(ptr.1)(a6)
	lw	a1,%lo(size.0)(a1)
	bge	a2,a1,.L69
	lui	a0,%hi(.LANCHOR0)
	addi	a0,a0,%lo(.LANCHOR0)
	addiw	a7,a2,1
	add	a2,a0,a2
	sb	a3,0(a2)
	sw	a7,%lo(ptr.1)(a6)
	sext.w	a2,a7
.L69:
	bne	a1,a2,.L70
	j	.L68
.L73:
	lui	a5,%hi(size.0)
	li	a4,28
	sw	a4,%lo(size.0)(a5)
	j	.L70
.L75:
	lui	a5,%hi(size.0)
	li	a4,4
	sw	a4,%lo(size.0)(a5)
	j	.L70
.L74:
	lui	a5,%hi(size.0)
	li	a4,280
	sw	a4,%lo(size.0)(a5)
	j	.L70
.L76:
	lui	a5,%hi(size.0)
	li	a4,20
	sw	a4,%lo(size.0)(a5)
	j	.L70
	.size	uart_task.part.0, .-uart_task.part.0
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-160
	sd	s0,144(sp)
	sd	ra,152(sp)
	sd	s1,136(sp)
	sd	s2,128(sp)
	sd	s3,120(sp)
	sd	s4,112(sp)
	sd	s5,104(sp)
	sd	s6,96(sp)
	sd	s7,88(sp)
	sd	s8,80(sp)
	sd	s9,72(sp)
	sd	s10,64(sp)
	sd	s11,56(sp)
	addi	s0,sp,160
	li	a5,1090535424
	li	a4,32768
	sw	a4,1028(a5)
	sw	a4,1048(a5)
	li	a4,6
	sb	a4,1103(a5)
	li	a5,2000
.L78:
 #APP
# 165 "../main.c" 1
	nop
# 0 "" 2
 #NO_APP
	addiw	a5,a5,-1
	bne	a5,zero,.L78
	li	a5,1090535424
	lw	a4,1056(a5)
	slli	a5,a4,48
	bge	a5,zero,.L79
	li	a5,536870912
	lw	a2,0(a5)
	li	a4,2019913728
	addi	a4,a4,-959
	beq	a2,a4,.L156
.L80:
	li	a5,4096
	lw	a5,0(a5)
	li	a4,-1
	beq	a5,a4,.L79
 #APP
# 456 "../include/core_cmFunc.h" 1
	MSR msp, a5

# 0 "" 2
 #NO_APP
	li	a5,4096
	addi	a5,a5,4
	lw	a5,0(a5)
 #APP
# 153 "../main.c" 1
	bx a5
# 0 "" 2
 #NO_APP
.L79:
	li	a2,1073745920
	lw	a5,-2016(a2)
	li	a4,1073741824
	li	a1,262144
	andi	a5,a5,-769
	sw	a5,-2016(a2)
	lw	a5,1044(a4)
	lui	s7,%hi(.LANCHOR0)
	addi	t1,s7,%lo(.LANCHOR0)
	ori	a5,a5,16
	sw	a5,1044(a4)
	lw	a3,1052(a4)
	lui	a5,%hi(.LANCHOR1)
	addi	a5,a5,%lo(.LANCHOR1)
	ori	a3,a3,4
	sw	a3,1052(a4)
	li	a3,1090535424
	sw	a1,4(a3)
	ld	a1,0(a5)
	ld	a3,8(a5)
	li	a5,1090535424
	sd	a1,280(t1)
	sd	a3,288(t1)
	lbu	a3,1111(a5)
	sd	t1,-136(s0)
	li	a2,1107300352
	ori	a3,a3,1
	sb	a3,1111(a5)
	lbu	a3,1083(a5)
	addi	a2,a2,1024
	li	a6,16384
	andi	a3,a3,15
	ori	a3,a3,32
	sb	a3,1083(a5)
	lbu	a3,1110(a5)
	addi	a6,a6,23
	li	a0,1073745920
	ori	a3,a3,1
	sb	a3,1110(a5)
	lbu	a3,1083(a5)
	sd	a2,-120(s0)
	li	a1,1141907456
	andi	a3,a3,-16
	ori	a3,a3,2
	sb	a3,1083(a5)
	lw	a7,1056(a4)
	addi	a1,a1,4
	li	a3,16384
	ori	a7,a7,32
	sw	a7,1056(a4)
	sh	a6,-1022(a0)
	sw	a1,0(a2)
	li	a4,196608
	sw	a4,4(a2)
	addi	a3,a3,4
	sh	a3,12(a2)
	lw	a4,0(a2)
	lui	a5,%hi(.LANCHOR0+312)
	addi	a5,a5,%lo(.LANCHOR0+312)
	ori	a4,a4,2
	sw	a4,0(a2)
	lui	s1,%hi(uart_command)
	li	a4,-24576
	sd	a5,-128(s0)
	lw	a6,%lo(uart_command)(s1)
	addi	a5,a4,1345
	lui	s8,%hi(flash_data_ready)
	li	a3,-24576
	lbu	s2,%lo(flash_data_ready)(s8)
	sd	a5,-144(s0)
	addi	a5,a3,1282
	sd	a5,-152(s0)
	lui	s5,%hi(flash_verify_ok)
	addi	s6,t1,568
	beq	a6,zero,.L84
.L85:
	beq	s2,zero,.L110
.L113:
	lui	a5,%hi(flash_addr)
	lw	s3,%lo(flash_addr)(a5)
	li	a5,1090535424
	li	s2,1090535424
	srliw	a4,s3,1
	sw	a4,28(a5)
	ld	a4,-144(s0)
	slli	s3,s3,32
	srli	s3,s3,32
	sh	a4,0(a5)
.L91:
	ld	a5,16(s2)
	slli	a4,a5,31
	blt	a4,zero,.L89
.L92:
	bne	a6,zero,.L157
	ld	a5,-120(s0)
	ld	a5,24(a5)
	srli	a5,a5,2
	andi	a5,a5,1
	beq	a5,zero,.L91
	call	uart_task.part.0
	ld	a5,16(s2)
	lw	a6,%lo(uart_command)(s1)
	slli	a4,a5,31
	bge	a4,zero,.L92
.L89:
	ld	a4,-152(s0)
	li	a5,1090535424
	li	s2,1090535424
	sh	a4,0(a5)
.L97:
	ld	a5,16(s2)
	slli	a4,a5,31
	blt	a4,zero,.L95
.L98:
	bne	a6,zero,.L158
	ld	a5,-120(s0)
	ld	a5,24(a5)
	srli	a5,a5,2
	andi	a5,a5,1
	beq	a5,zero,.L97
	call	uart_task.part.0
	ld	a5,16(s2)
	lw	a6,%lo(uart_command)(s1)
	slli	a4,a5,31
	bge	a4,zero,.L98
.L95:
	ld	a5,-136(s0)
	lbu	s4,%lo(flash_verify_ok)(s5)
	ld	s2,-128(s0)
	addi	s9,a5,376
	li	s11,1090535424
.L99:
	mv	s7,s2
	mv	s10,s3
	mv	a4,s3
	mv	a5,s2
.L100:
	lw	a2,0(a5)
	addi	a5,a5,4
	addi	a4,a4,4
	sw	a2,-4(a4)
	bne	a5,s9,.L100
.L105:
	ld	a5,16(s11)
	slli	a4,a5,31
	blt	a4,zero,.L108
	bne	a6,zero,.L104
.L102:
	ld	a5,-120(s0)
	ld	a5,24(a5)
	srli	a5,a5,2
	andi	a5,a5,1
	beq	a5,zero,.L105
	call	uart_task.part.0
	ld	a5,16(s11)
	lw	a6,%lo(uart_command)(s1)
	slli	a4,a5,31
	blt	a4,zero,.L108
	beq	a6,zero,.L102
.L104:
	ld	a5,16(s11)
	slli	a4,a5,31
	blt	a4,zero,.L108
	ld	a5,16(s11)
	slli	a4,a5,31
	bge	a4,zero,.L104
	j	.L108
.L159:
	beq	s7,s9,.L107
.L108:
	lbu	a4,0(s7)
	lbu	a5,0(s10)
	addi	s7,s7,1
	addi	s10,s10,1
	beq	a4,a5,.L159
	li	s4,0
.L107:
	sb	s4,%lo(flash_verify_ok)(s5)
	addi	s2,s2,64
	addi	s3,s3,64
	addi	s9,s9,64
	bne	s2,s6,.L99
	sb	zero,%lo(flash_data_ready)(s8)
	beq	a6,zero,.L146
.L110:
	call	command_task
	lw	a6,%lo(uart_command)(s1)
	lbu	s2,%lo(flash_data_ready)(s8)
	bne	a6,zero,.L85
.L84:
	ld	a5,-120(s0)
	ld	a5,24(a5)
	srli	a5,a5,2
	andi	a5,a5,1
	beq	a5,zero,.L82
	call	uart_task.part.0
	beq	s2,zero,.L83
	lw	a6,%lo(uart_command)(s1)
	j	.L113
.L157:
	li	a4,1090535424
.L90:
	ld	a5,16(a4)
	slli	a3,a5,31
	bge	a3,zero,.L90
	j	.L89
.L158:
	li	a4,1090535424
.L96:
	ld	a5,16(a4)
	slli	a3,a5,31
	bge	a3,zero,.L96
	j	.L95
.L146:
	ld	a5,-120(s0)
	ld	s2,24(a5)
	srli	s2,s2,2
	andi	s2,s2,1
	beq	s2,zero,.L84
.L152:
	call	uart_task.part.0
.L83:
	lw	a5,%lo(uart_command)(s1)
	bne	a5,zero,.L110
	ld	a5,-120(s0)
	ld	s2,24(a5)
	srli	s2,s2,2
	andi	s2,s2,1
	bne	s2,zero,.L152
.L82:
	li	a6,0
	bne	s2,zero,.L113
.L115:
	ld	a5,-120(s0)
	ld	a5,24(a5)
	srli	a5,a5,2
	andi	a5,a5,1
	bne	a5,zero,.L152
	ld	a5,-120(s0)
	ld	a5,24(a5)
	srli	a5,a5,2
	andi	a5,a5,1
	bne	a5,zero,.L152
	j	.L115
.L156:
	lw	a3,4(a5)
	bne	a3,a2,.L80
	lw	a4,8(a5)
	bne	a4,a3,.L80
	lw	a3,12(a5)
	bne	a3,a4,.L80
	sw	zero,0(a5)
	j	.L79
	.size	main, .-main
	.globl	security_key_flash
	.bss
	.align	3
	.set	.LANCHOR0,. + 0
	.type	uart_buffer, @object
	.size	uart_buffer, 280
uart_buffer:
	.zero	280
	.type	security_key, @object
	.size	security_key, 16
security_key:
	.zero	16
	.type	session_key, @object
	.size	session_key, 16
session_key:
	.zero	16
	.type	flash_data, @object
	.size	flash_data, 256
flash_data:
	.zero	256
	.section	.key,"aw"
	.align	3
	.set	.LANCHOR1,. + 0
	.type	security_key_flash, @object
	.size	security_key_flash, 16
security_key_flash:
	.string	""
	.ascii	"\001\002\003\004\005\006\007\b\t\n\013\f\r\016\017"
	.section	.sbss,"aw",@nobits
	.align	2
	.type	size.0, @object
	.size	size.0, 4
size.0:
	.zero	4
	.type	ptr.1, @object
	.size	ptr.1, 4
ptr.1:
	.zero	4
	.type	command.2, @object
	.size	command.2, 4
command.2:
	.zero	4
	.type	unlock_end, @object
	.size	unlock_end, 4
unlock_end:
	.zero	4
	.type	unlock_begin, @object
	.size	unlock_begin, 4
unlock_begin:
	.zero	4
	.type	flash_verify_ok, @object
	.size	flash_verify_ok, 1
flash_verify_ok:
	.zero	1
	.type	flash_data_ready, @object
	.size	flash_data_ready, 1
flash_data_ready:
	.zero	1
	.zero	2
	.type	flash_addr, @object
	.size	flash_addr, 4
flash_addr:
	.zero	4
	.type	uart_command, @object
	.size	uart_command, 4
uart_command:
	.zero	4
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
