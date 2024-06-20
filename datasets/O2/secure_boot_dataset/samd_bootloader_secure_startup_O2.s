	.file	"startup.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.romfunc,"ax",@progbits
	.align	1
	.globl	irq_handler_reset
	.type	irq_handler_reset, @function
irq_handler_reset:
	addi	sp,sp,-16
	lui	a0,%hi(_data)
	lui	a5,%hi(_edata)
	sd	ra,8(sp)
	addi	a4,a0,%lo(_data)
	addi	a5,a5,%lo(_edata)
	bgeu	a4,a5,.L2
	addi	a2,a5,-1
	sub	a2,a2,a4
	andi	a2,a2,-4
	lui	a1,%hi(_etext)
	addi	a2,a2,4
	addi	a1,a1,%lo(_etext)
	addi	a0,a0,%lo(_data)
	call	memcpy
.L2:
	lui	a0,%hi(_bss)
	lui	a5,%hi(_ebss)
	addi	a4,a0,%lo(_bss)
	addi	a5,a5,%lo(_ebss)
	bgeu	a4,a5,.L3
	addi	a2,a5,-1
	sub	a2,a2,a4
	andi	a2,a2,-4
	addi	a2,a2,4
	li	a1,0
	addi	a0,a0,%lo(_bss)
	call	memset
.L3:
	ld	ra,8(sp)
	addi	sp,sp,16
	tail	main
	.size	irq_handler_reset, .-irq_handler_reset
	.globl	vectors
	.section	.vectors,"a"
	.align	3
	.type	vectors, @object
	.size	vectors, 16
vectors:
	.dword	_stack_top
	.dword	irq_handler_reset
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
