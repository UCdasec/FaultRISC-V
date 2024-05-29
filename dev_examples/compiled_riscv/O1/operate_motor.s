	.file	"operate_motor.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	isMaintenanceRequired
	.type	isMaintenanceRequired, @function
isMaintenanceRequired:
	li	a5,99
	sgt	a0,a0,a5
	ret
	.size	isMaintenanceRequired, .-isMaintenanceRequired
	.section	.rodata.str1.8,"aMS",@progbits,1
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
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	puts
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	performMaintenance, .-performMaintenance
	.align	1
	.globl	checkMotorStatus
	.type	checkMotorStatus, @function
checkMotorStatus:
	li	a0,80
	ret
	.size	checkMotorStatus, .-checkMotorStatus
	.section	.rodata.str1.8
	.align	3
.LC1:
	.string	"Adjusting motor speed to %d RPM.\n"
	.text
	.align	1
	.globl	adjustMotorSpeed
	.type	adjustMotorSpeed, @function
adjustMotorSpeed:
	addi	sp,sp,-16
	sd	ra,8(sp)
	mv	a1,a0
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	printf
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	adjustMotorSpeed, .-adjustMotorSpeed
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sd	ra,8(sp)
	li	a0,50
	call	adjustMotorSpeed
	li	a0,0
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
