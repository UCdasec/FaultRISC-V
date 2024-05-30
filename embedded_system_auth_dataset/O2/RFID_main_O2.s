	.file	"main.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	SystemClock_Config
	.type	SystemClock_Config, @function
SystemClock_Config:
	li	a5,1
	addi	sp,sp,-80
	slli	a5,a5,36
	addi	a5,a5,1
	li	a4,2
	addi	a0,sp,24
	sd	ra,72(sp)
	sw	zero,28(sp)
	sw	zero,32(sp)
	sw	zero,36(sp)
	sw	zero,48(sp)
	sw	zero,52(sp)
	sw	zero,56(sp)
	sw	zero,60(sp)
	sd	zero,0(sp)
	sd	zero,8(sp)
	sw	zero,16(sp)
	sw	a4,24(sp)
	sd	a5,40(sp)
	call	HAL_RCC_OscConfig
	beq	a0,zero,.L2
 #APP
# 71 "../../../CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	cpsid i
# 0 "" 2
 #NO_APP
.L3:
	j	.L3
.L2:
	li	a5,1
	slli	a5,a5,42
	li	a4,15
	sd	a5,8(sp)
	li	a1,0
	li	a5,1792
	mv	a0,sp
	sd	a4,0(sp)
	sw	a5,16(sp)
	call	HAL_RCC_ClockConfig
	beq	a0,zero,.L1
 #APP
# 71 "../../../CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	cpsid i
# 0 "" 2
 #NO_APP
.L5:
	j	.L5
.L1:
	ld	ra,72(sp)
	addi	sp,sp,80
	jr	ra
	.size	SystemClock_Config, .-SystemClock_Config
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-128
	sd	ra,120(sp)
	sd	s0,112(sp)
	sd	s1,104(sp)
	call	HAL_Init
	call	SystemClock_Config
	li	a5,1073876992
	sd	zero,16(sp)
	sd	zero,24(sp)
	lw	a4,24(a5)
	li	a1,4096
	li	a0,1073811456
	ori	a4,a4,32
	sw	a4,24(a5)
	lw	a4,24(a5)
	li	a2,0
	addi	a1,a1,-240
	andi	a4,a4,32
	sw	a4,4(sp)
	lw	a4,4(sp)
	lw	a4,24(a5)
	addi	a0,a0,-2048
	li	s1,1
	ori	a4,a4,4
	sw	a4,24(a5)
	lw	a4,24(a5)
	li	s0,1
	slli	s0,s0,33
	andi	a4,a4,4
	sw	a4,8(sp)
	lw	a4,8(sp)
	lw	a4,24(a5)
	addi	s0,s0,2
	ori	a4,a4,8
	sw	a4,24(a5)
	lw	a5,24(a5)
	andi	a5,a5,8
	sw	a5,12(sp)
	lw	a5,12(sp)
	call	HAL_GPIO_WritePin
	li	a1,4096
	li	a0,1073811456
	li	a2,0
	addi	a1,a1,-2016
	addi	a0,a0,-1024
	call	HAL_GPIO_WritePin
	li	a0,1073811456
	li	a5,7
	addi	a1,sp,16
	addi	a0,a0,-2048
	sd	a5,16(sp)
	sw	s1,24(sp)
	call	HAL_GPIO_Init
	li	a5,268435456
	addi	a5,a5,241
	li	a0,1073811456
	slli	a5,a5,4
	addi	a1,sp,16
	addi	a0,a0,-2048
	sd	a5,16(sp)
	sd	s0,24(sp)
	call	HAL_GPIO_Init
	li	a4,2097152
	li	a5,1
	addi	a4,a4,1
	slli	a5,a5,33
	li	a0,1073811456
	slli	a4,a4,11
	addi	a5,a5,1
	addi	a1,sp,16
	addi	a0,a0,-1024
	sd	a4,16(sp)
	sd	a5,24(sp)
	call	HAL_GPIO_Init
	li	a0,1073811456
	li	a5,61440
	addi	a1,sp,16
	addi	a0,a0,-1024
	sd	a5,16(sp)
	sw	s1,24(sp)
	call	HAL_GPIO_Init
	li	a5,1
	slli	a5,a5,32
	li	a0,1073811456
	addi	a5,a5,32
	addi	a0,a0,-1024
	addi	a1,sp,16
	sd	a5,16(sp)
	sd	s0,24(sp)
	call	HAL_GPIO_Init
	lui	a0,%hi(.LANCHOR0)
	li	a3,1073762304
	li	a4,98304
	li	a5,1
	addi	s0,a0,%lo(.LANCHOR0)
	addi	a3,a3,1024
	addi	a4,a4,1696
	slli	a5,a5,46
	addi	a0,a0,%lo(.LANCHOR0)
	sd	a3,0(s0)
	sd	a4,8(s0)
	sd	a5,16(s0)
	sd	zero,24(s0)
	sd	zero,32(s0)
	call	HAL_I2C_Init
	beq	a0,zero,.L9
 #APP
