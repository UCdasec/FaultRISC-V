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
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	sd	s1,8(sp)
	sd	s2,0(sp)
	mv	s0,a0
	slli	a5,a0,32
	srli	a5,a5,32
	lw	s1,0(a5)
	lw	s2,4(a5)
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
	li	a0,1
	call	commSendFooter
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
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
	li	a0,1
	call	commSendFooter
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	__sendNack, .-__sendNack
	.align	1
	.globl	__waitBootCommand
	.type	__waitBootCommand, @function
__waitBootCommand:
	addi	sp,sp,-16
	sd	ra,8(sp)
	lui	a5,%hi(cmdArgCnt)
	li	a4,-1
	sw	a4,%lo(cmdArgCnt)(a5)
	lui	a5,%hi(cmdArgStr)
	sd	zero,%lo(cmdArgStr)(a5)
	call	commParse
	beq	a0,zero,.L10
	mv	a5,a0
	lui	a4,%hi(cmdArgCnt)
	sw	zero,%lo(cmdArgCnt)(a4)
	lbu	a3,0(a0)
	lui	a4,%hi(cmdChar)
	sb	a3,%lo(cmdChar)(a4)
	lbu	a4,1(a0)
	li	a0,0
	bne	a4,zero,.L13
.L9:
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
.L13:
	addi	a5,a5,1
	lui	a4,%hi(cmdArgStr)
	sd	a5,%lo(cmdArgStr)(a4)
	lui	a5,%hi(cmdArgCnt)
	li	a4,1
	sw	a4,%lo(cmdArgCnt)(a5)
	j	.L9
.L10:
	li	a0,-1
	j	.L9
	.size	__waitBootCommand, .-__waitBootCommand
	.section	.rodata.str1.8
	.align	3
.LC2:
	.string	"987654321"
	.text
	.align	1
	.globl	__waitPINCommand
	.type	__waitPINCommand, @function
__waitPINCommand:
	addi	sp,sp,-80
	sd	ra,72(sp)
	sd	s0,64(sp)
	sd	s1,56(sp)
	sd	s2,48(sp)
	sd	s3,40(sp)
	sd	s4,32(sp)
	sd	s5,24(sp)
	sd	s6,16(sp)
	sd	s7,8(sp)
	li	a0,1000
	call	timerSet
	li	s1,-1
	lui	s3,%hi(cmdChar)
	li	s2,105
	lui	s5,%hi(cmdArgCnt)
	li	s4,1
	lui	s7,%hi(cmdArgStr)
	lui	s6,%hi(.LC2)
	j	.L16
.L26:
	call	__sendNack
	j	.L16
.L19:
	call	__sendNack
.L16:
	call	timerGet
	sext.w	a0,a0
	beq	a0,zero,.L25
	call	__waitBootCommand
	beq	a0,s1,.L16
	lbu	a5,%lo(cmdChar)(s3)
	bne	a5,s2,.L26
	lw	a5,%lo(cmdArgCnt)(s5)
	bne	a5,s4,.L19
	addi	a1,s6,%lo(.LC2)
	ld	a0,%lo(cmdArgStr)(s7)
	call	strcmp
	mv	s0,a0
	bne	a0,zero,.L19
	call	__sendAck
.L21:
	mv	a0,s0
	ld	ra,72(sp)
	ld	s0,64(sp)
	ld	s1,56(sp)
	ld	s2,48(sp)
	ld	s3,40(sp)
	ld	s4,32(sp)
	ld	s5,24(sp)
	ld	s6,16(sp)
	ld	s7,8(sp)
	addi	sp,sp,80
	jr	ra
.L25:
	li	s0,-1
	j	.L21
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
	.text
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
	lui	s9,%hi(bootTimeout)
	li	s3,-1
	sw	s3,12(sp)
	lui	s6,%hi(cmdChar)
	lui	s8,%hi(cmdArgCnt)
