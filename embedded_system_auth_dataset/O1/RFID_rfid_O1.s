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
	mv	a6,a0
	addi	t4,a0,12
	addi	a0,a0,8
	lui	t1,%hi(CHECK)
	li	a7,4
	li	t3,1
	j	.L2
.L3:
	addi	a5,a5,1
	beq	a5,a7,.L8
.L4:
	add	a3,a1,a5
	add	a4,a2,a5
	lbu	a3,0(a3)
	lbu	a4,0(a4)
	beq	a3,a4,.L3
	sb	zero,%lo(CHECK)(t1)
	j	.L3
.L8:
	lbu	a5,%lo(CHECK)(t1)
	beq	a5,t3,.L5
	beq	a6,a0,.L5
	bne	a5,zero,.L6
	lui	a5,%hi(CHECK)
	li	a4,1
	sb	a4,%lo(CHECK)(a5)
.L6:
	addi	a6,a6,4
	beq	a6,t4,.L5
.L2:
	mv	a2,a6
	li	a5,0
	j	.L4
.L5:
	lui	a5,%hi(CHECK)
	lbu	a0,%lo(CHECK)(a5)
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
	mv	a7,a0
	addi	a0,a0,12
	lui	t4,%hi(DATATEST)
	lui	t1,%hi(CHECK)
	li	t3,1
	j	.L10
.L11:
	addi	a4,a4,1
	addi	a5,a5,1
	beq	a5,a6,.L24
.L12:
	lbu	a2,0(a4)
	lbu	a3,0(a5)
	beq	a2,a3,.L11
	sb	zero,%lo(CHECK)(t1)
	j	.L11
.L24:
	lbu	a5,%lo(CHECK)(t1)
	beq	a5,t3,.L25
	bne	a5,zero,.L16
	sb	t3,%lo(CHECK)(t1)
.L16:
	addi	a7,a7,4
	beq	a7,a0,.L17
.L10:
	addi	a5,t4,%lo(DATATEST)
	addi	a6,a5,4
	mv	a4,a7
	j	.L12
.L25:
	li	a5,0
	li	a2,4
.L14:
	add	a4,a1,a5
	lbu	a3,0(a4)
	add	a4,a7,a5
	sb	a3,0(a4)
	addi	a5,a5,1
	bne	a5,a2,.L14
	lui	a5,%hi(ok)
	li	a4,1
	sw	a4,%lo(ok)(a5)
	ret
.L17:
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
	li	a0,1000
	call	HAL_Delay
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
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
	addi	a2,a0,4
	li	a5,0
	lui	a7,%hi(CHECK)
	li	a6,4
	j	.L29
.L28:
	addi	a5,a5,1
	beq	a5,a6,.L43
.L29:
	add	a3,a1,a5
	add	a4,a2,a5
	lbu	a3,0(a3)
	lbu	a4,0(a4)
	beq	a3,a4,.L28
	sb	zero,%lo(CHECK)(a7)
	j	.L28
.L43:
	lui	a5,%hi(CHECK)
	lbu	a5,%lo(CHECK)(a5)
	li	a4,1
	beq	a5,a4,.L30
	bne	a5,zero,.L31
	lui	a5,%hi(CHECK)
	sb	a4,%lo(CHECK)(a5)
.L31:
	addi	a2,a0,8
	li	a5,0
	lui	a6,%hi(CHECK)
	li	a0,4
	j	.L33
.L32:
	addi	a5,a5,1
	beq	a5,a0,.L44
.L33:
	add	a3,a1,a5
	add	a4,a2,a5
	lbu	a3,0(a3)
	lbu	a4,0(a4)
	beq	a3,a4,.L32
	sb	zero,%lo(CHECK)(a6)
	j	.L32
.L44:
	lui	a5,%hi(CHECK)
	lbu	a5,%lo(CHECK)(a5)
	li	a4,1
	beq	a5,a4,.L30
	bne	a5,zero,.L36
	lui	a5,%hi(CHECK)
	li	a4,1
	sb	a4,%lo(CHECK)(a5)
.L36:
	lui	a5,%hi(ok)
	lw	a5,%lo(ok)(a5)
	beq	a5,zero,.L45
	ret
.L30:
	sb	zero,0(a2)
	sb	zero,1(a2)
	sb	zero,2(a2)
	sb	zero,3(a2)
	lui	a5,%hi(ok)
	li	a4,1
	sw	a4,%lo(ok)(a5)
	ret
.L45:
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
	li	a0,1000
	call	HAL_Delay
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	QUET_THE3, .-QUET_THE3
	.align	1
	.globl	QUET_THE4
	.type	QUET_THE4, @function
QUET_THE4:
	li	a5,0
	lui	a6,%hi(CHECK)
	li	a2,4
	j	.L48
.L47:
	addi	a5,a5,1
	beq	a5,a2,.L50
.L48:
	add	a3,a1,a5
	add	a4,a0,a5
	lbu	a3,0(a3)
	lbu	a4,0(a4)
	beq	a3,a4,.L47
	sb	zero,%lo(CHECK)(a6)
	j	.L47
.L50:
	lui	a5,%hi(CHECK)
	lbu	a0,%lo(CHECK)(a5)
	ret
	.size	QUET_THE4, .-QUET_THE4
	.align	1
	.globl	Buzzer
	.type	Buzzer, @function
Buzzer:
	ble	a1,zero,.L56
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	sd	s1,24(sp)
	sd	s2,16(sp)
	sd	s3,8(sp)
	sd	s4,0(sp)
	mv	s4,a1
	li	s3,0
	li	s2,4096
	addi	s2,s2,-2048
	li	s1,1073811456
	addi	s1,s1,-1024
	sext.w	s0,a0
