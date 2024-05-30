	.file	"main.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	pinChange
	.type	pinChange, @function
pinChange:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	mv	a5,a0
	mv	a4,a1
	sw	a5,-20(s0)
	mv	a5,a4
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	sext.w	a5,a5
	bne	a5,zero,.L2
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,10
	bne	a4,a5,.L3
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	andi	a4,a4,-2
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L3:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,11
	bne	a4,a5,.L5
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	andi	a4,a4,-3
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L5:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,12
	bne	a4,a5,.L6
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	andi	a4,a4,-5
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L6:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,13
	bne	a4,a5,.L7
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	andi	a4,a4,-9
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L7:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,14
	bne	a4,a5,.L8
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	andi	a4,a4,-17
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L8:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,15
	bne	a4,a5,.L9
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	andi	a4,a4,-33
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L9:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,16
	bne	a4,a5,.L10
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	andi	a4,a4,-65
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L10:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,17
	bne	a4,a5,.L11
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	andi	a4,a4,127
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L11:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,20
	bne	a4,a5,.L12
	li	a5,40
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,40
	andi	a4,a4,-2
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L12:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,21
	bne	a4,a5,.L13
	li	a5,40
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,40
	andi	a4,a4,-3
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L13:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,22
	bne	a4,a5,.L14
	li	a5,40
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,40
	andi	a4,a4,-5
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L14:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,23
	bne	a4,a5,.L15
	li	a5,40
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,40
	andi	a4,a4,-9
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L15:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,24
	bne	a4,a5,.L16
	li	a5,40
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,40
	andi	a4,a4,-17
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L16:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,25
	bne	a4,a5,.L17
	li	a5,40
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,40
	andi	a4,a4,-33
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L17:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,26
	bne	a4,a5,.L18
	li	a5,40
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,40
	andi	a4,a4,-65
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L18:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,30
	bne	a4,a5,.L19
	li	a5,43
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,43
	andi	a4,a4,-2
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L19:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,31
	bne	a4,a5,.L20
	li	a5,43
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,43
	andi	a4,a4,-3
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L20:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,32
	bne	a4,a5,.L21
	li	a5,43
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,43
	andi	a4,a4,-5
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L21:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,33
	bne	a4,a5,.L22
	li	a5,43
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,43
	andi	a4,a4,-9
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L22:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,34
	bne	a4,a5,.L23
	li	a5,43
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,43
	andi	a4,a4,-17
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L23:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,35
	bne	a4,a5,.L24
	li	a5,43
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,43
	andi	a4,a4,-33
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L24:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,36
	bne	a4,a5,.L25
	li	a5,43
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,43
	andi	a4,a4,-65
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L25:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,37
	bne	a4,a5,.L48
	li	a5,43
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,43
	andi	a4,a4,127
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L2:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,10
	bne	a4,a5,.L26
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	ori	a4,a4,1
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L26:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,11
	bne	a4,a5,.L27
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	ori	a4,a4,2
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L27:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,12
	bne	a4,a5,.L28
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	ori	a4,a4,4
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L28:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,13
	bne	a4,a5,.L29
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	ori	a4,a4,8
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L29:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,14
	bne	a4,a5,.L30
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	ori	a4,a4,16
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L30:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,15
	bne	a4,a5,.L31
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	ori	a4,a4,32
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L31:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,16
	bne	a4,a5,.L32
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	ori	a4,a4,64
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L32:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,17
	bne	a4,a5,.L33
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	ori	a4,a4,-128
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L33:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,20
	bne	a4,a5,.L34
	li	a5,40
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,40
	ori	a4,a4,1
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L34:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,21
	bne	a4,a5,.L35
	li	a5,40
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,40
	ori	a4,a4,2
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L35:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,22
	bne	a4,a5,.L36
	li	a5,40
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,40
	ori	a4,a4,4
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L36:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,23
	bne	a4,a5,.L37
	li	a5,40
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,40
	ori	a4,a4,8
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L37:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,24
	bne	a4,a5,.L38
	li	a5,40
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,40
	ori	a4,a4,16
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L38:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,25
	bne	a4,a5,.L39
	li	a5,40
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,40
	ori	a4,a4,32
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L39:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,26
	bne	a4,a5,.L40
	li	a5,40
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,40
	ori	a4,a4,64
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L40:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,30
	bne	a4,a5,.L41
	li	a5,43
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,43
	ori	a4,a4,1
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L41:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,31
	bne	a4,a5,.L42
	li	a5,43
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,43
	ori	a4,a4,2
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L42:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,32
	bne	a4,a5,.L43
	li	a5,43
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,43
	ori	a4,a4,4
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L43:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,33
	bne	a4,a5,.L44
	li	a5,43
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,43
	ori	a4,a4,8
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L44:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,34
	bne	a4,a5,.L45
	li	a5,43
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,43
	ori	a4,a4,16
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L45:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,35
	bne	a4,a5,.L46
	li	a5,43
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,43
	ori	a4,a4,32
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L46:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,36
	bne	a4,a5,.L47
	li	a5,43
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,43
	ori	a4,a4,64
	andi	a4,a4,0xff
	sb	a4,0(a5)
	j	.L48
.L47:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,37
	bne	a4,a5,.L48
	li	a5,43
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,43
	ori	a4,a4,-128
	andi	a4,a4,0xff
	sb	a4,0(a5)
.L48:
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	pinChange, .-pinChange
	.align	1
	.globl	Lcd8_Port
	.type	Lcd8_Port, @function
Lcd8_Port:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	mv	a5,a0
	sb	a5,-17(s0)
	lbu	a5,-17(s0)
	sext.w	a5,a5
	andi	a5,a5,1
	sext.w	a5,a5
	beq	a5,zero,.L50
	li	a1,1
	li	a0,30
	call	pinChange
	j	.L51
.L50:
	li	a1,0
	li	a0,30
	call	pinChange
.L51:
	lbu	a5,-17(s0)
	sext.w	a5,a5
	andi	a5,a5,2
	sext.w	a5,a5
	beq	a5,zero,.L52
	li	a1,1
	li	a0,31
	call	pinChange
	j	.L53
.L52:
	li	a1,0
	li	a0,31
	call	pinChange
