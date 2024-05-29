	.file	"main.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.local	cmdChar
	.comm	cmdChar,1,1
	.local	cmdArgStr
	.comm	cmdArgStr,8,8
	.local	cmdArgCnt
	.comm	cmdArgCnt,4,4
	.globl	BootloaderNameString
	.data
	.align	3
	.type	BootloaderNameString, @object
	.size	BootloaderNameString, 13
BootloaderNameString:
	.string	"seeBoot v0.1"
	.globl	bootable
	.section	.sdata,"aw"
	.align	2
	.type	bootable, @object
	.size	bootable, 4
bootable:
	.word	-1
	.globl	bootImageName
	.bss
	.align	3
	.type	bootImageName, @object
	.size	bootImageName, 17
bootImageName:
	.zero	17
	.globl	bootTimeout
	.section	.sbss,"aw",@nobits
	.align	2
	.type	bootTimeout, @object
	.size	bootTimeout, 4
bootTimeout:
	.zero	4
	.globl	checksum
	.type	checksum, @object
	.size	checksum, 1
checksum:
	.zero	1
	.globl	pin
	.data
	.align	3
	.type	pin, @object
	.size	pin, 10
pin:
	.string	"987654321"
	.globl	pinIndex
	.section	.sbss
	.align	2
	.type	pinIndex, @object
	.size	pinIndex, 4
pinIndex:
	.zero	4
	.globl	key1
	.data
	.align	3
	.type	key1, @object
	.size	key1, 16
key1:
	.word	1122867
	.word	1146447479
	.word	-2003195205
	.word	-857870593
	.globl	key2
	.align	3
	.type	key2, @object
	.size	key2, 16
key2:
	.word	19088743
	.word	-1985229329
	.word	-19088744
	.word	1985229328
	.globl	pkt
	.bss
	.align	3
	.type	pkt, @object
	.size	pkt, 80
pkt:
	.zero	80
	.globl	tmp
	.align	3
	.type	tmp, @object
	.size	tmp, 128
tmp:
	.zero	128
	.section	.rodata
	.align	3
.LC0:
	.string	" "
	.align	3
.LC1:
	.string	" Cheking Firmware..."
	.align	3
.LC2:
	.string	" Firmware Found: "
	.align	3
.LC3:
	.string	" Auto-boot in "
	.align	3
.LC4:
	.string	" No bootable image found!"
	.align	3
.LC5:
	.string	" Booting..."
	.align	3
.LC6:
	.string	" Manual Boot (Boot Command Shell)"
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	sd	s1,24(sp)
	addi	s0,sp,48
	call	timerInit
	call	commInit
	call	flashInit
	li	a0,1000
	call	timerSet
	nop
.L2:
	call	timerGet
	mv	a5,a0
	sext.w	a5,a5
	bne	a5,zero,.L2
.L31:
	call	commSendHeader
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	commSendBody
	lui	a5,%hi(BootloaderNameString)
	addi	a0,a5,%lo(BootloaderNameString)
	call	commSendBody
	li	a0,0
	call	commSendFooter
	call	commSendHeader
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	commSendBody
	li	a0,0
	call	commSendFooter
	lui	a5,%hi(bootImageName)
	addi	a0,a5,%lo(bootImageName)
	call	flashGetNameString
	mv	a5,a0
	mv	a4,a5
	lui	a5,%hi(bootable)
	sw	a4,%lo(bootable)(a5)
	lui	a5,%hi(bootable)
	lw	a5,%lo(bootable)(a5)
	bne	a5,zero,.L3
	call	commSendHeader
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	commSendBody
	lui	a5,%hi(bootImageName)
	addi	a0,a5,%lo(bootImageName)
	call	commSendBody
	li	a0,0
	call	commSendFooter
	lui	a5,%hi(bootTimeout)
	li	a4,5
	sw	a4,%lo(bootTimeout)(a5)
.L6:
	li	a5,120
	sh	a5,-48(s0)
	call	commSendHeader
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	commSendBody
	lui	a5,%hi(bootTimeout)
	lw	a5,%lo(bootTimeout)(a5)
	andi	a5,a5,0xff
	addiw	a5,a5,48
	andi	a5,a5,0xff
	sb	a5,-48(s0)
	addi	a5,s0,-48
	mv	a0,a5
	call	commSendBody
	li	a0,0
	call	commSendFooter
	call	__waitPINCommand
	mv	a5,a0
	beq	a5,zero,.L32
	lui	a5,%hi(bootTimeout)
	lw	a5,%lo(bootTimeout)(a5)
	addiw	a5,a5,-1
	sext.w	a4,a5
	lui	a5,%hi(bootTimeout)
	sw	a4,%lo(bootTimeout)(a5)
	lui	a5,%hi(bootTimeout)
	lw	a5,%lo(bootTimeout)(a5)
	bgt	a5,zero,.L6
	j	.L5
