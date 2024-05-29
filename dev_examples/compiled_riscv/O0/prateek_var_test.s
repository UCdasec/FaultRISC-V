	.file	"prateek_var_test.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	a
	.section	.sdata,"aw"
	.align	2
	.type	a, @object
	.size	a, 4
a:
	.word	10
	.globl	b
	.data
	.align	3
	.type	b, @object
	.size	b, 20
b:
	.word	1
	.word	2
	.word	3
	.word	4
	.word	5
	.globl	c
	.section	.rodata
	.align	3
.LC1:
	.string	"Global Test"
	.section	.sdata
	.align	3
	.type	c, @object
	.size	c, 8
c:
	.dword	.LC1
	.globl	d
	.section	.rodata
	.align	3
.LC2:
	.string	"test1"
	.align	3
.LC3:
	.string	"test2"
	.align	3
.LC4:
	.string	"test3"
	.data
	.align	3
	.type	d, @object
	.size	d, 24
d:
	.dword	.LC2
	.dword	.LC3
	.dword	.LC4
	.globl	e
	.section	.sdata
	.align	2
	.type	e, @object
	.size	e, 4
e:
	.word	1076719780
	.section	.rodata
	.align	3
.LC5:
	.string	"Local Test"
	.align	3
.LC6:
	.string	"test4"
	.align	3
.LC7:
	.string	"test5"
	.align	3
.LC8:
	.string	"test6"
	.align	3
.LC0:
	.word	6
	.word	7
	.word	8
	.word	9
	.word	10
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-80
	sd	s0,72(sp)
	addi	s0,sp,80
	li	a5,20
	sw	a5,-20(s0)
	lui	a5,%hi(.LC0)
	addi	a5,a5,%lo(.LC0)
	ld	a4,0(a5)
	sd	a4,-56(s0)
	ld	a4,8(a5)
	sd	a4,-48(s0)
	lw	a5,16(a5)
	sw	a5,-40(s0)
	lui	a5,%hi(.LC5)
	addi	a5,a5,%lo(.LC5)
	sd	a5,-32(s0)
	lui	a5,%hi(.LC6)
	addi	a5,a5,%lo(.LC6)
	sd	a5,-80(s0)
	lui	a5,%hi(.LC7)
	addi	a5,a5,%lo(.LC7)
	sd	a5,-72(s0)
	lui	a5,%hi(.LC8)
	addi	a5,a5,%lo(.LC8)
	sd	a5,-64(s0)
	lui	a5,%hi(.LC9)
	flw	fa5,%lo(.LC9)(a5)
	fsw	fa5,-36(s0)
	li	a5,0
	mv	a0,a5
	ld	s0,72(sp)
	addi	sp,sp,80
	jr	ra
	.size	main, .-main
	.section	.rodata
	.align	2
.LC9:
	.word	1078523331
	.ident	"GCC: () 13.2.0"
