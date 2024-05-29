	.file	"monitor_battery_secure.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	isBatteryLow
	.type	isBatteryLow, @function
isBatteryLow:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	fsw	fa0,-20(s0)
	fsw	fa1,-24(s0)
	flw	fa4,-20(s0)
	flw	fa5,-24(s0)
	flt.s	a5,fa4,fa5
	snez	a5,a5
	andi	a5,a5,0xff
	sext.w	a5,a5
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	isBatteryLow, .-isBatteryLow
	.section	.rodata
	.align	3
.LC0:
	.string	"Battery is low! Taking necessary actions."
	.text
	.align	1
	.globl	handleLowBattery
	.type	handleLowBattery, @function
handleLowBattery:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	puts
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	handleLowBattery, .-handleLowBattery
	.align	1
	.globl	readBatteryVoltage
	.type	readBatteryVoltage, @function
readBatteryVoltage:
	addi	sp,sp,-16
	sd	s0,8(sp)
	addi	s0,sp,16
	lui	a5,%hi(.LC1)
	flw	fa5,%lo(.LC1)(a5)
	fmv.s	fa0,fa5
	ld	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	readBatteryVoltage, .-readBatteryVoltage
	.section	.rodata
	.align	3
.LC3:
	.string	"Battery voltage is within normal range."
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	lui	a5,%hi(.LC2)
	flw	fa5,%lo(.LC2)(a5)
	fsw	fa5,-20(s0)
	call	readBatteryVoltage
	fsw	fa0,-24(s0)
	flw	fa1,-20(s0)
	flw	fa0,-24(s0)
	call	isBatteryLow
	mv	a5,a0
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	sext.w	a5,a5
	beq	a5,zero,.L7
	call	handleLowBattery
	j	.L8
.L7:
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	puts
.L8:
	li	a5,0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.section	.rodata
	.align	2
.LC1:
	.word	1080033280
	.align	2
.LC2:
	.word	1080872141
	.ident	"GCC: () 13.2.0"
