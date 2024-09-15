	.file	"main.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	epulse
	.type	epulse, @function
epulse:
	lbu	a4,50(zero)
	li	a5,700
	ori	a4,a4,128
	sb	a4,50(zero)
.L2:
 #APP
# 269 "main.c" 1
	nop
# 0 "" 2
 #NO_APP
	addiw	a5,a5,-1
	bne	a5,zero,.L2
	lbu	a4,50(zero)
	li	a5,700
	andi	a4,a4,127
	sb	a4,50(zero)
.L3:
 #APP
# 269 "main.c" 1
	nop
# 0 "" 2
 #NO_APP
	addiw	a5,a5,-1
	bne	a5,zero,.L3
	ret
	.size	epulse, .-epulse
	.align	1
	.globl	displaybyte
	.type	displaybyte, @function
displaybyte:
	addi	sp,sp,-32
	sd	s0,16(sp)
	sd	s1,8(sp)
	li	s0,50
	sd	ra,24(sp)
	lbu	a5,0(s0)
	mv	s1,a0
	andi	a5,a5,163
	sb	a5,0(s0)
	lbu	a4,0(s0)
	srli	a5,a0,4
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
	srli	a4,a0,4
	andi	a4,a4,8
	or	a5,a5,a4
	sb	a5,0(s0)
	call	epulse
	lbu	a4,0(s0)
	andi	a5,s1,15
	slliw	a2,a5,6
	andi	a4,a4,163
	sb	a4,0(s0)
	lbu	a4,0(s0)
	andi	a2,a2,64
	slliw	a3,a5,1
	or	a4,a4,a2
	sb	a4,0(s0)
	lbu	a4,0(s0)
	andi	a3,a3,4
	slliw	a5,a5,2
	or	a4,a4,a3
	sb	a4,0(s0)
	lbu	a4,0(s0)
	andi	a5,a5,16
	andi	s1,s1,8
	or	a5,a4,a5
	sb	a5,0(s0)
	lbu	a5,0(s0)
	or	a5,a5,s1
	sb	a5,0(s0)
	ld	s0,16(sp)
	ld	ra,24(sp)
	ld	s1,8(sp)
	addi	sp,sp,32
	tail	epulse
	.size	displaybyte, .-displaybyte
	.align	1
	.globl	display
	.type	display, @function
display:
	addi	sp,sp,-32
	sd	s0,16(sp)
	sd	ra,24(sp)
	mv	s0,a0
	call	strlen
	sext.w	a5,a0
	ble	a5,zero,.L9
	addiw	a0,a0,-1
	slli	a0,a0,32
	sd	s1,8(sp)
	srli	a0,a0,32
	addi	s1,s0,1
	add	s1,s1,a0
.L11:
	lbu	a0,0(s0)
	addi	s0,s0,1
	call	displaybyte
	bne	s0,s1,.L11
	ld	s1,8(sp)
.L9:
	ld	ra,24(sp)
	ld	s0,16(sp)
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
	lui	a5,%hi(.LC0)
	addi	a5,a5,%lo(.LC0)
	ld	a4,0(a5)
	lhu	a5,8(a5)
	addi	sp,sp,-48
	sd	s0,32(sp)
	sd	s1,24(sp)
	sd	ra,40(sp)
	sd	a4,0(sp)
	sh	a5,8(sp)
	lbu	a5,56(zero)
	mv	s0,sp
	addi	s1,sp,10
	andi	a5,a5,254
	sb	a5,56(zero)
.L15:
	lbu	a0,0(s0)
	addi	s0,s0,1
	call	displaybyte
	bne	s0,s1,.L15
	lbu	a5,56(zero)
	ori	a5,a5,1
	sb	a5,56(zero)
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
	sd	s0,0(sp)
	sd	ra,8(sp)
	li	s0,56
	lbu	a5,0(s0)
	li	a0,1
	andi	a5,a5,254
	sb	a5,0(s0)
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
	sd	s0,0(sp)
	sd	ra,8(sp)
	li	s0,56
	lbu	a5,0(s0)
	li	a0,128
	andi	a5,a5,254
	sb	a5,0(s0)
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
	sd	s0,0(sp)
	sd	ra,8(sp)
	li	s0,56
	lbu	a5,0(s0)
	li	a0,192
	andi	a5,a5,254
	sb	a5,0(s0)
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
	.globl	delay_ms
	.type	delay_ms, @function
delay_ms:
	mv	a3,a0
	li	a4,0
	beq	a0,zero,.L31
.L25:
	li	a5,700
.L27:
 #APP
# 269 "main.c" 1
	nop
# 0 "" 2
 #NO_APP
	addiw	a5,a5,-1
	bne	a5,zero,.L27
	addiw	a4,a4,1
	bne	a3,a4,.L25
	ret
.L31:
	ret
	.size	delay_ms, .-delay_ms
	.align	1
	.globl	senddata
	.type	senddata, @function
senddata:
	addi	sp,sp,-16
	sd	s0,0(sp)
	sd	ra,8(sp)
	mv	s0,a0
	call	strlen
	sext.w	a5,a0
	ble	a5,zero,.L32
	addiw	a5,a0,-1
	slli	a5,a5,32
	addi	a3,s0,1
	srli	a5,a5,32
	mv	a4,s0
	add	a3,a3,a5
.L35:
	lbu	a5,0(a4)
	sb	a5,44(zero)
.L34:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L34
	addi	a4,a4,1
	bne	a4,a3,.L35
.L32:
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	senddata, .-senddata
	.align	1
	.globl	USART_Init
	.type	USART_Init, @function
USART_Init:
	li	a3,64
	sb	zero,0(a3)
	li	a5,23
	sb	a5,41(zero)
	li	a2,43
	lbu	a4,0(a2)
	li	a5,42
	ori	a4,a4,2
	sb	a4,0(a2)
	li	a4,24
	sb	a4,0(a5)
	li	a4,-114
	sb	a4,0(a3)
	lbu	a4,0(a5)
	ori	a4,a4,128
	sb	a4,0(a5)
	ret
	.size	USART_Init, .-USART_Init
	.align	1
	.globl	USART_Receive
	.type	USART_Receive, @function
