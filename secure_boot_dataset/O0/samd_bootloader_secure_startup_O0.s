	.file	"startup.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	vectors
	.section	.vectors,"a"
	.align	3
	.type	vectors, @object
	.size	vectors, 16
vectors:
	.dword	_stack_top
	.dword	irq_handler_reset
	.section	.romfunc,"ax",@progbits
	.align	1
	.globl	irq_handler_reset
	.type	irq_handler_reset, @function
irq_handler_reset:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	lui	a5,%hi(_etext)
	addi	a5,a5,%lo(_etext)
	sd	a5,-24(s0)
	lui	a5,%hi(_data)
	addi	a5,a5,%lo(_data)
	sd	a5,-32(s0)
	j	.L2
.L3:
	ld	a4,-24(s0)
	addi	a5,a4,4
	sd	a5,-24(s0)
	ld	a5,-32(s0)
	addi	a3,a5,4
	sd	a3,-32(s0)
	lw	a4,0(a4)
	sw	a4,0(a5)
.L2:
	ld	a4,-32(s0)
	lui	a5,%hi(_edata)
	addi	a5,a5,%lo(_edata)
	bltu	a4,a5,.L3
	lui	a5,%hi(_bss)
	addi	a5,a5,%lo(_bss)
	sd	a5,-32(s0)
	j	.L4
.L5:
	ld	a5,-32(s0)
	addi	a4,a5,4
	sd	a4,-32(s0)
	sw	zero,0(a5)
.L4:
	ld	a4,-32(s0)
	lui	a5,%hi(_ebss)
	addi	a5,a5,%lo(_ebss)
	bltu	a4,a5,.L5
	call	main
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	irq_handler_reset, .-irq_handler_reset
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
