	.file	"main.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	hi2c1
	.bss
	.align	3
	.type	hi2c1, @object
	.size	hi2c1, 112
hi2c1:
	.zero	112
	.globl	hspi1
	.align	3
	.type	hspi1, @object
	.size	hspi1, 136
hspi1:
	.zero	136
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	call	HAL_Init
	call	SystemClock_Config
	call	MX_GPIO_Init
	call	MX_I2C1_Init
	call	MX_SPI1_Init
	call	lcd_init
	call	MFRC522_Init
.L25:
	li	a1,2
	li	a5,1073811456
	addi	a0,a5,-2048
	call	HAL_GPIO_ReadPin
	mv	a5,a0
	sext.w	a4,a5
	lui	a5,%hi(gtmenu)
	sw	a4,%lo(gtmenu)(a5)
	lui	a5,%hi(gtmenu)
	lw	a5,%lo(gtmenu)(a5)
	bne	a5,zero,.L2
	nop
.L3:
	lui	a5,%hi(gtmenu)
	lw	a5,%lo(gtmenu)(a5)
	bne	a5,zero,.L3
	lui	a5,%hi(demtong)
	li	a4,1
	sw	a4,%lo(demtong)(a5)
.L2:
	lui	a5,%hi(demtong)
	lw	a5,%lo(demtong)(a5)
	bne	a5,zero,.L4
	call	Kiemtrarfid
	call	manhinhchinh
