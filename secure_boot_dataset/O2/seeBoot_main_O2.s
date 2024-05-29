	.file	"main.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	__boot
	.type	__boot, @function
__boot:
	slli	a5,a0,32
	addi	sp,sp,-32
	srli	a5,a5,32
	sd	ra,24(sp)
	sd	s0,16(sp)
	sd	s1,8(sp)
	sd	s2,0(sp)
	lw	s1,0(a5)
	lw	s2,4(a5)
	mv	s0,a0
	call	timerClose
	call	commDispose
	call	flashClose
	li	a5,469770240
	addi	a5,a5,-607
	slli	a5,a5,3
	sw	s0,0(a5)
 #APP
# 302 "main.c" 1
	msr msp, s1	
bx	s2	

# 0 "" 2
 #NO_APP
.L2:
	j	.L2
	.size	__boot, .-__boot
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"a"
	.text
	.align	1
	.globl	__sendAck
	.type	__sendAck, @function
__sendAck:
	addi	sp,sp,-16
	sd	ra,8(sp)
	call	commSendHeader
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	commSendBody
	ld	ra,8(sp)
	li	a0,1
	addi	sp,sp,16
	tail	commSendFooter
	.size	__sendAck, .-__sendAck
	.section	.rodata.str1.8
	.align	3
.LC1:
	.string	"n"
	.text
	.align	1
	.globl	__sendNack
	.type	__sendNack, @function
__sendNack:
	addi	sp,sp,-16
	sd	ra,8(sp)
	call	commSendHeader
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	commSendBody
	ld	ra,8(sp)
	li	a0,1
	addi	sp,sp,16
	tail	commSendFooter
	.size	__sendNack, .-__sendNack
	.section	.rodata.str1.8
	.align	3
.LC2:
	.string	"987654321"
	.text
	.align	1
	.globl	__waitPINCommand
	.type	__waitPINCommand, @function
__waitPINCommand:
	addi	sp,sp,-64
	li	a0,1000
	sd	s0,48(sp)
	sd	s1,40(sp)
	sd	s2,32(sp)
	sd	s3,24(sp)
	sd	s4,16(sp)
	sd	s5,8(sp)
	sd	ra,56(sp)
	sd	s6,0(sp)
	lui	s0,%hi(cmdArgCnt)
	call	timerSet
	lui	s1,%hi(cmdArgStr)
	li	s2,-1
	lui	s3,%hi(cmdChar)
	lui	s5,%hi(.LC2)
	lui	s4,%hi(.LC1)
.L11:
	call	timerGet
	sext.w	a0,a0
	beq	a0,zero,.L25
.L15:
	sw	s2,%lo(cmdArgCnt)(s0)
	sd	zero,%lo(cmdArgStr)(s1)
	call	commParse
	beq	a0,zero,.L11
	lbu	a5,0(a0)
	lbu	a4,1(a0)
	sw	zero,%lo(cmdArgCnt)(s0)
	sb	a5,%lo(cmdChar)(s3)
	bne	a4,zero,.L26
.L12:
	call	commSendHeader
	addi	a0,s4,%lo(.LC1)
	call	commSendBody
	li	a0,1
	call	commSendFooter
	call	timerGet
	sext.w	a0,a0
	bne	a0,zero,.L15
.L25:
	li	s6,-1
	j	.L22
.L26:
	li	a4,1
	addi	a0,a0,1
	sw	a4,%lo(cmdArgCnt)(s0)
	sd	a0,%lo(cmdArgStr)(s1)
	li	a4,105
	addi	a1,s5,%lo(.LC2)
	bne	a5,a4,.L12
	call	strcmp
	mv	s6,a0
	bne	a0,zero,.L12
	call	commSendHeader
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	commSendBody
	li	a0,1
	call	commSendFooter
.L22:
	ld	ra,56(sp)
	ld	s0,48(sp)
	ld	s1,40(sp)
	ld	s2,32(sp)
	ld	s3,24(sp)
	ld	s4,16(sp)
	ld	s5,8(sp)
	mv	a0,s6
	ld	s6,0(sp)
	addi	sp,sp,64
	jr	ra
	.size	__waitPINCommand, .-__waitPINCommand
	.section	.rodata.str1.8
	.align	3
