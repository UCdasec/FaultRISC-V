	.file	"main.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	u8_data
	.section	.sbss,"aw",@nobits
	.type	u8_data, @object
	.size	u8_data, 1
u8_data:
	.zero	1
	.globl	mystr
	.align	3
	.type	mystr, @object
	.size	mystr, 6
mystr:
	.zero	6
	.globl	ID
	.type	ID, @object
	.size	ID, 1
ID:
	.zero	1
	.globl	flg
	.type	flg, @object
	.size	flg, 1
flg:
	.zero	1
	.globl	flgd
	.type	flgd, @object
	.size	flgd, 1
flgd:
	.zero	1
	.globl	flgs
	.type	flgs, @object
	.size	flgs, 1
flgs:
	.zero	1
	.globl	Fifo
	.bss
	.align	3
	.type	Fifo, @object
	.size	Fifo, 20
Fifo:
	.zero	20
	.globl	FifoCnt
	.section	.sbss
	.type	FifoCnt, @object
	.size	FifoCnt, 1
FifoCnt:
	.zero	1
	.globl	IDcnt
	.type	IDcnt, @object
	.size	IDcnt, 1
IDcnt:
	.zero	1
	.globl	IDT
	.type	IDT, @object
	.size	IDT, 1
IDT:
	.zero	1
	.globl	flgmenu
	.type	flgmenu, @object
	.size	flgmenu, 1
flgmenu:
	.zero	1
	.section	.rodata
	.align	3
.LC0:
	.string	"  Finger Print  "
	.align	3
.LC1:
	.string	"     Access     "
	.align	3
.LC2:
	.string	"  Finger Added    "
	.align	3
.LC3:
	.string	"  Successfully  "
	.align	3
.LC4:
	.string	"    Finger      "
	.align	3
.LC5:
	.string	"   Deleted    "
	.align	3
.LC6:
	.string	"  Delete finger "
	.align	3
.LC7:
	.string	"%02d"
	.align	3
.LC8:
	.string	"   ID : "
	.align	3
.LC9:
	.string	"  Not  Found    "
	.align	3
.LC10:
	.string	"  Place finger  "
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	li	a5,55
	li	a4,9
	sb	a4,0(a5)
	li	a5,49
	li	a4,-36
	sb	a4,0(a5)
	li	a5,52
	sb	zero,0(a5)
	li	a5,53
	li	a4,-1
	sb	a4,0(a5)
	lui	a5,%hi(FifoCnt)
	sb	zero,%lo(FifoCnt)(a5)
	li	a0,500
	call	delay_ms
	call	dispinit
	call	USART_Init
	li	a0,200
	call	delay_ms
	li	a5,95
	li	a4,-128
	sb	a4,0(a5)
	call	line1
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	display
	call	line2
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	display
	lui	a5,%hi(flg)
	li	a4,8
	sb	a4,%lo(flg)(a5)
	lui	a5,%hi(flgd)
	li	a4,8
	sb	a4,%lo(flgd)(a5)
	lui	a5,%hi(flgs)
	li	a4,8
	sb	a4,%lo(flgs)(a5)
	lui	a5,%hi(flgmenu)
	sb	zero,%lo(flgmenu)(a5)
	li	a0,4
	call	__eerd_byte_m16
	mv	a5,a0
	mv	a4,a5
	lui	a5,%hi(IDcnt)
	sb	a4,%lo(IDcnt)(a5)
	lui	a5,%hi(IDcnt)
	lbu	a5,%lo(IDcnt)(a5)
	mv	a4,a5
	li	a5,255
	bne	a4,a5,.L2
	lui	a5,%hi(IDcnt)
	sb	zero,%lo(IDcnt)(a5)
	lui	a5,%hi(IDcnt)
	lbu	a5,%lo(IDcnt)(a5)
	mv	a1,a5
	li	a0,4
	call	__eewr_byte_m16
	j	.L13