.L4:
	lui	a5,%hi(demtong)
	lw	a5,%lo(demtong)(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L25
	lui	a5,%hi(menupage)
	lw	a5,%lo(menupage)(a5)
	bne	a5,zero,.L6
	call	menu_tong
	li	a1,1
	li	a5,1073811456
	addi	a0,a5,-2048
	call	HAL_GPIO_ReadPin
	mv	a5,a0
	sext.w	a4,a5
	lui	a5,%hi(gtlen)
	sw	a4,%lo(gtlen)(a5)
	li	a1,4
	li	a5,1073811456
	addi	a0,a5,-2048
	call	HAL_GPIO_ReadPin
	mv	a5,a0
	sext.w	a4,a5
	lui	a5,%hi(gtxuong)
	sw	a4,%lo(gtxuong)(a5)
	li	a1,2
	li	a5,1073811456
	addi	a0,a5,-2048
	call	HAL_GPIO_ReadPin
	mv	a5,a0
	sext.w	a4,a5
	lui	a5,%hi(gtmenu)
	sw	a4,%lo(gtmenu)(a5)
	lui	a5,%hi(gtlen)
	lw	a5,%lo(gtlen)(a5)
	bne	a5,zero,.L7
	lui	a5,%hi(demmenu)
	lw	a5,%lo(demmenu)(a5)
	bne	a5,zero,.L8
	lui	a5,%hi(demmenu)
	li	a4,1
	sw	a4,%lo(demmenu)(a5)
	j	.L9
.L8:
	lui	a5,%hi(demmenu)
	lw	a5,%lo(demmenu)(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L9
	lui	a5,%hi(demmenu)
	sw	zero,%lo(demmenu)(a5)
.L9:
	call	menu_tong
	li	a0,200
	call	HAL_Delay
.L7:
	lui	a5,%hi(gtxuong)
	lw	a5,%lo(gtxuong)(a5)
	bne	a5,zero,.L10
	lui	a5,%hi(demmenu)
	lw	a5,%lo(demmenu)(a5)
	bne	a5,zero,.L11
	lui	a5,%hi(demmenu)
	li	a4,1
	sw	a4,%lo(demmenu)(a5)
	j	.L12
.L11:
	lui	a5,%hi(demmenu)
	lw	a5,%lo(demmenu)(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L12
	lui	a5,%hi(demmenu)
	sw	zero,%lo(demmenu)(a5)
.L12:
	call	menu_tong
	li	a0,200
	call	HAL_Delay
.L10:
	lui	a5,%hi(gtmenu)
	lw	a5,%lo(gtmenu)(a5)
	bne	a5,zero,.L6
	li	a0,50
	call	HAL_Delay
	lui	a5,%hi(gtmenu)
	lw	a5,%lo(gtmenu)(a5)
	bne	a5,zero,.L6
	call	chon_tong
.L6:
	lui	a5,%hi(menupage)
	lw	a5,%lo(menupage)(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L13
	call	menu_caidat
	li	a1,1
	li	a5,1073811456
	addi	a0,a5,-2048
	call	HAL_GPIO_ReadPin
	mv	a5,a0
	sext.w	a4,a5
	lui	a5,%hi(gtlen)
	sw	a4,%lo(gtlen)(a5)
	li	a1,4
	li	a5,1073811456
	addi	a0,a5,-2048
	call	HAL_GPIO_ReadPin
	mv	a5,a0
	sext.w	a4,a5
	lui	a5,%hi(gtxuong)
	sw	a4,%lo(gtxuong)(a5)
	li	a1,2
	li	a5,1073811456
	addi	a0,a5,-2048
	call	HAL_GPIO_ReadPin
	mv	a5,a0
	sext.w	a4,a5
	lui	a5,%hi(gtmenu)
	sw	a4,%lo(gtmenu)(a5)
	lui	a5,%hi(gtlen)
	lw	a5,%lo(gtlen)(a5)
	bne	a5,zero,.L14
	lui	a5,%hi(demmenu)
	lw	a5,%lo(demmenu)(a5)
	bne	a5,zero,.L15
	lui	a5,%hi(demmenu)
	li	a4,3
	sw	a4,%lo(demmenu)(a5)
	j	.L16
.L15:
	lui	a5,%hi(demmenu)
	lw	a5,%lo(demmenu)(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L17
	lui	a5,%hi(demmenu)
	sw	zero,%lo(demmenu)(a5)
	j	.L16
.L17:
	lui	a5,%hi(demmenu)
	lw	a5,%lo(demmenu)(a5)
	mv	a4,a5
	li	a5,2
	bne	a4,a5,.L18
	lui	a5,%hi(demmenu)
	li	a4,1
	sw	a4,%lo(demmenu)(a5)
	j	.L16
.L18:
	lui	a5,%hi(demmenu)
	lw	a5,%lo(demmenu)(a5)
	mv	a4,a5
	li	a5,3
	bne	a4,a5,.L16
	lui	a5,%hi(demmenu)
	li	a4,2
	sw	a4,%lo(demmenu)(a5)
.L16:
	call	menu_caidat
	li	a0,200
	call	HAL_Delay
.L14:
	lui	a5,%hi(gtxuong)
	lw	a5,%lo(gtxuong)(a5)
	bne	a5,zero,.L19
	lui	a5,%hi(demmenu)
	lw	a5,%lo(demmenu)(a5)
	bne	a5,zero,.L20
	lui	a5,%hi(demmenu)
	li	a4,1
	sw	a4,%lo(demmenu)(a5)
	j	.L21
.L20:
	lui	a5,%hi(demmenu)
	lw	a5,%lo(demmenu)(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L22
	lui	a5,%hi(demmenu)
	li	a4,2
	sw	a4,%lo(demmenu)(a5)
	j	.L21
.L22:
	lui	a5,%hi(demmenu)
	lw	a5,%lo(demmenu)(a5)
	mv	a4,a5
	li	a5,2
	bne	a4,a5,.L23
	lui	a5,%hi(demmenu)
	li	a4,3
	sw	a4,%lo(demmenu)(a5)
	j	.L21
.L23:
	lui	a5,%hi(demmenu)
	lw	a5,%lo(demmenu)(a5)
	mv	a4,a5
	li	a5,3
	bne	a4,a5,.L21
	lui	a5,%hi(demmenu)
	sw	zero,%lo(demmenu)(a5)
.L21:
	call	menu_caidat
	li	a0,200
	call	HAL_Delay
.L19:
	lui	a5,%hi(gtmenu)
	lw	a5,%lo(gtmenu)(a5)
	bne	a5,zero,.L13
	li	a0,50
	call	HAL_Delay
	lui	a5,%hi(gtmenu)
	lw	a5,%lo(gtmenu)(a5)
	bne	a5,zero,.L13
	call	chon_caidat
.L13:
	lui	a5,%hi(gtmenu)
	lw	a5,%lo(gtmenu)(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L24
	lui	a5,%hi(gtlen)
	lw	a5,%lo(gtlen)(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L24
	lui	a5,%hi(gtxuong)
	lw	a5,%lo(gtxuong)(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L24
	lui	a5,%hi(count)
	lw	a5,%lo(count)(a5)
	addiw	a5,a5,1
	sext.w	a4,a5
	lui	a5,%hi(count)
	sw	a4,%lo(count)(a5)
	li	a0,20
	call	HAL_Delay
.L24:
	lui	a5,%hi(count)
	lw	a5,%lo(count)(a5)
	mv	a4,a5
	li	a5,150
	bne	a4,a5,.L25
	lui	a5,%hi(demtong)
	sw	zero,%lo(demtong)(a5)
	lui	a5,%hi(count)
	sw	zero,%lo(count)(a5)
	lui	a5,%hi(menupage)
	sw	zero,%lo(menupage)(a5)
	j	.L25
	.size	main, .-main
	.align	1
	.globl	SystemClock_Config
	.type	SystemClock_Config, @function
SystemClock_Config:
	addi	sp,sp,-80
	sd	ra,72(sp)
	sd	s0,64(sp)
	addi	s0,sp,80
	sd	zero,-56(s0)
	sd	zero,-48(s0)
	sd	zero,-40(s0)
	sd	zero,-32(s0)
	sd	zero,-24(s0)
	sd	zero,-80(s0)
	sd	zero,-72(s0)
	sw	zero,-64(s0)
	li	a5,2
	sw	a5,-56(s0)
	li	a5,1
	sw	a5,-40(s0)
	li	a5,16
	sw	a5,-36(s0)
	sw	zero,-28(s0)
	addi	a5,s0,-56
	mv	a0,a5
	call	HAL_RCC_OscConfig
	mv	a5,a0
	beq	a5,zero,.L27
	call	Error_Handler
.L27:
	li	a5,15
	sw	a5,-80(s0)
	sw	zero,-76(s0)
	sw	zero,-72(s0)
	li	a5,1024
	sw	a5,-68(s0)
	li	a5,1792
	sw	a5,-64(s0)
	addi	a5,s0,-80
	li	a1,0
	mv	a0,a5
	call	HAL_RCC_ClockConfig
	mv	a5,a0
	beq	a5,zero,.L29
	call	Error_Handler
.L29:
	nop
	ld	ra,72(sp)
	ld	s0,64(sp)
	addi	sp,sp,80
	jr	ra
	.size	SystemClock_Config, .-SystemClock_Config
	.align	1
	.type	MX_I2C1_Init, @function
MX_I2C1_Init:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	lui	a5,%hi(hi2c1)
	addi	a5,a5,%lo(hi2c1)
	li	a4,1073762304
	addi	a4,a4,1024
	sd	a4,0(a5)
	lui	a5,%hi(hi2c1)
	addi	a5,a5,%lo(hi2c1)
	li	a4,98304
	addi	a4,a4,1696
	sw	a4,8(a5)
	lui	a5,%hi(hi2c1)
	addi	a5,a5,%lo(hi2c1)
	sw	zero,12(a5)
	lui	a5,%hi(hi2c1)
	addi	a5,a5,%lo(hi2c1)
	sw	zero,16(a5)
	lui	a5,%hi(hi2c1)
	addi	a5,a5,%lo(hi2c1)
	li	a4,16384
	sw	a4,20(a5)
	lui	a5,%hi(hi2c1)
	addi	a5,a5,%lo(hi2c1)
	sw	zero,24(a5)
	lui	a5,%hi(hi2c1)
	addi	a5,a5,%lo(hi2c1)
	sw	zero,28(a5)
	lui	a5,%hi(hi2c1)
	addi	a5,a5,%lo(hi2c1)
	sw	zero,32(a5)
	lui	a5,%hi(hi2c1)
	addi	a5,a5,%lo(hi2c1)
	sw	zero,36(a5)
	lui	a5,%hi(hi2c1)
	addi	a0,a5,%lo(hi2c1)
	call	HAL_I2C_Init
	mv	a5,a0
	beq	a5,zero,.L32
	call	Error_Handler
.L32:
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	MX_I2C1_Init, .-MX_I2C1_Init
	.align	1
	.type	MX_SPI1_Init, @function
MX_SPI1_Init:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	lui	a5,%hi(hspi1)
	addi	a5,a5,%lo(hspi1)
	li	a4,1073819648
	sd	a4,0(a5)
	lui	a5,%hi(hspi1)
	addi	a5,a5,%lo(hspi1)
	li	a4,260
	sw	a4,8(a5)
	lui	a5,%hi(hspi1)
	addi	a5,a5,%lo(hspi1)
	sw	zero,12(a5)
	lui	a5,%hi(hspi1)
	addi	a5,a5,%lo(hspi1)
	sw	zero,16(a5)
	lui	a5,%hi(hspi1)
	addi	a5,a5,%lo(hspi1)
	sw	zero,20(a5)
	lui	a5,%hi(hspi1)
	addi	a5,a5,%lo(hspi1)
	sw	zero,24(a5)
	lui	a5,%hi(hspi1)
	addi	a5,a5,%lo(hspi1)
	li	a4,512
	sw	a4,28(a5)
	lui	a5,%hi(hspi1)
	addi	a5,a5,%lo(hspi1)
	sw	zero,32(a5)
	lui	a5,%hi(hspi1)
	addi	a5,a5,%lo(hspi1)
	sw	zero,36(a5)
	lui	a5,%hi(hspi1)
	addi	a5,a5,%lo(hspi1)
	sw	zero,40(a5)
	lui	a5,%hi(hspi1)
	addi	a5,a5,%lo(hspi1)
	sw	zero,44(a5)
	lui	a5,%hi(hspi1)
	addi	a5,a5,%lo(hspi1)
	li	a4,10
	sw	a4,48(a5)
	lui	a5,%hi(hspi1)
	addi	a0,a5,%lo(hspi1)
	call	HAL_SPI_Init
	mv	a5,a0
	beq	a5,zero,.L35
	call	Error_Handler
.L35:
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	MX_SPI1_Init, .-MX_SPI1_Init
	.align	1
	.type	MX_GPIO_Init, @function
MX_GPIO_Init:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	zero,-32(s0)
	sd	zero,-24(s0)
	li	a5,1073876992
	lw	a5,24(a5)
	sext.w	a4,a5
	li	a5,1073876992
	ori	a4,a4,32
	sext.w	a4,a4
	sw	a4,24(a5)
	li	a5,1073876992
	lw	a5,24(a5)
	sext.w	a5,a5
	andi	a5,a5,32
	sext.w	a5,a5
	sw	a5,-36(s0)
	lw	a5,-36(s0)
	li	a5,1073876992
	lw	a5,24(a5)
	sext.w	a4,a5
	li	a5,1073876992
	ori	a4,a4,4
	sext.w	a4,a4
	sw	a4,24(a5)
	li	a5,1073876992
	lw	a5,24(a5)
	sext.w	a5,a5
	andi	a5,a5,4
	sext.w	a5,a5
	sw	a5,-40(s0)
	lw	a5,-40(s0)
	li	a5,1073876992
	lw	a5,24(a5)
	sext.w	a4,a5
	li	a5,1073876992
	ori	a4,a4,8
	sext.w	a4,a4
	sw	a4,24(a5)
	li	a5,1073876992
	lw	a5,24(a5)
	sext.w	a5,a5
	andi	a5,a5,8
	sext.w	a5,a5
	sw	a5,-44(s0)
	lw	a5,-44(s0)
	li	a2,0
	li	a5,4096
	addi	a1,a5,-240
	li	a5,1073811456
	addi	a0,a5,-2048
	call	HAL_GPIO_WritePin
	li	a2,0
	li	a5,4096
	addi	a1,a5,-2016
	li	a5,1073811456
	addi	a0,a5,-1024
	call	HAL_GPIO_WritePin
	li	a5,7
	sw	a5,-32(s0)
	sw	zero,-28(s0)
	li	a5,1
	sw	a5,-24(s0)
	addi	a5,s0,-32
	mv	a1,a5
	li	a5,1073811456
	addi	a0,a5,-2048
	call	HAL_GPIO_Init
	li	a5,4096
	addi	a5,a5,-240
	sw	a5,-32(s0)
	li	a5,1
	sw	a5,-28(s0)
	li	a5,2
	sw	a5,-24(s0)
	li	a5,2
	sw	a5,-20(s0)
	addi	a5,s0,-32
	mv	a1,a5
	li	a5,1073811456
	addi	a0,a5,-2048
	call	HAL_GPIO_Init
	li	a5,4096
	addi	a5,a5,-2048
	sw	a5,-32(s0)
	li	a5,1
	sw	a5,-28(s0)
	li	a5,1
	sw	a5,-24(s0)
	li	a5,2
	sw	a5,-20(s0)
	addi	a5,s0,-32
	mv	a1,a5
	li	a5,1073811456
	addi	a0,a5,-1024
	call	HAL_GPIO_Init
	li	a5,61440
	sw	a5,-32(s0)
	sw	zero,-28(s0)
	li	a5,1
	sw	a5,-24(s0)
	addi	a5,s0,-32
	mv	a1,a5
	li	a5,1073811456
	addi	a0,a5,-1024
	call	HAL_GPIO_Init
	li	a5,32
	sw	a5,-32(s0)
	li	a5,1
	sw	a5,-28(s0)
	li	a5,2
	sw	a5,-24(s0)
	li	a5,2
	sw	a5,-20(s0)
	addi	a5,s0,-32
	mv	a1,a5
	li	a5,1073811456
	addi	a0,a5,-1024
	call	HAL_GPIO_Init
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	MX_GPIO_Init, .-MX_GPIO_Init
	.align	1
	.globl	Error_Handler
	.type	Error_Handler, @function
Error_Handler:
	addi	sp,sp,-16
	sd	s0,8(sp)
	addi	s0,sp,16
 #APP
# 71 "../../../CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	cpsid i
# 0 "" 2
 #NO_APP
	nop
.L38:
	j	.L38
	.size	Error_Handler, .-Error_Handler
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