.LC3:
	.string	" "
	.align	3
.LC4:
	.string	" Cheking Firmware..."
	.align	3
.LC5:
	.string	" Firmware Found: "
	.align	3
.LC6:
	.string	" Auto-boot in "
	.align	3
.LC7:
	.string	" No bootable image found!"
	.align	3
.LC8:
	.string	" Booting..."
	.align	3
.LC9:
	.string	" Manual Boot (Boot Command Shell)"
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-144
	sd	ra,136(sp)
	sd	s0,128(sp)
	sd	s1,120(sp)
	sd	s2,112(sp)
	sd	s3,104(sp)
	sd	s4,96(sp)
	sd	s5,88(sp)
	sd	s6,80(sp)
	sd	s7,72(sp)
	sd	s8,64(sp)
	sd	s9,56(sp)
	sd	s10,48(sp)
	sd	s11,40(sp)
	call	timerInit
	call	commInit
	call	flashInit
	li	a0,1000
	call	timerSet
.L28:
	call	timerGet
	sext.w	a0,a0
	bne	a0,zero,.L28
	lui	s8,%hi(.LANCHOR1)
	lui	s7,%hi(bootable)
	lui	s4,%hi(bootTimeout)
	lui	s1,%hi(cmdArgCnt)
	lui	s3,%hi(cmdChar)
	li	s5,-1
.L53:
	call	commSendHeader
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	commSendBody
	lui	a5,%hi(.LANCHOR0)
	addi	a0,a5,%lo(.LANCHOR0)
	call	commSendBody
	li	a0,0
	call	commSendFooter
	call	commSendHeader
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	commSendBody
	li	a0,0
	call	commSendFooter
	addi	a0,s8,%lo(.LANCHOR1)
	call	flashGetNameString
	sw	a0,%lo(bootable)(s7)
	beq	a0,zero,.L70
	li	a5,-1
	sw	a5,%lo(bootTimeout)(s4)
	call	commSendHeader
	lui	a5,%hi(.LC7)
	addi	a0,a5,%lo(.LC7)
	call	commSendBody
	li	a0,0
	call	commSendFooter
.L32:
	lw	a5,%lo(bootTimeout)(s4)
	beq	a5,zero,.L71
	call	commSendHeader
	lui	a0,%hi(.LC9)
	addi	a0,a0,%lo(.LC9)
	call	commSendBody
	li	a0,0
	call	commSendFooter
	li	a0,61440
	addi	a0,a0,-1440
	call	timerSet
	lui	s0,%hi(cmdArgStr)
	li	s6,1
.L35:
	call	timerGet
	sext.w	a0,a0
	beq	a0,zero,.L53
	sw	s5,%lo(cmdArgCnt)(s1)
	sd	zero,%lo(cmdArgStr)(s0)
	call	commParse
	beq	a0,zero,.L35
	lbu	a4,0(a0)
	lbu	a5,1(a0)
	sw	zero,%lo(cmdArgCnt)(s1)
	sb	a4,%lo(cmdChar)(s3)
	beq	a5,zero,.L36
	addi	a0,a0,1
	sd	a0,%lo(cmdArgStr)(s0)
	sw	s6,%lo(cmdArgCnt)(s1)
.L36:
	li	a0,61440
	addi	a0,a0,-1440
	call	timerSet
	lbu	a5,%lo(cmdChar)(s3)
	li	a4,98
	beq	a5,a4,.L72
	li	a4,101
	beq	a5,a4,.L73
	li	a4,112
	beq	a5,a4,.L74
	li	a4,118
	bne	a5,a4,.L35
	lw	a4,%lo(cmdArgCnt)(s1)
	li	a5,1
	bne	a4,a5,.L48
	ld	a0,%lo(cmdArgStr)(s0)
	call	strlen
	li	a5,160
	beq	a0,a5,.L75
.L48:
	call	__sendNack
	j	.L35
.L74:
	lw	a5,%lo(cmdArgCnt)(s1)
	bne	a5,s6,.L44
	ld	a0,%lo(cmdArgStr)(s0)
	call	strlen
	li	a5,160
	beq	a0,a5,.L45
.L44:
	call	commSendHeader
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	commSendBody
	li	a0,1
	call	commSendFooter
	j	.L35
