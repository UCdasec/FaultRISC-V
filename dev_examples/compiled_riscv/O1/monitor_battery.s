	.file	"monitor_battery.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	isBatteryLow
	.type	isBatteryLow, @function
isBatteryLow:
	flt.s	a0,fa0,fa1
	ret
	.size	isBatteryLow, .-isBatteryLow
	.section	.rodata.str1.8,"aMS",@progbits,1
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
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	puts
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	handleLowBattery, .-handleLowBattery
	.align	1
	.globl	readBatteryVoltage
	.type	readBatteryVoltage, @function
readBatteryVoltage:
	lui	a5,%hi(.LC1)
	flw	fa0,%lo(.LC1)(a5)
	ret
	.size	readBatteryVoltage, .-readBatteryVoltage
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sd	ra,8(sp)
	call	handleLowBattery
	li	a0,0
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.section	.srodata.cst4,"aM",@progbits,4
	.align	2
.LC1:
	.word	1080033280
	.ident	"GCC: () 13.2.0"