USART_Receive:
.L42:
	lbu	a5,43(zero)
	slliw	a5,a5,24
	sraiw	a5,a5,24
	bge	a5,zero,.L42
	lbu	a4,44(zero)
	lui	a5,%hi(u8_data)
	sb	a4,%lo(u8_data)(a5)
	ret
	.size	USART_Receive, .-USART_Receive
	.align	1
	.globl	__vector_11
	.type	__vector_11, @function
__vector_11:
	lui	a4,%hi(.LANCHOR0)
	addi	a4,a4,%lo(.LANCHOR0)
	lbu	a2,44(zero)
	lbu	a5,0(a4)
	lbu	a3,1(a4)
	lbu	a1,2(a4)
	lbu	t1,3(a4)
	andi	a2,a2,0xff
	slli	a5,a5,8
	lbu	a7,4(a4)
	slli	a3,a3,16
	or	a5,a2,a5
	lbu	a6,5(a4)
	slli	a1,a1,24
	or	a5,a5,a3
	lbu	a0,6(a4)
	lbu	a3,8(a4)
	lui	t3,%hi(FifoCnt)
	slli	t1,t1,32
	or	a5,a5,a1
	lbu	t4,7(a4)
	lbu	a1,%lo(FifoCnt)(t3)
	or	a5,a5,t1
	slli	a7,a7,40
	lbu	t1,9(a4)
	slli	a6,a6,48
	or	a5,a5,a7
	slli	a0,a0,56
	slli	a3,a3,8
	or	a5,a5,a6
	or	a5,a5,a0
	addiw	a1,a1,1
	or	a3,a3,t4
	lui	a0,%hi(u8_data)
	sb	a2,%lo(u8_data)(a0)
	sb	a1,%lo(FifoCnt)(t3)
	sb	t1,10(a4)
	sh	a3,8(a4)
	sd	a5,0(a4)
	ret
	.size	__vector_11, .-__vector_11
	.align	1
	.globl	USART_Transmit
	.type	USART_Transmit, @function
USART_Transmit:
	sb	a0,44(zero)
.L46:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L46
	ret
	.size	USART_Transmit, .-USART_Transmit
	.align	1
	.globl	AddFinger
	.type	AddFinger, @function
AddFinger:
	lui	a5,%hi(flg)
	addi	sp,sp,-16
	li	a0,4
	sb	zero,%lo(flg)(a5)
	sd	ra,8(sp)
	call	__eerd_byte_m16
	li	a5,255
	beq	a0,a5,.L59
	addiw	a5,a0,1
	andi	a5,a5,0xff
.L50:
	lui	a4,%hi(ID)
	lui	a3,%hi(IDcnt)
	sb	a5,%lo(ID)(a4)
	sb	a0,%lo(IDcnt)(a3)
	li	a5,77
	sb	a5,44(zero)
.L51:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L51
	li	a5,88
	sb	a5,44(zero)
.L52:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L52
	li	a5,16
	sb	a5,44(zero)
.L53:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L53
	li	a5,3
	sb	a5,44(zero)
.L54:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L54
	li	a5,64
	sb	a5,44(zero)
.L55:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L55
	sb	zero,44(zero)
.L56:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L56
	lbu	a4,%lo(ID)(a4)
	sb	a4,44(zero)
.L57:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L57
	addiw	a4,a4,-8
	andi	a4,a4,0xff
	sb	a4,44(zero)
.L58:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L58
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
.L59:
	li	a0,0
	li	a5,1
	j	.L50
	.size	AddFinger, .-AddFinger
	.align	1
	.globl	DeleteFinger
	.type	DeleteFinger, @function
DeleteFinger:
	lui	a5,%hi(flgd)
	addi	sp,sp,-16
	li	a0,4
	sb	zero,%lo(flgd)(a5)
	sd	ra,8(sp)
	call	__eerd_byte_m16
	lui	a5,%hi(IDcnt)
	lui	a4,%hi(ID)
	sb	a0,%lo(IDcnt)(a5)
	sb	a0,%lo(ID)(a4)
	li	a5,77
	sb	a5,44(zero)
.L78:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L78
	li	a5,88
	sb	a5,44(zero)
.L79:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L79
	li	a5,16
	sb	a5,44(zero)
.L80:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L80
	li	a5,3
	sb	a5,44(zero)
.L81:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L81
	li	a5,66
	sb	a5,44(zero)
.L82:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L82
	sb	zero,44(zero)
.L83:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L83
	lbu	a4,%lo(ID)(a4)
	sb	a4,44(zero)
.L84:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L84
	addiw	a4,a4,-6
	andi	a4,a4,0xff
	sb	a4,44(zero)
.L85:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L85
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	DeleteFinger, .-DeleteFinger
	.align	1
	.globl	SearchFinger
	.type	SearchFinger, @function
SearchFinger:
	lui	a5,%hi(flgs)
	addi	sp,sp,-16
	li	a0,4
	sb	zero,%lo(flgs)(a5)
	sd	ra,8(sp)
	call	__eerd_byte_m16
	lui	a5,%hi(IDcnt)
	lui	a4,%hi(ID)
	sb	a0,%lo(IDcnt)(a5)
	sb	a0,%lo(ID)(a4)
	li	a5,77
	sb	a5,44(zero)
.L104:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L104
	li	a5,88
	sb	a5,44(zero)
.L105:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L105
	li	a5,16
	sb	a5,44(zero)
.L106:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L106
	li	a5,5
	sb	a5,44(zero)
.L107:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L107
	li	a5,68
	sb	a5,44(zero)
.L108:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L108
	sb	zero,44(zero)
.L109:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L109
	li	a5,1
	sb	a5,44(zero)
.L110:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L110
	sb	zero,44(zero)
.L111:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L111
	lbu	a4,%lo(ID)(a4)
	sb	a4,44(zero)
.L112:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L112
	addiw	a4,a4,-1
	andi	a4,a4,0xff
	sb	a4,44(zero)