.L3:
	lui	a5,%hi(bootTimeout)
	li	a4,-1
	sw	a4,%lo(bootTimeout)(a5)
	call	commSendHeader
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	commSendBody
	li	a0,0
	call	commSendFooter
	j	.L5
.L32:
	nop
.L5:
	lui	a5,%hi(bootTimeout)
	lw	a5,%lo(bootTimeout)(a5)
	bgt	a5,zero,.L7
	lui	a5,%hi(bootTimeout)
	lw	a5,%lo(bootTimeout)(a5)
	bne	a5,zero,.L7
	call	commSendHeader
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	commSendBody
	li	a0,0
	call	commSendFooter
	call	commFlush
	li	a0,134234112
	call	__boot
.L7:
	call	commSendHeader
	lui	a5,%hi(.LC6)
	addi	a0,a5,%lo(.LC6)
	call	commSendBody
	li	a0,0
	call	commSendFooter
	li	a5,61440
	addi	a0,a5,-1440
	call	timerSet
	j	.L8
.L30:
	call	__waitBootCommand
	mv	a5,a0
	mv	a4,a5
	li	a5,-1
	bne	a4,a5,.L9
	j	.L8
.L9:
	li	a5,61440
	addi	a0,a5,-1440
	call	timerSet
	lui	a5,%hi(cmdChar)
	lbu	a5,%lo(cmdChar)(a5)
	mv	a4,a5
	li	a5,98
	bne	a4,a5,.L10
	lui	a5,%hi(bootImageName)
	addi	a0,a5,%lo(bootImageName)
	call	flashGetNameString
	mv	a5,a0
	mv	a4,a5
	lui	a5,%hi(bootable)
	sw	a4,%lo(bootable)(a5)
	lui	a5,%hi(bootable)
	lw	a5,%lo(bootable)(a5)
	bne	a5,zero,.L11
	call	__sendAck
	j	.L12
.L11:
	call	__sendNack
.L12:
	call	commFlush
	lui	a5,%hi(bootable)
	lw	a5,%lo(bootable)(a5)
	bne	a5,zero,.L8
	li	a0,134234112
	call	__boot
	j	.L8
.L10:
	lui	a5,%hi(cmdChar)
	lbu	a5,%lo(cmdChar)(a5)
	mv	a4,a5
	li	a5,101
	bne	a4,a5,.L14
	call	flashErease
	call	__sendAck
	j	.L8