.L53:
	call	commSendHeader
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	commSendBody
	lui	a0,%hi(.LANCHOR0)
	addi	a0,a0,%lo(.LANCHOR0)
	call	commSendBody
	li	a0,0
	call	commSendFooter
	call	commSendHeader
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	call	commSendBody
	li	a0,0
	call	commSendFooter
	lui	a0,%hi(.LANCHOR1)
	addi	a0,a0,%lo(.LANCHOR1)
	call	flashGetNameString
	lui	a5,%hi(bootable)
	sw	a0,%lo(bootable)(a5)
	beq	a0,zero,.L60
	lw	a5,12(sp)
	sw	a5,%lo(bootTimeout)(s9)
	call	commSendHeader
	lui	a0,%hi(.LC7)
	addi	a0,a0,%lo(.LC7)
	call	commSendBody
	li	a0,0
	call	commSendFooter
.L32:
	lw	a5,%lo(bootTimeout)(s9)
	beq	a5,zero,.L61
	call	commSendHeader
	lui	a0,%hi(.LC9)
	addi	a0,a0,%lo(.LC9)
	call	commSendBody
	li	a0,0
	call	commSendFooter
	li	a0,61440
	addi	a0,a0,-1440
	call	timerSet
	li	s4,61440
	addi	s4,s4,-1440
	li	s5,98
	lui	s7,%hi(bootable)
	j	.L35
.L60:
	call	commSendHeader
	lui	a0,%hi(.LC5)
	addi	a0,a0,%lo(.LC5)
	call	commSendBody
	lui	a0,%hi(.LANCHOR1)
	addi	a0,a0,%lo(.LANCHOR1)
	call	commSendBody
	li	a0,0
	call	commSendFooter
	lui	a5,%hi(bootTimeout)
	li	a4,5
	sw	a4,%lo(bootTimeout)(a5)
	li	s2,120
	lui	s1,%hi(.LC6)
	mv	s0,a5
.L31:
	sh	s2,24(sp)
	call	commSendHeader
	addi	a0,s1,%lo(.LC6)
	call	commSendBody
	lw	a5,%lo(bootTimeout)(s0)
	addiw	a5,a5,48
	sb	a5,24(sp)
	addi	a0,sp,24
	call	commSendBody
	li	a0,0
	call	commSendFooter
	call	__waitPINCommand
	beq	a0,zero,.L32
	lw	a5,%lo(bootTimeout)(s0)
	addiw	a5,a5,-1
	sext.w	a4,a5
	sw	a5,%lo(bootTimeout)(s0)
	bgt	a4,zero,.L31
	j	.L32
.L61:
	call	commSendHeader
	lui	a0,%hi(.LC8)
	addi	a0,a0,%lo(.LC8)
	call	commSendBody
	li	a0,0
	call	commSendFooter
	call	commFlush
	li	a0,134234112
	call	__boot
.L62:
	lui	a5,%hi(.LANCHOR1)
	addi	a0,a5,%lo(.LANCHOR1)
	call	flashGetNameString
	sw	a0,%lo(bootable)(s7)
	bne	a0,zero,.L37
	call	__sendAck
.L38:
	call	commFlush
	lw	a5,%lo(bootable)(s7)
	bne	a5,zero,.L35
	li	a0,134234112
	call	__boot
.L37:
	call	__sendNack
	j	.L38
.L63:
	call	flashErease
	call	__sendAck
	j	.L35
.L64:
	lw	a4,%lo(cmdArgCnt)(s8)
	li	a5,1
	bne	a4,a5,.L42
	lui	a5,%hi(cmdArgStr)
	ld	a0,%lo(cmdArgStr)(a5)
	call	strlen
	li	a5,160
	beq	a0,a5,.L43
.L42:
	call	__sendNack
.L35:
	call	timerGet
	sext.w	a0,a0
	beq	a0,zero,.L53
	call	__waitBootCommand
	beq	a0,s3,.L35
	mv	a0,s4
	call	timerSet
	lbu	a5,%lo(cmdChar)(s6)
	beq	a5,s5,.L62
	li	a4,101
	beq	a5,a4,.L63
	li	a4,112
	beq	a5,a4,.L64
	li	a4,118
	bne	a5,a4,.L35
	lw	a4,%lo(cmdArgCnt)(s8)
	li	a5,1
	bne	a4,a5,.L47
	lui	a5,%hi(cmdArgStr)
	ld	a0,%lo(cmdArgStr)(a5)
	call	strlen
	li	a5,160
	beq	a0,a5,.L48