.L113:
	lbu	a5,43(zero)
	andi	a5,a5,32
	beq	a5,zero,.L113
	ld	ra,8(sp)
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
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	sd	s1,8(sp)
	li	a4,2000
.L136:
	li	a5,700
.L137:
 #APP
# 269 "main.c" 1
	nop
# 0 "" 2
 #NO_APP
	addiw	a5,a5,-1
	bne	a5,zero,.L137
	addiw	a4,a4,-1
	bne	a4,zero,.L136
	lbu	a5,56(zero)
	li	a0,1
	lui	s0,%hi(.LC1)
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	li	a0,128
	addi	s0,s0,%lo(.LC1)
	ori	a5,a5,1
	sb	a5,56(zero)
	lbu	a5,56(zero)
	addi	s1,s0,16
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	ori	a5,a5,1
	sb	a5,56(zero)
.L139:
	lbu	a0,0(s0)
	addi	s0,s0,1
	call	displaybyte
	bne	s0,s1,.L139
	lbu	a5,56(zero)
	li	a0,192
	lui	s0,%hi(.LC2)
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	addi	s0,s0,%lo(.LC2)
	addi	s1,s0,16
	ori	a5,a5,1
	sb	a5,56(zero)
.L140:
	lbu	a0,0(s0)
	addi	s0,s0,1
	call	displaybyte
	bne	s0,s1,.L140
	lbu	a5,56(zero)
	andi	a5,a5,247
	sb	a5,56(zero)
	ld	ra,24(sp)
	ld	s0,16(sp)
	ld	s1,8(sp)
	addi	sp,sp,32
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
	addi	sp,sp,-64
	sd	s0,48(sp)
	lui	s0,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(s0)
	sd	ra,56(sp)
	beq	a5,zero,.L145
	sd	s1,40(sp)
	lui	s1,%hi(.LANCHOR0)
	addi	s1,s1,%lo(.LANCHOR0)
	addiw	a4,a5,-1
	sd	s2,32(sp)
	sd	s3,24(sp)
	add	a4,s1,a4
	lbu	a4,0(a4)
	lui	s2,%hi(flg)
	li	a2,48
	lbu	a3,%lo(flg)(s2)
	beq	a4,a2,.L301
	li	a2,4
	beq	a3,a2,.L302
	li	a1,3
	bne	a3,a1,.L161
	sb	zero,%lo(flg)(s2)
	li	a3,64
	bne	a4,a3,.L303
	lui	s3,%hi(flgd)
	lbu	a5,%lo(flgd)(s3)
	beq	a5,a2,.L304
.L177:
	li	a4,3
	bne	a5,a4,.L305
	lui	s2,%hi(flgs)
	lbu	a3,%lo(flgs)(s2)
	sd	s4,16(sp)
	sb	zero,%lo(flgd)(s3)
	li	a4,64
.L205:
	li	a5,4
	beq	a3,a5,.L209
	ld	s4,16(sp)
.L204:
	lbu	a5,%lo(FifoCnt)(s0)
	addiw	a4,a5,-1
	mv	a5,a4
	add	a4,s1,a4
	lbu	a4,0(a4)
	j	.L210
.L313:
	lbu	a1,%lo(flg)(s2)
	li	a2,1
	lbu	a5,%lo(FifoCnt)(s0)
	bne	a1,a2,.L294
	sb	a4,%lo(flg)(s2)
.L294:
	li	a4,4
	beq	a3,a4,.L168
	li	a4,3
	bne	a3,a4,.L306
.L278:
	addiw	a4,a5,-1
	mv	a5,a4
	add	a4,s1,a4
	lbu	a4,0(a4)
.L181:
	sb	zero,%lo(flgd)(s3)
	li	a3,66
	lui	s2,%hi(flgs)
	beq	a4,a3,.L190
.L178:
	li	a5,2
	beq	a4,a5,.L307
.L195:
	li	a5,1
	beq	a4,a5,.L308
.L199:
	li	a5,48
	lbu	a3,%lo(flgs)(s2)
	bne	a4,a5,.L287
	lbu	a5,%lo(FifoCnt)(s0)
	bne	a3,zero,.L206
	addiw	a4,a5,-1
	mv	a5,a4
	add	a4,s1,a4
	lbu	a4,0(a4)
	li	a3,1
	sb	a3,%lo(flgs)(s2)
	li	a3,68
	bne	a4,a3,.L208
.L226:
	ld	s1,40(sp)
	ld	s2,32(sp)
	ld	s3,24(sp)
	sb	a5,%lo(FifoCnt)(s0)
.L145:
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
.L301:
	beq	a3,zero,.L148
	li	a5,4
	beq	a3,a5,.L309
	li	a5,3
	lui	s3,%hi(flgd)
	bne	a3,a5,.L237
	lbu	a3,%lo(flgd)(s3)
	sb	zero,%lo(flg)(s2)
.L238:
	lbu	a5,%lo(FifoCnt)(s0)
	addiw	a4,a5,-1
	mv	a5,a4
	add	a4,s1,a4
	lbu	a4,0(a4)
	beq	a3,zero,.L246
	li	a2,4
	beq	a3,a2,.L185
	li	a2,3
	beq	a3,a2,.L181
.L290:
	lui	s2,%hi(flgs)
	j	.L199
.L302:
	li	a5,51
	beq	a4,a5,.L310
.L153:
	li	a5,52
	beq	a4,a5,.L311
.L155:
	li	a5,49
	beq	a4,a5,.L312
.L157:
	li	a5,8
	lui	s3,%hi(flgd)
	sb	a5,%lo(flg)(s2)
	li	a3,64
	lbu	a5,%lo(flgd)(s3)
	beq	a4,a3,.L160
.L150:
	li	a5,2
	lbu	a3,%lo(flgd)(s3)
	beq	a4,a5,.L313
	li	a5,1
	bne	a4,a5,.L151
.L171:
	lbu	a2,%lo(flg)(s2)
	li	a4,1
	lbu	a5,%lo(FifoCnt)(s0)
	bne	a2,a4,.L296
	li	a4,3
	sb	a4,%lo(flg)(s2)