.L72:
	addi	a0,s8,%lo(.LANCHOR1)
	call	flashGetNameString
	sw	a0,%lo(bootable)(s7)
	bne	a0,zero,.L38
	call	__sendAck
.L39:
	call	commFlush
	lw	a5,%lo(bootable)(s7)
	bne	a5,zero,.L35
	li	a0,134234112
	call	__boot
.L38:
	call	__sendNack
	j	.L39
.L73:
	call	flashErease
	call	__sendAck
	j	.L35
.L70:
	call	commSendHeader
	lui	a0,%hi(.LC5)
	addi	a0,a0,%lo(.LC5)
	call	commSendBody
	addi	a0,s8,%lo(.LANCHOR1)
	call	commSendBody
	li	a0,0
	call	commSendFooter
	li	a5,5
	sw	a5,%lo(bootTimeout)(s4)
	lui	s2,%hi(.LC6)
	li	s0,120
	j	.L31
.L76:
	lw	a5,%lo(bootTimeout)(s4)
	addiw	a4,a5,-1
	sw	a4,%lo(bootTimeout)(s4)
	ble	a4,zero,.L32
.L31:
	sh	s0,24(sp)
	call	commSendHeader
	addi	a0,s2,%lo(.LC6)
	call	commSendBody
	lw	a5,%lo(bootTimeout)(s4)
	addi	a0,sp,24
	addiw	a5,a5,48
	sb	a5,24(sp)
	call	commSendBody
	li	a0,0
	call	commSendFooter
	call	__waitPINCommand
	bne	a0,zero,.L76
	j	.L32
.L45:
	addi	a5,s8,%lo(.LANCHOR1)
	addi	a4,a5,24
	sd	a5,0(sp)
	sd	a4,8(sp)
	mv	s11,a4
	addi	s2,a5,104
	li	s10,1
.L46:
	ld	a5,%lo(cmdArgStr)(s0)
	addi	s11,s11,1
	add	a5,a5,s10
	lbu	a0,0(a5)
	call	HexToInt
	ld	a2,%lo(cmdArgStr)(s0)
	mv	s9,a0
	add	a2,a2,s10
	lbu	a0,-1(a2)
	addi	s10,s10,2
	call	HexToInt
	slliw	a0,a0,4
	or	a5,s9,a0
	sb	a5,-1(s11)
	bne	s11,s2,.L46
	ld	s2,0(sp)
	ld	s9,8(sp)
	lui	a5,%hi(.LANCHOR0)
	addi	a1,a5,%lo(.LANCHOR0)
	li	a4,18
	addi	a2,a1,16
	addi	a3,s2,32
	addi	a1,a1,32
	mv	a0,s9
	call	blockDecipher
	call	crcReset
	li	a1,19
	mv	a0,s9
	call	crcCalculate
	lw	a4,100(s2)
	sext.w	a5,a0
	bne	a4,a5,.L48
	ld	a5,0(sp)
	li	a2,16
	lw	a1,32(a5)
	addi	a0,a5,36
	call	flashWriteAddress
	bne	a0,zero,.L48
.L51:
	call	__sendAck
	j	.L35
.L75:
	addi	a5,s8,%lo(.LANCHOR1)
	addi	a4,a5,24
	sd	a5,0(sp)
	sd	a4,8(sp)
	mv	s10,a4
	addi	s2,a5,104
	li	s11,1
.L50:
	ld	a5,%lo(cmdArgStr)(s0)
	addi	s10,s10,1
	add	a5,a5,s11
	lbu	a0,0(a5)
	call	HexToInt
	ld	a2,%lo(cmdArgStr)(s0)
	mv	s9,a0
	add	a2,a2,s11
	lbu	a0,-1(a2)
	addi	s11,s11,2
	call	HexToInt
	slliw	a0,a0,4
	or	a5,s9,a0
	sb	a5,-1(s10)
	bne	s10,s2,.L50
	ld	s2,0(sp)
	ld	s9,8(sp)
	lui	a5,%hi(.LANCHOR0)
	addi	a1,a5,%lo(.LANCHOR0)
	li	a4,18
	addi	a2,a1,16
	addi	a3,s2,32
	addi	a1,a1,32
	mv	a0,s9
	call	blockDecipher
	call	crcReset
	li	a1,19
	mv	a0,s9
	call	crcCalculate
	lw	a4,100(s2)
	sext.w	a5,a0
	bne	a4,a5,.L48
	ld	a5,0(sp)
	li	a2,16
	lw	a1,32(a5)
	addi	a0,a5,36
	call	flashVerifyAddress
	beq	a0,zero,.L51
	j	.L48