.L47:
	call	__sendNack
	j	.L35
.L43:
	lui	s11,%hi(.LANCHOR1)
	addi	s11,s11,%lo(.LANCHOR1)
	addi	s2,s11,24
	addi	s11,s11,104
	li	s1,1
	lui	s10,%hi(cmdArgStr)
.L44:
	ld	a5,%lo(cmdArgStr)(s10)
	add	a5,a5,s1
	lbu	a0,0(a5)
	call	HexToInt
	mv	s0,a0
	ld	a5,%lo(cmdArgStr)(s10)
	add	a5,a5,s1
	lbu	a0,-1(a5)
	call	HexToInt
	slliw	a0,a0,4
	or	s0,s0,a0
	sb	s0,0(s2)
	addi	s1,s1,2
	addi	s2,s2,1
	bne	s2,s11,.L44
	lui	s0,%hi(.LANCHOR1)
	addi	s0,s0,%lo(.LANCHOR1)
	addi	s1,s0,24
	lui	a1,%hi(.LANCHOR0)
	addi	a1,a1,%lo(.LANCHOR0)
	li	a4,18
	addi	a3,s0,32
	addi	a2,a1,16
	addi	a1,a1,32
	mv	a0,s1
	call	blockDecipher
	call	crcReset
	li	a1,19
	mv	a0,s1
	call	crcCalculate
	sext.w	a5,a0
	lw	a4,100(s0)
	beq	a4,a5,.L45
	call	__sendNack
	j	.L35
.L45:
	lui	a0,%hi(.LANCHOR1)
	addi	a0,a0,%lo(.LANCHOR1)
	li	a2,16
	lw	a1,32(a0)
	addi	a0,a0,36
	call	flashWriteAddress
	bne	a0,zero,.L46
	call	__sendAck
	j	.L35
.L46:
	call	__sendNack
	j	.L35
.L48:
	lui	s11,%hi(.LANCHOR1)
	addi	s11,s11,%lo(.LANCHOR1)
	addi	s2,s11,24
	addi	s11,s11,104
	li	s1,1
	lui	s10,%hi(cmdArgStr)
.L49:
	ld	a5,%lo(cmdArgStr)(s10)
	add	a5,a5,s1
	lbu	a0,0(a5)
	call	HexToInt
	mv	s0,a0
	ld	a5,%lo(cmdArgStr)(s10)
	add	a5,a5,s1
	lbu	a0,-1(a5)
	call	HexToInt
	slliw	a0,a0,4
	or	s0,s0,a0
	sb	s0,0(s2)
	addi	s1,s1,2
	addi	s2,s2,1
	bne	s2,s11,.L49
	lui	s0,%hi(.LANCHOR1)
	addi	s0,s0,%lo(.LANCHOR1)
	addi	s1,s0,24
	lui	a1,%hi(.LANCHOR0)
	addi	a1,a1,%lo(.LANCHOR0)
	li	a4,18
	addi	a3,s0,32
	addi	a2,a1,16
	addi	a1,a1,32
	mv	a0,s1
	call	blockDecipher
	call	crcReset
	li	a1,19
	mv	a0,s1
	call	crcCalculate
	sext.w	a5,a0
	lw	a4,100(s0)
	beq	a4,a5,.L50
	call	__sendNack
	j	.L35
.L50:
	lui	a0,%hi(.LANCHOR1)
	addi	a0,a0,%lo(.LANCHOR1)
	li	a2,16
	lw	a1,32(a0)
	addi	a0,a0,36
	call	flashVerifyAddress
	bne	a0,zero,.L51
	call	__sendAck
	j	.L35
.L51:
	call	__sendNack
	j	.L35
	.size	main, .-main
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