.L296:
	li	a4,4
	beq	a3,a4,.L168
	li	a4,3
	beq	a3,a4,.L278
	lui	s2,%hi(flgs)
	j	.L235
.L168:
	addiw	a4,a5,-1
	mv	a5,a4
	add	a4,s1,a4
	lbu	a4,0(a4)
.L185:
	li	a3,49
	beq	a4,a3,.L314
.L187:
	li	a3,8
.L175:
	sb	a3,%lo(flgd)(s3)
	li	a3,66
	lui	s2,%hi(flgs)
	bne	a4,a3,.L178
.L190:
	lbu	a3,%lo(flgs)(s2)
	li	a4,4
	beq	a3,a4,.L212
.L194:
	li	a4,3
	bne	a3,a4,.L226
.L292:
	sext.w	a4,a5
	add	a4,s1,a4
	lbu	a4,0(a4)
.L233:
	sb	zero,%lo(flgs)(s2)
	li	a3,68
	beq	a4,a3,.L226
.L208:
	addiw	a3,a4,-2
	andi	a3,a3,253
	bne	a3,zero,.L228
	lbu	a4,%lo(flgs)(s2)
.L234:
	li	a3,1
	bne	a4,a3,.L226
	li	a4,2
	sb	a4,%lo(flgs)(s2)
	j	.L226
.L291:
	addiw	a5,a5,-1
.L212:
	sext.w	a4,a5
	add	a4,s1,a4
	lbu	a4,0(a4)
	li	a3,52
	beq	a4,a3,.L315
.L214:
	li	a3,57
	beq	a4,a3,.L316
.L216:
	li	a3,58
	beq	a4,a3,.L317
.L221:
	li	a3,53
	beq	a4,a3,.L223
	lbu	a3,%lo(flgs)(s2)
.L210:
	li	a2,3
	beq	a3,a2,.L233
	li	a2,68
	bne	a4,a2,.L208
	li	a4,2
	bne	a3,a4,.L226
	li	a4,4
	sb	a4,%lo(flgs)(s2)
	j	.L226
.L206:
	li	a4,4
	addiw	a5,a5,-1
	bne	a3,a4,.L194
	j	.L212
.L148:
	lui	s3,%hi(flgd)
	lbu	a3,%lo(flgd)(s3)
	li	a5,1
	sb	a5,%lo(flg)(s2)
.L151:
	li	a5,48
	beq	a4,a5,.L238
	j	.L282
.L246:
	li	a3,1
	j	.L175
.L307:
	lbu	a3,%lo(flgd)(s3)
.L236:
	li	a2,1
	lbu	a4,%lo(flgs)(s2)
	lbu	a5,%lo(FifoCnt)(s0)
	bne	a3,a2,.L300
	li	a3,2
	sb	a3,%lo(flgd)(s3)
.L300:
	li	a3,4
	beq	a4,a3,.L291
	li	a3,3
	addiw	a5,a5,-1
	bne	a4,a3,.L234
	j	.L292
.L160:
	li	a4,4
	bne	a5,a4,.L177
	li	a5,8
	sb	a5,%lo(flgd)(s3)
	li	a4,64
	lui	s2,%hi(flgs)
	j	.L195
.L308:
	lbu	a3,%lo(flgd)(s3)
.L235:
	li	a2,1
	lbu	a5,%lo(FifoCnt)(s0)
	lbu	a4,%lo(flgs)(s2)
	bne	a3,a2,.L298
	li	a3,3
	sb	a3,%lo(flgd)(s3)
.L298:
	li	a3,4
	beq	a4,a3,.L291
	li	a3,3
	addiw	a5,a5,-1
	beq	a4,a3,.L292
.L232:
	li	a3,1
	bne	a4,a3,.L226
	li	a4,3
	sb	a4,%lo(flgs)(s2)
	j	.L226
.L161:
	lui	s3,%hi(flgd)
	li	a0,64
	lbu	a5,%lo(flgd)(s3)
	bne	a4,a0,.L150
	li	a0,2
	bne	a3,a0,.L160
	sb	a2,%lo(flg)(s2)
	beq	a5,a2,.L165
	bne	a5,a1,.L290
	sb	zero,%lo(flgd)(s3)
	lui	s2,%hi(flgs)
	j	.L199
.L306:
	lui	s2,%hi(flgs)
	j	.L236
.L305:
	lui	s2,%hi(flgs)
	lbu	a3,%lo(flgs)(s2)
	li	a5,4
	bne	a3,a5,.L204
.L192:
	lbu	a5,%lo(FifoCnt)(s0)
	li	a3,51
	addiw	a4,a5,-1
	mv	a5,a4
	add	a4,s1,a4
	lbu	a4,0(a4)
	bne	a4,a3,.L212
	sd	s4,16(sp)
	lbu	a5,56(zero)
	li	a0,1
	lui	s3,%hi(.LC3)
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	li	a0,128
	addi	s3,s3,%lo(.LC3)
	ori	a5,a5,1
	sb	a5,56(zero)
	lbu	a5,56(zero)
	addi	s4,s3,14
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	ori	a5,a5,1
	sb	a5,56(zero)
.L213:
	lbu	a0,0(s3)
	addi	s3,s3,1
	call	displaybyte
	bne	s4,s3,.L213
	li	a5,8
	sb	a5,%lo(flgs)(s2)
	call	DoCancel
	lbu	a5,%lo(FifoCnt)(s0)
	ld	s4,16(sp)
	addiw	a5,a5,-1
	j	.L212
.L314:
	sd	s4,16(sp)
	sd	s5,8(sp)
	lbu	a5,56(zero)
	li	a0,1
	lui	s2,%hi(.LC8)
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	li	a0,128
	addi	s2,s2,%lo(.LC8)
	ori	a5,a5,1
	sb	a5,56(zero)
	lbu	a5,56(zero)
	addi	s4,s2,16
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	ori	a5,a5,1
	sb	a5,56(zero)
