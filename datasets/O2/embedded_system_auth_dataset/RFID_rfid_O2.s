	.file	"rfid.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	QUET_THE
	.type	QUET_THE, @function
QUET_THE:
	addi	t1,a0,8
	lui	a2,%hi(CHECK)
	li	a6,4
	li	a7,1
.L2:
	li	a5,0
.L4:
	add	a3,a1,a5
	add	a4,a0,a5
	lbu	a3,0(a3)
	lbu	a4,0(a4)
	addi	a5,a5,1
	beq	a3,a4,.L3
	sb	zero,%lo(CHECK)(a2)
.L3:
	bne	a5,a6,.L4
	lbu	a5,%lo(CHECK)(a2)
	beq	a5,a7,.L5
	beq	a0,t1,.L5
	bne	a5,zero,.L7
	sb	a7,%lo(CHECK)(a2)
.L7:
	addi	a0,a0,4
	j	.L2
.L5:
	sext.w	a0,a5
	ret
	.size	QUET_THE, .-QUET_THE
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	" HET DUNG LUONG"
	.text
	.align	1
	.globl	QUET_THE2
	.type	QUET_THE2, @function
QUET_THE2:
	lui	t1,%hi(DATATEST)
	lui	a6,%hi(DATATEST+4)
	addi	t4,a0,12
	lui	a7,%hi(CHECK)
	addi	t1,t1,%lo(DATATEST)
	addi	a6,a6,%lo(DATATEST+4)
	li	t3,1
.L12:
	mv	a5,t1
	mv	a4,a0
.L14:
	lbu	a2,0(a4)
	lbu	a3,0(a5)
	addi	a4,a4,1
	addi	a5,a5,1
	beq	a2,a3,.L13
	sb	zero,%lo(CHECK)(a7)
.L13:
	bne	a6,a5,.L14
	lbu	a5,%lo(CHECK)(a7)
	beq	a5,t3,.L25
	bne	a5,zero,.L18
	sb	t3,%lo(CHECK)(a7)
.L18:
	addi	a0,a0,4
	bne	a0,t4,.L12
	lui	a5,%hi(ok)
	lw	a5,%lo(ok)(a5)
	beq	a5,zero,.L26
	ret
.L26:
	addi	sp,sp,-16
	sd	ra,8(sp)
	call	lcd_clear_display
	li	a0,10
	call	HAL_Delay
	li	a1,0
	li	a0,1
	call	lcd_goto_XY
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	lcd_send_string
	ld	ra,8(sp)
	li	a0,1000
	addi	sp,sp,16
	tail	HAL_Delay
.L25:
	li	a5,0
	li	a2,4
.L16:
	add	a4,a1,a5
	lbu	a3,0(a4)
	add	a4,a0,a5
	addi	a5,a5,1
	sb	a3,0(a4)
	bne	a5,a2,.L16
	lui	a5,%hi(ok)
	li	a4,1
	sw	a4,%lo(ok)(a5)
	ret
	.size	QUET_THE2, .-QUET_THE2
	.section	.rodata.str1.8
	.align	3
.LC1:
	.string	"KHONG CO THE NAY"
	.text
	.align	1
	.globl	QUET_THE3
	.type	QUET_THE3, @function
QUET_THE3:
	addi	a4,a0,4
	li	a5,0
	lui	a3,%hi(CHECK)
	li	a7,4
.L29:
	add	a6,a1,a5
	add	a2,a4,a5
	lbu	a6,0(a6)
	lbu	a2,0(a2)
	addi	a5,a5,1
	beq	a6,a2,.L28
	sb	zero,%lo(CHECK)(a3)
.L28:
	bne	a5,a7,.L29
	lbu	a5,%lo(CHECK)(a3)
	li	a2,1
	beq	a5,a2,.L30
	beq	a5,zero,.L42
.L31:
	addi	a4,a0,8
	li	a5,0
	li	a6,4
.L33:
	add	a0,a4,a5
	add	a2,a1,a5
	lbu	a0,0(a0)
	lbu	a2,0(a2)
	addi	a5,a5,1
	beq	a0,a2,.L32
	sb	zero,%lo(CHECK)(a3)
.L32:
	bne	a5,a6,.L33
	lbu	a5,%lo(CHECK)(a3)
	li	a2,1
	beq	a5,a2,.L30
	beq	a5,zero,.L43
	lui	a5,%hi(ok)
	lw	a5,%lo(ok)(a5)
	beq	a5,zero,.L44
