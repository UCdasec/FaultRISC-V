	.file	"main.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	rx
	.section	.sbss,"aw",@nobits
	.type	rx, @object
	.size	rx, 1
rx:
	.zero	1
	.text
	.align	1
	.globl	Config_USART
	.type	Config_USART, @function
Config_USART:
	addi	sp,sp,-16
	sd	s0,8(sp)
	addi	s0,sp,16
	li	a5,196
	li	a4,103
	sb	a4,0(a5)
	li	a5,197
	sb	zero,0(a5)
	li	a5,193
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,193
	ori	a4,a4,8
	andi	a4,a4,0xff
	sb	a4,0(a5)
	li	a5,193
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,193
	ori	a4,a4,16
	andi	a4,a4,0xff
	sb	a4,0(a5)
	li	a5,194
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,194
	ori	a4,a4,6
	andi	a4,a4,0xff
	sb	a4,0(a5)
	nop
	ld	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	Config_USART, .-Config_USART
	.align	1
	.globl	USART_Receive
	.type	USART_Receive, @function
USART_Receive:
	addi	sp,sp,-16
	sd	s0,8(sp)
	addi	s0,sp,16
	li	a5,192
	lbu	a5,0(a5)
	andi	a5,a5,0xff
	slliw	a5,a5,24
	sraiw	a5,a5,24
	bge	a5,zero,.L3
	li	a5,198
	lbu	a5,0(a5)
	andi	a5,a5,0xff
	j	.L4
.L3:
	li	a5,0
.L4:
	mv	a0,a5
	ld	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	USART_Receive, .-USART_Receive
	.align	1
	.globl	USART_Transmit
	.type	USART_Transmit, @function
USART_Transmit:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	nop
.L6:
	li	a5,192
	lbu	a5,0(a5)
	andi	a5,a5,0xff
	sext.w	a5,a5
	andi	a5,a5,32
	sext.w	a5,a5
	beq	a5,zero,.L6
	ld	a4,-24(s0)
	li	a5,198
	andi	a4,a4,0xff
	sb	a4,0(a5)
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	USART_Transmit, .-USART_Transmit
	.align	1
	.globl	Gate
	.type	Gate, @function