# 71 "../../../CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	cpsid i
# 0 "" 2
 #NO_APP
.L10:
	j	.L10
.L9:
	li	a5,1
	slli	a5,a5,41
	li	a4,1073819648
	sd	a4,112(s0)
	sd	a5,136(s0)
	li	a4,260
	li	a5,10
	addi	a0,s0,112
	sd	a4,120(s0)
	sd	zero,128(s0)
	sd	zero,144(s0)
	sd	zero,152(s0)
	sw	a5,160(s0)
	call	HAL_SPI_Init
	bne	a0,zero,.L46
	sd	s2,96(sp)
	sd	s3,88(sp)
	sd	s4,80(sp)
	sd	s5,72(sp)
	sd	s6,64(sp)
	sd	s7,56(sp)
	sd	s8,48(sp)
	sd	s9,40(sp)
	sd	s10,32(sp)
	li	s3,1073811456
	call	lcd_init
	call	MFRC522_Init
	lui	s2,%hi(gtmenu)
	lui	s0,%hi(demtong)
	lui	s4,%hi(menupage)
	lui	s5,%hi(gtlen)
	lui	s7,%hi(gtxuong)
	lui	s9,%hi(demmenu)
	lui	s6,%hi(count)
	addi	s3,s3,-2048
	li	s1,1
	li	s8,150
	li	s10,3
.L16:
	li	a1,2
	mv	a0,s3
	call	HAL_GPIO_ReadPin
	sext.w	a0,a0
	sw	a0,%lo(gtmenu)(s2)
	bne	a0,zero,.L13
.L49:
	lw	a5,%lo(menupage)(s4)
	sw	s1,%lo(demtong)(s0)
	beq	a5,zero,.L47
.L17:
	beq	a5,s1,.L26
.L45:
	lw	a5,%lo(gtmenu)(s2)
.L27:
	beq	a5,s1,.L48
.L38:
	lw	a5,%lo(count)(s6)
	bne	a5,s8,.L16
	li	a1,2
	mv	a0,s3
	sw	zero,%lo(demtong)(s0)
	sw	zero,%lo(count)(s6)
	sw	zero,%lo(menupage)(s4)
	call	HAL_GPIO_ReadPin
	sext.w	a0,a0
	sw	a0,%lo(gtmenu)(s2)
	beq	a0,zero,.L49
.L13:
	lw	a5,%lo(demtong)(s0)
	bne	a5,zero,.L15
	call	Kiemtrarfid
	call	manhinhchinh
	lw	a5,%lo(demtong)(s0)
.L15:
	bne	a5,s1,.L16
	lw	a5,%lo(menupage)(s4)
	bne	a5,zero,.L17
.L47:
	call	menu_tong
	li	a1,1
	mv	a0,s3
	call	HAL_GPIO_ReadPin
	mv	a5,a0
	li	a1,4
	mv	a0,s3
	sw	a5,%lo(gtlen)(s5)
	call	HAL_GPIO_ReadPin
	mv	a5,a0
	li	a1,2
	mv	a0,s3
	sw	a5,%lo(gtxuong)(s7)
	call	HAL_GPIO_ReadPin
	lw	a5,%lo(gtlen)(s5)
	sw	a0,%lo(gtmenu)(s2)
	bne	a5,zero,.L18
	lw	a5,%lo(demmenu)(s9)
	bne	a5,zero,.L19
	sw	s1,%lo(demmenu)(s9)
.L20:
	call	menu_tong
	li	a0,200
	call	HAL_Delay