.L27:
	ret
.L42:
	sb	a2,%lo(CHECK)(a3)
	j	.L31
.L43:
	lui	a5,%hi(ok)
	lw	a5,%lo(ok)(a5)
	sb	a2,%lo(CHECK)(a3)
	bne	a5,zero,.L27
.L44:
	addi	sp,sp,-16
	sd	ra,8(sp)
	call	lcd_clear_display
	li	a0,10
	call	HAL_Delay
	li	a1,0
	li	a0,1
	call	lcd_goto_XY
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	lcd_send_string
	ld	ra,8(sp)
	li	a0,1000
	addi	sp,sp,16
	tail	HAL_Delay
.L30:
	sb	zero,0(a4)
	sb	zero,1(a4)
	sb	zero,2(a4)
	sb	zero,3(a4)
	lui	a5,%hi(ok)
	li	a4,1
	sw	a4,%lo(ok)(a5)
	ret
	.size	QUET_THE3, .-QUET_THE3
	.align	1
	.globl	QUET_THE4
	.type	QUET_THE4, @function
QUET_THE4:
	li	a5,0
	lui	a6,%hi(CHECK)
	li	a2,4
.L47:
	add	a3,a1,a5
	add	a4,a0,a5
	lbu	a3,0(a3)
	lbu	a4,0(a4)
	addi	a5,a5,1
	beq	a3,a4,.L46
	sb	zero,%lo(CHECK)(a6)
.L46:
	bne	a5,a2,.L47
	lbu	a0,%lo(CHECK)(a6)
	ret
	.size	QUET_THE4, .-QUET_THE4
	.align	1
	.globl	Buzzer
	.type	Buzzer, @function
Buzzer:
	ble	a1,zero,.L56
	addi	sp,sp,-48
	sd	s1,24(sp)
	sd	s2,16(sp)
	li	s1,1073811456
	li	s2,4096
	sd	s0,32(sp)
	sd	s3,8(sp)
	sd	s4,0(sp)
	sd	ra,40(sp)
	mv	s4,a1
	mv	s3,a0
	li	s0,0
	addi	s2,s2,-2048
	addi	s1,s1,-1024
.L51:
	li	a2,0
	mv	a1,s2
	mv	a0,s1
	call	HAL_GPIO_WritePin
	mv	a0,s3
	call	HAL_Delay
	li	a2,1
	mv	a1,s2
	mv	a0,s1
	call	HAL_GPIO_WritePin
	mv	a0,s3
	call	HAL_Delay
	addiw	a5,s0,1
	andi	a4,a5,0xff
	mv	s0,a4
	blt	a4,s4,.L51
	ld	ra,40(sp)
	ld	s0,32(sp)
	ld	s1,24(sp)
	ld	s2,16(sp)
	ld	s3,8(sp)
	ld	s4,0(sp)
	addi	sp,sp,48
	jr	ra
.L56:
	ret
	.size	Buzzer, .-Buzzer
	.align	1
	.globl	Mocua
	.type	Mocua, @function
Mocua:
	li	a0,1073811456
	addi	sp,sp,-16
	li	a2,1
	li	a1,32
	addi	a0,a0,-1024
	sd	ra,8(sp)
	call	HAL_GPIO_WritePin
	li	a0,8192
	addi	a0,a0,1808
	call	HAL_Delay
	ld	ra,8(sp)
	li	a0,1073811456
	li	a2,0
	li	a1,32
	addi	a0,a0,-1024
	addi	sp,sp,16
	tail	HAL_GPIO_WritePin
	.size	Mocua, .-Mocua
	.section	.rodata.str1.8
	.align	3
.LC2:
	.string	"THE HOP LE"
	.align	3
.LC3:
	.string	"MOI BAN VAO NHA"
	.align	3
.LC4:
	.string	"THE KHONG HOP LE "
	.text
	.align	1
	.globl	Kiemtrarfid
	.type	Kiemtrarfid, @function
Kiemtrarfid:
	lui	a0,%hi(TagType)
	addi	sp,sp,-32
	addi	a0,a0,%lo(TagType)
	sd	ra,24(sp)
	call	MFRC522_Check
	bne	a0,zero,.L73
	ld	ra,24(sp)
	addi	sp,sp,32
	jr	ra
