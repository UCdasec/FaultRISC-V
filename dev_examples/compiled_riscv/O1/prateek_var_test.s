	.file	"prateek_var_test.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	li	a0,0
	ret
	.size	main, .-main
	.globl	e
	.globl	d
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC1:
	.string	"test1"
	.align	3
.LC2:
	.string	"test2"
	.align	3
.LC3:
	.string	"test3"
	.globl	c
	.align	3
.LC4:
	.string	"Global Test"
	.globl	b
	.globl	a
	.data
	.align	3
	.type	d, @object
	.size	d, 24
d:
	.dword	.LC1
	.dword	.LC2
	.dword	.LC3
	.type	b, @object
	.size	b, 20
b:
	.word	1
	.word	2
	.word	3
	.word	4
	.word	5
	.section	.sdata,"aw"
	.align	3
	.type	e, @object
	.size	e, 4
e:
	.word	1076719780
	.zero	4
	.type	c, @object
	.size	c, 8
c:
	.dword	.LC4
	.type	a, @object
	.size	a, 4
a:
	.word	10
	.ident	"GCC: () 13.2.0"