.L18:
	lw	a5,%lo(gtxuong)(s7)
	bne	a5,zero,.L21
	lw	a5,%lo(demmenu)(s9)
	bne	a5,zero,.L22
	sw	s1,%lo(demmenu)(s9)
.L23:
	call	menu_tong
	li	a0,200
	call	HAL_Delay
.L21:
	lw	a5,%lo(gtmenu)(s2)
	beq	a5,zero,.L24
.L44:
	lw	a5,%lo(menupage)(s4)
	bne	a5,s1,.L45
.L26:
	call	menu_caidat
	li	a1,1
	mv	a0,s3
	call	HAL_GPIO_ReadPin
	mv	a5,a0
	li	a1,4
	mv	a0,s3
	sw	a5,%lo(gtlen)(s5)
	call	HAL_GPIO_ReadPin
	mv	a5,a0
	li	a1,2
	mv	a0,s3
	sw	a5,%lo(gtxuong)(s7)
	call	HAL_GPIO_ReadPin
	lw	a5,%lo(gtlen)(s5)
	sw	a0,%lo(gtmenu)(s2)
	bne	a5,zero,.L28
	lw	a5,%lo(demmenu)(s9)
	bne	a5,zero,.L29
	sw	s10,%lo(demmenu)(s9)
.L30:
	call	menu_caidat
	li	a0,200
	call	HAL_Delay
.L28:
	lw	a5,%lo(gtxuong)(s7)
	bne	a5,zero,.L33
	lw	a5,%lo(demmenu)(s9)
	bne	a5,zero,.L34
	sw	s1,%lo(demmenu)(s9)
.L35:
	call	menu_caidat
	li	a0,200
	call	HAL_Delay
.L33:
	lw	a5,%lo(gtmenu)(s2)
	bne	a5,zero,.L27
	li	a0,50
	call	HAL_Delay
	lw	a5,%lo(gtmenu)(s2)
	bne	a5,zero,.L27
	call	chon_caidat
	j	.L45
.L46:
 #APP
# 71 "../../../CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	cpsid i
# 0 "" 2
 #NO_APP
.L12:
	j	.L12
.L48:
	lw	a5,%lo(gtlen)(s5)
	bne	a5,s1,.L38
	lw	a5,%lo(gtxuong)(s7)
	bne	a5,s1,.L38
	lw	a5,%lo(count)(s6)
	li	a0,20
	addiw	a5,a5,1
	sw	a5,%lo(count)(s6)
	call	HAL_Delay
	j	.L38
.L24:
	li	a0,50
	call	HAL_Delay
	lw	a5,%lo(gtmenu)(s2)
	bne	a5,zero,.L44
	call	chon_tong
	j	.L44
.L19:
	bne	a5,s1,.L20
	sw	zero,%lo(demmenu)(s9)
	j	.L20
.L22:
	bne	a5,s1,.L23
	sw	zero,%lo(demmenu)(s9)
	j	.L23
.L34:
	beq	a5,s1,.L50
	li	a4,2
	beq	a5,a4,.L51
	bne	a5,s10,.L35
	sw	zero,%lo(demmenu)(s9)
	j	.L35
.L29:
	beq	a5,s1,.L52
	li	a4,2
	beq	a5,a4,.L53
	bne	a5,s10,.L30
	sw	a4,%lo(demmenu)(s9)
	j	.L30
.L50:
	li	a5,2
	sw	a5,%lo(demmenu)(s9)
	j	.L35
.L52:
	sw	zero,%lo(demmenu)(s9)
	j	.L30
.L51:
	sw	s10,%lo(demmenu)(s9)
	j	.L35
.L53:
	sw	s1,%lo(demmenu)(s9)
	j	.L30
	.size	main, .-main
	.text
	.align	1
	.globl	Error_Handler
	.type	Error_Handler, @function
Error_Handler:
 #APP
# 71 "../../../CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	cpsid i
# 0 "" 2
 #NO_APP
.L55:
	j	.L55
	.size	Error_Handler, .-Error_Handler
	.globl	hspi1
	.globl	hi2c1
	.bss
	.align	3
	.set	.LANCHOR0,. + 0
	.type	hi2c1, @object
	.size	hi2c1, 112
hi2c1:
	.zero	112
	.type	hspi1, @object
	.size	hspi1, 136
hspi1:
	.zero	136
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