.L188:
	lbu	a0,0(s2)
	addi	s2,s2,1
	call	displaybyte
	bne	s4,s2,.L188
	lbu	a5,56(zero)
	li	a0,192
	lui	s4,%hi(mystr)
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	lui	a1,%hi(.LC6)
	lui	s2,%hi(.LC7)
	ori	a5,a5,1
	sb	a5,56(zero)
	lui	a5,%hi(ID)
	lbu	a2,%lo(ID)(a5)
	addi	a1,a1,%lo(.LC6)
	addi	a0,s4,%lo(mystr)
	addi	s2,s2,%lo(.LC7)
	call	sprintf
	addi	s5,s2,8
.L189:
	lbu	a0,0(s2)
	addi	s2,s2,1
	call	displaybyte
	bne	s5,s2,.L189
	lbu	a0,%lo(mystr)(s4)
	addi	s4,s4,%lo(mystr)
	lui	s2,%hi(IDcnt)
	call	displaybyte
	lbu	a0,1(s4)
	call	displaybyte
	lbu	a0,%lo(IDcnt)(s2)
	li	a1,255
	addi	a0,a0,8
	call	__eewr_byte_m16
	lbu	a1,%lo(IDcnt)(s2)
	li	a0,4
	addiw	a1,a1,-1
	andi	a1,a1,0xff
	sb	a1,%lo(IDcnt)(s2)
	call	__eewr_byte_m16
	call	DoCancel
	lbu	a5,%lo(FifoCnt)(s0)
	ld	s4,16(sp)
	ld	s5,8(sp)
	addiw	a4,a5,-1
	mv	a5,a4
	add	a4,s1,a4
	lbu	a4,0(a4)
	j	.L187
.L237:
	lbu	a3,%lo(flgd)(s3)
	j	.L238
.L304:
	li	a5,8
	sb	a5,%lo(flgd)(s3)
	lui	s2,%hi(flgs)
	j	.L178
.L315:
	sd	s4,16(sp)
	lbu	a5,56(zero)
	li	a0,1
	lui	s3,%hi(.LC4)
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	li	a0,128
	addi	s3,s3,%lo(.LC4)
	ori	a5,a5,1
	sb	a5,56(zero)
	lbu	a5,56(zero)
	addi	s4,s3,14
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	ori	a5,a5,1
	sb	a5,56(zero)
.L215:
	lbu	a0,0(s3)
	addi	s3,s3,1
	call	displaybyte
	bne	s4,s3,.L215
	li	a5,8
	sb	a5,%lo(flgs)(s2)
	call	DoCancel
	lbu	a5,%lo(FifoCnt)(s0)
	ld	s4,16(sp)
	addiw	a4,a5,-1
	mv	a5,a4
	add	a4,s1,a4
	lbu	a4,0(a4)
	j	.L214
.L312:
	sd	s4,16(sp)
	sd	s5,8(sp)
	sd	s6,0(sp)
	lbu	a5,56(zero)
	li	a0,1
	lui	s3,%hi(.LC5)
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	li	a0,128
	addi	s3,s3,%lo(.LC5)
	ori	a5,a5,1
	sb	a5,56(zero)
	lbu	a5,56(zero)
	addi	s4,s3,15
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	ori	a5,a5,1
	sb	a5,56(zero)
.L158:
	lbu	a0,0(s3)
	addi	s3,s3,1
	call	displaybyte
	bne	s3,s4,.L158
	lbu	a5,56(zero)
	li	a0,192
	lui	s6,%hi(ID)
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	lui	s4,%hi(mystr)
	lui	a1,%hi(.LC6)
	ori	a5,a5,1
	sb	a5,56(zero)
	lbu	a2,%lo(ID)(s6)
	lui	s3,%hi(.LC7)
	addi	a1,a1,%lo(.LC6)
	addi	a0,s4,%lo(mystr)
	addi	s3,s3,%lo(.LC7)
	call	sprintf
	addi	s5,s3,8
.L159:
	lbu	a0,0(s3)
	addi	s3,s3,1
	call	displaybyte
	bne	s5,s3,.L159
	lbu	a0,%lo(mystr)(s4)
	addi	s4,s4,%lo(mystr)
	lui	s3,%hi(IDcnt)
	call	displaybyte
	lbu	a0,1(s4)
	call	displaybyte
	lbu	a0,%lo(IDcnt)(s3)
	lbu	a1,%lo(ID)(s6)
	addi	a0,a0,8
	call	__eewr_byte_m16
	lbu	a1,%lo(IDcnt)(s3)
	li	a0,4
	addiw	a1,a1,1
	andi	a1,a1,0xff
	sb	a1,%lo(IDcnt)(s3)
	call	__eewr_byte_m16
	call	DoCancel
	lbu	a5,%lo(FifoCnt)(s0)
	ld	s4,16(sp)
	ld	s5,8(sp)
	addiw	a5,a5,-1
	add	a5,s1,a5
	lbu	a4,0(a5)
	ld	s6,0(sp)
	j	.L157
.L311:
	sd	s4,16(sp)
	lbu	a5,56(zero)
	li	a0,1
	lui	s3,%hi(.LC4)
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	li	a0,128
	addi	s3,s3,%lo(.LC4)
	ori	a5,a5,1
	sb	a5,56(zero)
	lbu	a5,56(zero)
	addi	s4,s3,14
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	ori	a5,a5,1
	sb	a5,56(zero)
.L156:
	lbu	a0,0(s3)
	addi	s3,s3,1
	call	displaybyte
	bne	s4,s3,.L156
	call	DoCancel
	lbu	a5,%lo(FifoCnt)(s0)
	ld	s4,16(sp)
	addiw	a5,a5,-1
	add	a5,s1,a5
	lbu	a4,0(a5)
	j	.L155
.L310:
	sd	s4,16(sp)
	lbu	a5,56(zero)
	li	a0,1
	lui	s3,%hi(.LC3)
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	li	a0,128
	addi	s3,s3,%lo(.LC3)
	ori	a5,a5,1
	sb	a5,56(zero)
	lbu	a5,56(zero)
	addi	s4,s3,14
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	ori	a5,a5,1
	sb	a5,56(zero)