.L2:
	lui	a5,%hi(IDcnt)
	lbu	a5,%lo(IDcnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,8
	sext.w	a5,a5
	mv	a0,a5
	call	__eerd_byte_m16
	mv	a5,a0
	mv	a4,a5
	lui	a5,%hi(ID)
	sb	a4,%lo(ID)(a5)
.L13:
	call	ProcessFifo
	li	a5,51
	lbu	a5,0(a5)
	andi	a5,a5,0xff
	sext.w	a5,a5
	andi	a5,a5,4
	sext.w	a5,a5
	bne	a5,zero,.L4
	lui	a5,%hi(flgmenu)
	li	a4,8
	sb	a4,%lo(flgmenu)(a5)
	call	cleardisplay
	call	line1
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	display
	call	line2
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	display
	li	a0,2000
	call	delay_ms
	call	AddFinger
	lui	a5,%hi(flgmenu)
	sb	zero,%lo(flgmenu)(a5)
.L4:
	li	a5,51
	lbu	a5,0(a5)
	andi	a5,a5,0xff
	sext.w	a5,a5
	andi	a5,a5,32
	sext.w	a5,a5
	bne	a5,zero,.L5
	li	a0,4
	call	__eerd_byte_m16
	mv	a5,a0
	mv	a4,a5
	lui	a5,%hi(IDT)
	sb	a4,%lo(IDT)(a5)
	lui	a5,%hi(IDT)
	lbu	a5,%lo(IDT)(a5)
	beq	a5,zero,.L6
	lui	a5,%hi(IDT)
	lbu	a5,%lo(IDT)(a5)
	mv	a4,a5
	li	a5,255
	bne	a4,a5,.L7
.L6:
	call	cleardisplay
	call	line1
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	display
	call	line2
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	display
	call	DoCancel
	j	.L5
.L7:
	call	cleardisplay
	call	line1
	lui	a5,%hi(.LC6)
	addi	a0,a5,%lo(.LC6)
	call	display
	call	line2
	lui	a5,%hi(IDT)
	lbu	a5,%lo(IDT)(a5)
	sext.w	a5,a5
	mv	a2,a5
	lui	a5,%hi(.LC7)
	addi	a1,a5,%lo(.LC7)
	lui	a5,%hi(mystr)
	addi	a0,a5,%lo(mystr)
	call	sprintf
	lui	a5,%hi(.LC8)
	addi	a0,a5,%lo(.LC8)
	call	display
	lui	a5,%hi(mystr)
	lbu	a5,%lo(mystr)(a5)
	mv	a0,a5
	call	displaybyte
	lui	a5,%hi(mystr)
	addi	a5,a5,%lo(mystr)
	lbu	a5,1(a5)
	mv	a0,a5
	call	displaybyte
	lui	a5,%hi(flgmenu)
	li	a4,1
	sb	a4,%lo(flgmenu)(a5)
.L5:
	li	a5,51
	lbu	a5,0(a5)
	andi	a5,a5,0xff
	sext.w	a5,a5
	andi	a5,a5,2
	sext.w	a5,a5
	bne	a5,zero,.L8
	lui	a5,%hi(flgmenu)
	lbu	a5,%lo(flgmenu)(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L8
	call	DeleteFinger
	lui	a5,%hi(flgmenu)
	sb	zero,%lo(flgmenu)(a5)
.L8:
	li	a5,51
	lbu	a5,0(a5)
	andi	a5,a5,0xff
	sext.w	a5,a5
	andi	a5,a5,16
	sext.w	a5,a5
	bne	a5,zero,.L9
	call	DoCancel
	lui	a5,%hi(flgmenu)
	sb	zero,%lo(flgmenu)(a5)
.L9:
	li	a5,51
	lbu	a5,0(a5)
	andi	a5,a5,0xff
	sext.w	a5,a5
	andi	a5,a5,8
	sext.w	a5,a5
	bne	a5,zero,.L13
	lui	a5,%hi(flgmenu)
	lbu	a5,%lo(flgmenu)(a5)
	bne	a5,zero,.L13
	li	a0,4
	call	__eerd_byte_m16
	mv	a5,a0
	mv	a4,a5
	lui	a5,%hi(IDT)
	sb	a4,%lo(IDT)(a5)
	lui	a5,%hi(IDT)
	lbu	a5,%lo(IDT)(a5)
	beq	a5,zero,.L11
	lui	a5,%hi(IDT)
	lbu	a5,%lo(IDT)(a5)
	mv	a4,a5
	li	a5,255
	bne	a4,a5,.L12
.L11:
	call	cleardisplay
	call	line1
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	display
	call	line2
	lui	a5,%hi(.LC9)
	addi	a0,a5,%lo(.LC9)
	call	display
	call	DoCancel
	j	.L10
.L12:
	call	cleardisplay
	call	line1
	lui	a5,%hi(.LC10)
	addi	a0,a5,%lo(.LC10)
	call	display
	call	SearchFinger
.L10:
	j	.L13
	.size	main, .-main
	.align	1
	.globl	display
	.type	display, @function
display:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	ld	a0,-40(s0)
	call	strlen
	mv	a5,a0
	sw	a5,-24(s0)
	sw	zero,-20(s0)
	j	.L15
.L16:
	lw	a5,-20(s0)
	ld	a4,-40(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a0,a5
	call	displaybyte
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L15:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	blt	a4,a5,.L16
	nop
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	display, .-display
	.align	1
	.globl	displaybyte
	.type	displaybyte, @function
displaybyte:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	mv	a5,a0
	sb	a5,-33(s0)
	lbu	a5,-33(s0)
	sb	a5,-17(s0)
	lbu	a5,-17(s0)
	andi	a5,a5,-16
	sb	a5,-17(s0)
	lbu	a5,-17(s0)
	srliw	a5,a5,4
	sb	a5,-17(s0)
	li	a5,50
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,50
	andi	a4,a4,-93
	andi	a4,a4,0xff
	sb	a4,0(a5)
	li	a5,50
	lbu	a5,0(a5)
	andi	a5,a5,0xff
	slliw	a4,a5,24
	sraiw	a4,a4,24
	lb	a5,-17(s0)
	slliw	a5,a5,6
	slliw	a5,a5,24
	sraiw	a5,a5,24
	andi	a5,a5,64
	slliw	a5,a5,24
	sraiw	a5,a5,24
	or	a5,a4,a5
	slliw	a4,a5,24
	sraiw	a4,a4,24
	li	a5,50
	andi	a4,a4,0xff
	sb	a4,0(a5)
	li	a5,50
	lbu	a5,0(a5)
	andi	a5,a5,0xff
	slliw	a4,a5,24
	sraiw	a4,a4,24
	lb	a5,-17(s0)
	slliw	a5,a5,1
	slliw	a5,a5,24
	sraiw	a5,a5,24
	andi	a5,a5,4
	slliw	a5,a5,24
	sraiw	a5,a5,24
	or	a5,a4,a5
	slliw	a4,a5,24
	sraiw	a4,a4,24
	li	a5,50
	andi	a4,a4,0xff
	sb	a4,0(a5)
	li	a5,50
	lbu	a5,0(a5)
	andi	a5,a5,0xff
	slliw	a4,a5,24
	sraiw	a4,a4,24
	lb	a5,-17(s0)
	slliw	a5,a5,2
	slliw	a5,a5,24
	sraiw	a5,a5,24
	andi	a5,a5,16
	slliw	a5,a5,24
	sraiw	a5,a5,24
	or	a5,a4,a5
	slliw	a4,a5,24
	sraiw	a4,a4,24
	li	a5,50
	andi	a4,a4,0xff
	sb	a4,0(a5)
	li	a5,50
	lbu	a5,0(a5)
	andi	a5,a5,0xff
	slliw	a4,a5,24
	sraiw	a4,a4,24
	lb	a5,-17(s0)
	andi	a5,a5,8
	slliw	a5,a5,24
	sraiw	a5,a5,24
	or	a5,a4,a5
	slliw	a4,a5,24
	sraiw	a4,a4,24
	li	a5,50
	andi	a4,a4,0xff
	sb	a4,0(a5)
	call	epulse
	lbu	a5,-33(s0)
	sb	a5,-17(s0)
	lbu	a5,-17(s0)
	andi	a5,a5,15
	sb	a5,-17(s0)
	li	a5,50
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,50
	andi	a4,a4,-93
	andi	a4,a4,0xff
	sb	a4,0(a5)
	li	a5,50
	lbu	a5,0(a5)
	andi	a5,a5,0xff
	slliw	a4,a5,24
	sraiw	a4,a4,24
	lb	a5,-17(s0)
	slliw	a5,a5,6
	slliw	a5,a5,24
	sraiw	a5,a5,24
	andi	a5,a5,64
	slliw	a5,a5,24
	sraiw	a5,a5,24
	or	a5,a4,a5
	slliw	a4,a5,24
	sraiw	a4,a4,24
	li	a5,50
	andi	a4,a4,0xff
	sb	a4,0(a5)
	li	a5,50
	lbu	a5,0(a5)
	andi	a5,a5,0xff
	slliw	a4,a5,24
	sraiw	a4,a4,24
	lb	a5,-17(s0)
	slliw	a5,a5,1
	slliw	a5,a5,24
	sraiw	a5,a5,24
	andi	a5,a5,4
	slliw	a5,a5,24
	sraiw	a5,a5,24
	or	a5,a4,a5
	slliw	a4,a5,24
	sraiw	a4,a4,24
	li	a5,50
	andi	a4,a4,0xff
	sb	a4,0(a5)
	li	a5,50
	lbu	a5,0(a5)
	andi	a5,a5,0xff
	slliw	a4,a5,24
	sraiw	a4,a4,24
	lb	a5,-17(s0)
	slliw	a5,a5,2
	slliw	a5,a5,24
	sraiw	a5,a5,24
	andi	a5,a5,16
	slliw	a5,a5,24
	sraiw	a5,a5,24
	or	a5,a4,a5
	slliw	a4,a5,24
	sraiw	a4,a4,24
	li	a5,50
	andi	a4,a4,0xff
	sb	a4,0(a5)
	li	a5,50
	lbu	a5,0(a5)
	andi	a5,a5,0xff
	slliw	a4,a5,24
	sraiw	a4,a4,24
	lb	a5,-17(s0)
	andi	a5,a5,8
	slliw	a5,a5,24
	sraiw	a5,a5,24
	or	a5,a4,a5
	slliw	a4,a5,24
	sraiw	a4,a4,24
	li	a5,50
	andi	a4,a4,0xff
	sb	a4,0(a5)
	call	epulse
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	displaybyte, .-displaybyte
	.section	.rodata
	.align	3
.LC11:
	.ascii	"C\003\003\002(\001\f\006\002\002"
	.text
	.align	1
	.globl	dispinit
	.type	dispinit, @function
dispinit:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	lui	a5,%hi(.LC11)
	addi	a5,a5,%lo(.LC11)
	ld	a4,0(a5)
	sd	a4,-32(s0)
	lhu	a5,8(a5)
	sh	a5,-24(s0)
	li	a5,56
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,56
	andi	a4,a4,-2
	andi	a4,a4,0xff
	sb	a4,0(a5)
	sw	zero,-20(s0)
	j	.L19
.L20:
	lw	a5,-20(s0)
	addi	a5,a5,-16
	add	a5,a5,s0
	lbu	a5,-16(a5)
	mv	a0,a5
	call	displaybyte
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L19:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,9
	ble	a4,a5,.L20
	li	a5,56
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,56
	ori	a4,a4,1
	andi	a4,a4,0xff
	sb	a4,0(a5)
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	dispinit, .-dispinit
	.align	1
	.globl	cleardisplay
	.type	cleardisplay, @function
cleardisplay:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	li	a5,56
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,56
	andi	a4,a4,-2
	andi	a4,a4,0xff
	sb	a4,0(a5)
	li	a0,1
	call	displaybyte
	li	a5,56
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,56
	ori	a4,a4,1
	andi	a4,a4,0xff
	sb	a4,0(a5)
	nop
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
	addi	s0,sp,16
	li	a5,56
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,56
	andi	a4,a4,-2
	andi	a4,a4,0xff
	sb	a4,0(a5)
	li	a0,128
	call	displaybyte
	li	a5,56
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,56
	ori	a4,a4,1
	andi	a4,a4,0xff
	sb	a4,0(a5)
	nop
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
	addi	s0,sp,16
	li	a5,56
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,56
	andi	a4,a4,-2
	andi	a4,a4,0xff
	sb	a4,0(a5)
	li	a0,192
	call	displaybyte
	li	a5,56
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,56
	ori	a4,a4,1
	andi	a4,a4,0xff
	sb	a4,0(a5)
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	line2, .-line2
	.align	1
	.globl	epulse
	.type	epulse, @function
epulse:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	li	a5,50
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,50
	ori	a4,a4,-128
	andi	a4,a4,0xff
	sb	a4,0(a5)
	li	a0,1
	call	delay_ms
	li	a5,50
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,50
	andi	a4,a4,127
	andi	a4,a4,0xff
	sb	a4,0(a5)
	li	a0,1
	call	delay_ms
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	epulse, .-epulse
	.align	1
	.globl	delay_ms
	.type	delay_ms, @function
delay_ms:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	mv	a5,a0
	sw	a5,-36(s0)
	sw	zero,-20(s0)
	j	.L26
.L29:
	sw	zero,-24(s0)
	j	.L27
.L28:
 #APP
# 269 "main.c" 1
	nop
# 0 "" 2
 #NO_APP
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
.L27:
	lw	a5,-24(s0)
	sext.w	a4,a5
	li	a5,699
	bleu	a4,a5,.L28
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L26:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-36(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bltu	a4,a5,.L29
	nop
	nop
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	delay_ms, .-delay_ms
	.align	1
	.globl	senddata
	.type	senddata, @function
senddata:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	ld	a0,-40(s0)
	call	strlen
	mv	a5,a0
	sw	a5,-24(s0)
	sw	zero,-20(s0)
	j	.L31
.L32:
	lw	a5,-20(s0)
	ld	a4,-40(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a0,a5
	call	USART_Transmit
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L31:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	blt	a4,a5,.L32
	nop
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	senddata, .-senddata
	.align	1
	.globl	USART_Init
	.type	USART_Init, @function
USART_Init:
	addi	sp,sp,-16
	sd	s0,8(sp)
	addi	s0,sp,16
	li	a5,64
	sb	zero,0(a5)
	li	a5,41
	li	a4,23
	sb	a4,0(a5)
	li	a5,43
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,43
	ori	a4,a4,2
	andi	a4,a4,0xff
	sb	a4,0(a5)
	li	a5,42
	li	a4,24
	sb	a4,0(a5)
	li	a5,64
	li	a4,-114
	sb	a4,0(a5)
	li	a5,42
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,42
	ori	a4,a4,-128
	andi	a4,a4,0xff
	sb	a4,0(a5)
	nop
	ld	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	USART_Init, .-USART_Init
	.align	1
	.globl	USART_Receive
	.type	USART_Receive, @function
USART_Receive:
	addi	sp,sp,-16
	sd	s0,8(sp)
	addi	s0,sp,16
	nop
.L35:
	li	a5,43
	lbu	a5,0(a5)
	andi	a5,a5,0xff
	slliw	a5,a5,24
	sraiw	a5,a5,24
	bge	a5,zero,.L35
	li	a5,44
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	lui	a5,%hi(u8_data)
	sb	a4,%lo(u8_data)(a5)
	nop
	ld	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	USART_Receive, .-USART_Receive
	.align	1
	.globl	__vector_11
	.type	__vector_11, @function
__vector_11:
	addi	sp,sp,-16
	sd	s0,8(sp)
	addi	s0,sp,16
	li	a5,44
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	lui	a5,%hi(u8_data)
	sb	a4,%lo(u8_data)(a5)
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	addiw	a5,a5,1
	andi	a4,a5,0xff
	lui	a5,%hi(FifoCnt)
	sb	a4,%lo(FifoCnt)(a5)
	lui	a5,%hi(Fifo)
	addi	a5,a5,%lo(Fifo)
	lbu	a4,9(a5)
	lui	a5,%hi(Fifo)
	addi	a5,a5,%lo(Fifo)
	sb	a4,10(a5)
	lui	a5,%hi(Fifo)
	addi	a5,a5,%lo(Fifo)
	lbu	a4,8(a5)
	lui	a5,%hi(Fifo)
	addi	a5,a5,%lo(Fifo)
	sb	a4,9(a5)
	lui	a5,%hi(Fifo)
	addi	a5,a5,%lo(Fifo)
	lbu	a4,7(a5)
	lui	a5,%hi(Fifo)
	addi	a5,a5,%lo(Fifo)
	sb	a4,8(a5)
	lui	a5,%hi(Fifo)
	addi	a5,a5,%lo(Fifo)
	lbu	a4,6(a5)
	lui	a5,%hi(Fifo)
	addi	a5,a5,%lo(Fifo)
	sb	a4,7(a5)
	lui	a5,%hi(Fifo)
	addi	a5,a5,%lo(Fifo)
	lbu	a4,5(a5)
	lui	a5,%hi(Fifo)
	addi	a5,a5,%lo(Fifo)
	sb	a4,6(a5)
	lui	a5,%hi(Fifo)
	addi	a5,a5,%lo(Fifo)
	lbu	a4,4(a5)
	lui	a5,%hi(Fifo)
	addi	a5,a5,%lo(Fifo)
	sb	a4,5(a5)
	lui	a5,%hi(Fifo)
	addi	a5,a5,%lo(Fifo)
	lbu	a4,3(a5)
	lui	a5,%hi(Fifo)
	addi	a5,a5,%lo(Fifo)
	sb	a4,4(a5)
	lui	a5,%hi(Fifo)
	addi	a5,a5,%lo(Fifo)
	lbu	a4,2(a5)
	lui	a5,%hi(Fifo)
	addi	a5,a5,%lo(Fifo)
	sb	a4,3(a5)
	lui	a5,%hi(Fifo)
	addi	a5,a5,%lo(Fifo)
	lbu	a4,1(a5)
	lui	a5,%hi(Fifo)
	addi	a5,a5,%lo(Fifo)
	sb	a4,2(a5)
	lui	a5,%hi(Fifo)
	addi	a5,a5,%lo(Fifo)
	lbu	a4,0(a5)
	lui	a5,%hi(Fifo)
	addi	a5,a5,%lo(Fifo)
	sb	a4,1(a5)
	lui	a5,%hi(u8_data)
	lbu	a4,%lo(u8_data)(a5)
	lui	a5,%hi(Fifo)
	addi	a5,a5,%lo(Fifo)
	sb	a4,0(a5)
	nop
	ld	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	__vector_11, .-__vector_11
	.align	1
	.globl	USART_Transmit
	.type	USART_Transmit, @function
USART_Transmit:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	mv	a5,a0
	sb	a5,-17(s0)
	li	a5,44
	lbu	a4,-17(s0)
	sb	a4,0(a5)
	nop
.L39:
	li	a5,43
	lbu	a5,0(a5)
	andi	a5,a5,0xff
	sext.w	a5,a5
	andi	a5,a5,32
	sext.w	a5,a5
	beq	a5,zero,.L39
	nop
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	USART_Transmit, .-USART_Transmit
	.align	1
	.globl	AddFinger
	.type	AddFinger, @function
AddFinger:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	lui	a5,%hi(flg)
	sb	zero,%lo(flg)(a5)
	li	a0,4
	call	__eerd_byte_m16
	mv	a5,a0
	mv	a4,a5
	lui	a5,%hi(IDcnt)
	sb	a4,%lo(IDcnt)(a5)
	lui	a5,%hi(IDcnt)
	lbu	a5,%lo(IDcnt)(a5)
	mv	a4,a5
	li	a5,255
	bne	a4,a5,.L41
	lui	a5,%hi(IDcnt)
	sb	zero,%lo(IDcnt)(a5)
.L41:
	lui	a5,%hi(IDcnt)
	lbu	a5,%lo(IDcnt)(a5)
	addiw	a5,a5,1
	andi	a4,a5,0xff
	lui	a5,%hi(ID)
	sb	a4,%lo(ID)(a5)
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
	lui	a5,%hi(ID)
	lbu	a5,%lo(ID)(a5)
	mv	a0,a5
	call	USART_Transmit
	lui	a5,%hi(ID)
	lbu	a5,%lo(ID)(a5)
	addiw	a5,a5,-8
	andi	a5,a5,0xff
	mv	a0,a5
	call	USART_Transmit
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	AddFinger, .-AddFinger
	.align	1
	.globl	DeleteFinger
	.type	DeleteFinger, @function
DeleteFinger:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	lui	a5,%hi(flgd)
	sb	zero,%lo(flgd)(a5)
	li	a0,4
	call	__eerd_byte_m16
	mv	a5,a0
	mv	a4,a5
	lui	a5,%hi(IDcnt)
	sb	a4,%lo(IDcnt)(a5)
	lui	a5,%hi(IDcnt)
	lbu	a4,%lo(IDcnt)(a5)
	lui	a5,%hi(ID)
	sb	a4,%lo(ID)(a5)
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
	lui	a5,%hi(ID)
	lbu	a5,%lo(ID)(a5)
	mv	a0,a5
	call	USART_Transmit
	lui	a5,%hi(ID)
	lbu	a5,%lo(ID)(a5)
	addiw	a5,a5,-6
	andi	a5,a5,0xff
	mv	a0,a5
	call	USART_Transmit
	nop
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
	addi	s0,sp,16
	lui	a5,%hi(flgs)
	sb	zero,%lo(flgs)(a5)
	li	a0,4
	call	__eerd_byte_m16
	mv	a5,a0
	mv	a4,a5
	lui	a5,%hi(IDcnt)
	sb	a4,%lo(IDcnt)(a5)
	lui	a5,%hi(IDcnt)
	lbu	a4,%lo(IDcnt)(a5)
	lui	a5,%hi(ID)
	sb	a4,%lo(ID)(a5)
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
	lui	a5,%hi(ID)
	lbu	a5,%lo(ID)(a5)
	mv	a0,a5
	call	USART_Transmit
	lui	a5,%hi(ID)
	lbu	a5,%lo(ID)(a5)
	addiw	a5,a5,-1
	andi	a5,a5,0xff
	mv	a0,a5
	call	USART_Transmit
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	SearchFinger, .-SearchFinger
	.section	.rodata
	.align	3
.LC12:
	.string	"   Time Out   "
	.align	3
.LC13:
	.string	"Process Failed"
	.align	3
.LC14:
	.string	" Finger Added  "
	.align	3
.LC15:
	.string	" Entry Deleted  "
	.align	3
.LC16:
	.string	"Finger Placed"
	.align	3
.LC17:
	.string	" Entry Passed  "
	.align	3
.LC18:
	.string	" Access Denied  "
	.align	3
.LC19:
	.string	" Parameter Error"
	.text
	.align	1
	.globl	ProcessFifo
	.type	ProcessFifo, @function
ProcessFifo:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	beq	a5,zero,.L76
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	lui	a4,%hi(Fifo)
	addi	a4,a4,%lo(Fifo)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,48
	bne	a4,a5,.L46
	lui	a5,%hi(flg)
	lbu	a5,%lo(flg)(a5)
	bne	a5,zero,.L46
	lui	a5,%hi(flg)
	li	a4,1
	sb	a4,%lo(flg)(a5)
.L46:
	lui	a5,%hi(flg)
	lbu	a5,%lo(flg)(a5)
	mv	a4,a5
	li	a5,4
	bne	a4,a5,.L47
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	lui	a4,%hi(Fifo)
	addi	a4,a4,%lo(Fifo)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,51
	bne	a4,a5,.L48
	call	cleardisplay
	call	line1
	lui	a5,%hi(.LC12)
	addi	a0,a5,%lo(.LC12)
	call	display
	call	DoCancel
.L48:
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	lui	a4,%hi(Fifo)
	addi	a4,a4,%lo(Fifo)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,52
	bne	a4,a5,.L49
	call	cleardisplay
	call	line1
	lui	a5,%hi(.LC13)
	addi	a0,a5,%lo(.LC13)
	call	display
	call	DoCancel
.L49:
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	lui	a4,%hi(Fifo)
	addi	a4,a4,%lo(Fifo)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,49
	bne	a4,a5,.L50
	call	cleardisplay
	call	line1
	lui	a5,%hi(.LC14)
	addi	a0,a5,%lo(.LC14)
	call	display
	call	line2
	lui	a5,%hi(ID)
	lbu	a5,%lo(ID)(a5)
	sext.w	a5,a5
	mv	a2,a5
	lui	a5,%hi(.LC7)
	addi	a1,a5,%lo(.LC7)
	lui	a5,%hi(mystr)
	addi	a0,a5,%lo(mystr)
	call	sprintf
	lui	a5,%hi(.LC8)
	addi	a0,a5,%lo(.LC8)
	call	display
	lui	a5,%hi(mystr)
	lbu	a5,%lo(mystr)(a5)
	mv	a0,a5
	call	displaybyte
	lui	a5,%hi(mystr)
	addi	a5,a5,%lo(mystr)
	lbu	a5,1(a5)
	mv	a0,a5
	call	displaybyte
	lui	a5,%hi(IDcnt)
	lbu	a5,%lo(IDcnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,8
	sext.w	a5,a5
	mv	a4,a5
	lui	a5,%hi(ID)
	lbu	a5,%lo(ID)(a5)
	mv	a1,a5
	mv	a0,a4
	call	__eewr_byte_m16
	lui	a5,%hi(IDcnt)
	lbu	a5,%lo(IDcnt)(a5)
	addiw	a5,a5,1
	andi	a4,a5,0xff
	lui	a5,%hi(IDcnt)
	sb	a4,%lo(IDcnt)(a5)
	lui	a5,%hi(IDcnt)
	lbu	a5,%lo(IDcnt)(a5)
	mv	a1,a5
	li	a0,4
	call	__eewr_byte_m16
	call	DoCancel
.L50:
	lui	a5,%hi(flg)
	li	a4,8
	sb	a4,%lo(flg)(a5)
.L47:
	lui	a5,%hi(flg)
	lbu	a5,%lo(flg)(a5)
	mv	a4,a5
	li	a5,3
	bne	a4,a5,.L51
	lui	a5,%hi(flg)
	sb	zero,%lo(flg)(a5)
.L51:
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	lui	a4,%hi(Fifo)
	addi	a4,a4,%lo(Fifo)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,64
	bne	a4,a5,.L52
	lui	a5,%hi(flg)
	lbu	a5,%lo(flg)(a5)
	mv	a4,a5
	li	a5,2
	bne	a4,a5,.L52
	lui	a5,%hi(flg)
	li	a4,4
	sb	a4,%lo(flg)(a5)
.L52:
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	lui	a4,%hi(Fifo)
	addi	a4,a4,%lo(Fifo)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,2
	bne	a4,a5,.L53
	lui	a5,%hi(flg)
	lbu	a5,%lo(flg)(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L53
	lui	a5,%hi(flg)
	li	a4,2
	sb	a4,%lo(flg)(a5)
.L53:
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	lui	a4,%hi(Fifo)
	addi	a4,a4,%lo(Fifo)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L54
	lui	a5,%hi(flg)
	lbu	a5,%lo(flg)(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L54
	lui	a5,%hi(flg)
	li	a4,3
	sb	a4,%lo(flg)(a5)
.L54:
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	lui	a4,%hi(Fifo)
	addi	a4,a4,%lo(Fifo)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,48
	bne	a4,a5,.L55
	lui	a5,%hi(flgd)
	lbu	a5,%lo(flgd)(a5)
	bne	a5,zero,.L55
	lui	a5,%hi(flgd)
	li	a4,1
	sb	a4,%lo(flgd)(a5)
.L55:
	lui	a5,%hi(flgd)
	lbu	a5,%lo(flgd)(a5)
	mv	a4,a5
	li	a5,4
	bne	a4,a5,.L56
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	lui	a4,%hi(Fifo)
	addi	a4,a4,%lo(Fifo)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,51
	bne	a4,a5,.L57
	call	cleardisplay
	call	line1
	lui	a5,%hi(.LC12)
	addi	a0,a5,%lo(.LC12)
	call	display
	call	DoCancel
.L57:
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	lui	a4,%hi(Fifo)
	addi	a4,a4,%lo(Fifo)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,52
	bne	a4,a5,.L58
	call	cleardisplay
	call	line1
	lui	a5,%hi(.LC13)
	addi	a0,a5,%lo(.LC13)
	call	display
	call	DoCancel
.L58:
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	lui	a4,%hi(Fifo)
	addi	a4,a4,%lo(Fifo)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,49
	bne	a4,a5,.L59
	call	cleardisplay
	call	line1
	lui	a5,%hi(.LC15)
	addi	a0,a5,%lo(.LC15)
	call	display
	call	line2
	lui	a5,%hi(ID)
	lbu	a5,%lo(ID)(a5)
	sext.w	a5,a5
	mv	a2,a5
	lui	a5,%hi(.LC7)
	addi	a1,a5,%lo(.LC7)
	lui	a5,%hi(mystr)
	addi	a0,a5,%lo(mystr)
	call	sprintf
	lui	a5,%hi(.LC8)
	addi	a0,a5,%lo(.LC8)
	call	display
	lui	a5,%hi(mystr)
	lbu	a5,%lo(mystr)(a5)
	mv	a0,a5
	call	displaybyte
	lui	a5,%hi(mystr)
	addi	a5,a5,%lo(mystr)
	lbu	a5,1(a5)
	mv	a0,a5
	call	displaybyte
	lui	a5,%hi(IDcnt)
	lbu	a5,%lo(IDcnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,8
	sext.w	a5,a5
	li	a1,255
	mv	a0,a5
	call	__eewr_byte_m16
	lui	a5,%hi(IDcnt)
	lbu	a5,%lo(IDcnt)(a5)
	addiw	a5,a5,-1
	andi	a4,a5,0xff
	lui	a5,%hi(IDcnt)
	sb	a4,%lo(IDcnt)(a5)
	lui	a5,%hi(IDcnt)
	lbu	a5,%lo(IDcnt)(a5)
	mv	a1,a5
	li	a0,4
	call	__eewr_byte_m16
	call	DoCancel
.L59:
	lui	a5,%hi(flgd)
	li	a4,8
	sb	a4,%lo(flgd)(a5)
.L56:
	lui	a5,%hi(flgd)
	lbu	a5,%lo(flgd)(a5)
	mv	a4,a5
	li	a5,3
	bne	a4,a5,.L60
	lui	a5,%hi(flgd)
	sb	zero,%lo(flgd)(a5)
.L60:
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	lui	a4,%hi(Fifo)
	addi	a4,a4,%lo(Fifo)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,66
	bne	a4,a5,.L61
	lui	a5,%hi(flgd)
	lbu	a5,%lo(flgd)(a5)
	mv	a4,a5
	li	a5,2
	bne	a4,a5,.L61
	lui	a5,%hi(flgd)
	li	a4,4
	sb	a4,%lo(flgd)(a5)
.L61:
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	lui	a4,%hi(Fifo)
	addi	a4,a4,%lo(Fifo)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,2
	bne	a4,a5,.L62
	lui	a5,%hi(flgd)
	lbu	a5,%lo(flgd)(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L62
	lui	a5,%hi(flgd)
	li	a4,2
	sb	a4,%lo(flgd)(a5)
.L62:
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	lui	a4,%hi(Fifo)
	addi	a4,a4,%lo(Fifo)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L63
	lui	a5,%hi(flgd)
	lbu	a5,%lo(flgd)(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L63
	lui	a5,%hi(flgd)
	li	a4,3
	sb	a4,%lo(flgd)(a5)
.L63:
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	lui	a4,%hi(Fifo)
	addi	a4,a4,%lo(Fifo)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,48
	bne	a4,a5,.L64
	lui	a5,%hi(flgs)
	lbu	a5,%lo(flgs)(a5)
	bne	a5,zero,.L64
	lui	a5,%hi(flgs)
	li	a4,1
	sb	a4,%lo(flgs)(a5)
.L64:
	lui	a5,%hi(flgs)
	lbu	a5,%lo(flgs)(a5)
	mv	a4,a5
	li	a5,4
	bne	a4,a5,.L65
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	lui	a4,%hi(Fifo)
	addi	a4,a4,%lo(Fifo)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,49
	bne	a4,a5,.L66
	call	cleardisplay
	call	line1
	lui	a5,%hi(.LC16)
	addi	a0,a5,%lo(.LC16)
	call	display
	lui	a5,%hi(flgs)
	sb	zero,%lo(flgs)(a5)
.L66:
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	lui	a4,%hi(Fifo)
	addi	a4,a4,%lo(Fifo)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,51
	bne	a4,a5,.L67
	call	cleardisplay
	call	line1
	lui	a5,%hi(.LC12)
	addi	a0,a5,%lo(.LC12)
	call	display
	lui	a5,%hi(flgs)
	li	a4,8
	sb	a4,%lo(flgs)(a5)
	call	DoCancel
.L67:
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	lui	a4,%hi(Fifo)
	addi	a4,a4,%lo(Fifo)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,52
	bne	a4,a5,.L68
	call	cleardisplay
	call	line1
	lui	a5,%hi(.LC13)
	addi	a0,a5,%lo(.LC13)
	call	display
	lui	a5,%hi(flgs)
	li	a4,8
	sb	a4,%lo(flgs)(a5)
	call	DoCancel
.L68:
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	lui	a4,%hi(Fifo)
	addi	a4,a4,%lo(Fifo)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,57
	bne	a4,a5,.L69
	call	cleardisplay
	call	line1
	lui	a5,%hi(.LC17)
	addi	a0,a5,%lo(.LC17)
	call	display
	call	line2
	lui	a5,%hi(flgs)
	li	a4,8
	sb	a4,%lo(flgs)(a5)
	li	a5,56
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,56
	ori	a4,a4,8
	andi	a4,a4,0xff
	sb	a4,0(a5)
	li	a0,2000
	call	delay_ms
	call	DoCancel
.L69:
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	lui	a4,%hi(Fifo)
	addi	a4,a4,%lo(Fifo)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,58
	bne	a4,a5,.L70
	call	cleardisplay
	call	line1
	lui	a5,%hi(.LC18)
	addi	a0,a5,%lo(.LC18)
	call	display
	call	line2
	lui	a5,%hi(flgs)
	li	a4,8
	sb	a4,%lo(flgs)(a5)
	call	DoCancel
.L70:
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	lui	a4,%hi(Fifo)
	addi	a4,a4,%lo(Fifo)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,53
	bne	a4,a5,.L65
	call	cleardisplay
	call	line1
	lui	a5,%hi(.LC19)
	addi	a0,a5,%lo(.LC19)
	call	display
	lui	a5,%hi(flgs)
	li	a4,8
	sb	a4,%lo(flgs)(a5)
	call	DoCancel
.L65:
	lui	a5,%hi(flgs)
	lbu	a5,%lo(flgs)(a5)
	mv	a4,a5
	li	a5,3
	bne	a4,a5,.L71
	lui	a5,%hi(flgs)
	sb	zero,%lo(flgs)(a5)
.L71:
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	lui	a4,%hi(Fifo)
	addi	a4,a4,%lo(Fifo)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,68
	bne	a4,a5,.L72
	lui	a5,%hi(flgs)
	lbu	a5,%lo(flgs)(a5)
	mv	a4,a5
	li	a5,2
	bne	a4,a5,.L72
	lui	a5,%hi(flgs)
	li	a4,4
	sb	a4,%lo(flgs)(a5)
.L72:
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	lui	a4,%hi(Fifo)
	addi	a4,a4,%lo(Fifo)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,4
	beq	a4,a5,.L73
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	lui	a4,%hi(Fifo)
	addi	a4,a4,%lo(Fifo)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,2
	bne	a4,a5,.L74
.L73:
	lui	a5,%hi(flgs)
	lbu	a5,%lo(flgs)(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L74
	lui	a5,%hi(flgs)
	li	a4,2
	sb	a4,%lo(flgs)(a5)
.L74:
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	lui	a4,%hi(Fifo)
	addi	a4,a4,%lo(Fifo)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L75
	lui	a5,%hi(flgs)
	lbu	a5,%lo(flgs)(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L75
	lui	a5,%hi(flgs)
	li	a4,3
	sb	a4,%lo(flgs)(a5)
.L75:
	lui	a5,%hi(FifoCnt)
	lbu	a5,%lo(FifoCnt)(a5)
	addiw	a5,a5,-1
	andi	a4,a5,0xff
	lui	a5,%hi(FifoCnt)
	sb	a4,%lo(FifoCnt)(a5)
.L76:
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	ProcessFifo, .-ProcessFifo
	.align	1
	.globl	DoCancel
	.type	DoCancel, @function
DoCancel:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	li	a0,2000
	call	delay_ms
	call	cleardisplay
	call	line1
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	display
	call	line2
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	display
	li	a5,56
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,56
	andi	a4,a4,-9
	andi	a4,a4,0xff
	sb	a4,0(a5)
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	DoCancel, .-DoCancel
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
