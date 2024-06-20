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
	addi	sp,sp,-80
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
	li	a5,2
	sw	a5,24(sp)
	li	a5,1
	sw	a5,40(sp)
	li	a5,16
	sw	a5,44(sp)
	addi	a0,sp,24
	call	HAL_RCC_OscConfig
	bne	a0,zero,.L7
	li	a5,15
	sw	a5,0(sp)
	sw	zero,4(sp)
	sw	zero,8(sp)
	li	a5,1024
	sw	a5,12(sp)
	li	a5,1792
	sw	a5,16(sp)
	li	a1,0
	mv	a0,sp
	call	HAL_RCC_ClockConfig
	bne	a0,zero,.L8
	ld	ra,72(sp)
	addi	sp,sp,80
	jr	ra
.L7:
 #APP
# 71 "../../../CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	cpsid i
# 0 "" 2
 #NO_APP
.L3:
	j	.L3
.L8:
 #APP
# 71 "../../../CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	cpsid i
# 0 "" 2
 #NO_APP
.L5:
	j	.L5
	.size	SystemClock_Config, .-SystemClock_Config
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-144
	sd	ra,136(sp)
	sd	s0,128(sp)
	sd	s1,120(sp)
	call	HAL_Init
	call	SystemClock_Config
	sd	zero,16(sp)
	sd	zero,24(sp)
	li	a5,1073876992
	lw	a4,24(a5)
	ori	a4,a4,32
	sw	a4,24(a5)
	lw	a4,24(a5)
	andi	a4,a4,32
	sw	a4,4(sp)
	lw	a4,4(sp)
	lw	a4,24(a5)
	ori	a4,a4,4
	sw	a4,24(a5)
	lw	a4,24(a5)
	andi	a4,a4,4
	sw	a4,8(sp)
	lw	a4,8(sp)
	lw	a4,24(a5)
	ori	a4,a4,8
	sw	a4,24(a5)
	lw	a5,24(a5)
	andi	a5,a5,8
	sw	a5,12(sp)
	lw	a5,12(sp)
	li	a2,0
	li	a1,4096
	addi	a1,a1,-240
	li	a0,1073811456
	addi	a0,a0,-2048
	call	HAL_GPIO_WritePin
	li	a2,0
	li	a1,4096
	addi	a1,a1,-2016
	li	a0,1073811456
	addi	a0,a0,-1024
	call	HAL_GPIO_WritePin
	li	a5,7
	sw	a5,16(sp)
	sw	zero,20(sp)
	li	s0,1
	sw	s0,24(sp)
	addi	a1,sp,16
	li	a0,1073811456
	addi	a0,a0,-2048
	call	HAL_GPIO_Init
	li	a5,4096
	addi	a5,a5,-240
	sw	a5,16(sp)
	sw	s0,20(sp)
	li	s1,2
	sw	s1,24(sp)
	sw	s1,28(sp)
	addi	a1,sp,16
	li	a0,1073811456
	addi	a0,a0,-2048
	call	HAL_GPIO_Init
	li	a5,4096
	addi	a5,a5,-2048
	sw	a5,16(sp)
	sw	s0,20(sp)
	sw	s0,24(sp)
	sw	s1,28(sp)
	addi	a1,sp,16
	li	a0,1073811456
	addi	a0,a0,-1024
	call	HAL_GPIO_Init
	li	a5,61440
	sw	a5,16(sp)
	sw	zero,20(sp)
	sw	s0,24(sp)
	addi	a1,sp,16
	li	a0,1073811456
	addi	a0,a0,-1024
	call	HAL_GPIO_Init
	li	a5,32
	sw	a5,16(sp)
	sw	s0,20(sp)
	sw	s1,24(sp)
	sw	s1,28(sp)
	addi	a1,sp,16
	li	a0,1073811456
	addi	a0,a0,-1024
	call	HAL_GPIO_Init
	lui	a0,%hi(.LANCHOR0)
	addi	a5,a0,%lo(.LANCHOR0)
	li	a4,1073762304
	addi	a4,a4,1024
	sd	a4,0(a5)
	li	a4,98304
	addi	a4,a4,1696
	sw	a4,8(a5)
	sw	zero,12(a5)
	sw	zero,16(a5)
	li	a4,16384
	sw	a4,20(a5)
	sw	zero,24(a5)
	sw	zero,28(a5)
	sw	zero,32(a5)
	sw	zero,36(a5)
	addi	a0,a0,%lo(.LANCHOR0)
	call	HAL_I2C_Init
	bne	a0,zero,.L42
	lui	a0,%hi(.LANCHOR0)
	addi	a0,a0,%lo(.LANCHOR0)
	li	a5,1073819648
	sd	a5,112(a0)
	li	a5,260
	sw	a5,120(a0)
	sw	zero,124(a0)
	sw	zero,128(a0)
	sw	zero,132(a0)
	sw	zero,136(a0)
	li	a5,512
	sw	a5,140(a0)
	sw	zero,144(a0)
	sw	zero,148(a0)
	sw	zero,152(a0)
	sw	zero,156(a0)
	li	a5,10
	sw	a5,160(a0)
	addi	a0,a0,112
	call	HAL_SPI_Init
	bne	a0,zero,.L43
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
	call	lcd_init
	call	MFRC522_Init
	lui	s0,%hi(demtong)
	li	s1,1
	mv	s4,s1
	lui	s5,%hi(menupage)
	lui	s7,%hi(demmenu)
	li	s10,3
	mv	s9,s10
	j	.L38
