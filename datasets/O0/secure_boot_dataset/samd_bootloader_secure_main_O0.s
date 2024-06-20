	.file	"main.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.type	NVIC_SystemReset, @function
NVIC_SystemReset:
	addi	sp,sp,-16
	sd	s0,8(sp)
	addi	s0,sp,16
 #APP
# 445 "../include/core_cmInstr.h" 1
	dsb
# 0 "" 2
 #NO_APP
	nop
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
	nop
.L2:
	j	.L2
	.size	NVIC_SystemReset, .-NVIC_SystemReset
	.globl	security_key_flash
	.section	.key,"aw"
	.align	3
	.type	security_key_flash, @object
	.size	security_key_flash, 16
security_key_flash:
	.string	""
	.ascii	"\001\002\003\004\005\006\007\b\t\n\013\f\r\016\017"
	.local	security_key
	.comm	security_key,16,8
	.section	.sdata,"aw"
	.align	3
	.type	ram, @object
	.size	ram, 8
ram:
	.dword	536870912
	.local	uart_command
	.comm	uart_command,4,4
	.local	uart_buffer
	.comm	uart_buffer,280,4
	.local	flash_data
	.comm	flash_data,256,4
	.local	flash_addr
	.comm	flash_addr,4,4
	.local	flash_data_ready
	.comm	flash_data_ready,1,1
	.local	flash_verify_ok
	.comm	flash_verify_ok,1,1
	.local	unlock_begin
	.comm	unlock_begin,4,4
	.local	unlock_end
	.comm	unlock_end,4,4
	.local	session_key
	.comm	session_key,16,8
	.text
	.align	1
	.type	sys_init, @function
sys_init:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	li	a5,1073745920
	addi	a5,a5,-2048
	lw	a4,32(a5)
	andi	a4,a4,-769
	sw	a4,32(a5)
	li	a5,1073741824
	addi	a5,a5,1024
	lw	a5,20(a5)
	sext.w	a4,a5
	li	a5,1073741824
	addi	a5,a5,1024
	ori	a4,a4,16
	sext.w	a4,a4
	sw	a4,20(a5)
	li	a5,1073741824
	addi	a5,a5,1024
	lw	a5,28(a5)
	sext.w	a4,a5
	li	a5,1073741824
	addi	a5,a5,1024
	ori	a4,a4,4
	sext.w	a4,a4
	sw	a4,28(a5)
	li	a5,1090535424
	li	a4,262144
	sw	a4,4(a5)
	sw	zero,-20(s0)
	j	.L4
