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
	sd	ra,8(sp)
	lui	a4,%hi(_data)
	addi	a4,a4,%lo(_data)
	lui	a5,%hi(_edata)
	addi	a5,a5,%lo(_edata)
	bgeu	a4,a5,.L2
	lui	a4,%hi(_data)
	addi	a5,a4,%lo(_data)
	lui	a3,%hi(_edata-1)
	addi	a3,a3,%lo(_edata-1)
	sub	a3,a3,a5
	andi	a3,a3,-4
	addi	a3,a3,4
	lui	a5,%hi(_etext)
	addi	a2,a5,%lo(_etext)
	add	a3,a3,a2
	addi	a4,a4,%lo(_data)
	addi	a5,a5,%lo(_etext)
.L3:
	addi	a5,a5,4
	addi	a4,a4,4
	lw	a2,-4(a5)
	sw	a2,-4(a4)
	bne	a5,a3,.L3
.L2:
	lui	a4,%hi(_bss)
	addi	a4,a4,%lo(_bss)
	lui	a5,%hi(_ebss)
	addi	a5,a5,%lo(_ebss)
	bgeu	a4,a5,.L4
	lui	a5,%hi(_bss)
	addi	a3,a5,%lo(_bss)
	lui	a4,%hi(_ebss-1)
	addi	a4,a4,%lo(_ebss-1)
	sub	a4,a4,a3
	andi	a4,a4,-4
	addi	a4,a4,4
	add	a4,a4,a3
	addi	a5,a5,%lo(_bss)
.L5:
	addi	a5,a5,4
	sw	zero,-4(a5)
	bne	a5,a4,.L5
.L4:
	call	main
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
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