.L42:
 #APP
# 71 "../../../CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	cpsid i
# 0 "" 2
 #NO_APP
.L11:
	j	.L11
.L43:
 #APP
# 71 "../../../CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	cpsid i
# 0 "" 2
 #NO_APP
.L13:
	j	.L13
.L47:
	sw	s4,%lo(demtong)(s0)
.L15:
	lw	a5,%lo(menupage)(s5)
	beq	a5,zero,.L44
.L18:
	lw	a5,%lo(menupage)(s5)
	beq	a5,s1,.L45
.L25:
	lw	a5,%lo(gtmenu)(s2)
	beq	a5,s1,.L46
.L36:
	lw	a4,%lo(count)(s6)
	li	a5,150
	bne	a4,a5,.L17
	sw	zero,%lo(demtong)(s0)
	lui	a5,%hi(count)
	sw	zero,%lo(count)(a5)
	sw	zero,%lo(menupage)(s5)
.L38:
	li	s3,1073811456
	addi	s3,s3,-2048
	lui	s2,%hi(gtmenu)
	lui	s8,%hi(gtlen)
	lui	s6,%hi(count)
	j	.L17
.L48:
	call	Kiemtrarfid
	call	manhinhchinh
.L16:
	lw	a5,%lo(demtong)(s0)
	beq	a5,s1,.L15
.L17:
	li	a1,2
	mv	a0,s3
	call	HAL_GPIO_ReadPin
	sext.w	a0,a0
	sw	a0,%lo(gtmenu)(s2)
	beq	a0,zero,.L47
	lw	a5,%lo(demtong)(s0)
	bne	a5,zero,.L16
	j	.L48
.L44:
	call	menu_tong
	mv	a1,s1
	li	a0,1073811456
	addi	a0,a0,-2048
	call	HAL_GPIO_ReadPin
	lui	s11,%hi(gtlen)
	sw	a0,%lo(gtlen)(s11)
	li	a1,4
	li	a0,1073811456
	addi	a0,a0,-2048
	call	HAL_GPIO_ReadPin
	lui	a5,%hi(gtxuong)
	sw	a0,%lo(gtxuong)(a5)
	li	a1,2
	li	a0,1073811456
	addi	a0,a0,-2048
	call	HAL_GPIO_ReadPin
	lui	a5,%hi(gtmenu)
	sw	a0,%lo(gtmenu)(a5)
	lw	a5,%lo(gtlen)(s11)
	bne	a5,zero,.L19
	lw	a5,%lo(demmenu)(s7)
	bne	a5,zero,.L20
	sw	s4,%lo(demmenu)(s7)
.L21:
	call	menu_tong
	li	a0,200
	call	HAL_Delay
