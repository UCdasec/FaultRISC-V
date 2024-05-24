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
	addi	sp,sp,-16
	sd	s0,8(sp)
	addi	s0,sp,16
	li	a5,1
	mv	a0,a5
	ld	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	isMotionDetected, .-isMotionDetected
	.align	1
	.globl	isDoorOpen
	.type	isDoorOpen, @function
isDoorOpen:
	addi	sp,sp,-16
	sd	s0,8(sp)
	addi	s0,sp,16
	li	a5,0
	mv	a0,a5
	ld	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	isDoorOpen, .-isDoorOpen
	.section	.rodata
	.align	3
.LC0:
	.string	"Intrusion detected! Activating alarm."
	.text
	.align	1
	.globl	triggerAlarm
	.type	triggerAlarm, @function
triggerAlarm:
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
	.size	triggerAlarm, .-triggerAlarm
	.section	.rodata
	.align	3
.LC1:
	.string	"No intrusion detected. System is secure."
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	call	isMotionDetected
	mv	a5,a0
	beq	a5,zero,.L7
	call	triggerAlarm
	j	.L8
.L7:
	call	isDoorOpen
	mv	a5,a0
	beq	a5,zero,.L9
	call	triggerAlarm
	j	.L8
.L9:
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	puts
.L8:
	li	a5,0
	mv	a0,a5
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
