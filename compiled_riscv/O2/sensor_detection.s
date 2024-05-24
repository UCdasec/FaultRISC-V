	.file	"sensor_detection.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	isMotionDetected
	.type	isMotionDetected, @function
isMotionDetected:
	li	a0,1
	ret
	.size	isMotionDetected, .-isMotionDetected
	.align	1
	.globl	isDoorOpen
	.type	isDoorOpen, @function
isDoorOpen:
	li	a0,0
	ret
	.size	isDoorOpen, .-isDoorOpen
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"Intrusion detected! Activating alarm."
	.text
	.align	1
	.globl	triggerAlarm
	.type	triggerAlarm, @function
triggerAlarm:
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	tail	puts
	.size	triggerAlarm, .-triggerAlarm
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	lui	a0,%hi(.LC0)
	addi	sp,sp,-16
	addi	a0,a0,%lo(.LC0)
	sd	ra,8(sp)
	call	puts
	ld	ra,8(sp)
	li	a0,0
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