.L73:
	sd	s0,16(sp)
	lui	s0,%hi(UID)
	addi	a0,s0,%lo(UID)
	call	MFRC522_ReadCardSerial
	bne	a0,zero,.L74
	ld	s0,16(sp)
	ld	ra,24(sp)
	addi	sp,sp,32
	jr	ra
.L74:
	lui	a0,%hi(.LANCHOR0)
	addi	a1,s0,%lo(UID)
	addi	a0,a0,%lo(.LANCHOR0)
	call	QUET_THE
	andi	a0,a0,0xff
	lui	a5,%hi(tt_1)
	sb	a0,%lo(tt_1)(a5)
	li	s0,1
	beq	a0,s0,.L75
	call	lcd_clear_display
	li	a0,10
	call	HAL_Delay
	li	a1,0
	li	a0,1
	call	lcd_goto_XY
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	call	lcd_send_string
	li	a1,4096
	li	a0,1073811456
	li	a2,0
	addi	a1,a1,-2048
	addi	a0,a0,-1024
	call	HAL_GPIO_WritePin
	li	a0,200
	call	HAL_Delay
	li	a1,4096
	li	a0,1073811456
	li	a2,1
	addi	a1,a1,-2048
	addi	a0,a0,-1024
	call	HAL_GPIO_WritePin
	li	a0,200
	call	HAL_Delay
	lui	a5,%hi(CHECK)
	sb	s0,%lo(CHECK)(a5)
	ld	s0,16(sp)
	ld	ra,24(sp)
	li	a0,1000
	addi	sp,sp,32
	tail	HAL_Delay
.L75:
	sd	s1,8(sp)
	sd	s2,0(sp)
	call	lcd_clear_display
	li	a0,10
	call	HAL_Delay
	li	a1,3
	li	a0,1
	call	lcd_goto_XY
	lui	a0,%hi(.LC2)
	addi	a0,a0,%lo(.LC2)
	call	lcd_send_string
	li	a1,1
	li	a0,2
	call	lcd_goto_XY
	lui	a0,%hi(.LC3)
	addi	a0,a0,%lo(.LC3)
	li	s2,4096
	li	s1,1073811456
	call	lcd_send_string
	li	s0,3
	addi	s2,s2,-2048
	addi	s1,s1,-1024
.L66:
	li	a2,0
	mv	a1,s2
	mv	a0,s1
	call	HAL_GPIO_WritePin
	li	a0,70
	call	HAL_Delay
	li	a2,1
	mv	a1,s2
	mv	a0,s1
	call	HAL_GPIO_WritePin
	addiw	s0,s0,-1
	li	a0,70
	andi	s0,s0,0xff
	call	HAL_Delay
	bne	s0,zero,.L66
	li	a0,1073811456
	li	a2,1
	li	a1,32
	addi	a0,a0,-1024
	call	HAL_GPIO_WritePin
	li	a0,8192
	addi	a0,a0,1808
	call	HAL_Delay
	ld	s0,16(sp)
	ld	s1,8(sp)
	ld	s2,0(sp)
	ld	ra,24(sp)
	li	a0,1073811456
	li	a2,0
	li	a1,32
	addi	a0,a0,-1024
	addi	sp,sp,32
	tail	HAL_GPIO_WritePin
	.size	Kiemtrarfid, .-Kiemtrarfid
	.align	1
	.globl	Checkadmin
	.type	Checkadmin, @function
Checkadmin:
	lui	a0,%hi(TagType)
	addi	sp,sp,-16
	addi	a0,a0,%lo(TagType)
	sd	ra,8(sp)
	call	MFRC522_Check
	bne	a0,zero,.L92
.L76:
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
.L92:
	sd	s0,0(sp)
	lui	s0,%hi(UID)
	addi	a0,s0,%lo(UID)
	call	MFRC522_ReadCardSerial
	bne	a0,zero,.L93
	ld	s0,0(sp)
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
.L93:
	addi	a5,s0,%lo(UID)
	lui	a4,%hi(.LANCHOR0)
	addi	a4,a4,%lo(.LANCHOR0)
	addi	a1,a5,4
	li	a0,0
.L81:
	lbu	a2,0(a5)
	lbu	a3,0(a4)
	addi	a5,a5,1
	addi	a4,a4,1
	beq	a2,a3,.L80
	li	a0,1