.L154:
	lbu	a0,0(s3)
	addi	s3,s3,1
	call	displaybyte
	bne	s3,s4,.L154
	call	DoCancel
	lbu	a5,%lo(FifoCnt)(s0)
	ld	s4,16(sp)
	addiw	a5,a5,-1
	add	a5,s1,a5
	lbu	a4,0(a5)
	j	.L153
.L317:
	sd	s4,16(sp)
	lbu	a5,56(zero)
	li	a0,1
	lui	s3,%hi(.LC11)
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	li	a0,128
	addi	s3,s3,%lo(.LC11)
	ori	a5,a5,1
	sb	a5,56(zero)
	lbu	a5,56(zero)
	addi	s4,s3,16
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	ori	a5,a5,1
	sb	a5,56(zero)
.L222:
	lbu	a0,0(s3)
	addi	s3,s3,1
	call	displaybyte
	bne	s4,s3,.L222
	lbu	a5,56(zero)
	li	a0,192
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	ori	a5,a5,1
	sb	a5,56(zero)
	li	a5,8
	sb	a5,%lo(flgs)(s2)
	call	DoCancel
	lbu	a5,%lo(FifoCnt)(s0)
	ld	s4,16(sp)
	addiw	a4,a5,-1
	mv	a5,a4
	add	a4,s1,a4
	lbu	a4,0(a4)
	j	.L221
.L316:
	sd	s4,16(sp)
	lbu	a5,56(zero)
	li	a0,1
	lui	s3,%hi(.LC10)
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	li	a0,128
	addi	s3,s3,%lo(.LC10)
	ori	a5,a5,1
	sb	a5,56(zero)
	lbu	a5,56(zero)
	addi	s4,s3,15
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	ori	a5,a5,1
	sb	a5,56(zero)
.L217:
	lbu	a0,0(s3)
	addi	s3,s3,1
	call	displaybyte
	bne	s4,s3,.L217
	lbu	a5,56(zero)
	li	a0,192
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	li	a4,2000
	ori	a5,a5,1
	sb	a5,56(zero)
	li	a5,8
	sb	a5,%lo(flgs)(s2)
	lbu	a5,56(zero)
	ori	a5,a5,8
	sb	a5,56(zero)
.L218:
	li	a5,700
.L219:
 #APP
# 269 "main.c" 1
	nop
# 0 "" 2
 #NO_APP
	addiw	a5,a5,-1
	bne	a5,zero,.L219
	addiw	a4,a4,-1
	bne	a4,zero,.L218
	call	DoCancel
	lbu	a5,%lo(FifoCnt)(s0)
	ld	s4,16(sp)
	addiw	a4,a5,-1
	mv	a5,a4
	add	a4,s1,a4
	lbu	a4,0(a4)
	j	.L216
.L223:
	sd	s4,16(sp)
	lbu	a5,56(zero)
	li	a0,1
	lui	s3,%hi(.LC12)
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	li	a0,128
	addi	s3,s3,%lo(.LC12)
	ori	a5,a5,1
	sb	a5,56(zero)
	lbu	a5,56(zero)
	addi	s4,s3,16
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	ori	a5,a5,1
	sb	a5,56(zero)
.L224:
	lbu	a0,0(s3)
	addi	s3,s3,1
	call	displaybyte
	bne	s3,s4,.L224
	li	a5,8
	sb	a5,%lo(flgs)(s2)
	call	DoCancel
	lbu	a5,%lo(FifoCnt)(s0)
	lbu	a3,%lo(flgs)(s2)
	ld	s4,16(sp)
	addiw	a4,a5,-1
	mv	a5,a4
	add	a4,s1,a4
	lbu	a4,0(a4)
	j	.L210
.L180:
	li	a5,51
	bne	a4,a5,.L284
	lbu	a5,56(zero)
	li	a0,1
	lui	s2,%hi(.LC3)
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	li	a0,128
	addi	s2,s2,%lo(.LC3)
	ori	a5,a5,1
	sb	a5,56(zero)
	lbu	a5,56(zero)
	addi	s4,s2,14
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	ori	a5,a5,1
	sb	a5,56(zero)
.L184:
	lbu	a0,0(s2)
	addi	s2,s2,1
	call	displaybyte
	bne	s4,s2,.L184
	call	DoCancel
	ld	s4,16(sp)
.L165:
	lbu	a5,%lo(FifoCnt)(s0)
	li	a3,52
	addiw	a4,a5,-1
	mv	a5,a4
	add	a4,s1,a4
	lbu	a4,0(a4)
	bne	a4,a3,.L185
	sd	s4,16(sp)
	lbu	a5,56(zero)
	li	a0,1
	lui	s2,%hi(.LC4)
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	li	a0,128
	addi	s2,s2,%lo(.LC4)
	ori	a5,a5,1
	sb	a5,56(zero)
	lbu	a5,56(zero)
	addi	s4,s2,14
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	ori	a5,a5,1
	sb	a5,56(zero)
.L186:
	lbu	a0,0(s2)
	addi	s2,s2,1
	call	displaybyte
	bne	s4,s2,.L186
	call	DoCancel
	lbu	a5,%lo(FifoCnt)(s0)
	ld	s4,16(sp)
	addiw	a4,a5,-1
	mv	a5,a4
	add	a4,s1,a4
	lbu	a4,0(a4)
	j	.L185
.L309:
	li	a5,8
	sb	a5,%lo(flg)(s2)
	lui	s3,%hi(flgd)
	j	.L150
.L303:
	lui	s3,%hi(flgd)
	li	a2,2
	lbu	a3,%lo(flgd)(s3)
	beq	a4,a2,.L294
	li	a5,1
	beq	a4,a5,.L171
.L282:
	sd	s4,16(sp)
	li	a2,4
	beq	a3,a2,.L180
	lbu	a5,%lo(FifoCnt)(s0)
	li	a1,3
	addiw	a4,a5,-1
	mv	a5,a4
	add	a4,s1,a4
	lbu	a4,0(a4)
	bne	a3,a1,.L318
	ld	s4,16(sp)
	j	.L181