.L14:
	lui	a5,%hi(cmdChar)
	lbu	a5,%lo(cmdChar)(a5)
	mv	a4,a5
	li	a5,112
	bne	a4,a5,.L15
	lui	a5,%hi(cmdArgCnt)
	lw	a5,%lo(cmdArgCnt)(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L16
	lui	a5,%hi(cmdArgStr)
	ld	a5,%lo(cmdArgStr)(a5)
	mv	a0,a5
	call	strlen
	mv	a4,a0
	li	a5,160
	beq	a4,a5,.L17
.L16:
	call	__sendNack
	j	.L8
.L17:
	sw	zero,-36(s0)
	j	.L18
.L19:
	lui	a5,%hi(cmdArgStr)
	ld	a4,%lo(cmdArgStr)(a5)
	lw	a5,-36(s0)
	slliw	a5,a5,1
	sext.w	a5,a5
	addi	a5,a5,1
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a0,a5
	call	HexToInt
	mv	a5,a0
	slliw	s1,a5,24
	sraiw	s1,s1,24
	lui	a5,%hi(cmdArgStr)
	ld	a5,%lo(cmdArgStr)(a5)
	lw	a4,-36(s0)
	slliw	a4,a4,1
	sext.w	a4,a4
	add	a5,a5,a4
	lbu	a5,0(a5)
	mv	a0,a5
	call	HexToInt
	mv	a5,a0
	slliw	a5,a5,24
	sraiw	a5,a5,24
	slliw	a5,a5,4
	slliw	a5,a5,24
	sraiw	a5,a5,24
	or	a5,s1,a5
	slliw	a3,a5,24
	sraiw	a3,a3,24
	lw	a4,-36(s0)
	lui	a5,%hi(pkt)
	addi	a5,a5,%lo(pkt)
	add	a5,a4,a5
	andi	a4,a3,0xff
	sb	a4,0(a5)
	lw	a5,-36(s0)
	addiw	a5,a5,1
	sw	a5,-36(s0)
.L18:
	lw	a5,-36(s0)
	mv	a4,a5
	li	a5,79
	bleu	a4,a5,.L19
	li	a4,18
	lui	a5,%hi(pkt+8)
	addi	a3,a5,%lo(pkt+8)
	lui	a5,%hi(key2)
	addi	a2,a5,%lo(key2)
	lui	a5,%hi(key1)
	addi	a1,a5,%lo(key1)
	lui	a5,%hi(pkt)
	addi	a0,a5,%lo(pkt)
	call	blockDecipher
	call	crcReset
	li	a1,19
	lui	a5,%hi(pkt)
	addi	a0,a5,%lo(pkt)
	call	crcCalculate
	mv	a5,a0
	sw	a5,-44(s0)
	lui	a5,%hi(pkt)
	addi	a5,a5,%lo(pkt)
	lw	a5,76(a5)
	sext.w	a4,a5
	lw	a5,-44(s0)
	sext.w	a5,a5
	beq	a5,a4,.L20
	call	__sendNack
	j	.L8
.L20:
	lui	a5,%hi(pkt)
	addi	a5,a5,%lo(pkt)
	lw	a5,8(a5)
	sext.w	a5,a5
	li	a2,16
	mv	a1,a5
	lui	a5,%hi(pkt+12)
	addi	a0,a5,%lo(pkt+12)
	call	flashWriteAddress
	mv	a5,a0
	bne	a5,zero,.L21
	call	__sendAck
	j	.L8
.L21:
	call	__sendNack
	j	.L8
.L15:
	lui	a5,%hi(cmdChar)
	lbu	a5,%lo(cmdChar)(a5)
	mv	a4,a5
	li	a5,118
	bne	a4,a5,.L8
	lui	a5,%hi(cmdArgCnt)
	lw	a5,%lo(cmdArgCnt)(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L23
	lui	a5,%hi(cmdArgStr)
	ld	a5,%lo(cmdArgStr)(a5)
	mv	a0,a5
	call	strlen
	mv	a4,a0
	li	a5,160
	beq	a4,a5,.L24
.L23:
	call	__sendNack
	j	.L8
.L24:
	sw	zero,-40(s0)
	j	.L25
.L26:
	lui	a5,%hi(cmdArgStr)
	ld	a4,%lo(cmdArgStr)(a5)
	lw	a5,-40(s0)
	slliw	a5,a5,1
	sext.w	a5,a5
	addi	a5,a5,1
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a0,a5
	call	HexToInt
	mv	a5,a0
	slliw	s1,a5,24
	sraiw	s1,s1,24
	lui	a5,%hi(cmdArgStr)
	ld	a5,%lo(cmdArgStr)(a5)
	lw	a4,-40(s0)
	slliw	a4,a4,1
	sext.w	a4,a4
	add	a5,a5,a4
	lbu	a5,0(a5)
	mv	a0,a5
	call	HexToInt
	mv	a5,a0
	slliw	a5,a5,24
	sraiw	a5,a5,24
	slliw	a5,a5,4
	slliw	a5,a5,24
	sraiw	a5,a5,24
	or	a5,s1,a5
	slliw	a3,a5,24
	sraiw	a3,a3,24
	lw	a4,-40(s0)
	lui	a5,%hi(pkt)
	addi	a5,a5,%lo(pkt)
	add	a5,a4,a5
	andi	a4,a3,0xff
	sb	a4,0(a5)
	lw	a5,-40(s0)
	addiw	a5,a5,1
	sw	a5,-40(s0)
.L25:
	lw	a5,-40(s0)
	mv	a4,a5
	li	a5,79
	bleu	a4,a5,.L26
	li	a4,18
	lui	a5,%hi(pkt+8)
	addi	a3,a5,%lo(pkt+8)
	lui	a5,%hi(key2)
	addi	a2,a5,%lo(key2)
	lui	a5,%hi(key1)
	addi	a1,a5,%lo(key1)
	lui	a5,%hi(pkt)
	addi	a0,a5,%lo(pkt)
	call	blockDecipher
	call	crcReset
	li	a1,19
	lui	a5,%hi(pkt)
	addi	a0,a5,%lo(pkt)
	call	crcCalculate
	mv	a5,a0
	sw	a5,-44(s0)
	lui	a5,%hi(pkt)
	addi	a5,a5,%lo(pkt)
	lw	a5,76(a5)
	sext.w	a4,a5
	lw	a5,-44(s0)
	sext.w	a5,a5
	beq	a5,a4,.L27
	call	__sendNack
	j	.L8
.L27:
	lui	a5,%hi(pkt)
	addi	a5,a5,%lo(pkt)
	lw	a5,8(a5)
	sext.w	a5,a5
	li	a2,16
	mv	a1,a5
	lui	a5,%hi(pkt+12)
	addi	a0,a5,%lo(pkt+12)
	call	flashVerifyAddress
	mv	a5,a0
	bne	a5,zero,.L28
	call	__sendAck
	j	.L33
.L28:
	call	__sendNack
.L33:
	nop
.L8:
	call	timerGet
	mv	a5,a0
	sext.w	a5,a5
	bne	a5,zero,.L30
	j	.L31
	.size	main, .-main
	.align	1
	.globl	__boot
	.type	__boot, @function
__boot:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	mv	a5,a0
	sw	a5,-36(s0)
	lwu	a5,-36(s0)
	sd	a5,-24(s0)
	ld	a5,-24(s0)
	lw	a5,0(a5)
	sw	a5,-28(s0)
	ld	a5,-24(s0)
	addi	a5,a5,4
	lw	a5,0(a5)
	sw	a5,-32(s0)
	call	timerClose
	call	commDispose
	call	flashClose
	li	a5,469770240
	addi	a5,a5,-607
	slli	a5,a5,3
	lw	a4,-36(s0)
	sw	a4,0(a5)
	lw	a5,-28(s0)
	lw	a4,-32(s0)
 #APP
# 302 "main.c" 1
	msr msp, a5	
bx	a4	

# 0 "" 2
 #NO_APP
.L35:
	j	.L35
	.size	__boot, .-__boot
	.section	.rodata
	.align	3
.LC7:
	.string	"a"
	.text
	.align	1
	.globl	__sendAck
	.type	__sendAck, @function
__sendAck:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	call	commSendHeader
	lui	a5,%hi(.LC7)
	addi	a0,a5,%lo(.LC7)
	call	commSendBody
	li	a0,1
	call	commSendFooter
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	__sendAck, .-__sendAck
	.section	.rodata
	.align	3
.LC8:
	.string	"n"
	.text
	.align	1
	.globl	__sendNack
	.type	__sendNack, @function
__sendNack:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	call	commSendHeader
	lui	a5,%hi(.LC8)
	addi	a0,a5,%lo(.LC8)
	call	commSendBody
	li	a0,1
	call	commSendFooter
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	__sendNack, .-__sendNack
	.section	.rodata
	.align	3
.LC9:
	.string	"987654321"
	.text
	.align	1
	.globl	__waitPINCommand
	.type	__waitPINCommand, @function
__waitPINCommand:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	li	a0,1000
	call	timerSet
	j	.L39
.L45:
	call	__waitBootCommand
	mv	a5,a0
	mv	a4,a5
	li	a5,-1
	bne	a4,a5,.L40
	j	.L39
.L40:
	lui	a5,%hi(cmdChar)
	lbu	a5,%lo(cmdChar)(a5)
	mv	a4,a5
	li	a5,105
	beq	a4,a5,.L41
	call	__sendNack
	j	.L39
.L41:
	lui	a5,%hi(cmdArgCnt)
	lw	a5,%lo(cmdArgCnt)(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L42
	lui	a5,%hi(cmdArgStr)
	ld	a4,%lo(cmdArgStr)(a5)
	lui	a5,%hi(.LC9)
	addi	a1,a5,%lo(.LC9)
	mv	a0,a4
	call	strcmp
	mv	a5,a0
	beq	a5,zero,.L43
.L42:
	call	__sendNack
	j	.L39
.L43:
	call	__sendAck
	li	a5,0
	j	.L44
.L39:
	call	timerGet
	mv	a5,a0
	sext.w	a5,a5
	bne	a5,zero,.L45
	li	a5,-1
.L44:
	mv	a0,a5
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	__waitPINCommand, .-__waitPINCommand
	.align	1
	.globl	__waitBootCommand
	.type	__waitBootCommand, @function
__waitBootCommand:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	lui	a5,%hi(cmdArgCnt)
	li	a4,-1
	sw	a4,%lo(cmdArgCnt)(a5)
	lui	a5,%hi(cmdArgStr)
	sd	zero,%lo(cmdArgStr)(a5)
	call	commParse
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	bne	a5,zero,.L47
	li	a5,-1
	j	.L48
.L47:
	lui	a5,%hi(cmdArgCnt)
	sw	zero,%lo(cmdArgCnt)(a5)
	ld	a5,-24(s0)
	lbu	a4,0(a5)
	lui	a5,%hi(cmdChar)
	sb	a4,%lo(cmdChar)(a5)
	ld	a5,-24(s0)
	addi	a5,a5,1
	sd	a5,-24(s0)
	ld	a5,-24(s0)
	lbu	a5,0(a5)
	beq	a5,zero,.L49
	lui	a5,%hi(cmdArgStr)
	ld	a4,-24(s0)
	sd	a4,%lo(cmdArgStr)(a5)
	lui	a5,%hi(cmdArgCnt)
	li	a4,1
	sw	a4,%lo(cmdArgCnt)(a5)
	li	a5,0
	j	.L48
.L49:
	li	a5,0
.L48:
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	__waitBootCommand, .-__waitBootCommand
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
