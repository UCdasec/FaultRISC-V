	.file	"main.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.type	send_response, @function
send_response:
	li	a4,1107300352
	addi	a4,a4,1024
.L2:
	ld	a5,24(a4)
	andi	a5,a5,1
	beq	a5,zero,.L2
	slli	a0,a0,48
	srli	a0,a0,48
	li	a5,1107300352
	sh	a0,1064(a5)
	ret
	.size	send_response, .-send_response
	.align	1
	.type	uart_task, @function
uart_task:
	lui	a5,%hi(uart_command)
	lw	a5,%lo(uart_command)(a5)
	bne	a5,zero,.L4
	li	a5,1107300352
	addi	a5,a5,1024
	ld	a5,24(a5)
	srli	a5,a5,2
	andi	a5,a5,1
	bne	a5,zero,.L17
.L4:
	ret
.L17:
	li	a5,1107300352
	addi	a5,a5,1024
	lhu	a5,40(a5)
	slli	a4,a5,48
	srli	a4,a4,48
	li	a5,1879076864
	slli	a5,a5,1
	addi	a5,a5,16
	lw	a5,0(a5)
	slli	a3,a5,47
	blt	a3,zero,.L6
	lui	a5,%hi(command.2)
	lw	a5,%lo(command.2)(a5)
	beq	a5,zero,.L6
	lui	a5,%hi(ptr.1)
	lw	a3,%lo(ptr.1)(a5)
	lui	a5,%hi(size.0)
	lw	a5,%lo(size.0)(a5)
	bge	a3,a5,.L10
	addiw	a1,a3,1
	lui	a2,%hi(ptr.1)
	sw	a1,%lo(ptr.1)(a2)
	lui	a2,%hi(.LANCHOR0)
	addi	a2,a2,%lo(.LANCHOR0)
	add	a3,a2,a3
	sb	a4,0(a3)
.L10:
	lui	a4,%hi(ptr.1)
	lw	a4,%lo(ptr.1)(a4)
	bne	a4,a5,.L11
.L9:
	lui	a5,%hi(command.2)
	lw	a3,%lo(command.2)(a5)
	lui	a4,%hi(uart_command)
	sw	a3,%lo(uart_command)(a4)
	sw	zero,%lo(command.2)(a5)
	j	.L11
.L6:
	sext.w	a5,a4
	lui	a4,%hi(ptr.1)
	sw	zero,%lo(ptr.1)(a4)
	lui	a4,%hi(command.2)
	sw	a5,%lo(command.2)(a4)
	lui	a4,%hi(.LANCHOR0)
	sb	zero,%lo(.LANCHOR0)(a4)
	li	a4,160
	beq	a5,a4,.L12
	li	a4,161
	beq	a5,a4,.L13
	li	a4,162
	beq	a5,a4,.L14
	li	a4,163
	beq	a5,a4,.L15
	lui	a5,%hi(size.0)
	sw	zero,%lo(size.0)(a5)
	j	.L9
.L12:
	li	a4,28
.L8:
	lui	a5,%hi(size.0)
	sw	a4,%lo(size.0)(a5)
.L11:
	li	a5,1879076864
	slli	a5,a5,1
	sw	zero,16(a5)
	li	a4,798720
	addi	a4,a4,1280
	sw	a4,20(a5)
	lw	a4,20(a5)
	sext.w	a4,a4
	sw	a4,24(a5)
	li	a4,5
	sw	a4,16(a5)
	ret
.L13:
	li	a4,280
	j	.L8
.L14:
	li	a4,4
	j	.L8
.L15:
	li	a4,20
	j	.L8
	.size	uart_task, .-uart_task
	.align	1
	.type	command_task, @function
command_task:
	addi	sp,sp,-336
	sd	ra,328(sp)
	lui	a5,%hi(.LANCHOR0)
	lw	a4,%lo(.LANCHOR0)(a5)
	li	a5,2019913728
	addi	a5,a5,-959
	bne	a4,a5,.L41
	lui	a5,%hi(uart_command)
	lw	a5,%lo(uart_command)(a5)
	li	a4,160
	beq	a5,a4,.L42
	li	a4,161
	beq	a5,a4,.L43
	li	a4,162
	beq	a5,a4,.L44
	li	a4,163
	beq	a5,a4,.L45
	li	a0,82
	call	send_response
	j	.L20
.L41:
	li	a0,81
	call	send_response