.L318:
	lui	s2,%hi(flgs)
	li	a0,66
	lbu	a3,%lo(flgs)(s2)
	bne	a4,a0,.L285
	lbu	a6,%lo(flgd)(s3)
	li	a0,2
	bne	a6,a0,.L286
	sb	a2,%lo(flgd)(s3)
	beq	a3,a2,.L288
	beq	a3,a1,.L319
	ld	s4,16(sp)
.L228:
	li	a3,1
	bne	a4,a3,.L226
	lbu	a4,%lo(flgs)(s2)
	j	.L232
.L209:
	li	a5,49
	bne	a4,a5,.L288
	lbu	a5,56(zero)
	li	a0,1
	lui	s3,%hi(.LC9)
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	li	a0,128
	addi	s3,s3,%lo(.LC9)
	ori	a5,a5,1
	sb	a5,56(zero)
	lbu	a5,56(zero)
	addi	s4,s3,13
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	ori	a5,a5,1
	sb	a5,56(zero)
.L211:
	lbu	a0,0(s3)
	addi	s3,s3,1
	call	displaybyte
	bne	s4,s3,.L211
	ld	s4,16(sp)
	sb	zero,%lo(flgs)(s2)
	j	.L192
.L284:
	ld	s4,16(sp)
	j	.L165
.L319:
	ld	s4,16(sp)
	sb	zero,%lo(flgs)(s2)
	j	.L208
.L286:
	ld	s4,16(sp)
	j	.L190
.L285:
	ld	s4,16(sp)
	j	.L178
.L288:
	ld	s4,16(sp)
	j	.L192
.L287:
	sd	s4,16(sp)
	j	.L205
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
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-176
	sd	ra,168(sp)
	sd	s0,160(sp)
	sd	s1,152(sp)
	sd	s2,144(sp)
	sd	s3,136(sp)
	sd	s4,128(sp)
	sd	s5,120(sp)
	sd	s6,112(sp)
	sd	s7,104(sp)
	sd	s8,96(sp)
	sd	s9,88(sp)
	sd	s10,80(sp)
	sd	s11,72(sp)
	li	a5,9
	sb	a5,55(zero)
	li	a5,-36
	sb	a5,49(zero)
	sb	zero,52(zero)
	li	a5,-1
	sb	a5,53(zero)
	lui	a5,%hi(FifoCnt)
	sb	zero,%lo(FifoCnt)(a5)
	li	a4,500
.L321:
	li	a5,700
.L322:
 #APP
# 269 "main.c" 1
	nop
# 0 "" 2
 #NO_APP
	addiw	a5,a5,-1
	bne	a5,zero,.L322
	addiw	a4,a4,-1
	bne	a4,zero,.L321
	call	dispinit
	call	USART_Init
	li	a4,200
.L324:
	li	a5,700
.L325:
 #APP
# 269 "main.c" 1
	nop
# 0 "" 2
 #NO_APP
	addiw	a5,a5,-1
	bne	a5,zero,.L325
	addiw	a4,a4,-1
	bne	a4,zero,.L324
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
	lui	s4,%hi(flgmenu)
	lui	a4,%hi(flgs)
	li	a0,4
	sb	a5,%lo(flgs)(a4)
	sb	zero,%lo(flgmenu)(s4)
	call	__eerd_byte_m16
	lui	a5,%hi(IDcnt)
	sb	a0,%lo(IDcnt)(a5)
	li	a4,255
	beq	a0,a4,.L374
	addi	a0,a0,8
	call	__eerd_byte_m16
	lui	a5,%hi(ID)
	sb	a0,%lo(ID)(a5)
.L329:
	lui	a5,%hi(.LC13)
	addi	a5,a5,%lo(.LC13)
	sd	a5,32(sp)
	lui	a5,%hi(.LC14)
	addi	a5,a5,%lo(.LC14)
	sd	a5,40(sp)
	lui	a5,%hi(.LC15)
	addi	a5,a5,%lo(.LC15)
	sd	a5,0(sp)
	lui	a5,%hi(.LC16)
	addi	a5,a5,%lo(.LC16)
	sd	a5,16(sp)
	lui	a5,%hi(.LC17)
	addi	a5,a5,%lo(.LC17)
	sd	a5,24(sp)
	lui	a5,%hi(.LC7)
	addi	a5,a5,%lo(.LC7)
	sd	a5,8(sp)
	lui	a5,%hi(.LC18)
	addi	a5,a5,%lo(.LC18)
	sd	a5,48(sp)
	lui	a5,%hi(.LC19)
	lui	s7,%hi(.LC13+18)
	lui	s6,%hi(.LC14+16)
	lui	s0,%hi(.LC15+16)
	lui	s3,%hi(.LC16+14)
	lui	s2,%hi(.LC17+16)
	lui	s1,%hi(.LC7+8)
	lui	s5,%hi(.LC18+16)
	addi	a5,a5,%lo(.LC19)
	lui	s9,%hi(.LC19+16)
	addi	s7,s7,%lo(.LC13+18)
	addi	s6,s6,%lo(.LC14+16)
	lui	s8,%hi(IDT)
	addi	s0,s0,%lo(.LC15+16)
	addi	s3,s3,%lo(.LC16+14)
	addi	s2,s2,%lo(.LC17+16)
	addi	s1,s1,%lo(.LC7+8)
	addi	s5,s5,%lo(.LC18+16)
	sd	a5,56(sp)
	addi	s9,s9,%lo(.LC19+16)
	li	s10,253
.L328:
	call	ProcessFifo
	lbu	a5,51(zero)
	andi	a5,a5,4
	beq	a5,zero,.L375
.L330:
	lbu	a5,51(zero)
	andi	a5,a5,32
	bne	a5,zero,.L336
	li	a0,4
	call	__eerd_byte_m16
	addiw	a5,a0,-1
	sb	a0,%lo(IDT)(s8)
	andi	a5,a5,0xff
	bleu	a5,s10,.L337
	lbu	a5,56(zero)
	li	a0,1
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	li	a0,128
	ori	a5,a5,1
	sb	a5,56(zero)
	lbu	a5,56(zero)
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a4,56(zero)
	ld	s11,0(sp)
	ori	a4,a4,1
	sb	a4,56(zero)