.L80:
	bne	a1,a5,.L81
	lui	s0,%hi(CHECK)
	beq	a0,zero,.L94
	lui	a5,%hi(tt_1)
	sb	zero,%lo(CHECK)(s0)
	sb	zero,%lo(tt_1)(a5)
.L84:
	call	lcd_clear_display
	li	a0,10
	call	HAL_Delay
	li	a1,0
	li	a0,1
	call	lcd_goto_XY
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	call	lcd_send_string
	li	a1,4096
	li	a0,1073811456
	li	a2,0
	addi	a1,a1,-2048
	addi	a0,a0,-1024
	call	HAL_GPIO_WritePin
	li	a0,200
	call	HAL_Delay
	li	a1,4096
	li	a0,1073811456
	li	a2,1
	addi	a1,a1,-2048
	addi	a0,a0,-1024
	call	HAL_GPIO_WritePin
	li	a0,200
	call	HAL_Delay
	li	a5,1
	sb	a5,%lo(CHECK)(s0)
	ld	s0,0(sp)
	ld	ra,8(sp)
	li	a0,1000
	addi	sp,sp,16
	tail	HAL_Delay
.L94:
	lbu	a5,%lo(CHECK)(s0)
	lui	a3,%hi(tt_1)
	li	a4,1
	sb	a5,%lo(tt_1)(a3)
	bne	a5,a4,.L84
	lui	a4,%hi(ok)
	ld	s0,0(sp)
	sw	a5,%lo(ok)(a4)
	j	.L76
	.size	Checkadmin, .-Checkadmin
	.align	1
	.globl	THEM_THE
	.type	THEM_THE, @function
THEM_THE:
	lui	a0,%hi(TagType)
	addi	sp,sp,-16
	addi	a0,a0,%lo(TagType)
	sd	ra,8(sp)
	call	MFRC522_Check
	bne	a0,zero,.L104
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
.L104:
	sd	s0,0(sp)
	lui	s0,%hi(UID)
	addi	a0,s0,%lo(UID)
	call	MFRC522_ReadCardSerial
	bne	a0,zero,.L105
	ld	s0,0(sp)
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
.L105:
	addi	a1,s0,%lo(UID)
	ld	s0,0(sp)
	ld	ra,8(sp)
	lui	a0,%hi(.LANCHOR0)
	addi	a0,a0,%lo(.LANCHOR0)
	addi	sp,sp,16
	tail	QUET_THE2
	.size	THEM_THE, .-THEM_THE
	.align	1
	.globl	XOA_THE
	.type	XOA_THE, @function
XOA_THE:
	lui	a0,%hi(TagType)
	addi	sp,sp,-16
	addi	a0,a0,%lo(TagType)
	sd	ra,8(sp)
	call	MFRC522_Check
	bne	a0,zero,.L115
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
.L115:
	sd	s0,0(sp)
	lui	s0,%hi(UID)
	addi	a0,s0,%lo(UID)
	call	MFRC522_ReadCardSerial
	bne	a0,zero,.L116
	ld	s0,0(sp)
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
.L116:
	addi	a1,s0,%lo(UID)
	ld	s0,0(sp)
	ld	ra,8(sp)
	lui	a0,%hi(.LANCHOR0)
	addi	a0,a0,%lo(.LANCHOR0)
	addi	sp,sp,16
	tail	QUET_THE3
	.size	XOA_THE, .-XOA_THE
	.globl	TagType
	.globl	UID
	.globl	DOOR
	.globl	CHECK
	.globl	tt_1
	.globl	DATA_RIGHT
	.globl	DATATEST
	.data
	.align	3
	.set	.LANCHOR0,. + 0
	.type	DATA_RIGHT, @object
	.size	DATA_RIGHT, 12
DATA_RIGHT:
	.ascii	"2\301u\036"
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.string	""
	.section	.sbss,"aw",@nobits
	.align	3
	.type	TagType, @object
	.size	TagType, 1
TagType:
	.zero	1
	.zero	7
	.type	UID, @object
	.size	UID, 4
UID:
	.zero	4
	.type	DOOR, @object
	.size	DOOR, 1
DOOR:
	.zero	1
	.type	tt_1, @object
	.size	tt_1, 1
tt_1:
	.zero	1
	.zero	2
	.type	DATATEST, @object
	.size	DATATEST, 4
DATATEST:
	.zero	4
	.section	.sdata,"aw"
	.type	CHECK, @object
	.size	CHECK, 1
CHECK:
	.byte	1
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