.L20:
	lui	a5,%hi(uart_command)
	sw	zero,%lo(uart_command)(a5)
	ld	ra,328(sp)
	addi	sp,sp,336
	jr	ra
.L42:
	sd	s0,320(sp)
	sd	s1,312(sp)
	lui	a5,%hi(.LANCHOR0)
	addi	a5,a5,%lo(.LANCHOR0)
	lw	s1,4(a5)
	andi	s1,s1,-256
	lw	s0,8(a5)
	andi	s0,s0,-256
	addw	s0,s0,s1
	sext.w	a5,s0
	bgeu	s1,a5,.L22
	li	a4,262144
	bleu	a5,a4,.L46
.L22:
	lui	a5,%hi(unlock_end)
	sw	zero,%lo(unlock_end)(a5)
	lui	a5,%hi(flash_verify_ok)
	sb	zero,%lo(flash_verify_ok)(a5)
	li	a0,81
	call	send_response
	ld	s0,320(sp)
	ld	s1,312(sp)
	j	.L20
.L46:
	sd	s2,304(sp)
	sd	s3,296(sp)
	addi	a0,sp,24
	call	spritz_initialize_state
	lui	s3,%hi(.LANCHOR0)
	addi	s2,s3,%lo(.LANCHOR0)
	li	a2,16
	addi	a1,s2,280
	addi	a0,sp,24
	call	spritz_absorb
	li	a2,28
	addi	a1,s3,%lo(.LANCHOR0)
	addi	a0,sp,24
	call	spritz_absorb
	li	a2,16
	addi	a1,s2,296
	addi	a0,sp,24
	call	spritz_squeeze
	lui	a5,%hi(unlock_begin)
	sw	s1,%lo(unlock_begin)(a5)
	lui	a5,%hi(unlock_end)
	sw	s0,%lo(unlock_end)(a5)
	lui	a5,%hi(flash_verify_ok)
	li	a4,1
	sb	a4,%lo(flash_verify_ok)(a5)
	li	a0,80
	call	send_response
	ld	s0,320(sp)
	ld	s1,312(sp)
	ld	s2,304(sp)
	ld	s3,296(sp)
	j	.L20
.L43:
	lui	a5,%hi(.LANCHOR0+4)
	lw	a5,%lo(.LANCHOR0+4)(a5)
	lui	a4,%hi(flash_addr)
	sw	a5,%lo(flash_addr)(a4)
	lui	a4,%hi(unlock_begin)
	lw	a4,%lo(unlock_begin)(a4)
	bgtu	a4,a5,.L24
	lui	a4,%hi(unlock_end)
	lw	a4,%lo(unlock_end)(a4)
	bgtu	a4,a5,.L47
.L24:
	li	a0,81
	call	send_response
	j	.L20
.L47:
	sd	s0,320(sp)
	sd	s1,312(sp)
	addi	a0,sp,24
	call	spritz_initialize_state
	lui	s1,%hi(.LANCHOR0)
	addi	s0,s1,%lo(.LANCHOR0)
	li	a2,16
	addi	a1,s0,296
	addi	a0,sp,24
	call	spritz_absorb
	li	a1,65
	addi	a0,sp,24
	call	spritz_absorb_byte
	li	a2,264
	addi	a1,s1,%lo(.LANCHOR0)
	addi	a0,sp,24
	call	spritz_absorb
	li	a2,16
	addi	a1,sp,8
	addi	a0,sp,24
	call	spritz_squeeze
	addi	a4,s0,264
	addi	a5,sp,8
	addi	a1,sp,24
.L26:
	lbu	a2,0(a4)
	lbu	a3,0(a5)
	bne	a2,a3,.L25
	addi	a4,a4,1
	addi	a5,a5,1
	bne	a5,a1,.L26
	sd	s2,304(sp)
	sd	s3,296(sp)
	addi	a0,sp,24
	call	spritz_initialize_state
	lui	s0,%hi(.LANCHOR0)
	addi	s3,s0,%lo(.LANCHOR0)
	li	a2,16
	addi	a1,s3,296
	addi	a0,sp,24
	call	spritz_absorb
	li	a1,69
	addi	a0,sp,24
	call	spritz_absorb_byte
	li	a2,8
	addi	a1,s0,%lo(.LANCHOR0)
	addi	a0,sp,24
	call	spritz_absorb
	addi	s2,s3,8
	addi	s0,s3,312
	addi	s3,s3,568