.L53:
	li	a2,0
	mv	a1,s2
	mv	a0,s1
	call	HAL_GPIO_WritePin
	mv	a0,s0
	call	HAL_Delay
	li	a2,1
	mv	a1,s2
	mv	a0,s1
	call	HAL_GPIO_WritePin
	mv	a0,s0
	call	HAL_Delay
	addiw	a5,s3,1
	andi	s3,a5,0xff
	blt	s3,s4,.L53
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
	addi	sp,sp,-16
	sd	ra,8(sp)
	li	a2,1
	li	a1,32
	li	a0,1073811456
	addi	a0,a0,-1024
	call	HAL_GPIO_WritePin
	li	a0,8192
	addi	a0,a0,1808
	call	HAL_Delay
	li	a2,0
	li	a1,32
	li	a0,1073811456
	addi	a0,a0,-1024
	call	HAL_GPIO_WritePin
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
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
	addi	sp,sp,-16
	sd	ra,8(sp)
	lui	a0,%hi(TagType)
	addi	a0,a0,%lo(TagType)
	call	MFRC522_Check
	bne	a0,zero,.L65
.L61:
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
.L65:
	lui	a0,%hi(UID)
	addi	a0,a0,%lo(UID)
	call	MFRC522_ReadCardSerial
	beq	a0,zero,.L61
	lui	a1,%hi(UID)
	addi	a1,a1,%lo(UID)
	lui	a0,%hi(.LANCHOR0)
	addi	a0,a0,%lo(.LANCHOR0)
	call	QUET_THE
	andi	a0,a0,0xff
	lui	a5,%hi(tt_1)
	sb	a0,%lo(tt_1)(a5)
	li	a5,1
	beq	a0,a5,.L66
	call	lcd_clear_display
	li	a0,10
	call	HAL_Delay
	li	a1,0
	li	a0,1
	call	lcd_goto_XY
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	call	lcd_send_string
	li	a1,1
	li	a0,200
	call	Buzzer
	lui	a5,%hi(CHECK)
	li	a4,1
	sb	a4,%lo(CHECK)(a5)
	li	a0,1000
	call	HAL_Delay
	j	.L61
.L66:
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
	call	lcd_send_string
	li	a1,3
	li	a0,70
	call	Buzzer
	call	Mocua
	j	.L61
	.size	Kiemtrarfid, .-Kiemtrarfid
	.align	1
	.globl	Checkadmin
	.type	Checkadmin, @function
Checkadmin:
	addi	sp,sp,-16
	sd	ra,8(sp)
	lui	a0,%hi(TagType)
	addi	a0,a0,%lo(TagType)
	call	MFRC522_Check
	bne	a0,zero,.L71
.L67:
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
.L71:
	lui	a0,%hi(UID)
	addi	a0,a0,%lo(UID)
	call	MFRC522_ReadCardSerial
	beq	a0,zero,.L67
	lui	a1,%hi(UID)
	addi	a1,a1,%lo(UID)
	lui	a0,%hi(.LANCHOR0)
	addi	a0,a0,%lo(.LANCHOR0)
	call	QUET_THE4
	andi	a0,a0,0xff
	lui	a5,%hi(tt_1)
	sb	a0,%lo(tt_1)(a5)
	li	a5,1
	bne	a0,a5,.L69
	lui	a5,%hi(ok)
	li	a4,1
	sw	a4,%lo(ok)(a5)
	j	.L67
.L69:
	call	lcd_clear_display
	li	a0,10
	call	HAL_Delay
	li	a1,0
	li	a0,1
	call	lcd_goto_XY
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	call	lcd_send_string
	li	a1,1
	li	a0,200
	call	Buzzer
	lui	a5,%hi(CHECK)
	li	a4,1
	sb	a4,%lo(CHECK)(a5)
	li	a0,1000
	call	HAL_Delay
	j	.L67
	.size	Checkadmin, .-Checkadmin
	.align	1
	.globl	THEM_THE
	.type	THEM_THE, @function
THEM_THE:
	addi	sp,sp,-16
	sd	ra,8(sp)
	lui	a0,%hi(TagType)
	addi	a0,a0,%lo(TagType)
	call	MFRC522_Check
	bne	a0,zero,.L75
.L72:
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
.L75:
	lui	a0,%hi(UID)
	addi	a0,a0,%lo(UID)
	call	MFRC522_ReadCardSerial
	beq	a0,zero,.L72
	lui	a1,%hi(UID)
	addi	a1,a1,%lo(UID)
	lui	a0,%hi(.LANCHOR0)
	addi	a0,a0,%lo(.LANCHOR0)
	call	QUET_THE2
	j	.L72
	.size	THEM_THE, .-THEM_THE
	.align	1
	.globl	XOA_THE
	.type	XOA_THE, @function
XOA_THE:
	addi	sp,sp,-16
	sd	ra,8(sp)
	lui	a0,%hi(TagType)
	addi	a0,a0,%lo(TagType)
	call	MFRC522_Check
	bne	a0,zero,.L79
.L76:
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
.L79:
	lui	a0,%hi(UID)
	addi	a0,a0,%lo(UID)
	call	MFRC522_ReadCardSerial
	beq	a0,zero,.L76
	lui	a1,%hi(UID)
	addi	a1,a1,%lo(UID)
	lui	a0,%hi(.LANCHOR0)
	addi	a0,a0,%lo(.LANCHOR0)
	call	QUET_THE3
	j	.L76
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
