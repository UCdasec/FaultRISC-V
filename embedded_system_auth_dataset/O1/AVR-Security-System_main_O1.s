	.file	"main.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	delay_ms
	.type	delay_ms, @function
delay_ms:
	mv	a3,a0
	li	a4,0
	li	a2,700
	beq	a0,zero,.L8
.L2:
	mv	a5,a2
.L4:
 #APP
# 269 "main.c" 1
	nop
# 0 "" 2
 #NO_APP
	addiw	a5,a5,-1
	bne	a5,zero,.L4
	addiw	a4,a4,1
	bne	a3,a4,.L2
	ret
.L8:
	ret
	.size	delay_ms, .-delay_ms
	.align	1
	.globl	epulse
	.type	epulse, @function
epulse:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	li	s0,50
	lbu	a5,0(s0)
	ori	a5,a5,128
	sb	a5,0(s0)
	li	a0,1
	call	delay_ms
	lbu	a5,0(s0)
	andi	a5,a5,127
	sb	a5,0(s0)
	li	a0,1
	call	delay_ms
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	epulse, .-epulse
	.align	1
	.globl	displaybyte
	.type	displaybyte, @function
displaybyte:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	sd	s1,8(sp)
	mv	s1,a0
	srli	a4,a0,4
	li	s0,50
	lbu	a5,0(s0)
	andi	a5,a5,163
	sb	a5,0(s0)
	lbu	a3,0(s0)
	slliw	a2,a4,6
	andi	a2,a2,64
	or	a3,a3,a2
	sb	a3,0(s0)
	lbu	a3,0(s0)
	slliw	a2,a4,1
	andi	a2,a2,4
	or	a3,a3,a2
	sb	a3,0(s0)
	lbu	a3,0(s0)
	slliw	a5,a4,2
	andi	a5,a5,16
	or	a5,a3,a5
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	a4,a4,8
	or	a5,a5,a4
	sb	a5,0(s0)
	call	epulse
	lbu	a5,0(s0)
	andi	a5,a5,163
	sb	a5,0(s0)
	lbu	a4,0(s0)
	andi	a5,s1,15
	slliw	a3,a5,6
	andi	a3,a3,64
	or	a4,a4,a3
	sb	a4,0(s0)
	lbu	a4,0(s0)
	slliw	a3,a5,1
	andi	a3,a3,4
	or	a4,a4,a3
	sb	a4,0(s0)
	lbu	a4,0(s0)
	slliw	a5,a5,2
	andi	a5,a5,16
	or	a5,a4,a5
	sb	a5,0(s0)
	lbu	a5,0(s0)
	andi	s1,s1,8
	or	a5,a5,s1
	sb	a5,0(s0)
	call	epulse
	ld	ra,24(sp)
	ld	s0,16(sp)
	ld	s1,8(sp)
	addi	sp,sp,32
	jr	ra
	.size	displaybyte, .-displaybyte
	.align	1
	.globl	display
	.type	display, @function
display:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s1,8(sp)
	mv	s1,a0
	call	strlen
	sext.w	a5,a0
	ble	a5,zero,.L13
	sd	s0,16(sp)
	mv	s0,s1
	addi	s1,s1,1
	addiw	a0,a0,-1
	slli	a0,a0,32
	srli	a0,a0,32
	add	s1,s1,a0
.L15:
	lbu	a0,0(s0)
	call	displaybyte
	addi	s0,s0,1
	bne	s0,s1,.L15
	ld	s0,16(sp)
.L13:
	ld	ra,24(sp)
	ld	s1,8(sp)
	addi	sp,sp,32
	jr	ra
	.size	display, .-display
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"C\003\003\002(\001\f\006\002\002"
	.text
	.align	1
	.globl	dispinit
	.type	dispinit, @function
dispinit:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	sd	s1,24(sp)
	lui	a5,%hi(.LC0)
	addi	a5,a5,%lo(.LC0)
	ld	a4,0(a5)
	sd	a4,0(sp)
	lhu	a5,8(a5)
	sh	a5,8(sp)
	li	a4,56
	lbu	a5,0(a4)
	andi	a5,a5,254
	sb	a5,0(a4)
	mv	s0,sp
	addi	s1,sp,10
.L19:
	lbu	a0,0(s0)
	call	displaybyte
	addi	s0,s0,1
	bne	s0,s1,.L19
	li	a4,56
	lbu	a5,0(a4)
	ori	a5,a5,1
	sb	a5,0(a4)
	ld	ra,40(sp)
	ld	s0,32(sp)
	ld	s1,24(sp)
	addi	sp,sp,48
	jr	ra
	.size	dispinit, .-dispinit
	.align	1
	.globl	cleardisplay
	.type	cleardisplay, @function
cleardisplay:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	li	s0,56
	lbu	a5,0(s0)
	andi	a5,a5,254
	sb	a5,0(s0)
	li	a0,1
	call	displaybyte
	lbu	a5,0(s0)
	ori	a5,a5,1
	sb	a5,0(s0)
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	cleardisplay, .-cleardisplay
	.align	1
	.globl	line1
	.type	line1, @function