.L28:
	lbu	s1,0(s2)
	addi	a0,sp,24
	call	spritz_drip
	subw	s1,s1,a0
	sb	s1,0(s0)
	addi	s2,s2,1
	addi	s0,s0,1
	bne	s0,s3,.L28
	lui	a5,%hi(flash_data_ready)
	li	a4,1
	sb	a4,%lo(flash_data_ready)(a5)
	li	a0,80
	call	send_response
	ld	s0,320(sp)
	ld	s1,312(sp)
	ld	s2,304(sp)
	ld	s3,296(sp)
	j	.L20
.L44:
	lui	a5,%hi(flash_verify_ok)
	lbu	a5,%lo(flash_verify_ok)(a5)
	li	a0,84
	subw	a0,a0,a5
	call	send_response
	j	.L20
.L45:
	lui	a5,%hi(.LANCHOR0)
	addi	a5,a5,%lo(.LANCHOR0)
	lw	a3,4(a5)
	li	a4,536870912
	sw	a3,0(a4)
	lw	a3,8(a5)
	sw	a3,4(a4)
	lw	a3,12(a5)
	sw	a3,8(a4)
	lw	a5,16(a5)
	sw	a5,12(a4)
	li	a0,80
	call	send_response
	li	a4,1107300352
	addi	a4,a4,1024
.L32:
	ld	a5,24(a4)
	srli	a5,a5,1
	andi	a5,a5,1
	beq	a5,zero,.L32
 #APP
# 445 "../include/core_cmInstr.h" 1
	dsb
# 0 "" 2
 #NO_APP
	li	a5,14680064
	addi	a5,a5,237
	slli	a5,a5,8
	li	a4,100270080
	addi	a4,a4,4
	sw	a4,12(a5)
 #APP
# 445 "../include/core_cmInstr.h" 1
	dsb
# 0 "" 2
 #NO_APP
.L33:
	j	.L33
.L25:
	li	a0,81
	call	send_response
	ld	s0,320(sp)
	ld	s1,312(sp)
	j	.L20
	.size	command_task, .-command_task
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-128
	sd	ra,120(sp)
	sd	s0,112(sp)
	addi	s0,sp,128
	li	a5,1090535424
	li	a4,32768
	sw	a4,1028(a5)
	sw	a4,1048(a5)
	li	a4,6
	sb	a4,1103(a5)
	li	a5,2000
.L49:
 #APP
# 165 "../main.c" 1
	nop
# 0 "" 2
 #NO_APP
	addiw	a5,a5,-1
	bne	a5,zero,.L49
	li	a5,1090535424
	addi	a5,a5,1024
	lw	a5,32(a5)
	slli	a4,a5,48
	bge	a4,zero,.L67
	li	a5,536870912
	lw	a4,0(a5)
	li	a5,2019913728
	addi	a5,a5,-959
	beq	a4,a5,.L86
.L51:
	li	a5,4096
	lw	a5,0(a5)
	li	a4,-1
	beq	a5,a4,.L67
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
.L67:
	li	a5,1073745920
	lw	a4,-2016(a5)
	andi	a4,a4,-769
	sw	a4,-2016(a5)
	li	a5,1073741824
	lw	a4,1044(a5)
	ori	a4,a4,16
	sw	a4,1044(a5)
	lw	a4,1052(a5)
	ori	a4,a4,4
	sw	a4,1052(a5)
	li	a5,1090535424
	li	a4,262144
	sw	a4,4(a5)
	lui	a5,%hi(.LANCHOR1)
	addi	a5,a5,%lo(.LANCHOR1)
	lui	a4,%hi(.LANCHOR0+280)
	addi	a4,a4,%lo(.LANCHOR0+280)
	addi	a2,a5,16
