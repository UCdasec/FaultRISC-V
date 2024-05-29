	.file	"operate_motor_secure.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	isMaintenanceRequired
	.type	isMaintenanceRequired, @function
isMaintenanceRequired:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	mv	a5,a0
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,99
	sgt	a5,a4,a5
	andi	a5,a5,0xff
	sext.w	a5,a5
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	isMaintenanceRequired, .-isMaintenanceRequired
	.section	.rodata
	.align	3
.LC0:
	.string	"Maintenance required! Initiating maintenance procedures."
	.text
	.align	1
	.globl	performMaintenance
	.type	performMaintenance, @function
performMaintenance:
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
	.size	performMaintenance, .-performMaintenance
	.align	1
	.globl	checkMotorStatus
	.type	checkMotorStatus, @function
checkMotorStatus:
	addi	sp,sp,-16
	sd	s0,8(sp)
	addi	s0,sp,16
	li	a5,80
	mv	a0,a5
	ld	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	checkMotorStatus, .-checkMotorStatus
	.section	.rodata
	.align	3
.LC1:
	.string	"Adjusting motor speed to %d RPM.\n"
	.text
	.align	1
	.globl	adjustMotorSpeed
	.type	adjustMotorSpeed, @function
adjustMotorSpeed:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	mv	a5,a0
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a1,a5
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	printf
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	adjustMotorSpeed, .-adjustMotorSpeed
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	li	a5,95
	sw	a5,-20(s0)
	li	a5,75
	sw	a5,-24(s0)
	lw	a5,-20(s0)
	mv	a0,a5
	call	isMaintenanceRequired
	mv	a5,a0
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	sext.w	a5,a5
	beq	a5,zero,.L8
	call	performMaintenance
	j	.L9
.L8:
	call	checkMotorStatus
	mv	a5,a0
	sw	a5,-32(s0)
	lw	a5,-32(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bge	a4,a5,.L10
	li	a0,100
	call	adjustMotorSpeed
	j	.L9
.L10:
	li	a0,50
	call	adjustMotorSpeed
.L9:
	li	a5,0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