line1:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	li	s0,56
	lbu	a5,0(s0)
	andi	a5,a5,254
	sb	a5,0(s0)
	li	a0,128
	call	displaybyte
	lbu	a5,0(s0)
	ori	a5,a5,1
	sb	a5,0(s0)
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	line1, .-line1
	.align	1
	.globl	line2
	.type	line2, @function
line2:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	li	s0,56
	lbu	a5,0(s0)
	andi	a5,a5,254
	sb	a5,0(s0)
	li	a0,192
	call	displaybyte
	lbu	a5,0(s0)
	ori	a5,a5,1
	sb	a5,0(s0)
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	line2, .-line2
	.align	1
	.globl	USART_Init
	.type	USART_Init, @function
USART_Init:
	li	a4,64
	sb	zero,0(a4)
	li	a5,23
	sb	a5,41(zero)
	li	a3,43
	lbu	a5,0(a3)
	ori	a5,a5,2
	sb	a5,0(a3)
	li	a5,42
	li	a3,24
	sb	a3,0(a5)
	li	a3,-114
	sb	a3,0(a4)
	lbu	a4,0(a5)
	ori	a4,a4,128
	sb	a4,0(a5)
	ret
	.size	USART_Init, .-USART_Init
	.align	1
	.globl	USART_Receive
	.type	USART_Receive, @function
USART_Receive:
.L30:
	lbu	a5,43(zero)
	slliw	a5,a5,24
	sraiw	a5,a5,24
	bge	a5,zero,.L30
	lbu	a4,44(zero)
	lui	a5,%hi(u8_data)
	sb	a4,%lo(u8_data)(a5)
	ret
	.size	USART_Receive, .-USART_Receive
	.align	1
	.globl	__vector_11
	.type	__vector_11, @function
__vector_11:
	lbu	a4,44(zero)
	andi	a4,a4,0xff
	lui	a5,%hi(u8_data)
	sb	a4,%lo(u8_data)(a5)
	lui	a3,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a3)
	addiw	a5,a5,1
	sb	a5,%lo(FifoCnt)(a3)
	lui	a5,%hi(.LANCHOR0)
	addi	a5,a5,%lo(.LANCHOR0)
	lbu	a3,9(a5)
	sb	a3,10(a5)
	lbu	a3,8(a5)
	sb	a3,9(a5)
	lbu	a3,7(a5)
	sb	a3,8(a5)
	lbu	a3,6(a5)
	sb	a3,7(a5)
	lbu	a3,5(a5)
	sb	a3,6(a5)
	lbu	a3,4(a5)
	sb	a3,5(a5)
	lbu	a3,3(a5)
	sb	a3,4(a5)
	lbu	a3,2(a5)
	sb	a3,3(a5)
	lbu	a3,1(a5)
	sb	a3,2(a5)
	lbu	a3,0(a5)
	sb	a3,1(a5)
	sb	a4,0(a5)
	ret
	.size	__vector_11, .-__vector_11
	.align	1
	.globl	USART_Transmit
	.type	USART_Transmit, @function
USART_Transmit:
	sb	a0,44(zero)
.L34:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L34
	ret
	.size	USART_Transmit, .-USART_Transmit
	.align	1
	.globl	senddata
	.type	senddata, @function
senddata:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s1,8(sp)
	mv	s1,a0
	call	strlen
	sext.w	a5,a0
	ble	a5,zero,.L36
	sd	s0,16(sp)
	mv	s0,s1
	addi	s1,s1,1
	addiw	a0,a0,-1
	slli	a0,a0,32
	srli	a0,a0,32
	add	s1,s1,a0
.L38:
	lbu	a0,0(s0)
	call	USART_Transmit
	addi	s0,s0,1
	bne	s0,s1,.L38
	ld	s0,16(sp)
.L36:
	ld	ra,24(sp)
	ld	s1,8(sp)
	addi	sp,sp,32
	jr	ra
	.size	senddata, .-senddata
	.align	1
	.globl	AddFinger
	.type	AddFinger, @function
AddFinger:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	lui	a5,%hi(flg)
	sb	zero,%lo(flg)(a5)
	li	a0,4
	call	__eerd_byte_m16
	li	a5,255
	beq	a0,a5,.L45
.L42:
	lui	a5,%hi(IDcnt)
	sb	a0,%lo(IDcnt)(a5)
	lui	s0,%hi(ID)
	addiw	a0,a0,1
	sb	a0,%lo(ID)(s0)
	li	a0,77
	call	USART_Transmit
	li	a0,88
	call	USART_Transmit
	li	a0,16
	call	USART_Transmit
	li	a0,3
	call	USART_Transmit
	li	a0,64
	call	USART_Transmit
	li	a0,0
	call	USART_Transmit
	lbu	a0,%lo(ID)(s0)
	call	USART_Transmit
	lbu	a0,%lo(ID)(s0)
	addiw	a0,a0,-8
	andi	a0,a0,0xff
	call	USART_Transmit
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
.L45:
	li	a0,0
	j	.L42
	.size	AddFinger, .-AddFinger
	.align	1
	.globl	DeleteFinger
	.type	DeleteFinger, @function
