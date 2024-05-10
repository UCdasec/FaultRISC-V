	.file	"calibration.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"Probe Calibration Program"
	.align	3
.LC1:
	.string	"Do you want to set calibration (S) or load calibration (L)? "
	.align	3
.LC2:
	.string	" %c"
	.align	3
.LC3:
	.string	"Enter calibration values for:"
	.align	3
.LC4:
	.string	"North: "
	.align	3
.LC5:
	.string	"%f"
	.align	3
.LC6:
	.string	"South: "
	.align	3
.LC7:
	.string	"East: "
	.align	3
.LC8:
	.string	"West: "
	.align	3
.LC9:
	.string	"Up: "
	.align	3
.LC10:
	.string	"Down: "
	.align	3
.LC11:
	.string	"w"
	.align	3
.LC12:
	.string	"calibration"
	.align	3
.LC13:
	.string	"Error opening the calibration file for writing."
	.align	3
.LC14:
	.string	"%.2f %.2f %.2f %.2f %.2f %.2f"
	.align	3
.LC15:
	.string	"Calibration values have been set and saved to the 'calibration' file."
	.align	3
.LC16:
	.string	"r"
	.align	3
.LC17:
	.string	"Error opening the calibration file for reading. Calibration values are not set."
	.align	3
.LC18:
	.string	"%f %f %f %f %f %f"
	.align	3
.LC19:
	.string	"Loaded Calibration Values:"
	.align	3
.LC20:
	.string	"North: %.2f\n"
	.align	3
.LC21:
	.string	"South: %.2f\n"
	.align	3
.LC22:
	.string	"East: %.2f\n"
	.align	3
.LC23:
	.string	"West: %.2f\n"
	.align	3
.LC24:
	.string	"Up: %.2f\n"
	.align	3
.LC25:
	.string	"Down: %.2f\n"
	.align	3
.LC26:
	.string	"Invalid choice. Please enter 'S' to set calibration or 'L' to load calibration."
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48
	sd	ra,40(sp)
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	puts
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	printf
	addi	a1,sp,31
	lui	a0,%hi(.LC2)
	addi	a0,a0,%lo(.LC2)
	call	scanf
	lbu	a5,31(sp)
	andi	a5,a5,223
	li	a4,83
	beq	a5,a4,.L8
	li	a4,76
	beq	a5,a4,.L9
	lui	a0,%hi(.LC26)
	addi	a0,a0,%lo(.LC26)
	call	puts
	li	a0,0
	j	.L4
.L8:
	sd	s0,32(sp)
	lui	a0,%hi(.LC3)
	addi	a0,a0,%lo(.LC3)
	call	puts
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	call	printf
	mv	a1,sp
	lui	s0,%hi(.LC5)
	addi	a0,s0,%lo(.LC5)
	call	scanf
	lui	a0,%hi(.LC6)
	addi	a0,a0,%lo(.LC6)
	call	printf
	addi	a1,sp,4
	addi	a0,s0,%lo(.LC5)
	call	scanf
	lui	a0,%hi(.LC7)
	addi	a0,a0,%lo(.LC7)
	call	printf
	addi	a1,sp,8
	addi	a0,s0,%lo(.LC5)
	call	scanf
	lui	a0,%hi(.LC8)
	addi	a0,a0,%lo(.LC8)
	call	printf
	addi	a1,sp,12
	addi	a0,s0,%lo(.LC5)
	call	scanf
	lui	a0,%hi(.LC9)
	addi	a0,a0,%lo(.LC9)
	call	printf
	addi	a1,sp,16
	addi	a0,s0,%lo(.LC5)
	call	scanf
	lui	a0,%hi(.LC10)
	addi	a0,a0,%lo(.LC10)
	call	printf
	addi	a1,sp,20
	addi	a0,s0,%lo(.LC5)
	call	scanf
	lui	a1,%hi(.LC11)
	addi	a1,a1,%lo(.LC11)
	lui	a0,%hi(.LC12)
	addi	a0,a0,%lo(.LC12)
	call	fopen
	mv	s0,a0
	beq	a0,zero,.L10
	flw	fa5,20(sp)
	fcvt.d.s	fa5,fa5
	fmv.x.d	a7,fa5
	flw	fa5,16(sp)
	fcvt.d.s	fa5,fa5
	fmv.x.d	a6,fa5
	flw	fa5,12(sp)
	fcvt.d.s	fa5,fa5
	fmv.x.d	a5,fa5
	flw	fa5,8(sp)
	fcvt.d.s	fa5,fa5
	fmv.x.d	a4,fa5
	flw	fa5,4(sp)
	fcvt.d.s	fa5,fa5
	fmv.x.d	a3,fa5
	flw	fa5,0(sp)
	fcvt.d.s	fa5,fa5
	fmv.x.d	a2,fa5
	lui	a1,%hi(.LC14)
	addi	a1,a1,%lo(.LC14)
	call	fprintf
	mv	a0,s0
	call	fclose
	lui	a0,%hi(.LC15)
	addi	a0,a0,%lo(.LC15)
	call	puts
	li	a0,0
	ld	s0,32(sp)