.L19:
	lui	a5,%hi(gtxuong)
	lw	a5,%lo(gtxuong)(a5)
	bne	a5,zero,.L22
	lw	a5,%lo(demmenu)(s7)
	bne	a5,zero,.L23
	sw	s4,%lo(demmenu)(s7)
.L24:
	call	menu_tong
	li	a0,200
	call	HAL_Delay
.L22:
	lui	a5,%hi(gtmenu)
	lw	a5,%lo(gtmenu)(a5)
	bne	a5,zero,.L18
	li	a0,50
	call	HAL_Delay
	lui	a5,%hi(gtmenu)
	lw	a5,%lo(gtmenu)(a5)
	bne	a5,zero,.L18
	call	chon_tong
	j	.L18
.L20:
	bne	a5,s1,.L21
	sw	zero,%lo(demmenu)(s7)
	j	.L21
.L23:
	bne	a5,s1,.L24
	sw	zero,%lo(demmenu)(s7)
	j	.L24
.L45:
	call	menu_caidat
	mv	a1,s1
	li	a0,1073811456
	addi	a0,a0,-2048
	call	HAL_GPIO_ReadPin
	lui	s11,%hi(gtlen)
	sw	a0,%lo(gtlen)(s11)
	li	a1,4
	li	a0,1073811456
	addi	a0,a0,-2048
	call	HAL_GPIO_ReadPin
	lui	a5,%hi(gtxuong)
	sw	a0,%lo(gtxuong)(a5)
	li	a1,2
	li	a0,1073811456
	addi	a0,a0,-2048
	call	HAL_GPIO_ReadPin
	lui	a5,%hi(gtmenu)
	sw	a0,%lo(gtmenu)(a5)
	lw	a5,%lo(gtlen)(s11)
	bne	a5,zero,.L26
	lw	a5,%lo(demmenu)(s7)
	bne	a5,zero,.L27
	sw	s9,%lo(demmenu)(s7)
.L28:
	call	menu_caidat
	li	a0,200
	call	HAL_Delay
.L26:
	lui	a5,%hi(gtxuong)
	lw	a5,%lo(gtxuong)(a5)
	bne	a5,zero,.L31
	lw	a5,%lo(demmenu)(s7)
	bne	a5,zero,.L32
	sw	s4,%lo(demmenu)(s7)
.L33:
	call	menu_caidat
	li	a0,200
	call	HAL_Delay
.L31:
	lui	a5,%hi(gtmenu)
	lw	a5,%lo(gtmenu)(a5)
	bne	a5,zero,.L25
	li	a0,50
	call	HAL_Delay
	lui	a5,%hi(gtmenu)
	lw	a5,%lo(gtmenu)(a5)
	bne	a5,zero,.L25
	call	chon_caidat
	j	.L25
.L27:
	beq	a5,s1,.L49
	li	a4,2
	beq	a5,a4,.L50
	bne	a5,s10,.L28
	li	a5,2
	sw	a5,%lo(demmenu)(s7)
	j	.L28
.L49:
	sw	zero,%lo(demmenu)(s7)
	j	.L28
.L50:
	sw	s4,%lo(demmenu)(s7)
	j	.L28
.L32:
	beq	a5,s1,.L51
	li	a4,2
	beq	a5,a4,.L52
	bne	a5,s10,.L33
	sw	zero,%lo(demmenu)(s7)
	j	.L33
.L51:
	li	a5,2
	sw	a5,%lo(demmenu)(s7)
	j	.L33
.L52:
	sw	s9,%lo(demmenu)(s7)
	j	.L33
.L46:
	lw	a5,%lo(gtlen)(s8)
	bne	a5,s1,.L36
	lui	a5,%hi(gtxuong)
	lw	a5,%lo(gtxuong)(a5)
	bne	a5,s1,.L36
	lui	a4,%hi(count)
	lw	a5,%lo(count)(a4)
	addiw	a5,a5,1
	sw	a5,%lo(count)(a4)
	li	a0,20
	call	HAL_Delay
	j	.L36
	.size	main, .-main
	.align	1
	.globl	Error_Handler
	.type	Error_Handler, @function
Error_Handler:
 #APP
# 71 "../../../CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	cpsid i
# 0 "" 2
 #NO_APP
.L54:
	j	.L54
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