DeleteFinger:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	lui	a5,%hi(flgd)
	sb	zero,%lo(flgd)(a5)
	li	a0,4
	call	__eerd_byte_m16
	lui	a5,%hi(IDcnt)
	sb	a0,%lo(IDcnt)(a5)
	lui	s0,%hi(ID)
	sb	a0,%lo(ID)(s0)
	li	a0,77
	call	USART_Transmit
	li	a0,88
	call	USART_Transmit
	li	a0,16
	call	USART_Transmit
	li	a0,3
	call	USART_Transmit
	li	a0,66
	call	USART_Transmit
	li	a0,0
	call	USART_Transmit
	lbu	a0,%lo(ID)(s0)
	call	USART_Transmit
	lbu	a0,%lo(ID)(s0)
	addiw	a0,a0,-6
	andi	a0,a0,0xff
	call	USART_Transmit
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	DeleteFinger, .-DeleteFinger
	.align	1
	.globl	SearchFinger
	.type	SearchFinger, @function
SearchFinger:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	lui	a5,%hi(flgs)
	sb	zero,%lo(flgs)(a5)
	li	a0,4
	call	__eerd_byte_m16
	lui	a5,%hi(IDcnt)
	sb	a0,%lo(IDcnt)(a5)
	lui	s0,%hi(ID)
	sb	a0,%lo(ID)(s0)
	li	a0,77
	call	USART_Transmit
	li	a0,88
	call	USART_Transmit
	li	a0,16
	call	USART_Transmit
	li	a0,5
	call	USART_Transmit
	li	a0,68
	call	USART_Transmit
	li	a0,0
	call	USART_Transmit
	li	a0,1
	call	USART_Transmit
	li	a0,0
	call	USART_Transmit
	lbu	a0,%lo(ID)(s0)
	call	USART_Transmit
	lbu	a0,%lo(ID)(s0)
	addiw	a0,a0,-1
	andi	a0,a0,0xff
	call	USART_Transmit
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	SearchFinger, .-SearchFinger
	.section	.rodata.str1.8
	.align	3
.LC1:
	.string	"  Finger Print  "
	.align	3
.LC2:
	.string	"     Access     "
	.text
	.align	1
	.globl	DoCancel
	.type	DoCancel, @function
DoCancel:
	addi	sp,sp,-16
	sd	ra,8(sp)
	li	a0,2000
	call	delay_ms
	call	cleardisplay
	call	line1
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	display
	call	line2
	lui	a0,%hi(.LC2)
	addi	a0,a0,%lo(.LC2)
	call	display
	li	a4,56
	lbu	a5,0(a4)
	andi	a5,a5,247
	sb	a5,0(a4)
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	DoCancel, .-DoCancel
	.section	.rodata.str1.8
	.align	3
.LC3:
	.string	"   Time Out   "
	.align	3
.LC4:
	.string	"Process Failed"
	.align	3
.LC5:
	.string	" Finger Added  "
	.align	3
.LC6:
	.string	"%02d"
	.align	3
.LC7:
	.string	"   ID : "
	.align	3
.LC8:
	.string	" Entry Deleted  "
	.align	3
.LC9:
	.string	"Finger Placed"
	.align	3
.LC10:
	.string	" Entry Passed  "
	.align	3
.LC11:
	.string	" Access Denied  "
	.align	3
.LC12:
	.string	" Parameter Error"
	.text
	.align	1
	.globl	ProcessFifo
	.type	ProcessFifo, @function