.L338:
	lbu	a0,0(s11)
	addi	s11,s11,1
	call	displaybyte
	bne	s11,s0,.L338
	lbu	a5,56(zero)
	li	a0,192
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a4,56(zero)
	ld	s11,16(sp)
	ori	a4,a4,1
	sb	a4,56(zero)
.L339:
	lbu	a0,0(s11)
	addi	s11,s11,1
	call	displaybyte
	bne	s3,s11,.L339
	call	DoCancel
.L336:
	lbu	a5,51(zero)
	andi	a5,a5,2
	bne	a5,zero,.L343
	lbu	a4,%lo(flgmenu)(s4)
	li	a5,1
	beq	a4,a5,.L342
.L343:
	lbu	a5,51(zero)
	andi	a5,a5,16
	beq	a5,zero,.L376
	lbu	a5,51(zero)
	lbu	a4,%lo(flgmenu)(s4)
	andi	a5,a5,8
	or	a5,a5,a4
	bne	a5,zero,.L328
	li	a0,4
	call	__eerd_byte_m16
	addiw	a5,a0,-1
	sb	a0,%lo(IDT)(s8)
	andi	a5,a5,0xff
	bleu	a5,s10,.L377
.L347:
	lbu	a5,56(zero)
	li	a0,1
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	li	a0,128
	ori	a5,a5,1
	sb	a5,56(zero)
	lbu	a5,56(zero)
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a4,56(zero)
	ld	s11,0(sp)
	ori	a4,a4,1
	sb	a4,56(zero)
.L350:
	lbu	a0,0(s11)
	addi	s11,s11,1
	call	displaybyte
	bne	s11,s0,.L350
	lbu	a5,56(zero)
	li	a0,192
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a4,56(zero)
	ld	s11,48(sp)
	ori	a4,a4,1
	sb	a4,56(zero)
.L351:
	lbu	a0,0(s11)
	addi	s11,s11,1
	call	displaybyte
	bne	s5,s11,.L351
	call	DoCancel
	call	ProcessFifo
	lbu	a5,51(zero)
	andi	a5,a5,4
	bne	a5,zero,.L330
.L375:
	li	a5,8
	sb	a5,%lo(flgmenu)(s4)
	lbu	a5,56(zero)
	li	a0,1
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	li	a0,128
	ori	a5,a5,1
	sb	a5,56(zero)
	lbu	a5,56(zero)
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a4,56(zero)
	ld	s11,32(sp)
	ori	a4,a4,1
	sb	a4,56(zero)
.L331:
	lbu	a0,0(s11)
	addi	s11,s11,1
	call	displaybyte
	bne	s11,s7,.L331
	lbu	a5,56(zero)
	li	a0,192
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a4,56(zero)
	ld	s11,40(sp)
	ori	a4,a4,1
	sb	a4,56(zero)
.L332:
	lbu	a0,0(s11)
	addi	s11,s11,1
	call	displaybyte
	bne	s11,s6,.L332
	li	a4,2000
.L333:
	li	a5,700
.L334:
 #APP
# 269 "main.c" 1
	nop
# 0 "" 2
 #NO_APP
	addiw	a5,a5,-1
	bne	a5,zero,.L334
	addiw	a4,a4,-1
	bne	a4,zero,.L333
	call	AddFinger
	sb	zero,%lo(flgmenu)(s4)
	j	.L330
.L376:
	call	DoCancel
	sb	zero,%lo(flgmenu)(s4)
	lbu	a5,51(zero)
	andi	a5,a5,8
	bne	a5,zero,.L328
	li	a0,4
	call	__eerd_byte_m16
	addiw	a5,a0,-1
	sb	a0,%lo(IDT)(s8)
	andi	a5,a5,0xff
	bgtu	a5,s10,.L347
.L377:
	lbu	a5,56(zero)
	li	a0,1
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	li	a0,128
	ori	a5,a5,1
	sb	a5,56(zero)
	lbu	a5,56(zero)
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a4,56(zero)
	ld	s11,56(sp)
	ori	a4,a4,1
	sb	a4,56(zero)
.L353:
	lbu	a0,0(s11)
	addi	s11,s11,1
	call	displaybyte
	bne	s11,s9,.L353
	call	SearchFinger
	j	.L328
.L337:
	lbu	a5,56(zero)
	li	a0,1
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	li	a0,128
	ori	a5,a5,1
	sb	a5,56(zero)
	lbu	a5,56(zero)
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a4,56(zero)
	ld	s11,24(sp)
	ori	a4,a4,1
	sb	a4,56(zero)
.L340:
	lbu	a0,0(s11)
	addi	s11,s11,1
	call	displaybyte
	bne	s11,s2,.L340
	lbu	a5,56(zero)
	li	a0,192
	andi	a5,a5,254
	sb	a5,56(zero)
	call	displaybyte
	lbu	a5,56(zero)
	lui	a4,%hi(.LC6)
	addi	a1,a4,%lo(.LC6)
	ori	a5,a5,1
	sb	a5,56(zero)
	lbu	a2,%lo(IDT)(s8)
	lui	a4,%hi(mystr)
	addi	a0,a4,%lo(mystr)
	call	sprintf
	ld	s11,8(sp)
.L341:
	lbu	a0,0(s11)
	addi	s11,s11,1
	call	displaybyte
	bne	s11,s1,.L341
	lui	a5,%hi(mystr)
	lbu	a0,%lo(mystr)(a5)
	mv	s11,a5
	call	displaybyte
	addi	a5,s11,%lo(mystr)
	lbu	a0,1(a5)
	call	displaybyte
	li	a5,1
	sb	a5,%lo(flgmenu)(s4)
	lbu	a5,51(zero)
	andi	a5,a5,2
	bne	a5,zero,.L343
.L342:
	call	DeleteFinger
	sb	zero,%lo(flgmenu)(s4)
	j	.L343
.L374:
	li	a1,0
	li	a0,4
	sb	zero,%lo(IDcnt)(a5)
	call	__eewr_byte_m16
	j	.L329
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