.L71:
	call	commSendHeader
	lui	a0,%hi(.LC8)
	addi	a0,a0,%lo(.LC8)
	call	commSendBody
	li	a0,0
	call	commSendFooter
	call	commFlush
	li	a0,134234112
	call	__boot
	.size	main, .-main
	.text
	.align	1
	.globl	__waitBootCommand
	.type	__waitBootCommand, @function
__waitBootCommand:
	addi	sp,sp,-32
	sd	s0,16(sp)
	sd	s1,8(sp)
	lui	s0,%hi(cmdArgCnt)
	lui	s1,%hi(cmdArgStr)
	li	a5,-1
	sd	ra,24(sp)
	sw	a5,%lo(cmdArgCnt)(s0)
	sd	zero,%lo(cmdArgStr)(s1)
	call	commParse
	beq	a0,zero,.L81
	lbu	a3,0(a0)
	lbu	a5,1(a0)
	lui	a4,%hi(cmdChar)
	sw	zero,%lo(cmdArgCnt)(s0)
	sb	a3,%lo(cmdChar)(a4)
	bne	a5,zero,.L79
.L80:
	li	a0,0
.L78:
	ld	ra,24(sp)
	ld	s0,16(sp)
	ld	s1,8(sp)
	addi	sp,sp,32
	jr	ra
.L79:
	addi	a0,a0,1
	li	a5,1
	sd	a0,%lo(cmdArgStr)(s1)
	sw	a5,%lo(cmdArgCnt)(s0)
	j	.L80
.L81:
	li	a0,-1
	j	.L78
	.size	__waitBootCommand, .-__waitBootCommand
	.globl	tmp
	.globl	pkt
	.globl	key2
	.globl	key1
	.globl	pinIndex
	.globl	pin
	.globl	checksum
	.globl	bootTimeout
	.globl	bootImageName
	.globl	bootable
	.globl	BootloaderNameString
	.data
	.align	3
	.set	.LANCHOR0,. + 0
	.type	BootloaderNameString, @object
	.size	BootloaderNameString, 13
BootloaderNameString:
	.string	"seeBoot v0.1"
	.zero	3
	.type	key2, @object
	.size	key2, 16
key2:
	.word	19088743
	.word	-1985229329
	.word	-19088744
	.word	1985229328
	.type	key1, @object
	.size	key1, 16
key1:
	.word	1122867
	.word	1146447479
	.word	-2003195205
	.word	-857870593
	.type	pin, @object
	.size	pin, 10
pin:
	.string	"987654321"
	.bss
	.align	3
	.set	.LANCHOR1,. + 0
	.type	bootImageName, @object
	.size	bootImageName, 17
bootImageName:
	.zero	17
	.zero	7
	.type	pkt, @object
	.size	pkt, 80
pkt:
	.zero	80
	.type	tmp, @object
	.size	tmp, 128
tmp:
	.zero	128
	.section	.sbss,"aw",@nobits
	.align	3
	.type	pinIndex, @object
	.size	pinIndex, 4
pinIndex:
	.zero	4
	.type	checksum, @object
	.size	checksum, 1
checksum:
	.zero	1
	.zero	3
	.type	bootTimeout, @object
	.size	bootTimeout, 4
bootTimeout:
	.zero	4
	.type	cmdArgCnt, @object
	.size	cmdArgCnt, 4
cmdArgCnt:
	.zero	4
	.type	cmdArgStr, @object
	.size	cmdArgStr, 8
cmdArgStr:
	.zero	8
	.type	cmdChar, @object
	.size	cmdChar, 1
cmdChar:
	.zero	1
	.section	.sdata,"aw"
	.align	2
	.type	bootable, @object
	.size	bootable, 4
bootable:
	.word	-1
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