.L53:
	lbu	a5,-17(s0)
	sext.w	a5,a5
	andi	a5,a5,4
	sext.w	a5,a5
	beq	a5,zero,.L54
	li	a1,1
	li	a0,32
	call	pinChange
	j	.L55
.L54:
	li	a1,0
	li	a0,32
	call	pinChange
.L55:
	lbu	a5,-17(s0)
	sext.w	a5,a5
	andi	a5,a5,8
	sext.w	a5,a5
	beq	a5,zero,.L56
	li	a1,1
	li	a0,33
	call	pinChange
	j	.L57
.L56:
	li	a1,0
	li	a0,33
	call	pinChange
.L57:
	lbu	a5,-17(s0)
	sext.w	a5,a5
	andi	a5,a5,16
	sext.w	a5,a5
	beq	a5,zero,.L58
	li	a1,1
	li	a0,34
	call	pinChange
	j	.L59
.L58:
	li	a1,0
	li	a0,34
	call	pinChange
.L59:
	lbu	a5,-17(s0)
	sext.w	a5,a5
	andi	a5,a5,32
	sext.w	a5,a5
	beq	a5,zero,.L60
	li	a1,1
	li	a0,35
	call	pinChange
	j	.L61
.L60:
	li	a1,0
	li	a0,35
	call	pinChange
.L61:
	lbu	a5,-17(s0)
	sext.w	a5,a5
	andi	a5,a5,64
	sext.w	a5,a5
	beq	a5,zero,.L62
	li	a1,1
	li	a0,36
	call	pinChange
	j	.L63
.L62:
	li	a1,0
	li	a0,36
	call	pinChange
.L63:
	lb	a5,-17(s0)
	bge	a5,zero,.L64
	li	a1,1
	li	a0,37
	call	pinChange
	j	.L66
.L64:
	li	a1,0
	li	a0,37
	call	pinChange
.L66:
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	Lcd8_Port, .-Lcd8_Port
	.align	1
	.globl	Lcd8_Cmd
	.type	Lcd8_Cmd, @function