ProcessFifo:
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	beq	a5,zero,.L110
	addi	sp,sp,-32
	sd	ra,24(sp)
	addiw	a5,a5,-1
	lui	a4,%hi(.LANCHOR0)
	addi	a4,a4,%lo(.LANCHOR0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	li	a4,48
	beq	a5,a4,.L113
	lui	a4,%hi(flg)
	lbu	a3,%lo(flg)(a4)
	li	a4,4
	beq	a3,a4,.L114
	lui	a5,%hi(flg)
	lbu	a4,%lo(flg)(a5)
	li	a5,3
	bne	a4,a5,.L56
.L101:
	lui	a5,%hi(flg)
	sb	zero,%lo(flg)(a5)
	j	.L56
.L113:
	lui	a5,%hi(flg)
	lbu	a5,%lo(flg)(a5)
	bne	a5,zero,.L55
	lui	a5,%hi(flg)
	li	a4,1
	sb	a4,%lo(flg)(a5)
	j	.L56
.L114:
	li	a4,51
	beq	a5,a4,.L115
.L58:
	lui	a5,%hi(FifoCnt)
	lbu	a4,%lo(FifoCnt)(a5)
	addiw	a4,a4,-1
	lui	a5,%hi(.LANCHOR0)
	addi	a5,a5,%lo(.LANCHOR0)
	add	a5,a5,a4
	lbu	a4,0(a5)
	li	a5,52
	beq	a4,a5,.L116
.L59:
	lui	a5,%hi(FifoCnt)
	lbu	a4,%lo(FifoCnt)(a5)
	addiw	a4,a4,-1
	lui	a5,%hi(.LANCHOR0)
	addi	a5,a5,%lo(.LANCHOR0)
	add	a5,a5,a4
	lbu	a4,0(a5)
	li	a5,49
	beq	a4,a5,.L117
.L60:
	lui	a5,%hi(flg)
	li	a4,8
	sb	a4,%lo(flg)(a5)
.L56:
	lui	a5,%hi(FifoCnt)
	lbu	a4,%lo(FifoCnt)(a5)
	addiw	a4,a4,-1
	lui	a5,%hi(.LANCHOR0)
	addi	a5,a5,%lo(.LANCHOR0)
	add	a5,a5,a4
	lbu	a5,0(a5)
	li	a4,64
	beq	a5,a4,.L118
	li	a4,2
	bne	a5,a4,.L63
	lui	a4,%hi(flg)
	lbu	a3,%lo(flg)(a4)
	li	a4,1
	beq	a3,a4,.L119
.L67:
	lui	a4,%hi(flgd)
	lbu	a3,%lo(flgd)(a4)
	li	a4,4
	bne	a3,a4,.L70
	li	a4,51
	bne	a5,a4,.L71
	call	cleardisplay
	call	line1
	lui	a0,%hi(.LC3)
	addi	a0,a0,%lo(.LC3)
	call	display
	call	DoCancel
.L71:
	lui	a5,%hi(FifoCnt)
	lbu	a4,%lo(FifoCnt)(a5)
	addiw	a4,a4,-1
	lui	a5,%hi(.LANCHOR0)
	addi	a5,a5,%lo(.LANCHOR0)
	add	a5,a5,a4
	lbu	a4,0(a5)
	li	a5,52
	beq	a4,a5,.L120
.L72:
	lui	a5,%hi(FifoCnt)
	lbu	a4,%lo(FifoCnt)(a5)
	addiw	a4,a4,-1
	lui	a5,%hi(.LANCHOR0)
	addi	a5,a5,%lo(.LANCHOR0)
	add	a5,a5,a4
	lbu	a4,0(a5)
	li	a5,49
	beq	a4,a5,.L121
.L73:
	lui	a5,%hi(flgd)
	li	a4,8
	sb	a4,%lo(flgd)(a5)
	lui	a5,%hi(FifoCnt)
	lbu	a4,%lo(FifoCnt)(a5)
	addiw	a4,a4,-1
	lui	a5,%hi(.LANCHOR0)
	addi	a5,a5,%lo(.LANCHOR0)
	add	a5,a5,a4
	lbu	a5,0(a5)
	li	a4,66
	bne	a5,a4,.L75
.L78:
	li	a4,48
	bne	a5,a4,.L80
	lui	a5,%hi(flgs)
	lbu	a5,%lo(flgs)(a5)
	bne	a5,zero,.L81
	lui	a5,%hi(flgs)
	li	a4,1
	sb	a4,%lo(flgs)(a5)
	j	.L82
.L115:
	call	cleardisplay
	call	line1
	lui	a0,%hi(.LC3)
	addi	a0,a0,%lo(.LC3)
	call	display
	call	DoCancel
	j	.L58
.L116:
	call	cleardisplay
	call	line1
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	call	display
	call	DoCancel
	j	.L59
.L117:
	sd	s0,16(sp)
	sd	s1,8(sp)
	call	cleardisplay
	call	line1
	lui	a0,%hi(.LC5)
	addi	a0,a0,%lo(.LC5)
	call	display
	call	line2
	lui	s1,%hi(ID)
	lbu	a2,%lo(ID)(s1)
	lui	a1,%hi(.LC6)
	addi	a1,a1,%lo(.LC6)
	lui	s0,%hi(mystr)
	addi	a0,s0,%lo(mystr)
	call	sprintf
	lui	a0,%hi(.LC7)
	addi	a0,a0,%lo(.LC7)
	call	display
	lbu	a0,%lo(mystr)(s0)
	call	displaybyte
	addi	s0,s0,%lo(mystr)
	lbu	a0,1(s0)
	call	displaybyte
	lui	s0,%hi(IDcnt)
	lbu	a0,%lo(IDcnt)(s0)
	lbu	a1,%lo(ID)(s1)
	addi	a0,a0,8
	call	__eewr_byte_m16
	lbu	a1,%lo(IDcnt)(s0)
	addiw	a1,a1,1
	andi	a1,a1,0xff
	sb	a1,%lo(IDcnt)(s0)
	li	a0,4
	call	__eewr_byte_m16
	call	DoCancel
	ld	s0,16(sp)
	ld	s1,8(sp)
	j	.L60
.L118:
	lui	a4,%hi(flg)
	lbu	a3,%lo(flg)(a4)
	li	a4,2
	beq	a3,a4,.L122
.L65:
	li	a4,48
	bne	a5,a4,.L67
	lui	a5,%hi(flgd)
	lbu	a5,%lo(flgd)(a5)
	bne	a5,zero,.L68
	lui	a5,%hi(flgd)
	li	a4,1
	sb	a4,%lo(flgd)(a5)
	j	.L69
.L122:
	lui	a4,%hi(flg)
	li	a3,4
	sb	a3,%lo(flg)(a4)
	j	.L65
.L119:
	lui	a4,%hi(flg)
	li	a3,2
	sb	a3,%lo(flg)(a4)
	j	.L67
.L131:
	lui	a5,%hi(flg)
	li	a4,3
	sb	a4,%lo(flg)(a5)
	j	.L66
.L120:
	call	cleardisplay
	call	line1
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	call	display
	call	DoCancel
	j	.L72
.L121:
	sd	s0,16(sp)
	call	cleardisplay
	call	line1
	lui	a0,%hi(.LC8)
	addi	a0,a0,%lo(.LC8)
	call	display
	call	line2
	lui	a5,%hi(ID)
	lbu	a2,%lo(ID)(a5)
	lui	a1,%hi(.LC6)
	addi	a1,a1,%lo(.LC6)
	lui	s0,%hi(mystr)
	addi	a0,s0,%lo(mystr)
	call	sprintf
	lui	a0,%hi(.LC7)
	addi	a0,a0,%lo(.LC7)
	call	display
	lbu	a0,%lo(mystr)(s0)
	call	displaybyte
	addi	s0,s0,%lo(mystr)
	lbu	a0,1(s0)
	call	displaybyte
	lui	s0,%hi(IDcnt)
	lbu	a0,%lo(IDcnt)(s0)
	li	a1,255
	addi	a0,a0,8
	call	__eewr_byte_m16
	lbu	a1,%lo(IDcnt)(s0)
	addiw	a1,a1,-1
	andi	a1,a1,0xff
	sb	a1,%lo(IDcnt)(s0)
	li	a0,4
	call	__eewr_byte_m16
	call	DoCancel
	ld	s0,16(sp)
	j	.L73
.L132:
	lui	a4,%hi(flgd)
	lbu	a3,%lo(flgd)(a4)
	li	a4,2
	bne	a3,a4,.L78
	lui	a4,%hi(flgd)
	li	a3,4
	sb	a3,%lo(flgd)(a4)
	j	.L78
.L133:
	lui	a4,%hi(flgd)
	li	a3,2
	sb	a3,%lo(flgd)(a4)
	j	.L80
.L123:
	lui	a5,%hi(flgd)
	li	a4,3
	sb	a4,%lo(flgd)(a5)
	j	.L79
.L124:
	call	cleardisplay
	call	line1
	lui	a0,%hi(.LC3)
	addi	a0,a0,%lo(.LC3)
	call	display
	lui	a5,%hi(flgs)
	li	a4,8
	sb	a4,%lo(flgs)(a5)
	call	DoCancel
	j	.L85
.L125:
	call	cleardisplay
	call	line1
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	call	display
	lui	a5,%hi(flgs)
	li	a4,8
	sb	a4,%lo(flgs)(a5)
	call	DoCancel
	j	.L86
.L126:
	call	cleardisplay
	call	line1
	lui	a0,%hi(.LC10)
	addi	a0,a0,%lo(.LC10)
	call	display
	call	line2
	lui	a5,%hi(flgs)
	li	a4,8
	sb	a4,%lo(flgs)(a5)
	li	a4,56
	lbu	a5,0(a4)
	ori	a5,a5,8
	sb	a5,0(a4)
	li	a0,2000
	call	delay_ms
	call	DoCancel
	j	.L87
.L127:
	call	cleardisplay
	call	line1
	lui	a0,%hi(.LC11)
	addi	a0,a0,%lo(.LC11)
	call	display
	call	line2
	lui	a5,%hi(flgs)
	li	a4,8
	sb	a4,%lo(flgs)(a5)
	call	DoCancel
	j	.L88
.L128:
	call	cleardisplay
	call	line1
	lui	a0,%hi(.LC12)
	addi	a0,a0,%lo(.LC12)
	call	display
	lui	a5,%hi(flgs)
	li	a4,8
	sb	a4,%lo(flgs)(a5)
	call	DoCancel
	j	.L83
.L97:
	lui	a5,%hi(flgs)
	sb	zero,%lo(flgs)(a5)
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	addiw	a3,a5,-1
	lui	a4,%hi(.LANCHOR0)
	addi	a4,a4,%lo(.LANCHOR0)
	add	a4,a4,a3
	lbu	a4,0(a4)
	li	a3,68
	bne	a4,a3,.L90
	j	.L93
.L129:
	lui	a4,%hi(flgs)
	lbu	a3,%lo(flgs)(a4)
	li	a4,2
	bne	a3,a4,.L93
	lui	a4,%hi(flgs)
	li	a3,4
	sb	a3,%lo(flgs)(a4)
	j	.L93
.L130:
	lui	a4,%hi(flgs)
	li	a3,2
	sb	a3,%lo(flgs)(a4)
	j	.L93
.L91:
	li	a3,1
	bne	a4,a3,.L93
	lui	a4,%hi(flgs)
	lbu	a3,%lo(flgs)(a4)
	li	a4,1
	bne	a3,a4,.L93
	lui	a4,%hi(flgs)
	li	a3,3
	sb	a3,%lo(flgs)(a4)
	j	.L93
.L81:
	li	a4,4
	beq	a5,a4,.L85
	lui	a5,%hi(flgs)
	lbu	a4,%lo(flgs)(a5)
	li	a5,3
	beq	a4,a5,.L97
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	addiw	a3,a5,-1
	lui	a4,%hi(.LANCHOR0)
	addi	a4,a4,%lo(.LANCHOR0)
	add	a4,a4,a3
	lbu	a4,0(a4)
	j	.L90
.L68:
	li	a4,4
	beq	a5,a4,.L72
	lui	a5,%hi(flgd)
	lbu	a4,%lo(flgd)(a5)
	li	a5,3
	beq	a4,a5,.L99
	lui	a5,%hi(FifoCnt)
	lbu	a4,%lo(FifoCnt)(a5)
	addiw	a4,a4,-1
	lui	a5,%hi(.LANCHOR0)
	addi	a5,a5,%lo(.LANCHOR0)
	add	a5,a5,a4
	lbu	a5,0(a5)
.L76:
	li	a4,1
	bne	a5,a4,.L78
	lui	a5,%hi(flgd)
	lbu	a4,%lo(flgd)(a5)
	li	a5,1
	beq	a4,a5,.L123
.L79:
	lui	a5,%hi(flgs)
	lbu	a4,%lo(flgs)(a5)
	li	a5,4
	bne	a4,a5,.L83
.L84:
	lui	a5,%hi(FifoCnt)
	lbu	a4,%lo(FifoCnt)(a5)
	addiw	a4,a4,-1
	lui	a5,%hi(.LANCHOR0)
	addi	a5,a5,%lo(.LANCHOR0)
	add	a5,a5,a4
	lbu	a4,0(a5)
	li	a5,51
	beq	a4,a5,.L124
.L85:
	lui	a5,%hi(FifoCnt)
	lbu	a4,%lo(FifoCnt)(a5)
	addiw	a4,a4,-1
	lui	a5,%hi(.LANCHOR0)
	addi	a5,a5,%lo(.LANCHOR0)
	add	a5,a5,a4
	lbu	a4,0(a5)
	li	a5,52
	beq	a4,a5,.L125
.L86:
	lui	a5,%hi(FifoCnt)
	lbu	a4,%lo(FifoCnt)(a5)
	addiw	a4,a4,-1
	lui	a5,%hi(.LANCHOR0)
	addi	a5,a5,%lo(.LANCHOR0)
	add	a5,a5,a4
	lbu	a4,0(a5)
	li	a5,57
	beq	a4,a5,.L126
.L87:
	lui	a5,%hi(FifoCnt)
	lbu	a4,%lo(FifoCnt)(a5)
	addiw	a4,a4,-1
	lui	a5,%hi(.LANCHOR0)
	addi	a5,a5,%lo(.LANCHOR0)
	add	a5,a5,a4
	lbu	a4,0(a5)
	li	a5,58
	beq	a4,a5,.L127
.L88:
	lui	a5,%hi(FifoCnt)
	lbu	a4,%lo(FifoCnt)(a5)
	addiw	a4,a4,-1
	lui	a5,%hi(.LANCHOR0)
	addi	a5,a5,%lo(.LANCHOR0)
	add	a5,a5,a4
	lbu	a4,0(a5)
	li	a5,53
	beq	a4,a5,.L128
.L83:
	lui	a5,%hi(flgs)
	lbu	a4,%lo(flgs)(a5)
	li	a5,3
	beq	a4,a5,.L97
.L82:
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	addiw	a3,a5,-1
	lui	a4,%hi(.LANCHOR0)
	addi	a4,a4,%lo(.LANCHOR0)
	add	a4,a4,a3
	lbu	a4,0(a4)
	li	a3,68
	beq	a4,a3,.L129
.L90:
	addiw	a3,a4,-2
	andi	a3,a3,253
	bne	a3,zero,.L91
	lui	a4,%hi(flgs)
	lbu	a3,%lo(flgs)(a4)
	li	a4,1
	beq	a3,a4,.L130
.L93:
	addiw	a5,a5,-1
	lui	a4,%hi(FifoCnt)
	sb	a5,%lo(FifoCnt)(a4)
	ld	ra,24(sp)
	addi	sp,sp,32
	jr	ra
.L55:
	li	a4,4
	beq	a5,a4,.L59
	lui	a5,%hi(flg)
	lbu	a4,%lo(flg)(a5)
	li	a5,3
	beq	a4,a5,.L101
	lui	a5,%hi(FifoCnt)
	lbu	a4,%lo(FifoCnt)(a5)
	addiw	a4,a4,-1
	lui	a5,%hi(.LANCHOR0)
	addi	a5,a5,%lo(.LANCHOR0)
	add	a5,a5,a4
	lbu	a5,0(a5)
.L63:
	li	a4,1
	bne	a5,a4,.L65
	lui	a5,%hi(flg)
	lbu	a4,%lo(flg)(a5)
	li	a5,1
	beq	a4,a5,.L131
.L66:
	lui	a5,%hi(flgd)
	lbu	a4,%lo(flgd)(a5)
	li	a5,4
	beq	a4,a5,.L71
.L70:
	lui	a5,%hi(flgd)
	lbu	a4,%lo(flgd)(a5)
	li	a5,3
	bne	a4,a5,.L69
.L99:
	lui	a5,%hi(flgd)
	sb	zero,%lo(flgd)(a5)
.L69:
	lui	a5,%hi(FifoCnt)
	lbu	a4,%lo(FifoCnt)(a5)
	addiw	a4,a4,-1
	lui	a5,%hi(.LANCHOR0)
	addi	a5,a5,%lo(.LANCHOR0)
	add	a5,a5,a4
	lbu	a5,0(a5)
	li	a4,66
	beq	a5,a4,.L132
.L75:
	li	a4,2
	bne	a5,a4,.L76
	lui	a4,%hi(flgd)
	lbu	a3,%lo(flgd)(a4)
	li	a4,1
	beq	a3,a4,.L133
.L80:
	lui	a4,%hi(flgs)
	lbu	a3,%lo(flgs)(a4)
	li	a4,4
	bne	a3,a4,.L83
	li	a4,49
	bne	a5,a4,.L84
	call	cleardisplay
	call	line1
	lui	a0,%hi(.LC9)
	addi	a0,a0,%lo(.LC9)
	call	display
	lui	a5,%hi(flgs)
	sb	zero,%lo(flgs)(a5)
	j	.L84
.L110:
	ret
	.size	ProcessFifo, .-ProcessFifo
	.section	.rodata.str1.8
	.align	3
.LC13:
	.string	"  Finger Added    "
	.align	3
.LC14:
	.string	"  Successfully  "
	.align	3
.LC15:
	.string	"    Finger      "
	.align	3
.LC16:
	.string	"   Deleted    "
	.align	3
.LC17:
	.string	"  Delete finger "
	.align	3
.LC18:
	.string	"  Not  Found    "
	.align	3
.LC19:
	.string	"  Place finger  "
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
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
	li	a5,9
	sb	a5,55(zero)
	li	a5,-36
	sb	a5,49(zero)
	sb	zero,52(zero)
	li	a5,-1
	sb	a5,53(zero)
	lui	a5,%hi(FifoCnt)
	sb	zero,%lo(FifoCnt)(a5)
	li	a0,500
	call	delay_ms
	call	dispinit
	call	USART_Init
	li	a0,200
	call	delay_ms
	li	a5,-128
	sb	a5,95(zero)
	call	line1
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	display
	call	line2
	lui	a0,%hi(.LC2)
	addi	a0,a0,%lo(.LC2)
	call	display
	li	a5,8
	lui	a4,%hi(flg)
	sb	a5,%lo(flg)(a4)
	lui	a4,%hi(flgd)
	sb	a5,%lo(flgd)(a4)
	lui	a4,%hi(flgs)
	sb	a5,%lo(flgs)(a4)
	lui	a5,%hi(flgmenu)
	sb	zero,%lo(flgmenu)(a5)
	li	a0,4
	call	__eerd_byte_m16
	lui	a5,%hi(IDcnt)
	sb	a0,%lo(IDcnt)(a5)
	li	a5,255
	beq	a0,a5,.L148
	addi	a0,a0,8
	call	__eerd_byte_m16
	lui	a5,%hi(ID)
	sb	a0,%lo(ID)(a5)
.L137:
	lui	s0,%hi(flgmenu)
	li	s4,8
	lui	s3,%hi(.LC13)
	lui	s2,%hi(.LC14)
	lui	s1,%hi(IDT)
	lui	s6,%hi(.LC17)
	lui	s5,%hi(.LC6)
	j	.L136
.L148:
	lui	a5,%hi(IDcnt)
	sb	zero,%lo(IDcnt)(a5)
	li	a1,0
	li	a0,4
	call	__eewr_byte_m16
	j	.L137
.L150:
	sb	s4,%lo(flgmenu)(s0)
	call	cleardisplay
	call	line1
	addi	a0,s3,%lo(.LC13)
	call	display
	call	line2
	addi	a0,s2,%lo(.LC14)
	call	display
	li	a0,2000
	call	delay_ms
	call	AddFinger
	sb	zero,%lo(flgmenu)(s0)
	j	.L138
.L140:
	call	cleardisplay
	call	line1
	addi	a0,s6,%lo(.LC17)
	call	display
	call	line2
	lbu	a2,%lo(IDT)(s1)
	addi	a1,s5,%lo(.LC6)
	lui	s7,%hi(mystr)
	addi	a0,s7,%lo(mystr)
	call	sprintf
	lui	a0,%hi(.LC7)
	addi	a0,a0,%lo(.LC7)
	call	display
	lbu	a0,%lo(mystr)(s7)
	call	displaybyte
	addi	s7,s7,%lo(mystr)
	lbu	a0,1(s7)
	call	displaybyte
	li	a5,1
	sb	a5,%lo(flgmenu)(s0)
	lbu	a5,51(zero)
	andi	a5,a5,2
	bne	a5,zero,.L142
.L141:
	call	DeleteFinger
	sb	zero,%lo(flgmenu)(s0)
	j	.L142
.L139:
	lbu	a5,51(zero)
	andi	a5,a5,2
	bne	a5,zero,.L142
	lbu	a4,%lo(flgmenu)(s0)
	li	a5,1
	beq	a4,a5,.L141
.L142:
	lbu	a5,51(zero)
	andi	a5,a5,16
	beq	a5,zero,.L149
	lbu	a5,51(zero)
	andi	a5,a5,8
	lbu	a4,%lo(flgmenu)(s0)
	or	a5,a5,a4
	beq	a5,zero,.L144
.L136:
	call	ProcessFifo
	lbu	a5,51(zero)
	andi	a5,a5,4
	beq	a5,zero,.L150
.L138:
	lbu	a5,51(zero)
	andi	a5,a5,32
	bne	a5,zero,.L139
	li	a0,4
	call	__eerd_byte_m16
	sb	a0,%lo(IDT)(s1)
	addiw	a0,a0,-1
	andi	a0,a0,0xff
	li	a5,253
	bleu	a0,a5,.L140
	call	cleardisplay
	call	line1
	lui	a0,%hi(.LC15)
	addi	a0,a0,%lo(.LC15)
	call	display
	call	line2
	lui	a0,%hi(.LC16)
	addi	a0,a0,%lo(.LC16)
	call	display
	call	DoCancel
	j	.L139
.L149:
	call	DoCancel
	sb	zero,%lo(flgmenu)(s0)
	lbu	a5,51(zero)
	andi	a5,a5,8
	bne	a5,zero,.L136
.L144:
	li	a0,4
	call	__eerd_byte_m16
	sb	a0,%lo(IDT)(s1)
	addiw	a0,a0,-1
	andi	a0,a0,0xff
	li	a5,253
	bleu	a0,a5,.L146
	call	cleardisplay
	call	line1
	lui	a0,%hi(.LC15)
	addi	a0,a0,%lo(.LC15)
	call	display
	call	line2
	lui	a0,%hi(.LC18)
	addi	a0,a0,%lo(.LC18)
	call	display
	call	DoCancel
	j	.L136
.L146:
	call	cleardisplay
	call	line1
	lui	a0,%hi(.LC19)
	addi	a0,a0,%lo(.LC19)
	call	display
	call	SearchFinger
	j	.L136
	.size	main, .-main
	.globl	flgmenu
	.globl	IDT
	.globl	IDcnt
	.globl	FifoCnt
	.globl	Fifo
	.globl	flgs
	.globl	flgd
	.globl	flg
	.globl	ID
	.globl	mystr
	.globl	u8_data
	.bss
	.align	3
	.set	.LANCHOR0,. + 0
	.type	Fifo, @object
	.size	Fifo, 20
Fifo:
	.zero	20
	.section	.sbss,"aw",@nobits
	.align	3
	.type	flgmenu, @object
	.size	flgmenu, 1
flgmenu:
	.zero	1
	.type	IDT, @object
	.size	IDT, 1
IDT:
	.zero	1
	.type	IDcnt, @object
	.size	IDcnt, 1
IDcnt:
	.zero	1
	.type	FifoCnt, @object
	.size	FifoCnt, 1
FifoCnt:
	.zero	1
	.type	flgs, @object
	.size	flgs, 1
flgs:
	.zero	1
	.type	flgd, @object
	.size	flgd, 1
flgd:
	.zero	1
	.type	flg, @object
	.size	flg, 1
flg:
	.zero	1
	.type	ID, @object
	.size	ID, 1
ID:
	.zero	1
	.type	mystr, @object
	.size	mystr, 6
mystr:
	.zero	6
	.type	u8_data, @object
	.size	u8_data, 1
u8_data:
	.zero	1
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