Gate:
	addi	sp,sp,-256
	sd	s0,248(sp)
	addi	s0,sp,256
	li	a5,40
	li	a4,1
	sb	a4,0(a5)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	fsd	fa5,-200(s0)
	fld	fa4,-200(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-208(s0)
	fld	fa4,-200(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-216(s0)
	fld	fa4,-208(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L91
	li	a5,1
	sb	a5,-217(s0)
	j	.L10
.L91:
	fld	fa4,-216(s0)
	lui	a5,%hi(.LC4)
	fld	fa5,%lo(.LC4)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L92
	fld	fa4,-200(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	fdiv.d	fa5,fa4,fa5
	fsd	fa5,-232(s0)
	fld	fa4,-232(s0)
	lui	a5,%hi(.LC5)
	fld	fa5,%lo(.LC5)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-240(s0)
	fld	fa4,-240(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L93
	li	a5,1
	sh	a5,-242(s0)
	j	.L15
.L93:
	fld	fa4,-240(s0)
	lui	a5,%hi(.LC4)
	fld	fa5,%lo(.LC4)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L94
	fld	fa4,-232(s0)
	lui	a5,%hi(.LC6)
	fld	fa5,%lo(.LC6)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-242(s0)
	j	.L18
.L19:
	li	a5,400
	sh	a5,-244(s0)
	nop
	lhu	a5,-242(s0)
	addiw	a5,a5,-1
	sh	a5,-242(s0)
.L18:
	lhu	a5,-242(s0)
	sext.w	a5,a5
	bne	a5,zero,.L19
	j	.L10
.L94:
	fld	fa5,-240(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-242(s0)
.L15:
	lhu	a5,-242(s0)
	sh	a5,-246(s0)
	j	.L10
.L92:
	fld	fa4,-208(s0)
	lui	a5,%hi(.LC7)
	fld	fa5,%lo(.LC7)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L95
	fld	fa5,-216(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-248(s0)
	lhu	a5,-248(s0)
	sh	a5,-250(s0)
	nop
	j	.L23
.L95:
	fld	fa5,-208(s0)
	fcvt.wu.d a5,fa5,rtz
	sb	a5,-217(s0)
.L10:
	lbu	a5,-217(s0)
	sb	a5,-251(s0)
	nop
.L23:
	li	a5,40
	sb	zero,0(a5)
	lui	a5,%hi(.LC8)
	fld	fa5,%lo(.LC8)(a5)
	fsd	fa5,-176(s0)
	fld	fa4,-176(s0)
	lui	a5,%hi(.LC5)
	fld	fa5,%lo(.LC5)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-184(s0)
	fld	fa4,-184(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L96
	li	a5,1
	sh	a5,-186(s0)
	j	.L26
.L96:
	fld	fa4,-184(s0)
	lui	a5,%hi(.LC4)
	fld	fa5,%lo(.LC4)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L97
	fld	fa4,-176(s0)
	lui	a5,%hi(.LC6)
	fld	fa5,%lo(.LC6)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-186(s0)
	j	.L29
.L30:
	li	a5,400
	sh	a5,-188(s0)
	nop
	lhu	a5,-186(s0)
	addiw	a5,a5,-1
	sh	a5,-186(s0)
.L29:
	lhu	a5,-186(s0)
	sext.w	a5,a5
	bne	a5,zero,.L30
	j	.L31
.L97:
	fld	fa5,-184(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-186(s0)
.L26:
	lhu	a5,-186(s0)
	sh	a5,-190(s0)
	nop
.L31:
	li	a5,40
	li	a4,1
	sb	a4,0(a5)
	lui	a5,%hi(.LC9)
	fld	fa5,%lo(.LC9)(a5)
	fsd	fa5,-112(s0)
	fld	fa4,-112(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-120(s0)
	fld	fa4,-112(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-128(s0)
	fld	fa4,-120(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L98
	li	a5,1
	sb	a5,-129(s0)
	j	.L34
.L98:
	fld	fa4,-128(s0)
	lui	a5,%hi(.LC4)
	fld	fa5,%lo(.LC4)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L99
	fld	fa4,-112(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	fdiv.d	fa5,fa4,fa5
	fsd	fa5,-144(s0)
	fld	fa4,-144(s0)
	lui	a5,%hi(.LC5)
	fld	fa5,%lo(.LC5)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-152(s0)
	fld	fa4,-152(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L100
	li	a5,1
	sh	a5,-154(s0)
	j	.L39
.L100:
	fld	fa4,-152(s0)
	lui	a5,%hi(.LC4)
	fld	fa5,%lo(.LC4)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L101
	fld	fa4,-144(s0)
	lui	a5,%hi(.LC6)
	fld	fa5,%lo(.LC6)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-154(s0)
	j	.L42
.L43:
	li	a5,400
	sh	a5,-156(s0)
	nop
	lhu	a5,-154(s0)
	addiw	a5,a5,-1
	sh	a5,-154(s0)
.L42:
	lhu	a5,-154(s0)
	sext.w	a5,a5
	bne	a5,zero,.L43
	j	.L34
.L101:
	fld	fa5,-152(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-154(s0)
.L39:
	lhu	a5,-154(s0)
	sh	a5,-158(s0)
	j	.L34
.L99:
	fld	fa4,-120(s0)
	lui	a5,%hi(.LC7)
	fld	fa5,%lo(.LC7)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L102
	fld	fa5,-128(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-160(s0)
	lhu	a5,-160(s0)
	sh	a5,-162(s0)
	nop
	j	.L47
.L102:
	fld	fa5,-120(s0)
	fcvt.wu.d a5,fa5,rtz
	sb	a5,-129(s0)
.L34:
	lbu	a5,-129(s0)
	sb	a5,-163(s0)
	nop
.L47:
	li	a5,40
	sb	zero,0(a5)
	lui	a5,%hi(.LC8)
	fld	fa5,%lo(.LC8)(a5)
	fsd	fa5,-88(s0)
	fld	fa4,-88(s0)
	lui	a5,%hi(.LC5)
	fld	fa5,%lo(.LC5)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-96(s0)
	fld	fa4,-96(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L103
	li	a5,1
	sh	a5,-98(s0)
	j	.L50
.L103:
	fld	fa4,-96(s0)
	lui	a5,%hi(.LC4)
	fld	fa5,%lo(.LC4)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L104
	fld	fa4,-88(s0)
	lui	a5,%hi(.LC6)
	fld	fa5,%lo(.LC6)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-98(s0)
	j	.L53
.L54:
	li	a5,400
	sh	a5,-100(s0)
	nop
	lhu	a5,-98(s0)
	addiw	a5,a5,-1
	sh	a5,-98(s0)
.L53:
	lhu	a5,-98(s0)
	sext.w	a5,a5
	bne	a5,zero,.L54
	j	.L55
.L104:
	fld	fa5,-96(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-98(s0)
.L50:
	lhu	a5,-98(s0)
	sh	a5,-102(s0)
	nop
.L55:
	li	a5,40
	li	a4,1
	sb	a4,0(a5)
	li	a5,40
	sb	zero,0(a5)
	li	a5,40
	li	a4,1
	sb	a4,0(a5)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	fsd	fa5,-24(s0)
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-32(s0)
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-40(s0)
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L105
	li	a5,1
	sb	a5,-41(s0)
	j	.L58
.L105:
	fld	fa4,-40(s0)
	lui	a5,%hi(.LC4)
	fld	fa5,%lo(.LC4)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L106
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	fdiv.d	fa5,fa4,fa5
	fsd	fa5,-56(s0)
	fld	fa4,-56(s0)
	lui	a5,%hi(.LC5)
	fld	fa5,%lo(.LC5)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-64(s0)
	fld	fa4,-64(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L107
	li	a5,1
	sh	a5,-66(s0)
	j	.L63
.L107:
	fld	fa4,-64(s0)
	lui	a5,%hi(.LC4)
	fld	fa5,%lo(.LC4)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L108
	fld	fa4,-56(s0)
	lui	a5,%hi(.LC6)
	fld	fa5,%lo(.LC6)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-66(s0)
	j	.L66
.L67:
	li	a5,400
	sh	a5,-68(s0)
	nop
	lhu	a5,-66(s0)
	addiw	a5,a5,-1
	sh	a5,-66(s0)
.L66:
	lhu	a5,-66(s0)
	sext.w	a5,a5
	bne	a5,zero,.L67
	j	.L58
.L108:
	fld	fa5,-64(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-66(s0)
.L63:
	lhu	a5,-66(s0)
	sh	a5,-70(s0)
	j	.L58
.L106:
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC7)
	fld	fa5,%lo(.LC7)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L109
	fld	fa5,-40(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-72(s0)
	lhu	a5,-72(s0)
	sh	a5,-74(s0)
	nop
	j	.L71
.L109:
	fld	fa5,-32(s0)
	fcvt.wu.d a5,fa5,rtz
	sb	a5,-41(s0)
.L58:
	lbu	a5,-41(s0)
	sb	a5,-75(s0)
	nop
.L71:
	li	a5,40
	sb	zero,0(a5)
	nop
	ld	s0,248(sp)
	addi	sp,sp,256
	jr	ra
	.size	Gate, .-Gate
	.section	.rodata
	.align	3
.LC10:
	.string	"Swipe the Card"
	.align	3
.LC11:
	.string	"Access Grant"
	.align	3
.LC13:
	.string	"Access Denied"
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-128
	sd	ra,120(sp)
	sd	s0,112(sp)
	addi	s0,sp,128
	li	a5,36
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,36
	ori	a4,a4,32
	andi	a4,a4,0xff
	sb	a4,0(a5)
	call	Config_USART
	li	a5,36
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,36
	ori	a4,a4,32
	andi	a4,a4,0xff
	sb	a4,0(a5)
 #APP
# 97 "main.c" 1
	sei
# 0 "" 2
 #NO_APP
	call	SWseriale_begin
	call	Lcd4_Init
	li	a1,0
	li	a0,1
	call	Lcd4_Set_Cursor
	lui	a5,%hi(.LC10)
	addi	a0,a5,%lo(.LC10)
	call	Lcd4_Write_String
	li	a5,39
	li	a4,1
	sb	a4,0(a5)
	li	a5,40
	sb	zero,0(a5)
.L146:
	call	SWseriale_available
	mv	a5,a0
	beq	a5,zero,.L111
	call	SWseriale_read
	mv	a5,a0
	sb	a5,-17(s0)
	lbu	a5,-17(s0)
	mv	a0,a5
	call	USART_Transmit
.L111:
	call	USART_Receive
	mv	a5,a0
	mv	a4,a5
	lui	a5,%hi(rx)
	sb	a4,%lo(rx)(a5)
	lui	a5,%hi(rx)
	lbu	a5,%lo(rx)(a5)
	mv	a4,a5
	li	a5,75
	bne	a4,a5,.L112
	lui	a5,%hi(.LC11)
	addi	a0,a5,%lo(.LC11)
	call	Lcd4_Write_String
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	ori	a4,a4,32
	andi	a4,a4,0xff
	sb	a4,0(a5)
	lui	a5,%hi(.LC12)
	fld	fa5,%lo(.LC12)(a5)
	fsd	fa5,-56(s0)
	fld	fa4,-56(s0)
	lui	a5,%hi(.LC5)
	fld	fa5,%lo(.LC5)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-64(s0)
	fld	fa4,-64(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L155
	li	a5,1
	sh	a5,-66(s0)
	j	.L115
.L155:
	fld	fa4,-64(s0)
	lui	a5,%hi(.LC4)
	fld	fa5,%lo(.LC4)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L156
	fld	fa4,-56(s0)
	lui	a5,%hi(.LC6)
	fld	fa5,%lo(.LC6)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-66(s0)
	j	.L118
.L119:
	li	a5,400
	sh	a5,-68(s0)
	nop
	lhu	a5,-66(s0)
	addiw	a5,a5,-1
	sh	a5,-66(s0)
.L118:
	lhu	a5,-66(s0)
	sext.w	a5,a5
	bne	a5,zero,.L119
	j	.L120
.L156:
	fld	fa5,-64(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-66(s0)
.L115:
	lhu	a5,-66(s0)
	sh	a5,-70(s0)
	nop
.L120:
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	andi	a4,a4,-33
	andi	a4,a4,0xff
	sb	a4,0(a5)
	lui	a5,%hi(.LC12)
	fld	fa5,%lo(.LC12)(a5)
	fsd	fa5,-32(s0)
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC5)
	fld	fa5,%lo(.LC5)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-40(s0)
	fld	fa4,-40(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L157
	li	a5,1
	sh	a5,-42(s0)
	j	.L123
.L157:
	fld	fa4,-40(s0)
	lui	a5,%hi(.LC4)
	fld	fa5,%lo(.LC4)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L158
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC6)
	fld	fa5,%lo(.LC6)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-42(s0)
	j	.L126
.L127:
	li	a5,400
	sh	a5,-44(s0)
	nop
	lhu	a5,-42(s0)
	addiw	a5,a5,-1
	sh	a5,-42(s0)
.L126:
	lhu	a5,-42(s0)
	sext.w	a5,a5
	bne	a5,zero,.L127
	j	.L128
.L158:
	fld	fa5,-40(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-42(s0)
.L123:
	lhu	a5,-42(s0)
	sh	a5,-46(s0)
	nop
.L128:
	lui	a5,%hi(rx)
	li	a4,79
	sb	a4,%lo(rx)(a5)
	call	Gate
	call	Lcd4_Clear
	j	.L146
.L112:
	lui	a5,%hi(rx)
	lbu	a5,%lo(rx)(a5)
	mv	a4,a5
	li	a5,88
	bne	a4,a5,.L146
	lui	a5,%hi(.LC13)
	addi	a0,a5,%lo(.LC13)
	call	Lcd4_Write_String
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	ori	a4,a4,32
	andi	a4,a4,0xff
	sb	a4,0(a5)
	lui	a5,%hi(.LC14)
	fld	fa5,%lo(.LC14)(a5)
	fsd	fa5,-104(s0)
	fld	fa4,-104(s0)
	lui	a5,%hi(.LC5)
	fld	fa5,%lo(.LC5)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-112(s0)
	fld	fa4,-112(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L159
	li	a5,1
	sh	a5,-114(s0)
	j	.L132
.L159:
	fld	fa4,-112(s0)
	lui	a5,%hi(.LC4)
	fld	fa5,%lo(.LC4)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L160
	fld	fa4,-104(s0)
	lui	a5,%hi(.LC6)
	fld	fa5,%lo(.LC6)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-114(s0)
	j	.L135
.L136:
	li	a5,400
	sh	a5,-116(s0)
	nop
	lhu	a5,-114(s0)
	addiw	a5,a5,-1
	sh	a5,-114(s0)
.L135:
	lhu	a5,-114(s0)
	sext.w	a5,a5
	bne	a5,zero,.L136
	j	.L137
.L160:
	fld	fa5,-112(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-114(s0)
.L132:
	lhu	a5,-114(s0)
	sh	a5,-118(s0)
	nop
.L137:
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	andi	a4,a4,-33
	andi	a4,a4,0xff
	sb	a4,0(a5)
	lui	a5,%hi(.LC12)
	fld	fa5,%lo(.LC12)(a5)
	fsd	fa5,-80(s0)
	fld	fa4,-80(s0)
	lui	a5,%hi(.LC5)
	fld	fa5,%lo(.LC5)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-88(s0)
	fld	fa4,-88(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L161
	li	a5,1
	sh	a5,-90(s0)
	j	.L140
.L161:
	fld	fa4,-88(s0)
	lui	a5,%hi(.LC4)
	fld	fa5,%lo(.LC4)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L162
	fld	fa4,-80(s0)
	lui	a5,%hi(.LC6)
	fld	fa5,%lo(.LC6)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-90(s0)
	j	.L143
.L144:
	li	a5,400
	sh	a5,-92(s0)
	nop
	lhu	a5,-90(s0)
	addiw	a5,a5,-1
	sh	a5,-90(s0)
.L143:
	lhu	a5,-90(s0)
	sext.w	a5,a5
	bne	a5,zero,.L144
	j	.L145
.L162:
	fld	fa5,-88(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-90(s0)
.L140:
	lhu	a5,-90(s0)
	sh	a5,-94(s0)
	nop
.L145:
	lui	a5,%hi(rx)
	li	a4,79
	sb	a4,%lo(rx)(a5)
	call	Lcd4_Clear
	j	.L146
	.size	main, .-main
	.section	.rodata
	.align	3
.LC0:
	.word	0
	.word	1083129856
	.align	3
.LC1:
	.word	1431655765
	.word	1075139925
	.align	3
.LC2:
	.word	0
	.word	1074790400
	.align	3
.LC3:
	.word	0
	.word	1072693248
	.align	3
.LC4:
	.word	0
	.word	1089470432
	.align	3
.LC5:
	.word	0
	.word	1085227008
	.align	3
.LC6:
	.word	0
	.word	1076101120
	.align	3
.LC7:
	.word	0
	.word	1081073664
	.align	3
.LC8:
	.word	0
	.word	1084178432
	.align	3
.LC9:
	.word	0
	.word	1083666432
	.align	3
.LC12:
	.word	0
	.word	1080623104
	.align	3
.LC14:
	.word	0
	.word	1084715008
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
