	.file	"rpm_plot.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"a"
	.align	3
.LC1:
	.string	"plot_data.dat"
	.align	3
.LC2:
	.string	"Error opening the plot data file."
	.align	3
.LC3:
	.string	"%.2lf %.2lf\n"
	.text
	.align	1
	.globl	updatePlotFile
	.type	updatePlotFile, @function
updatePlotFile:
	lui	a1,%hi(.LC0)
	lui	a0,%hi(.LC1)
	addi	sp,sp,-32
	addi	a1,a1,%lo(.LC0)
	addi	a0,a0,%lo(.LC1)
	fsd	fs0,8(sp)
	fsd	fs1,0(sp)
	sd	ra,24(sp)
	sd	s0,16(sp)
	fmv.d	fs0,fa0
	fmv.d	fs1,fa1
	call	fopen
	beq	a0,zero,.L5
	fmv.x.d	a3,fs1
	fmv.x.d	a2,fs0
	lui	a1,%hi(.LC3)
	addi	a1,a1,%lo(.LC3)
	mv	s0,a0
	call	fprintf
	mv	a0,s0
	ld	s0,16(sp)
	ld	ra,24(sp)
	fld	fs0,8(sp)
	fld	fs1,0(sp)
	addi	sp,sp,32
	tail	fclose
.L5:
	lui	a0,%hi(.LC2)
	addi	a0,a0,%lo(.LC2)
	call	puts
	li	a0,1
	call	exit
	.size	updatePlotFile, .-updatePlotFile
	.section	.rodata.str1.8
	.align	3
.LC4:
	.string	"w"
	.align	3
.LC5:
	.string	"Continuous X-Y Plot Generator"
	.align	3
.LC6:
	.string	"Enter a value (or 'q' to quit): "
	.align	3
.LC7:
	.string	"%lf"
	.align	3
.LC8:
	.string	"%c"
	.align	3
.LC9:
	.string	"Invalid input. Please enter a numeric value."
	.align	3
.LC10:
	.string	"Time: %.2lf seconds, Value: %.2lf\n"
	.align	3
.LC11:
	.string	"Exiting the program."
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	lui	a1,%hi(.LC4)
	lui	a0,%hi(.LC1)
	addi	sp,sp,-96
	addi	a1,a1,%lo(.LC4)
	addi	a0,a0,%lo(.LC1)
	sd	ra,88(sp)
	call	fopen
	beq	a0,zero,.L16
	sd	s0,80(sp)
	sd	s1,72(sp)
	sd	s2,64(sp)
	sd	s3,56(sp)
	sd	s5,40(sp)
	sd	s4,48(sp)
	call	fclose
	lui	a0,%hi(.LC5)
	addi	a0,a0,%lo(.LC5)
	call	puts
	lui	s3,%hi(.LC6)
	lui	s2,%hi(.LC7)
	lui	s1,%hi(.LC8)
	li	s0,1
	li	s5,81
.L9:
	addi	a0,s3,%lo(.LC6)
	call	printf
	addi	a1,sp,8
	addi	a0,s2,%lo(.LC7)
	call	scanf
	mv	a5,a0
	addi	a1,sp,7
	addi	a0,s1,%lo(.LC8)
	beq	a5,s0,.L10
	call	scanf
	lbu	a5,7(sp)
	lui	a0,%hi(.LC9)
	addi	a0,a0,%lo(.LC9)
	andi	a5,a5,223
	beq	a5,s5,.L11
	call	puts
	j	.L9
.L11:
	lui	a0,%hi(.LC11)
	addi	a0,a0,%lo(.LC11)
	call	puts
	ld	s0,80(sp)
	ld	s1,72(sp)
	ld	s2,64(sp)
	ld	s3,56(sp)
	ld	s4,48(sp)
	ld	s5,40(sp)
	li	a0,0
.L8:
	ld	ra,88(sp)
	addi	sp,sp,96
	jr	ra
.L10:
	li	a0,0
	fsd	fs0,24(sp)
	call	time
	bne	s4,zero,.L13
	mv	s4,a0
.L13:
	mv	a1,s4
	call	difftime
	fld	fa1,8(sp)
	fmv.d	fs0,fa0
	call	updatePlotFile
	fmv.x.d	a1,fs0
	ld	a2,8(sp)
	lui	a0,%hi(.LC10)
	addi	a0,a0,%lo(.LC10)
	call	printf
	fld	fs0,24(sp)
	j	.L9
.L16:
	lui	a0,%hi(.LC2)
	addi	a0,a0,%lo(.LC2)
	call	puts
	li	a0,1
	j	.L8
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