Lcd8_Cmd:
	addi	sp,sp,-80
	sd	ra,72(sp)
	sd	s0,64(sp)
	addi	s0,sp,80
	mv	a5,a0
	sb	a5,-65(s0)
	li	a1,0
	li	a0,11
	call	pinChange
	lbu	a5,-65(s0)
	mv	a0,a5
	call	Lcd8_Port
	li	a1,1
	li	a0,10
	call	pinChange
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	fsd	fa5,-48(s0)
	fld	fa4,-48(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-56(s0)
	fld	fa4,-56(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L88
	li	a5,1
	sh	a5,-58(s0)
	j	.L70
.L88:
	fld	fa4,-56(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L89
	fld	fa4,-48(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-58(s0)
	j	.L73
.L74:
	li	a5,400
	sh	a5,-60(s0)
	nop
	lhu	a5,-58(s0)
	addiw	a5,a5,-1
	sh	a5,-58(s0)
.L73:
	lhu	a5,-58(s0)
	sext.w	a5,a5
	bne	a5,zero,.L74
	j	.L75
.L89:
	fld	fa5,-56(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-58(s0)
.L70:
	lhu	a5,-58(s0)
	sh	a5,-62(s0)
	nop
.L75:
	li	a1,0
	li	a0,10
	call	pinChange
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	fsd	fa5,-24(s0)
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-32(s0)
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L90
	li	a5,1
	sh	a5,-34(s0)
	j	.L78
.L90:
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L91
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-34(s0)
	j	.L81
.L82:
	li	a5,400
	sh	a5,-36(s0)
	nop
	lhu	a5,-34(s0)
	addiw	a5,a5,-1
	sh	a5,-34(s0)
.L81:
	lhu	a5,-34(s0)
	sext.w	a5,a5
	bne	a5,zero,.L82
	j	.L83
.L91:
	fld	fa5,-32(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-34(s0)
.L78:
	lhu	a5,-34(s0)
	sh	a5,-38(s0)
	nop
.L83:
	nop
	ld	ra,72(sp)
	ld	s0,64(sp)
	addi	sp,sp,80
	jr	ra
	.size	Lcd8_Cmd, .-Lcd8_Cmd
	.align	1
	.globl	Lcd8_Clear
	.type	Lcd8_Clear, @function
Lcd8_Clear:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	li	a0,1
	call	Lcd8_Cmd
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	Lcd8_Clear, .-Lcd8_Clear
	.align	1
	.globl	Lcd8_Set_Cursor
	.type	Lcd8_Set_Cursor, @function
Lcd8_Set_Cursor:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	mv	a5,a0
	mv	a4,a1
	sb	a5,-17(s0)
	mv	a5,a4
	sb	a5,-18(s0)
	lbu	a5,-17(s0)
	andi	a4,a5,0xff
	li	a5,1
	bne	a4,a5,.L94
	lbu	a5,-18(s0)
	addiw	a5,a5,-128
	andi	a5,a5,0xff
	mv	a0,a5
	call	Lcd8_Cmd
	j	.L96
.L94:
	lbu	a5,-17(s0)
	andi	a4,a5,0xff
	li	a5,2
	bne	a4,a5,.L96
	lbu	a5,-18(s0)
	addiw	a5,a5,-64
	andi	a5,a5,0xff
	mv	a0,a5
	call	Lcd8_Cmd
.L96:
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	Lcd8_Set_Cursor, .-Lcd8_Set_Cursor
	.align	1
	.globl	Lcd8_Init
	.type	Lcd8_Init, @function
Lcd8_Init:
	addi	sp,sp,-112
	sd	ra,104(sp)
	sd	s0,96(sp)
	addi	s0,sp,112
	li	a1,0
	li	a0,11
	call	pinChange
	li	a1,0
	li	a0,10
	call	pinChange
	lui	a5,%hi(.LC4)
	fld	fa5,%lo(.LC4)(a5)
	fsd	fa5,-96(s0)
	fld	fa4,-96(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-104(s0)
	fld	fa4,-104(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L138
	li	a5,1
	sh	a5,-106(s0)
	j	.L100
.L138:
	fld	fa4,-104(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L139
	fld	fa4,-96(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-106(s0)
	j	.L103
.L104:
	li	a5,400
	sh	a5,-108(s0)
	nop
	lhu	a5,-106(s0)
	addiw	a5,a5,-1
	sh	a5,-106(s0)
.L103:
	lhu	a5,-106(s0)
	sext.w	a5,a5
	bne	a5,zero,.L104
	j	.L105
.L139:
	fld	fa5,-104(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-106(s0)
.L100:
	lhu	a5,-106(s0)
	sh	a5,-110(s0)
	nop
.L105:
	li	a0,48
	call	Lcd8_Cmd
	lui	a5,%hi(.LC5)
	fld	fa5,%lo(.LC5)(a5)
	fsd	fa5,-72(s0)
	fld	fa4,-72(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-80(s0)
	fld	fa4,-80(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L140
	li	a5,1
	sh	a5,-82(s0)
	j	.L108
.L140:
	fld	fa4,-80(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L141
	fld	fa4,-72(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-82(s0)
	j	.L111
.L112:
	li	a5,400
	sh	a5,-84(s0)
	nop
	lhu	a5,-82(s0)
	addiw	a5,a5,-1
	sh	a5,-82(s0)
.L111:
	lhu	a5,-82(s0)
	sext.w	a5,a5
	bne	a5,zero,.L112
	j	.L113
.L141:
	fld	fa5,-80(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-82(s0)
.L108:
	lhu	a5,-82(s0)
	sh	a5,-86(s0)
	nop
.L113:
	li	a0,48
	call	Lcd8_Cmd
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	fsd	fa5,-48(s0)
	fld	fa4,-48(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-56(s0)
	fld	fa4,-56(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L142
	li	a5,1
	sh	a5,-58(s0)
	j	.L116
.L142:
	fld	fa4,-56(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L143
	fld	fa4,-48(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-58(s0)
	j	.L119
.L120:
	li	a5,400
	sh	a5,-60(s0)
	nop
	lhu	a5,-58(s0)
	addiw	a5,a5,-1
	sh	a5,-58(s0)
.L119:
	lhu	a5,-58(s0)
	sext.w	a5,a5
	bne	a5,zero,.L120
	j	.L121
.L143:
	fld	fa5,-56(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-58(s0)
.L116:
	lhu	a5,-58(s0)
	sh	a5,-62(s0)
	nop
.L121:
	li	a0,48
	call	Lcd8_Cmd
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fsd	fa5,-24(s0)
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-32(s0)
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L144
	li	a5,1
	sh	a5,-34(s0)
	j	.L124
.L144:
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L145
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-34(s0)
	j	.L127
.L128:
	li	a5,400
	sh	a5,-36(s0)
	nop
	lhu	a5,-34(s0)
	addiw	a5,a5,-1
	sh	a5,-34(s0)
.L127:
	lhu	a5,-34(s0)
	sext.w	a5,a5
	bne	a5,zero,.L128
	j	.L129
.L145:
	fld	fa5,-32(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-34(s0)
.L124:
	lhu	a5,-34(s0)
	sh	a5,-38(s0)
	nop
.L129:
	li	a0,56
	call	Lcd8_Cmd
	li	a0,12
	call	Lcd8_Cmd
	li	a0,1
	call	Lcd8_Cmd
	li	a0,6
	call	Lcd8_Cmd
	nop
	ld	ra,104(sp)
	ld	s0,96(sp)
	addi	sp,sp,112
	jr	ra
	.size	Lcd8_Init, .-Lcd8_Init
	.align	1
	.globl	Lcd8_Write_Char
	.type	Lcd8_Write_Char, @function
Lcd8_Write_Char:
	addi	sp,sp,-80
	sd	ra,72(sp)
	sd	s0,64(sp)
	addi	s0,sp,80
	mv	a5,a0
	sb	a5,-65(s0)
	li	a1,1
	li	a0,11
	call	pinChange
	lbu	a5,-65(s0)
	mv	a0,a5
	call	Lcd8_Port
	li	a1,1
	li	a0,10
	call	pinChange
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	fsd	fa5,-48(s0)
	fld	fa4,-48(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-56(s0)
	fld	fa4,-56(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L167
	li	a5,1
	sh	a5,-58(s0)
	j	.L149
.L167:
	fld	fa4,-56(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L168
	fld	fa4,-48(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-58(s0)
	j	.L152
.L153:
	li	a5,400
	sh	a5,-60(s0)
	nop
	lhu	a5,-58(s0)
	addiw	a5,a5,-1
	sh	a5,-58(s0)
.L152:
	lhu	a5,-58(s0)
	sext.w	a5,a5
	bne	a5,zero,.L153
	j	.L154
.L168:
	fld	fa5,-56(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-58(s0)
.L149:
	lhu	a5,-58(s0)
	sh	a5,-62(s0)
	nop
.L154:
	li	a1,0
	li	a0,10
	call	pinChange
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	fsd	fa5,-24(s0)
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-32(s0)
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L169
	li	a5,1
	sh	a5,-34(s0)
	j	.L157
.L169:
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L170
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-34(s0)
	j	.L160
.L161:
	li	a5,400
	sh	a5,-36(s0)
	nop
	lhu	a5,-34(s0)
	addiw	a5,a5,-1
	sh	a5,-34(s0)
.L160:
	lhu	a5,-34(s0)
	sext.w	a5,a5
	bne	a5,zero,.L161
	j	.L162
.L170:
	fld	fa5,-32(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-34(s0)
.L157:
	lhu	a5,-34(s0)
	sh	a5,-38(s0)
	nop
.L162:
	nop
	ld	ra,72(sp)
	ld	s0,64(sp)
	addi	sp,sp,80
	jr	ra
	.size	Lcd8_Write_Char, .-Lcd8_Write_Char
	.align	1
	.globl	Lcd8_Write_String
	.type	Lcd8_Write_String, @function
Lcd8_Write_String:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sw	zero,-20(s0)
	j	.L172
.L173:
	lw	a5,-20(s0)
	ld	a4,-40(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a0,a5
	call	Lcd8_Write_Char
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L172:
	lw	a5,-20(s0)
	ld	a4,-40(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	bne	a5,zero,.L173
	nop
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	Lcd8_Write_String, .-Lcd8_Write_String
	.align	1
	.globl	Lcd8_Shift_Right
	.type	Lcd8_Shift_Right, @function
Lcd8_Shift_Right:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	li	a0,28
	call	Lcd8_Cmd
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	Lcd8_Shift_Right, .-Lcd8_Shift_Right
	.align	1
	.globl	Lcd8_Shift_Left
	.type	Lcd8_Shift_Left, @function
Lcd8_Shift_Left:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	li	a0,24
	call	Lcd8_Cmd
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	Lcd8_Shift_Left, .-Lcd8_Shift_Left
	.align	1
	.globl	Lcd4_Port
	.type	Lcd4_Port, @function
Lcd4_Port:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	mv	a5,a0
	sb	a5,-17(s0)
	lbu	a5,-17(s0)
	sext.w	a5,a5
	andi	a5,a5,1
	sext.w	a5,a5
	beq	a5,zero,.L177
	li	a1,1
	li	a0,34
	call	pinChange
	j	.L178
.L177:
	li	a1,0
	li	a0,34
	call	pinChange
.L178:
	lbu	a5,-17(s0)
	sext.w	a5,a5
	andi	a5,a5,2
	sext.w	a5,a5
	beq	a5,zero,.L179
	li	a1,1
	li	a0,35
	call	pinChange
	j	.L180
.L179:
	li	a1,0
	li	a0,35
	call	pinChange
.L180:
	lbu	a5,-17(s0)
	sext.w	a5,a5
	andi	a5,a5,4
	sext.w	a5,a5
	beq	a5,zero,.L181
	li	a1,1
	li	a0,36
	call	pinChange
	j	.L182
.L181:
	li	a1,0
	li	a0,36
	call	pinChange
.L182:
	lbu	a5,-17(s0)
	sext.w	a5,a5
	andi	a5,a5,8
	sext.w	a5,a5
	beq	a5,zero,.L183
	li	a1,1
	li	a0,37
	call	pinChange
	j	.L185
.L183:
	li	a1,0
	li	a0,37
	call	pinChange
.L185:
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	Lcd4_Port, .-Lcd4_Port
	.align	1
	.globl	Lcd4_Cmd
	.type	Lcd4_Cmd, @function
Lcd4_Cmd:
	addi	sp,sp,-80
	sd	ra,72(sp)
	sd	s0,64(sp)
	addi	s0,sp,80
	mv	a5,a0
	sb	a5,-65(s0)
	li	a1,0
	li	a0,11
	call	pinChange
	lbu	a5,-65(s0)
	mv	a0,a5
	call	Lcd4_Port
	li	a1,1
	li	a0,10
	call	pinChange
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	fsd	fa5,-48(s0)
	fld	fa4,-48(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-56(s0)
	fld	fa4,-56(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L207
	li	a5,1
	sh	a5,-58(s0)
	j	.L189
.L207:
	fld	fa4,-56(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L208
	fld	fa4,-48(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-58(s0)
	j	.L192
.L193:
	li	a5,400
	sh	a5,-60(s0)
	nop
	lhu	a5,-58(s0)
	addiw	a5,a5,-1
	sh	a5,-58(s0)
.L192:
	lhu	a5,-58(s0)
	sext.w	a5,a5
	bne	a5,zero,.L193
	j	.L194
.L208:
	fld	fa5,-56(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-58(s0)
.L189:
	lhu	a5,-58(s0)
	sh	a5,-62(s0)
	nop
.L194:
	li	a1,0
	li	a0,10
	call	pinChange
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	fsd	fa5,-24(s0)
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-32(s0)
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L209
	li	a5,1
	sh	a5,-34(s0)
	j	.L197
.L209:
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L210
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-34(s0)
	j	.L200
.L201:
	li	a5,400
	sh	a5,-36(s0)
	nop
	lhu	a5,-34(s0)
	addiw	a5,a5,-1
	sh	a5,-34(s0)
.L200:
	lhu	a5,-34(s0)
	sext.w	a5,a5
	bne	a5,zero,.L201
	j	.L202
.L210:
	fld	fa5,-32(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-34(s0)
.L197:
	lhu	a5,-34(s0)
	sh	a5,-38(s0)
	nop
.L202:
	nop
	ld	ra,72(sp)
	ld	s0,64(sp)
	addi	sp,sp,80
	jr	ra
	.size	Lcd4_Cmd, .-Lcd4_Cmd
	.align	1
	.globl	Lcd4_Clear
	.type	Lcd4_Clear, @function
Lcd4_Clear:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	li	a0,0
	call	Lcd4_Cmd
	li	a0,1
	call	Lcd4_Cmd
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	Lcd4_Clear, .-Lcd4_Clear
	.align	1
	.globl	Lcd4_Set_Cursor
	.type	Lcd4_Set_Cursor, @function
Lcd4_Set_Cursor:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	mv	a5,a0
	mv	a4,a1
	sb	a5,-33(s0)
	mv	a5,a4
	sb	a5,-34(s0)
	lbu	a5,-33(s0)
	andi	a4,a5,0xff
	li	a5,1
	bne	a4,a5,.L213
	lbu	a5,-34(s0)
	addiw	a5,a5,-128
	sb	a5,-17(s0)
	lbu	a5,-17(s0)
	srliw	a5,a5,4
	sb	a5,-18(s0)
	lbu	a5,-34(s0)
	andi	a5,a5,15
	sb	a5,-19(s0)
	lbu	a5,-18(s0)
	mv	a0,a5
	call	Lcd4_Cmd
	lbu	a5,-19(s0)
	mv	a0,a5
	call	Lcd4_Cmd
	j	.L215
.L213:
	lbu	a5,-33(s0)
	andi	a4,a5,0xff
	li	a5,2
	bne	a4,a5,.L215
	lbu	a5,-34(s0)
	addiw	a5,a5,-64
	sb	a5,-17(s0)
	lbu	a5,-17(s0)
	srliw	a5,a5,4
	sb	a5,-18(s0)
	lbu	a5,-34(s0)
	andi	a5,a5,15
	sb	a5,-19(s0)
	lbu	a5,-18(s0)
	mv	a0,a5
	call	Lcd4_Cmd
	lbu	a5,-19(s0)
	mv	a0,a5
	call	Lcd4_Cmd
.L215:
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	Lcd4_Set_Cursor, .-Lcd4_Set_Cursor
	.align	1
	.globl	Lcd4_Init
	.type	Lcd4_Init, @function
Lcd4_Init:
	addi	sp,sp,-96
	sd	ra,88(sp)
	sd	s0,80(sp)
	addi	s0,sp,96
	li	a0,0
	call	Lcd4_Port
	lui	a5,%hi(.LC4)
	fld	fa5,%lo(.LC4)(a5)
	fsd	fa5,-72(s0)
	fld	fa4,-72(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-80(s0)
	fld	fa4,-80(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L247
	li	a5,1
	sh	a5,-82(s0)
	j	.L219
.L247:
	fld	fa4,-80(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L248
	fld	fa4,-72(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-82(s0)
	j	.L222
.L223:
	li	a5,400
	sh	a5,-84(s0)
	nop
	lhu	a5,-82(s0)
	addiw	a5,a5,-1
	sh	a5,-82(s0)
.L222:
	lhu	a5,-82(s0)
	sext.w	a5,a5
	bne	a5,zero,.L223
	j	.L224
.L248:
	fld	fa5,-80(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-82(s0)
.L219:
	lhu	a5,-82(s0)
	sh	a5,-86(s0)
	nop
.L224:
	li	a0,3
	call	Lcd4_Cmd
	lui	a5,%hi(.LC5)
	fld	fa5,%lo(.LC5)(a5)
	fsd	fa5,-48(s0)
	fld	fa4,-48(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-56(s0)
	fld	fa4,-56(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L249
	li	a5,1
	sh	a5,-58(s0)
	j	.L227
.L249:
	fld	fa4,-56(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L250
	fld	fa4,-48(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-58(s0)
	j	.L230
.L231:
	li	a5,400
	sh	a5,-60(s0)
	nop
	lhu	a5,-58(s0)
	addiw	a5,a5,-1
	sh	a5,-58(s0)
.L230:
	lhu	a5,-58(s0)
	sext.w	a5,a5
	bne	a5,zero,.L231
	j	.L232
.L250:
	fld	fa5,-56(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-58(s0)
.L227:
	lhu	a5,-58(s0)
	sh	a5,-62(s0)
	nop
.L232:
	li	a0,3
	call	Lcd4_Cmd
	lui	a5,%hi(.LC6)
	fld	fa5,%lo(.LC6)(a5)
	fsd	fa5,-24(s0)
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-32(s0)
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L251
	li	a5,1
	sh	a5,-34(s0)
	j	.L235
.L251:
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L252
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-34(s0)
	j	.L238
.L239:
	li	a5,400
	sh	a5,-36(s0)
	nop
	lhu	a5,-34(s0)
	addiw	a5,a5,-1
	sh	a5,-34(s0)
.L238:
	lhu	a5,-34(s0)
	sext.w	a5,a5
	bne	a5,zero,.L239
	j	.L240
.L252:
	fld	fa5,-32(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-34(s0)
.L235:
	lhu	a5,-34(s0)
	sh	a5,-38(s0)
	nop
.L240:
	li	a0,3
	call	Lcd4_Cmd
	li	a0,2
	call	Lcd4_Cmd
	li	a0,2
	call	Lcd4_Cmd
	li	a0,8
	call	Lcd4_Cmd
	li	a0,0
	call	Lcd4_Cmd
	li	a0,12
	call	Lcd4_Cmd
	li	a0,0
	call	Lcd4_Cmd
	li	a0,6
	call	Lcd4_Cmd
	nop
	ld	ra,88(sp)
	ld	s0,80(sp)
	addi	sp,sp,96
	jr	ra
	.size	Lcd4_Init, .-Lcd4_Init
	.align	1
	.globl	Lcd4_Write_Char
	.type	Lcd4_Write_Char, @function
Lcd4_Write_Char:
	addi	sp,sp,-144
	sd	ra,136(sp)
	sd	s0,128(sp)
	addi	s0,sp,144
	mv	a5,a0
	sb	a5,-129(s0)
	lbu	a5,-129(s0)
	andi	a5,a5,15
	sb	a5,-17(s0)
	lbu	a5,-129(s0)
	andi	a5,a5,-16
	sb	a5,-18(s0)
	li	a1,1
	li	a0,11
	call	pinChange
	lbu	a5,-18(s0)
	srliw	a5,a5,4
	andi	a5,a5,0xff
	mv	a0,a5
	call	Lcd4_Port
	li	a1,1
	li	a0,10
	call	pinChange
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	fsd	fa5,-104(s0)
	fld	fa4,-104(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-112(s0)
	fld	fa4,-112(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L294
	li	a5,1
	sh	a5,-114(s0)
	j	.L256
.L294:
	fld	fa4,-112(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L295
	fld	fa4,-104(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-114(s0)
	j	.L259
.L260:
	li	a5,400
	sh	a5,-116(s0)
	nop
	lhu	a5,-114(s0)
	addiw	a5,a5,-1
	sh	a5,-114(s0)
.L259:
	lhu	a5,-114(s0)
	sext.w	a5,a5
	bne	a5,zero,.L260
	j	.L261
.L295:
	fld	fa5,-112(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-114(s0)
.L256:
	lhu	a5,-114(s0)
	sh	a5,-118(s0)
	nop
.L261:
	li	a1,0
	li	a0,10
	call	pinChange
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	fsd	fa5,-80(s0)
	fld	fa4,-80(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-88(s0)
	fld	fa4,-88(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L296
	li	a5,1
	sh	a5,-90(s0)
	j	.L264
.L296:
	fld	fa4,-88(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L297
	fld	fa4,-80(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-90(s0)
	j	.L267
.L268:
	li	a5,400
	sh	a5,-92(s0)
	nop
	lhu	a5,-90(s0)
	addiw	a5,a5,-1
	sh	a5,-90(s0)
.L267:
	lhu	a5,-90(s0)
	sext.w	a5,a5
	bne	a5,zero,.L268
	j	.L269
.L297:
	fld	fa5,-88(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-90(s0)
.L264:
	lhu	a5,-90(s0)
	sh	a5,-94(s0)
	nop
.L269:
	lbu	a5,-17(s0)
	mv	a0,a5
	call	Lcd4_Port
	li	a1,1
	li	a0,10
	call	pinChange
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	fsd	fa5,-56(s0)
	fld	fa4,-56(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-64(s0)
	fld	fa4,-64(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L298
	li	a5,1
	sh	a5,-66(s0)
	j	.L272
.L298:
	fld	fa4,-64(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L299
	fld	fa4,-56(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-66(s0)
	j	.L275
.L276:
	li	a5,400
	sh	a5,-68(s0)
	nop
	lhu	a5,-66(s0)
	addiw	a5,a5,-1
	sh	a5,-66(s0)
.L275:
	lhu	a5,-66(s0)
	sext.w	a5,a5
	bne	a5,zero,.L276
	j	.L277
.L299:
	fld	fa5,-64(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-66(s0)
.L272:
	lhu	a5,-66(s0)
	sh	a5,-70(s0)
	nop
.L277:
	li	a1,0
	li	a0,10
	call	pinChange
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	fsd	fa5,-32(s0)
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-40(s0)
	fld	fa4,-40(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L300
	li	a5,1
	sh	a5,-42(s0)
	j	.L280
.L300:
	fld	fa4,-40(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L301
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-42(s0)
	j	.L283
.L284:
	li	a5,400
	sh	a5,-44(s0)
	nop
	lhu	a5,-42(s0)
	addiw	a5,a5,-1
	sh	a5,-42(s0)
.L283:
	lhu	a5,-42(s0)
	sext.w	a5,a5
	bne	a5,zero,.L284
	j	.L285
.L301:
	fld	fa5,-40(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-42(s0)
.L280:
	lhu	a5,-42(s0)
	sh	a5,-46(s0)
	nop
.L285:
	nop
	ld	ra,136(sp)
	ld	s0,128(sp)
	addi	sp,sp,144
	jr	ra
	.size	Lcd4_Write_Char, .-Lcd4_Write_Char
	.align	1
	.globl	Lcd4_Write_String
	.type	Lcd4_Write_String, @function
Lcd4_Write_String:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sw	zero,-20(s0)
	j	.L303
.L304:
	lw	a5,-20(s0)
	ld	a4,-40(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a0,a5
	call	Lcd4_Write_Char
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L303:
	lw	a5,-20(s0)
	ld	a4,-40(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	bne	a5,zero,.L304
	nop
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	Lcd4_Write_String, .-Lcd4_Write_String
	.align	1
	.globl	Lcd4_Shift_Right
	.type	Lcd4_Shift_Right, @function
Lcd4_Shift_Right:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	li	a0,1
	call	Lcd4_Cmd
	li	a0,12
	call	Lcd4_Cmd
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	Lcd4_Shift_Right, .-Lcd4_Shift_Right
	.align	1
	.globl	Lcd4_Shift_Left
	.type	Lcd4_Shift_Left, @function
Lcd4_Shift_Left:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	li	a0,1
	call	Lcd4_Cmd
	li	a0,8
	call	Lcd4_Cmd
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	Lcd4_Shift_Left, .-Lcd4_Shift_Left
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
	bge	a5,zero,.L309
	li	a5,198
	lbu	a5,0(a5)
	andi	a5,a5,0xff
	j	.L310
.L309:
	li	a5,0
.L310:
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
.L312:
	li	a5,192
	lbu	a5,0(a5)
	andi	a5,a5,0xff
	sext.w	a5,a5
	andi	a5,a5,32
	sext.w	a5,a5
	beq	a5,zero,.L312
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
	lui	a5,%hi(.LC7)
	fld	fa5,%lo(.LC7)(a5)
	fsd	fa5,-200(s0)
	fld	fa4,-200(s0)
	lui	a5,%hi(.LC8)
	fld	fa5,%lo(.LC8)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-208(s0)
	fld	fa4,-200(s0)
	lui	a5,%hi(.LC9)
	fld	fa5,%lo(.LC9)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-216(s0)
	fld	fa4,-208(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L397
	li	a5,1
	sb	a5,-217(s0)
	j	.L316
.L397:
	fld	fa4,-216(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L398
	fld	fa4,-200(s0)
	lui	a5,%hi(.LC7)
	fld	fa5,%lo(.LC7)(a5)
	fdiv.d	fa5,fa4,fa5
	fsd	fa5,-232(s0)
	fld	fa4,-232(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-240(s0)
	fld	fa4,-240(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L399
	li	a5,1
	sh	a5,-242(s0)
	j	.L321
.L399:
	fld	fa4,-240(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L400
	fld	fa4,-232(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-242(s0)
	j	.L324
.L325:
	li	a5,400
	sh	a5,-244(s0)
	nop
	lhu	a5,-242(s0)
	addiw	a5,a5,-1
	sh	a5,-242(s0)
.L324:
	lhu	a5,-242(s0)
	sext.w	a5,a5
	bne	a5,zero,.L325
	j	.L316
.L400:
	fld	fa5,-240(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-242(s0)
.L321:
	lhu	a5,-242(s0)
	sh	a5,-246(s0)
	j	.L316
.L398:
	fld	fa4,-208(s0)
	lui	a5,%hi(.LC10)
	fld	fa5,%lo(.LC10)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L401
	fld	fa5,-216(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-248(s0)
	lhu	a5,-248(s0)
	sh	a5,-250(s0)
	nop
	j	.L329
.L401:
	fld	fa5,-208(s0)
	fcvt.wu.d a5,fa5,rtz
	sb	a5,-217(s0)
.L316:
	lbu	a5,-217(s0)
	sb	a5,-251(s0)
	nop
.L329:
	li	a5,40
	sb	zero,0(a5)
	lui	a5,%hi(.LC11)
	fld	fa5,%lo(.LC11)(a5)
	fsd	fa5,-176(s0)
	fld	fa4,-176(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-184(s0)
	fld	fa4,-184(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L402
	li	a5,1
	sh	a5,-186(s0)
	j	.L332
.L402:
	fld	fa4,-184(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L403
	fld	fa4,-176(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-186(s0)
	j	.L335
.L336:
	li	a5,400
	sh	a5,-188(s0)
	nop
	lhu	a5,-186(s0)
	addiw	a5,a5,-1
	sh	a5,-186(s0)
.L335:
	lhu	a5,-186(s0)
	sext.w	a5,a5
	bne	a5,zero,.L336
	j	.L337
.L403:
	fld	fa5,-184(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-186(s0)
.L332:
	lhu	a5,-186(s0)
	sh	a5,-190(s0)
	nop
.L337:
	li	a5,40
	li	a4,1
	sb	a4,0(a5)
	lui	a5,%hi(.LC12)
	fld	fa5,%lo(.LC12)(a5)
	fsd	fa5,-112(s0)
	fld	fa4,-112(s0)
	lui	a5,%hi(.LC8)
	fld	fa5,%lo(.LC8)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-120(s0)
	fld	fa4,-112(s0)
	lui	a5,%hi(.LC9)
	fld	fa5,%lo(.LC9)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-128(s0)
	fld	fa4,-120(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L404
	li	a5,1
	sb	a5,-129(s0)
	j	.L340
.L404:
	fld	fa4,-128(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L405
	fld	fa4,-112(s0)
	lui	a5,%hi(.LC7)
	fld	fa5,%lo(.LC7)(a5)
	fdiv.d	fa5,fa4,fa5
	fsd	fa5,-144(s0)
	fld	fa4,-144(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-152(s0)
	fld	fa4,-152(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L406
	li	a5,1
	sh	a5,-154(s0)
	j	.L345
.L406:
	fld	fa4,-152(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L407
	fld	fa4,-144(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-154(s0)
	j	.L348
.L349:
	li	a5,400
	sh	a5,-156(s0)
	nop
	lhu	a5,-154(s0)
	addiw	a5,a5,-1
	sh	a5,-154(s0)
.L348:
	lhu	a5,-154(s0)
	sext.w	a5,a5
	bne	a5,zero,.L349
	j	.L340
.L407:
	fld	fa5,-152(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-154(s0)
.L345:
	lhu	a5,-154(s0)
	sh	a5,-158(s0)
	j	.L340
.L405:
	fld	fa4,-120(s0)
	lui	a5,%hi(.LC10)
	fld	fa5,%lo(.LC10)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L408
	fld	fa5,-128(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-160(s0)
	lhu	a5,-160(s0)
	sh	a5,-162(s0)
	nop
	j	.L353
.L408:
	fld	fa5,-120(s0)
	fcvt.wu.d a5,fa5,rtz
	sb	a5,-129(s0)
.L340:
	lbu	a5,-129(s0)
	sb	a5,-163(s0)
	nop
.L353:
	li	a5,40
	sb	zero,0(a5)
	lui	a5,%hi(.LC11)
	fld	fa5,%lo(.LC11)(a5)
	fsd	fa5,-88(s0)
	fld	fa4,-88(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-96(s0)
	fld	fa4,-96(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L409
	li	a5,1
	sh	a5,-98(s0)
	j	.L356
.L409:
	fld	fa4,-96(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L410
	fld	fa4,-88(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-98(s0)
	j	.L359
.L360:
	li	a5,400
	sh	a5,-100(s0)
	nop
	lhu	a5,-98(s0)
	addiw	a5,a5,-1
	sh	a5,-98(s0)
.L359:
	lhu	a5,-98(s0)
	sext.w	a5,a5
	bne	a5,zero,.L360
	j	.L361
.L410:
	fld	fa5,-96(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-98(s0)
.L356:
	lhu	a5,-98(s0)
	sh	a5,-102(s0)
	nop
.L361:
	li	a5,40
	li	a4,1
	sb	a4,0(a5)
	li	a5,40
	sb	zero,0(a5)
	li	a5,40
	li	a4,1
	sb	a4,0(a5)
	lui	a5,%hi(.LC7)
	fld	fa5,%lo(.LC7)(a5)
	fsd	fa5,-24(s0)
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC8)
	fld	fa5,%lo(.LC8)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-32(s0)
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC9)
	fld	fa5,%lo(.LC9)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-40(s0)
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L411
	li	a5,1
	sb	a5,-41(s0)
	j	.L364
.L411:
	fld	fa4,-40(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L412
	fld	fa4,-24(s0)
	lui	a5,%hi(.LC7)
	fld	fa5,%lo(.LC7)(a5)
	fdiv.d	fa5,fa4,fa5
	fsd	fa5,-56(s0)
	fld	fa4,-56(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-64(s0)
	fld	fa4,-64(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L413
	li	a5,1
	sh	a5,-66(s0)
	j	.L369
.L413:
	fld	fa4,-64(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L414
	fld	fa4,-56(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-66(s0)
	j	.L372
.L373:
	li	a5,400
	sh	a5,-68(s0)
	nop
	lhu	a5,-66(s0)
	addiw	a5,a5,-1
	sh	a5,-66(s0)
.L372:
	lhu	a5,-66(s0)
	sext.w	a5,a5
	bne	a5,zero,.L373
	j	.L364
.L414:
	fld	fa5,-64(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-66(s0)
.L369:
	lhu	a5,-66(s0)
	sh	a5,-70(s0)
	j	.L364
.L412:
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC10)
	fld	fa5,%lo(.LC10)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L415
	fld	fa5,-40(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-72(s0)
	lhu	a5,-72(s0)
	sh	a5,-74(s0)
	nop
	j	.L377
.L415:
	fld	fa5,-32(s0)
	fcvt.wu.d a5,fa5,rtz
	sb	a5,-41(s0)
.L364:
	lbu	a5,-41(s0)
	sb	a5,-75(s0)
	nop
.L377:
	li	a5,40
	sb	zero,0(a5)
	nop
	ld	s0,248(sp)
	addi	sp,sp,256
	jr	ra
	.size	Gate, .-Gate
	.section	.rodata
	.align	3
.LC13:
	.string	"Swipe the Card"
	.align	3
.LC14:
	.string	"Access Grant"
	.align	3
.LC16:
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
	lui	a5,%hi(.LC13)
	addi	a0,a5,%lo(.LC13)
	call	Lcd4_Write_String
	li	a5,39
	li	a4,1
	sb	a4,0(a5)
	li	a5,40
	sb	zero,0(a5)
.L452:
	call	SWseriale_available
	mv	a5,a0
	beq	a5,zero,.L417
	call	SWseriale_read
	mv	a5,a0
	sb	a5,-17(s0)
	lbu	a5,-17(s0)
	mv	a0,a5
	call	USART_Transmit
.L417:
	call	USART_Receive
	mv	a5,a0
	mv	a4,a5
	lui	a5,%hi(rx)
	sb	a4,%lo(rx)(a5)
	lui	a5,%hi(rx)
	lbu	a5,%lo(rx)(a5)
	mv	a4,a5
	li	a5,75
	bne	a4,a5,.L418
	lui	a5,%hi(.LC14)
	addi	a0,a5,%lo(.LC14)
	call	Lcd4_Write_String
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	ori	a4,a4,32
	andi	a4,a4,0xff
	sb	a4,0(a5)
	lui	a5,%hi(.LC15)
	fld	fa5,%lo(.LC15)(a5)
	fsd	fa5,-56(s0)
	fld	fa4,-56(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-64(s0)
	fld	fa4,-64(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L461
	li	a5,1
	sh	a5,-66(s0)
	j	.L421
.L461:
	fld	fa4,-64(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L462
	fld	fa4,-56(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-66(s0)
	j	.L424
.L425:
	li	a5,400
	sh	a5,-68(s0)
	nop
	lhu	a5,-66(s0)
	addiw	a5,a5,-1
	sh	a5,-66(s0)
.L424:
	lhu	a5,-66(s0)
	sext.w	a5,a5
	bne	a5,zero,.L425
	j	.L426
.L462:
	fld	fa5,-64(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-66(s0)
.L421:
	lhu	a5,-66(s0)
	sh	a5,-70(s0)
	nop
.L426:
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	andi	a4,a4,-33
	andi	a4,a4,0xff
	sb	a4,0(a5)
	lui	a5,%hi(.LC15)
	fld	fa5,%lo(.LC15)(a5)
	fsd	fa5,-32(s0)
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-40(s0)
	fld	fa4,-40(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L463
	li	a5,1
	sh	a5,-42(s0)
	j	.L429
.L463:
	fld	fa4,-40(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L464
	fld	fa4,-32(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-42(s0)
	j	.L432
.L433:
	li	a5,400
	sh	a5,-44(s0)
	nop
	lhu	a5,-42(s0)
	addiw	a5,a5,-1
	sh	a5,-42(s0)
.L432:
	lhu	a5,-42(s0)
	sext.w	a5,a5
	bne	a5,zero,.L433
	j	.L434
.L464:
	fld	fa5,-40(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-42(s0)
.L429:
	lhu	a5,-42(s0)
	sh	a5,-46(s0)
	nop
.L434:
	lui	a5,%hi(rx)
	li	a4,79
	sb	a4,%lo(rx)(a5)
	call	Gate
	call	Lcd4_Clear
	j	.L452
.L418:
	lui	a5,%hi(rx)
	lbu	a5,%lo(rx)(a5)
	mv	a4,a5
	li	a5,88
	bne	a4,a5,.L452
	lui	a5,%hi(.LC16)
	addi	a0,a5,%lo(.LC16)
	call	Lcd4_Write_String
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	ori	a4,a4,32
	andi	a4,a4,0xff
	sb	a4,0(a5)
	lui	a5,%hi(.LC17)
	fld	fa5,%lo(.LC17)(a5)
	fsd	fa5,-104(s0)
	fld	fa4,-104(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-112(s0)
	fld	fa4,-112(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L465
	li	a5,1
	sh	a5,-114(s0)
	j	.L438
.L465:
	fld	fa4,-112(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L466
	fld	fa4,-104(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-114(s0)
	j	.L441
.L442:
	li	a5,400
	sh	a5,-116(s0)
	nop
	lhu	a5,-114(s0)
	addiw	a5,a5,-1
	sh	a5,-114(s0)
.L441:
	lhu	a5,-114(s0)
	sext.w	a5,a5
	bne	a5,zero,.L442
	j	.L443
.L466:
	fld	fa5,-112(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-114(s0)
.L438:
	lhu	a5,-114(s0)
	sh	a5,-118(s0)
	nop
.L443:
	li	a5,37
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,37
	andi	a4,a4,-33
	andi	a4,a4,0xff
	sb	a4,0(a5)
	lui	a5,%hi(.LC15)
	fld	fa5,%lo(.LC15)(a5)
	fsd	fa5,-80(s0)
	fld	fa4,-80(s0)
	lui	a5,%hi(.LC1)
	fld	fa5,%lo(.LC1)(a5)
	fmul.d	fa5,fa4,fa5
	fsd	fa5,-88(s0)
	fld	fa4,-88(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	flt.d	a5,fa4,fa5
	beq	a5,zero,.L467
	li	a5,1
	sh	a5,-90(s0)
	j	.L446
.L467:
	fld	fa4,-88(s0)
	lui	a5,%hi(.LC2)
	fld	fa5,%lo(.LC2)(a5)
	fgt.d	a5,fa4,fa5
	beq	a5,zero,.L468
	fld	fa4,-80(s0)
	lui	a5,%hi(.LC3)
	fld	fa5,%lo(.LC3)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-90(s0)
	j	.L449
.L450:
	li	a5,400
	sh	a5,-92(s0)
	nop
	lhu	a5,-90(s0)
	addiw	a5,a5,-1
	sh	a5,-90(s0)
.L449:
	lhu	a5,-90(s0)
	sext.w	a5,a5
	bne	a5,zero,.L450
	j	.L451
.L468:
	fld	fa5,-88(s0)
	fcvt.wu.d a5,fa5,rtz
	sh	a5,-90(s0)
.L446:
	lhu	a5,-90(s0)
	sh	a5,-94(s0)
	nop
.L451:
	lui	a5,%hi(rx)
	li	a4,79
	sb	a4,%lo(rx)(a5)
	call	Lcd4_Clear
	j	.L452
	.size	main, .-main
	.section	.rodata
	.align	3
.LC0:
	.word	0
	.word	1072693248
	.align	3
.LC1:
	.word	0
	.word	1085227008
	.align	3
.LC2:
	.word	0
	.word	1089470432
	.align	3
.LC3:
	.word	0
	.word	1076101120
	.align	3
.LC4:
	.word	0
	.word	1077149696
	.align	3
.LC5:
	.word	0
	.word	1075052544
	.align	3
.LC6:
	.word	0
	.word	1076232192
	.align	3
.LC7:
	.word	0
	.word	1083129856
	.align	3
.LC8:
	.word	1431655765
	.word	1075139925
	.align	3
.LC9:
	.word	0
	.word	1074790400
	.align	3
.LC10:
	.word	0
	.word	1081073664
	.align	3
.LC11:
	.word	0
	.word	1084178432
	.align	3
.LC12:
	.word	0
	.word	1083666432
	.align	3
.LC15:
	.word	0
	.word	1080623104
	.align	3
.LC17:
	.word	0
	.word	1084715008
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