.L52:
	lbu	a3,0(a5)
	sb	a3,0(a4)
	addi	a5,a5,1
	addi	a4,a4,1
	bne	a5,a2,.L52
	sd	s1,104(sp)
	sd	s2,96(sp)
	sd	s3,88(sp)
	sd	s4,80(sp)
	sd	s5,72(sp)
	sd	s6,64(sp)
	sd	s7,56(sp)
	sd	s8,48(sp)
	sd	s9,40(sp)
	sd	s10,32(sp)
	sd	s11,24(sp)
	li	a5,1090535424
	lbu	a4,1111(a5)
	ori	a4,a4,1
	sb	a4,1111(a5)
	lbu	a4,1083(a5)
	andi	a4,a4,15
	ori	a4,a4,32
	sb	a4,1083(a5)
	lbu	a4,1110(a5)
	ori	a4,a4,1
	sb	a4,1110(a5)
	lbu	a4,1083(a5)
	andi	a4,a4,-16
	ori	a4,a4,2
	sb	a4,1083(a5)
	li	a5,1073741824
	lw	a4,1056(a5)
	ori	a4,a4,32
	sw	a4,1056(a5)
	li	a5,1073745920
	li	a4,16384
	addi	a4,a4,23
	sh	a4,-1022(a5)
	li	a5,1107300352
	li	a4,1141907456
	addi	a4,a4,4
	sw	a4,1024(a5)
	li	a4,196608
	sw	a4,1028(a5)
	li	a4,16384
	addi	a4,a4,4
	sh	a4,1036(a5)
	lw	a4,1024(a5)
	ori	a4,a4,2
	sw	a4,1024(a5)
	lui	s9,%hi(flash_data_ready)
	li	s11,-24576
	addi	s11,s11,1345
	lui	s10,%hi(.LANCHOR0)
	addi	s10,s10,%lo(.LANCHOR0)
	addi	a5,s10,312
	sd	a5,-128(s0)
	lui	s6,%hi(flash_verify_ok)
	j	.L53
.L86:
	li	a5,536870912
	lw	a4,4(a5)
	li	a5,2019913728
	addi	a5,a5,-959
	bne	a4,a5,.L51
	li	a5,536870912
	lw	a4,8(a5)
	li	a5,2019913728
	addi	a5,a5,-959
	bne	a4,a5,.L51
	li	a5,536870912
	lw	a4,12(a5)
	li	a5,2019913728
	addi	a5,a5,-959
	bne	a4,a5,.L51
	li	a5,536870912
	sw	zero,0(a5)
	j	.L67
.L69:
	li	a5,0
.L63:
	lbu	a4,%lo(flash_verify_ok)(s6)
	and	a5,a5,a4
	sb	a5,%lo(flash_verify_ok)(s6)
	addi	s4,s4,64
	addi	s5,s5,64
	addi	s1,s1,64
	beq	s4,s8,.L65
.L59:
	sd	s4,-120(s0)
	mv	s2,s5
	mv	a4,s5
	mv	a5,s4
.L60:
	lw	a3,0(a5)
	sw	a3,0(a4)
	addi	a5,a5,4
	addi	a4,a4,4
	bne	a5,s1,.L60
	ld	a5,16(s3)
	slli	a4,a5,31
	blt	a4,zero,.L64
.L62:
	call	uart_task
	ld	a5,16(s3)
	slli	a4,a5,31
	bge	a4,zero,.L62
.L64:
	ld	a3,-120(s0)
	lbu	a4,0(a3)
	lbu	a5,0(s2)
	bne	a4,a5,.L69
	addi	a5,a3,1
	sd	a5,-120(s0)
	addi	s2,s2,1
	bne	a5,s1,.L64
	mv	a5,s7
	j	.L63
.L65:
	sb	zero,%lo(flash_data_ready)(s9)
.L53:
	call	uart_task
	lbu	s7,%lo(flash_data_ready)(s9)
	beq	s7,zero,.L54
	lui	a5,%hi(flash_addr)
	lw	a5,%lo(flash_addr)(a5)
	slli	s5,a5,32
	srli	s5,s5,32
	srliw	a5,a5,1
	li	a4,1090535424
	sw	a5,28(a4)
	sh	s11,0(a4)
	ld	a5,16(a4)
	slli	a4,a5,31
	blt	a4,zero,.L55
.L56:
	call	uart_task
	li	a5,1090535424
	ld	a5,16(a5)
	slli	a4,a5,31
	bge	a4,zero,.L56
.L55:
	li	a4,1090535424
	li	a5,-24576
	addi	a5,a5,1282
	sh	a5,0(a4)
	ld	a5,16(a4)
	slli	a4,a5,31
	blt	a4,zero,.L57
.L58:
	call	uart_task
	li	a5,1090535424
	ld	a5,16(a5)
	slli	a4,a5,31
	bge	a4,zero,.L58
.L57:
	addi	s1,s10,376
	ld	s4,-128(s0)
	li	s3,1090535424
	addi	s8,s10,568
	j	.L59
.L54:
	lui	a5,%hi(uart_command)
	lw	a5,%lo(uart_command)(a5)
	beq	a5,zero,.L53
	call	command_task
	j	.L53
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
