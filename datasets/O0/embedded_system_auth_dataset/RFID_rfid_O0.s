	.file	"rfid.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	DATATEST
	.section	.sbss,"aw",@nobits
	.align	3
	.type	DATATEST, @object
	.size	DATATEST, 4
DATATEST:
	.zero	4
	.globl	DATA_RIGHT
	.data
	.align	3
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
	.globl	tt_1
	.section	.sbss
	.type	tt_1, @object
	.size	tt_1, 1
tt_1:
	.zero	1
	.globl	CHECK
	.section	.sdata,"aw"
	.type	CHECK, @object
	.size	CHECK, 1
CHECK:
	.byte	1
	.globl	DOOR
	.section	.sbss
	.type	DOOR, @object
	.size	DOOR, 1
DOOR:
	.zero	1
	.globl	UID
	.align	3
	.type	UID, @object
	.size	UID, 4
UID:
	.zero	4
	.globl	TagType
	.type	TagType, @object
	.size	TagType, 1
TagType:
	.zero	1
	.text
	.align	1
	.globl	QUET_THE
	.type	QUET_THE, @function
QUET_THE:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	sw	zero,-20(s0)
	j	.L2
.L10:
	sw	zero,-24(s0)
	j	.L3
.L6:
	lw	a5,-24(s0)
	ld	a4,-48(s0)
	add	a5,a4,a5
	lbu	a3,0(a5)
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a4,a4,a5
	lw	a5,-24(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a3
	bne	a4,a5,.L4
	lui	a5,%hi(CHECK)
	lbu	a4,%lo(CHECK)(a5)
	lui	a5,%hi(CHECK)
	sb	a4,%lo(CHECK)(a5)
	j	.L5
.L4:
	lui	a5,%hi(CHECK)
	sb	zero,%lo(CHECK)(a5)
.L5:
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
.L3:
	lw	a5,-24(s0)
	sext.w	a4,a5
	li	a5,3
	ble	a4,a5,.L6
	lui	a5,%hi(CHECK)
	lbu	a5,%lo(CHECK)(a5)
	mv	a4,a5
	li	a5,1
	beq	a4,a5,.L12
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,1
	bgt	a4,a5,.L9
	lui	a5,%hi(CHECK)
	lbu	a5,%lo(CHECK)(a5)
	bne	a5,zero,.L9
	lui	a5,%hi(CHECK)
	li	a4,1
	sb	a4,%lo(CHECK)(a5)
.L9:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L2:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,2
	ble	a4,a5,.L10
	j	.L8
.L12:
	nop
.L8:
	lui	a5,%hi(CHECK)
	lbu	a5,%lo(CHECK)(a5)
	sext.w	a5,a5
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	QUET_THE, .-QUET_THE
	.section	.rodata
	.align	3
.LC0:
	.string	" HET DUNG LUONG"
	.text
	.align	1
	.globl	QUET_THE2
	.type	QUET_THE2, @function
QUET_THE2:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	sw	zero,-20(s0)
	j	.L14
.L24:
	sw	zero,-24(s0)
	j	.L15
.L18:
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a4,a4,a5
	lw	a5,-24(s0)
	add	a5,a4,a5
	lbu	a3,0(a5)
	lui	a5,%hi(DATATEST)
	lw	a4,-24(s0)
	addi	a5,a5,%lo(DATATEST)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a3
	bne	a4,a5,.L16
	lui	a5,%hi(CHECK)
	lbu	a4,%lo(CHECK)(a5)
	lui	a5,%hi(CHECK)
	sb	a4,%lo(CHECK)(a5)
	j	.L17
.L16:
	lui	a5,%hi(CHECK)
	sb	zero,%lo(CHECK)(a5)
.L17:
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
.L15:
	lw	a5,-24(s0)
	sext.w	a4,a5
	li	a5,3
	ble	a4,a5,.L18
	lui	a5,%hi(CHECK)
	lbu	a5,%lo(CHECK)(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L19
	sw	zero,-28(s0)
	j	.L20
.L21:
	lw	a5,-28(s0)
	ld	a4,-48(s0)
	add	a5,a4,a5
	lw	a4,-20(s0)
	slli	a4,a4,2
	ld	a3,-40(s0)
	add	a3,a3,a4
	lbu	a4,0(a5)
	lw	a5,-28(s0)
	add	a5,a3,a5
	sb	a4,0(a5)
	lw	a5,-28(s0)
	addiw	a5,a5,1
	sw	a5,-28(s0)
.L20:
	lw	a5,-28(s0)
	sext.w	a4,a5
	li	a5,3
	ble	a4,a5,.L21
	lui	a5,%hi(ok)
	li	a4,1
	sw	a4,%lo(ok)(a5)
	j	.L22
.L19:
	lui	a5,%hi(CHECK)
	lbu	a5,%lo(CHECK)(a5)
	bne	a5,zero,.L23
	lui	a5,%hi(CHECK)
	li	a4,1
	sb	a4,%lo(CHECK)(a5)
.L23:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L14:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,2
	ble	a4,a5,.L24
.L22:
	lui	a5,%hi(ok)
	lw	a5,%lo(ok)(a5)
	bne	a5,zero,.L26
	call	lcd_clear_display
	li	a0,10
	call	HAL_Delay
	li	a1,0
	li	a0,1
	call	lcd_goto_XY
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	lcd_send_string
	li	a0,1000
	call	HAL_Delay
.L26:
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	QUET_THE2, .-QUET_THE2
	.section	.rodata
	.align	3
.LC1:
	.string	"KHONG CO THE NAY"
	.text
	.align	1
	.globl	QUET_THE3
	.type	QUET_THE3, @function
QUET_THE3:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	li	a5,1
	sw	a5,-20(s0)
	j	.L28
.L38:
	sw	zero,-24(s0)
	j	.L29
.L32:
	lw	a5,-24(s0)
	ld	a4,-48(s0)
	add	a5,a4,a5
	lbu	a3,0(a5)
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a4,a4,a5
	lw	a5,-24(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a3
	bne	a4,a5,.L30
	lui	a5,%hi(CHECK)
	lbu	a4,%lo(CHECK)(a5)
	lui	a5,%hi(CHECK)
	sb	a4,%lo(CHECK)(a5)
	j	.L31
.L30:
	lui	a5,%hi(CHECK)
	sb	zero,%lo(CHECK)(a5)
.L31:
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
.L29:
	lw	a5,-24(s0)
	sext.w	a4,a5
	li	a5,3
	ble	a4,a5,.L32
	lui	a5,%hi(CHECK)
	lbu	a5,%lo(CHECK)(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L33
	sw	zero,-28(s0)
	j	.L34
.L35:
	lw	a5,-20(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a4,a4,a5
	lw	a5,-28(s0)
	add	a5,a4,a5
	sb	zero,0(a5)
	lw	a5,-28(s0)
	addiw	a5,a5,1
	sw	a5,-28(s0)
.L34:
	lw	a5,-28(s0)
	sext.w	a4,a5
	li	a5,3
	ble	a4,a5,.L35
	lui	a5,%hi(ok)
	li	a4,1
	sw	a4,%lo(ok)(a5)
	j	.L36
.L33:
	lui	a5,%hi(CHECK)
	lbu	a5,%lo(CHECK)(a5)
	bne	a5,zero,.L37
	lui	a5,%hi(CHECK)
	li	a4,1
	sb	a4,%lo(CHECK)(a5)
.L37:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L28:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,2
	ble	a4,a5,.L38
.L36:
	lui	a5,%hi(ok)
	lw	a5,%lo(ok)(a5)
	bne	a5,zero,.L40
	call	lcd_clear_display
	li	a0,10
	call	HAL_Delay
	li	a1,0
	li	a0,1
	call	lcd_goto_XY
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	lcd_send_string
	li	a0,1000
	call	HAL_Delay
.L40:
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	QUET_THE3, .-QUET_THE3
	.align	1
	.globl	QUET_THE4
	.type	QUET_THE4, @function
QUET_THE4:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	sw	zero,-20(s0)
	j	.L42
.L45:
	lw	a5,-20(s0)
	ld	a4,-48(s0)
	add	a5,a4,a5
	lbu	a3,0(a5)
	ld	a4,-40(s0)
	lw	a5,-20(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a3
	bne	a4,a5,.L43
	lui	a5,%hi(CHECK)
	lbu	a4,%lo(CHECK)(a5)
	lui	a5,%hi(CHECK)
	sb	a4,%lo(CHECK)(a5)
	j	.L44
.L43:
	lui	a5,%hi(CHECK)
	sb	zero,%lo(CHECK)(a5)
.L44:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L42:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,3
	ble	a4,a5,.L45
	lui	a5,%hi(CHECK)
	lbu	a5,%lo(CHECK)(a5)
	sext.w	a5,a5
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	QUET_THE4, .-QUET_THE4
	.align	1
	.globl	Buzzer
	.type	Buzzer, @function
Buzzer:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	mv	a5,a0
	mv	a4,a1
	sw	a5,-36(s0)
	mv	a5,a4
	sw	a5,-40(s0)
	sb	zero,-17(s0)
	j	.L48
.L49:
	li	a2,0
	li	a5,4096
	addi	a1,a5,-2048
	li	a5,1073811456
	addi	a0,a5,-1024
	call	HAL_GPIO_WritePin
	lw	a5,-36(s0)
	mv	a0,a5
	call	HAL_Delay
	li	a2,1
	li	a5,4096
	addi	a1,a5,-2048
	li	a5,1073811456
	addi	a0,a5,-1024
	call	HAL_GPIO_WritePin
	lw	a5,-36(s0)
	mv	a0,a5
	call	HAL_Delay
	lbu	a5,-17(s0)
	addiw	a5,a5,1
	sb	a5,-17(s0)
.L48:
	lbu	a5,-17(s0)
	sext.w	a4,a5
	lw	a5,-40(s0)
	sext.w	a5,a5
	bgt	a5,a4,.L49
	nop
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	Buzzer, .-Buzzer
	.align	1
	.globl	Mocua
	.type	Mocua, @function
Mocua:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	li	a2,1
	li	a1,32
	li	a5,1073811456
	addi	a0,a5,-1024
	call	HAL_GPIO_WritePin
	li	a5,8192
	addi	a0,a5,1808
	call	HAL_Delay
	li	a2,0
	li	a1,32
	li	a5,1073811456
	addi	a0,a5,-1024
	call	HAL_GPIO_WritePin
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	Mocua, .-Mocua
	.section	.rodata
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
	sd	s0,0(sp)
	addi	s0,sp,16
	lui	a5,%hi(TagType)
	addi	a0,a5,%lo(TagType)
	call	MFRC522_Check
	mv	a5,a0
	beq	a5,zero,.L54
	lui	a5,%hi(UID)
	addi	a0,a5,%lo(UID)
	call	MFRC522_ReadCardSerial
	mv	a5,a0
	beq	a5,zero,.L54
	lui	a5,%hi(UID)
	addi	a1,a5,%lo(UID)
	lui	a5,%hi(DATA_RIGHT)
	addi	a0,a5,%lo(DATA_RIGHT)
	call	QUET_THE
	mv	a5,a0
	andi	a4,a5,0xff
	lui	a5,%hi(tt_1)
	sb	a4,%lo(tt_1)(a5)
	lui	a5,%hi(tt_1)
	lbu	a5,%lo(tt_1)(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L53
	call	lcd_clear_display
	li	a0,10
	call	HAL_Delay
	li	a1,3
	li	a0,1
	call	lcd_goto_XY
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	lcd_send_string
	li	a1,1
	li	a0,2
	call	lcd_goto_XY
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	lcd_send_string
	li	a1,3
	li	a0,70
	call	Buzzer
	call	Mocua
	j	.L54
.L53:
	call	lcd_clear_display
	li	a0,10
	call	HAL_Delay
	li	a1,0
	li	a0,1
	call	lcd_goto_XY
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	lcd_send_string
	li	a1,1
	li	a0,200
	call	Buzzer
	lui	a5,%hi(CHECK)
	li	a4,1
	sb	a4,%lo(CHECK)(a5)
	li	a0,1000
	call	HAL_Delay
.L54:
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	Kiemtrarfid, .-Kiemtrarfid
	.align	1
	.globl	Checkadmin
	.type	Checkadmin, @function
Checkadmin:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	lui	a5,%hi(TagType)
	addi	a0,a5,%lo(TagType)
	call	MFRC522_Check
	mv	a5,a0
	beq	a5,zero,.L58
	lui	a5,%hi(UID)
	addi	a0,a5,%lo(UID)
	call	MFRC522_ReadCardSerial
	mv	a5,a0
	beq	a5,zero,.L58
	lui	a5,%hi(UID)
	addi	a1,a5,%lo(UID)
	lui	a5,%hi(DATA_RIGHT)
	addi	a0,a5,%lo(DATA_RIGHT)
	call	QUET_THE4
	mv	a5,a0
	andi	a4,a5,0xff
	lui	a5,%hi(tt_1)
	sb	a4,%lo(tt_1)(a5)
	lui	a5,%hi(tt_1)
	lbu	a5,%lo(tt_1)(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L57
	lui	a5,%hi(ok)
	li	a4,1
	sw	a4,%lo(ok)(a5)
	j	.L58
.L57:
	call	lcd_clear_display
	li	a0,10
	call	HAL_Delay
	li	a1,0
	li	a0,1
	call	lcd_goto_XY
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	lcd_send_string
	li	a1,1
	li	a0,200
	call	Buzzer
	lui	a5,%hi(CHECK)
	li	a4,1
	sb	a4,%lo(CHECK)(a5)
	li	a0,1000
	call	HAL_Delay
.L58:
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	Checkadmin, .-Checkadmin
	.align	1
	.globl	THEM_THE
	.type	THEM_THE, @function
THEM_THE:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	lui	a5,%hi(TagType)
	addi	a0,a5,%lo(TagType)
	call	MFRC522_Check
	mv	a5,a0
	beq	a5,zero,.L61
	lui	a5,%hi(UID)
	addi	a0,a5,%lo(UID)
	call	MFRC522_ReadCardSerial
	mv	a5,a0
	beq	a5,zero,.L61
	lui	a5,%hi(UID)
	addi	a1,a5,%lo(UID)
	lui	a5,%hi(DATA_RIGHT)
	addi	a0,a5,%lo(DATA_RIGHT)
	call	QUET_THE2
.L61:
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	THEM_THE, .-THEM_THE
	.align	1
	.globl	XOA_THE
	.type	XOA_THE, @function
XOA_THE:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	lui	a5,%hi(TagType)
	addi	a0,a5,%lo(TagType)
	call	MFRC522_Check
	mv	a5,a0
	beq	a5,zero,.L64
	lui	a5,%hi(UID)
	addi	a0,a5,%lo(UID)
	call	MFRC522_ReadCardSerial
	mv	a5,a0
	beq	a5,zero,.L64
	lui	a5,%hi(UID)
	addi	a1,a5,%lo(UID)
	lui	a5,%hi(DATA_RIGHT)
	addi	a0,a5,%lo(DATA_RIGHT)
	call	QUET_THE3
.L64:
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	XOA_THE, .-XOA_THE
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