.L5:
	lui	a5,%hi(security_key_flash)
	addi	a4,a5,%lo(security_key_flash)
	lw	a5,-20(s0)
	add	a5,a4,a5
	lbu	a4,0(a5)
	lui	a5,%hi(security_key)
	addi	a3,a5,%lo(security_key)
	lw	a5,-20(s0)
	add	a5,a3,a5
	sb	a4,0(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L4:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,15
	ble	a4,a5,.L5
	nop
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	sys_init, .-sys_init
	.align	1
	.type	run_application, @function
run_application:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	li	a5,4096
	lw	a5,0(a5)
	sw	a5,-20(s0)
	li	a5,4096
	addi	a5,a5,4
	lw	a5,0(a5)
	sw	a5,-24(s0)
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,-1
	beq	a4,a5,.L9
	lw	a5,-20(s0)
	sw	a5,-28(s0)
	lw	a5,-28(s0)
 #APP
# 456 "../include/core_cmFunc.h" 1
	MSR msp, a5

# 0 "" 2
 #NO_APP
	nop
	lw	a5,-24(s0)
 #APP
# 153 "../main.c" 1
	bx a5
# 0 "" 2
 #NO_APP
	j	.L6
.L9:
	nop
.L6:
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	run_application, .-run_application
	.align	1
	.type	bl_request, @function
bl_request:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	li	a5,1090535424
	addi	a5,a5,1024
	li	a4,32768
	sw	a4,4(a5)
	li	a5,1090535424
	addi	a5,a5,1024
	li	a4,32768
	sw	a4,24(a5)
	li	a5,1090535424
	addi	a5,a5,1024
	li	a4,6
	sb	a4,79(a5)
	sw	zero,-20(s0)
	j	.L11
.L12:
 #APP
# 165 "../main.c" 1
	nop
# 0 "" 2
 #NO_APP
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L11:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,1999
	ble	a4,a5,.L12
	li	a5,1090535424
	addi	a5,a5,1024
	lw	a5,32(a5)
	sext.w	a5,a5
	mv	a4,a5
	li	a5,32768
	and	a5,a4,a5
	sext.w	a5,a5
	bne	a5,zero,.L13
	li	a5,1
	j	.L14
.L13:
	lui	a5,%hi(ram)
	ld	a5,%lo(ram)(a5)
	lw	a5,0(a5)
	mv	a4,a5
	li	a5,2019913728
	addi	a5,a5,-959
	bne	a4,a5,.L15
	lui	a5,%hi(ram)
	ld	a5,%lo(ram)(a5)
	addi	a5,a5,4
	lw	a5,0(a5)
	mv	a4,a5
	li	a5,2019913728
	addi	a5,a5,-959
	bne	a4,a5,.L15
	lui	a5,%hi(ram)
	ld	a5,%lo(ram)(a5)
	addi	a5,a5,8
	lw	a5,0(a5)
	mv	a4,a5
	li	a5,2019913728
	addi	a5,a5,-959
	bne	a4,a5,.L15
	lui	a5,%hi(ram)
	ld	a5,%lo(ram)(a5)
	addi	a5,a5,12
	lw	a5,0(a5)
	mv	a4,a5
	li	a5,2019913728
	addi	a5,a5,-959
	bne	a4,a5,.L15
	lui	a5,%hi(ram)
	ld	a5,%lo(ram)(a5)
	sw	zero,0(a5)
	li	a5,1
	j	.L14
.L15:
	li	a5,0
.L14:
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	bl_request, .-bl_request
	.align	1
	.type	timer_reset, @function
timer_reset:
	addi	sp,sp,-16
	sd	s0,8(sp)
	addi	s0,sp,16
	li	a5,1879076864
	slli	a5,a5,1
	addi	a5,a5,16
	sw	zero,0(a5)
	li	a5,1879076864
	slli	a5,a5,1
	addi	a5,a5,16
	li	a4,798720
	addi	a4,a4,1280
	sw	a4,4(a5)
	li	a5,1879076864
	slli	a5,a5,1
	addi	a4,a5,16
	li	a5,1879076864
	slli	a5,a5,1
	addi	a5,a5,16
	lw	a4,4(a4)
	sext.w	a4,a4
	sw	a4,8(a5)
	li	a5,1879076864
	slli	a5,a5,1
	addi	a5,a5,16
	li	a4,5
	sw	a4,0(a5)
	nop
	ld	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	timer_reset, .-timer_reset
	.align	1
	.type	timer_expired, @function
timer_expired:
	addi	sp,sp,-16
	sd	s0,8(sp)
	addi	s0,sp,16
	li	a5,1879076864
	slli	a5,a5,1
	addi	a5,a5,16
	lw	a5,0(a5)
	sext.w	a5,a5
	slli	a4,a5,32
	srli	a4,a4,32
	li	a5,65536
	and	a5,a4,a5
	snez	a5,a5
	andi	a5,a5,0xff
	mv	a0,a5
	ld	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	timer_expired, .-timer_expired
	.align	1
	.type	uart_init, @function
uart_init:
	addi	sp,sp,-16
	sd	s0,8(sp)
	addi	s0,sp,16
	li	a5,1090535424
	addi	a5,a5,1024
	lbu	a5,87(a5)
	andi	a4,a5,0xff
	li	a5,1090535424
	addi	a5,a5,1024
	ori	a4,a4,1
	andi	a4,a4,0xff
	sb	a4,87(a5)
	li	a5,1090535424
	addi	a5,a5,1024
	lbu	a4,59(a5)
	andi	a4,a4,15
	ori	a4,a4,32
	sb	a4,59(a5)
	li	a5,1090535424
	addi	a5,a5,1024
	lbu	a5,86(a5)
	andi	a4,a5,0xff
	li	a5,1090535424
	addi	a5,a5,1024
	ori	a4,a4,1
	andi	a4,a4,0xff
	sb	a4,86(a5)
	li	a5,1090535424
	addi	a5,a5,1024
	lbu	a4,59(a5)
	andi	a4,a4,-16
	ori	a4,a4,2
	sb	a4,59(a5)
	li	a5,1073741824
	addi	a5,a5,1024
	lw	a5,32(a5)
	sext.w	a4,a5
	li	a5,1073741824
	addi	a5,a5,1024
	ori	a4,a4,32
	sext.w	a4,a4
	sw	a4,32(a5)
	li	a5,1073745920
	addi	a5,a5,-1024
	li	a4,16384
	addi	a4,a4,23
	sh	a4,2(a5)
	li	a5,1107300352
	addi	a5,a5,1024
	li	a4,1141907456
	addi	a4,a4,4
	sw	a4,0(a5)
	li	a5,1107300352
	addi	a5,a5,1024
	li	a4,196608
	sw	a4,4(a5)
	li	a5,1107300352
	addi	a5,a5,1024
	li	a4,16384
	addi	a4,a4,4
	sh	a4,12(a5)
	li	a5,1107300352
	addi	a5,a5,1024
	lw	a5,0(a5)
	sext.w	a4,a5
	li	a5,1107300352
	addi	a5,a5,1024
	ori	a4,a4,2
	sext.w	a4,a4
	sw	a4,0(a5)
	nop
	ld	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	uart_init, .-uart_init
	.align	1
	.type	send_response, @function
send_response:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	mv	a5,a0
	sw	a5,-20(s0)
	nop
.L21:
	li	a5,1107300352
	addi	a5,a5,1024
	lw	a5,24(a5)
	andi	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L21
	li	a5,1107300352
	addi	a5,a5,1024
	lw	a4,-20(s0)
	slli	a4,a4,48
	srli	a4,a4,48
	sh	a4,40(a5)
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	send_response, .-send_response
	.align	1
	.type	uart_sync, @function
uart_sync:
	addi	sp,sp,-16
	sd	s0,8(sp)
	addi	s0,sp,16
	nop
.L23:
	li	a5,1107300352
	addi	a5,a5,1024
	lw	a5,24(a5)
	srliw	a5,a5,1
	andi	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L23
	nop
	nop
	ld	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	uart_sync, .-uart_sync
	.align	1
	.type	uart_task, @function
uart_task:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	lui	a5,%hi(uart_command)
	lw	a5,%lo(uart_command)(a5)
	bne	a5,zero,.L36
	li	a5,1107300352
	addi	a5,a5,1024
	lw	a5,24(a5)
	srliw	a5,a5,2
	andi	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L37
	li	a5,1107300352
	addi	a5,a5,1024
	lhu	a5,40(a5)
	slli	a5,a5,48
	srli	a5,a5,48
	sw	a5,-20(s0)
	call	timer_expired
	mv	a5,a0
	beq	a5,zero,.L28
	lui	a5,%hi(command.2)
	sw	zero,%lo(command.2)(a5)
.L28:
	lui	a5,%hi(command.2)
	lw	a5,%lo(command.2)(a5)
	bne	a5,zero,.L29
	lui	a5,%hi(ptr.1)
	sw	zero,%lo(ptr.1)(a5)
	lui	a5,%hi(command.2)
	lw	a4,-20(s0)
	sw	a4,%lo(command.2)(a5)
	lui	a5,%hi(uart_buffer)
	addi	a5,a5,%lo(uart_buffer)
	sb	zero,0(a5)
	lui	a5,%hi(command.2)
	lw	a5,%lo(command.2)(a5)
	mv	a4,a5
	li	a5,160
	bne	a4,a5,.L30
	lui	a5,%hi(size.0)
	li	a4,28
	sw	a4,%lo(size.0)(a5)
	j	.L31
.L30:
	lui	a5,%hi(command.2)
	lw	a5,%lo(command.2)(a5)
	mv	a4,a5
	li	a5,161
	bne	a4,a5,.L32
	lui	a5,%hi(size.0)
	li	a4,280
	sw	a4,%lo(size.0)(a5)
	j	.L31
.L32:
	lui	a5,%hi(command.2)
	lw	a5,%lo(command.2)(a5)
	mv	a4,a5
	li	a5,162
	bne	a4,a5,.L33
	lui	a5,%hi(size.0)
	li	a4,4
	sw	a4,%lo(size.0)(a5)
	j	.L31
.L33:
	lui	a5,%hi(command.2)
	lw	a5,%lo(command.2)(a5)
	mv	a4,a5
	li	a5,163
	bne	a4,a5,.L34
	lui	a5,%hi(size.0)
	li	a4,20
	sw	a4,%lo(size.0)(a5)
	j	.L31
.L34:
	lui	a5,%hi(size.0)
	sw	zero,%lo(size.0)(a5)
	j	.L31
.L29:
	lui	a5,%hi(ptr.1)
	lw	a4,%lo(ptr.1)(a5)
	lui	a5,%hi(size.0)
	lw	a5,%lo(size.0)(a5)
	bge	a4,a5,.L31
	lui	a5,%hi(ptr.1)
	lw	a5,%lo(ptr.1)(a5)
	addiw	a4,a5,1
	sext.w	a3,a4
	lui	a4,%hi(ptr.1)
	sw	a3,%lo(ptr.1)(a4)
	lw	a4,-20(s0)
	andi	a4,a4,0xff
	lui	a3,%hi(uart_buffer)
	addi	a3,a3,%lo(uart_buffer)
	add	a5,a3,a5
	sb	a4,0(a5)
.L31:
	lui	a5,%hi(ptr.1)
	lw	a4,%lo(ptr.1)(a5)
	lui	a5,%hi(size.0)
	lw	a5,%lo(size.0)(a5)
	bne	a4,a5,.L35
	lui	a5,%hi(command.2)
	lw	a4,%lo(command.2)(a5)
	lui	a5,%hi(uart_command)
	sw	a4,%lo(uart_command)(a5)
	lui	a5,%hi(command.2)
	sw	zero,%lo(command.2)(a5)
.L35:
	call	timer_reset
	j	.L24
.L36:
	nop
	j	.L24
.L37:
	nop
.L24:
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	uart_task, .-uart_task
	.align	1
	.type	icmp, @function
icmp:
	addi	sp,sp,-64
	sd	s0,56(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	mv	a5,a2
	sw	a5,-52(s0)
	sw	zero,-20(s0)
	j	.L39
.L42:
	lw	a5,-20(s0)
	ld	a4,-40(s0)
	add	a5,a4,a5
	lbu	a3,0(a5)
	lw	a5,-20(s0)
	ld	a4,-48(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a3
	beq	a4,a5,.L40
	li	a5,0
	j	.L41
.L40:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L39:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-52(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	blt	a4,a5,.L42
	li	a5,1
.L41:
	mv	a0,a5
	ld	s0,56(sp)
	addi	sp,sp,64
	jr	ra
	.size	icmp, .-icmp
	.align	1
	.type	command_task, @function
command_task:
	addi	sp,sp,-352
	sd	ra,344(sp)
	sd	s0,336(sp)
	sd	s1,328(sp)
	addi	s0,sp,352
	lui	a5,%hi(uart_buffer)
	addi	a5,a5,%lo(uart_buffer)
	sd	a5,-48(s0)
	ld	a5,-48(s0)
	lw	a5,0(a5)
	mv	a4,a5
	li	a5,2019913728
	addi	a5,a5,-959
	beq	a4,a5,.L44
	li	a0,81
	call	send_response
	j	.L45
.L44:
	lui	a5,%hi(uart_command)
	lw	a5,%lo(uart_command)(a5)
	mv	a4,a5
	li	a5,160
	bne	a4,a5,.L46
	ld	a5,-48(s0)
	addi	a5,a5,4
	lw	a5,0(a5)
	andi	a5,a5,-256
	sw	a5,-60(s0)
	ld	a5,-48(s0)
	addi	a5,a5,8
	lw	a5,0(a5)
	andi	a5,a5,-256
	sext.w	a5,a5
	lw	a4,-60(s0)
	addw	a5,a4,a5
	sw	a5,-64(s0)
	lw	a5,-64(s0)
	mv	a4,a5
	lw	a5,-60(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bleu	a4,a5,.L47
	lw	a5,-64(s0)
	sext.w	a4,a5
	li	a5,262144
	bgtu	a4,a5,.L47
	addi	a5,s0,-344
	mv	a0,a5
	call	spritz_initialize_state
	addi	a4,s0,-344
	li	a2,16
	lui	a5,%hi(security_key)
	addi	a1,a5,%lo(security_key)
	mv	a0,a4
	call	spritz_absorb
	addi	a4,s0,-344
	li	a2,28
	lui	a5,%hi(uart_buffer)
	addi	a1,a5,%lo(uart_buffer)
	mv	a0,a4
	call	spritz_absorb
	addi	a4,s0,-344
	li	a2,16
	lui	a5,%hi(session_key)
	addi	a1,a5,%lo(session_key)
	mv	a0,a4
	call	spritz_squeeze
	lui	a5,%hi(unlock_begin)
	lw	a4,-60(s0)
	sw	a4,%lo(unlock_begin)(a5)
	lui	a5,%hi(unlock_end)
	lw	a4,-64(s0)
	sw	a4,%lo(unlock_end)(a5)
	lui	a5,%hi(flash_verify_ok)
	li	a4,1
	sb	a4,%lo(flash_verify_ok)(a5)
	li	a0,80
	call	send_response
	j	.L45
.L47:
	lui	a5,%hi(unlock_end)
	sw	zero,%lo(unlock_end)(a5)
	lui	a5,%hi(flash_verify_ok)
	sb	zero,%lo(flash_verify_ok)(a5)
	li	a0,81
	call	send_response
	j	.L45
.L46:
	lui	a5,%hi(uart_command)
	lw	a5,%lo(uart_command)(a5)
	mv	a4,a5
	li	a5,161
	bne	a4,a5,.L49
	ld	a5,-48(s0)
	lw	a4,4(a5)
	lui	a5,%hi(flash_addr)
	sw	a4,%lo(flash_addr)(a5)
	lui	a5,%hi(unlock_begin)
	lw	a4,%lo(unlock_begin)(a5)
	lui	a5,%hi(flash_addr)
	lw	a5,%lo(flash_addr)(a5)
	bgtu	a4,a5,.L50
	lui	a5,%hi(flash_addr)
	lw	a4,%lo(flash_addr)(a5)
	lui	a5,%hi(unlock_end)
	lw	a5,%lo(unlock_end)(a5)
	bgeu	a4,a5,.L50
	lui	a5,%hi(uart_buffer+264)
	addi	a5,a5,%lo(uart_buffer+264)
	sd	a5,-56(s0)
	addi	a5,s0,-344
	mv	a0,a5
	call	spritz_initialize_state
	addi	a4,s0,-344
	li	a2,16
	lui	a5,%hi(session_key)
	addi	a1,a5,%lo(session_key)
	mv	a0,a4
	call	spritz_absorb
	addi	a5,s0,-344
	li	a1,65
	mv	a0,a5
	call	spritz_absorb_byte
	addi	a4,s0,-344
	li	a2,264
	lui	a5,%hi(uart_buffer)
	addi	a1,a5,%lo(uart_buffer)
	mv	a0,a4
	call	spritz_absorb
	addi	a4,s0,-80
	addi	a5,s0,-344
	li	a2,16
	mv	a1,a4
	mv	a0,a5
	call	spritz_squeeze
	addi	a5,s0,-80
	li	a2,16
	mv	a1,a5
	ld	a0,-56(s0)
	call	icmp
	mv	a5,a0
	beq	a5,zero,.L51
	addi	a5,s0,-344
	mv	a0,a5
	call	spritz_initialize_state
	addi	a4,s0,-344
	li	a2,16
	lui	a5,%hi(session_key)
	addi	a1,a5,%lo(session_key)
	mv	a0,a4
	call	spritz_absorb
	addi	a5,s0,-344
	li	a1,69
	mv	a0,a5
	call	spritz_absorb_byte
	addi	a4,s0,-344
	li	a2,8
	lui	a5,%hi(uart_buffer)
	addi	a1,a5,%lo(uart_buffer)
	mv	a0,a4
	call	spritz_absorb
	sw	zero,-36(s0)
	j	.L52
.L53:
	lw	a5,-36(s0)
	addiw	a5,a5,8
	sext.w	a5,a5
	lui	a4,%hi(uart_buffer)
	addi	a4,a4,%lo(uart_buffer)
	add	a5,a4,a5
	lbu	s1,0(a5)
	addi	a5,s0,-344
	mv	a0,a5
	call	spritz_drip
	mv	a5,a0
	subw	a5,s1,a5
	andi	a4,a5,0xff
	lui	a5,%hi(flash_data)
	addi	a3,a5,%lo(flash_data)
	lw	a5,-36(s0)
	add	a5,a3,a5
	sb	a4,0(a5)
	lw	a5,-36(s0)
	addiw	a5,a5,1
	sw	a5,-36(s0)
.L52:
	lw	a5,-36(s0)
	sext.w	a4,a5
	li	a5,255
	ble	a4,a5,.L53
	lui	a5,%hi(flash_data_ready)
	li	a4,1
	sb	a4,%lo(flash_data_ready)(a5)
	li	a0,80
	call	send_response
	j	.L45
.L51:
	li	a0,81
	call	send_response
	j	.L45
.L50:
	li	a0,81
	call	send_response
	j	.L45
.L49:
	lui	a5,%hi(uart_command)
	lw	a5,%lo(uart_command)(a5)
	mv	a4,a5
	li	a5,162
	bne	a4,a5,.L56
	lui	a5,%hi(flash_verify_ok)
	lbu	a5,%lo(flash_verify_ok)(a5)
	beq	a5,zero,.L57
	li	a5,83
	j	.L58
.L57:
	li	a5,84
.L58:
	mv	a0,a5
	call	send_response
	j	.L45
.L56:
	lui	a5,%hi(uart_command)
	lw	a5,%lo(uart_command)(a5)
	mv	a4,a5
	li	a5,163
	bne	a4,a5,.L59
	lui	a5,%hi(ram)
	ld	a5,%lo(ram)(a5)
	ld	a4,-48(s0)
	lw	a4,4(a4)
	sw	a4,0(a5)
	lui	a5,%hi(ram)
	ld	a5,%lo(ram)(a5)
	addi	a5,a5,4
	ld	a4,-48(s0)
	lw	a4,8(a4)
	sw	a4,0(a5)
	lui	a5,%hi(ram)
	ld	a5,%lo(ram)(a5)
	addi	a5,a5,8
	ld	a4,-48(s0)
	lw	a4,12(a4)
	sw	a4,0(a5)
	lui	a5,%hi(ram)
	ld	a5,%lo(ram)(a5)
	addi	a5,a5,12
	ld	a4,-48(s0)
	lw	a4,16(a4)
	sw	a4,0(a5)
	li	a0,80
	call	send_response
	call	uart_sync
	call	NVIC_SystemReset
	j	.L45
.L59:
	li	a0,82
	call	send_response
.L45:
	lui	a5,%hi(uart_command)
	sw	zero,%lo(uart_command)(a5)
	nop
	ld	ra,344(sp)
	ld	s0,336(sp)
	ld	s1,328(sp)
	addi	sp,sp,352
	jr	ra
	.size	command_task, .-command_task
	.align	1
	.type	flash_task, @function
flash_task:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	lui	a5,%hi(flash_addr)
	lw	a5,%lo(flash_addr)(a5)
	slli	a5,a5,32
	srli	a5,a5,32
	sd	a5,-24(s0)
	lui	a5,%hi(flash_data)
	addi	a5,a5,%lo(flash_data)
	sd	a5,-32(s0)
	lui	a5,%hi(flash_addr)
	lw	a4,%lo(flash_addr)(a5)
	li	a5,1090535424
	srliw	a4,a4,1
	sext.w	a4,a4
	sw	a4,28(a5)
	li	a5,1090535424
	li	a4,-24576
	addi	a4,a4,1345
	sh	a4,0(a5)
	j	.L61
.L62:
	call	uart_task
.L61:
	li	a5,1090535424
	lw	a5,20(a5)
	andi	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L62
	li	a5,1090535424
	li	a4,-24576
	addi	a4,a4,1282
	sh	a4,0(a5)
	j	.L63
.L64:
	call	uart_task
.L63:
	li	a5,1090535424
	lw	a5,20(a5)
	andi	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L64
	sw	zero,-36(s0)
	j	.L65
.L70:
	sw	zero,-40(s0)
	j	.L66
.L67:
	lw	a5,-40(s0)
	slli	a5,a5,2
	ld	a4,-32(s0)
	add	a4,a4,a5
	lw	a5,-40(s0)
	slli	a5,a5,2
	ld	a3,-24(s0)
	add	a5,a3,a5
	lw	a4,0(a4)
	sw	a4,0(a5)
	lw	a5,-40(s0)
	addiw	a5,a5,1
	sw	a5,-40(s0)
.L66:
	lw	a5,-40(s0)
	sext.w	a4,a5
	li	a5,15
	ble	a4,a5,.L67
	j	.L68
.L69:
	call	uart_task
.L68:
	li	a5,1090535424
	lw	a5,20(a5)
	andi	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L69
	li	a2,64
	ld	a1,-24(s0)
	ld	a0,-32(s0)
	call	icmp
	mv	a5,a0
	mv	a3,a5
	lui	a5,%hi(flash_verify_ok)
	lbu	a5,%lo(flash_verify_ok)(a5)
	sext.w	a4,a5
	sext.w	a5,a3
	and	a5,a4,a5
	sext.w	a5,a5
	snez	a5,a5
	andi	a4,a5,0xff
	lui	a5,%hi(flash_verify_ok)
	sb	a4,%lo(flash_verify_ok)(a5)
	ld	a5,-32(s0)
	addi	a5,a5,64
	sd	a5,-32(s0)
	ld	a5,-24(s0)
	addi	a5,a5,64
	sd	a5,-24(s0)
	lw	a5,-36(s0)
	addiw	a5,a5,1
	sw	a5,-36(s0)
.L65:
	lw	a5,-36(s0)
	sext.w	a4,a5
	li	a5,3
	ble	a4,a5,.L70
	lui	a5,%hi(flash_data_ready)
	sb	zero,%lo(flash_data_ready)(a5)
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	flash_task, .-flash_task
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	call	bl_request
	mv	a5,a0
	xori	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L72
	call	run_application
.L72:
	call	sys_init
	call	uart_init
.L75:
	call	uart_task
	lui	a5,%hi(flash_data_ready)
	lbu	a5,%lo(flash_data_ready)(a5)
	beq	a5,zero,.L73
	call	flash_task
	j	.L75
.L73:
	lui	a5,%hi(uart_command)
	lw	a5,%lo(uart_command)(a5)
	beq	a5,zero,.L75
	call	command_task
	j	.L75
	.size	main, .-main
	.local	command.2
	.comm	command.2,4,4
	.local	ptr.1
	.comm	ptr.1,4,4
	.local	size.0
	.comm	size.0,4,4
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