.L4:
	ld	ra,40(sp)
	addi	sp,sp,48
	jr	ra
.L10:
	lui	a0,%hi(.LC13)
	addi	a0,a0,%lo(.LC13)
	call	puts
	li	a0,1
	ld	s0,32(sp)
	j	.L4
.L9:
	sd	s0,32(sp)
	lui	a1,%hi(.LC16)
	addi	a1,a1,%lo(.LC16)
	lui	a0,%hi(.LC12)
	addi	a0,a0,%lo(.LC12)
	call	fopen
	mv	s0,a0
	beq	a0,zero,.L11
	addi	a7,sp,20
	addi	a6,sp,16
	addi	a5,sp,12
	addi	a4,sp,8
	addi	a3,sp,4
	mv	a2,sp
	lui	a1,%hi(.LC18)
	addi	a1,a1,%lo(.LC18)
	call	fscanf
	mv	a0,s0
	call	fclose
	lui	a0,%hi(.LC19)
	addi	a0,a0,%lo(.LC19)
	call	puts
	flw	fa5,0(sp)
	fcvt.d.s	fa5,fa5
	fmv.x.d	a1,fa5
	lui	a0,%hi(.LC20)
	addi	a0,a0,%lo(.LC20)
	call	printf
	flw	fa5,4(sp)
	fcvt.d.s	fa5,fa5
	fmv.x.d	a1,fa5
	lui	a0,%hi(.LC21)
	addi	a0,a0,%lo(.LC21)
	call	printf
	flw	fa5,8(sp)
	fcvt.d.s	fa5,fa5
	fmv.x.d	a1,fa5
	lui	a0,%hi(.LC22)
	addi	a0,a0,%lo(.LC22)
	call	printf
	flw	fa5,12(sp)
	fcvt.d.s	fa5,fa5
	fmv.x.d	a1,fa5
	lui	a0,%hi(.LC23)
	addi	a0,a0,%lo(.LC23)
	call	printf
	flw	fa5,16(sp)
	fcvt.d.s	fa5,fa5
	fmv.x.d	a1,fa5
	lui	a0,%hi(.LC24)
	addi	a0,a0,%lo(.LC24)
	call	printf
	flw	fa5,20(sp)
	fcvt.d.s	fa5,fa5
	fmv.x.d	a1,fa5
	lui	a0,%hi(.LC25)
	addi	a0,a0,%lo(.LC25)
	call	printf
	li	a0,0
	ld	s0,32(sp)
	j	.L4
.L11:
	lui	a0,%hi(.LC17)
	addi	a0,a0,%lo(.LC17)
	call	puts
	li	a0,0
	ld	s0,32(sp)
	j	.L4
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
