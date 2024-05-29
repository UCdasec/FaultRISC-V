	.file	"uart.c"
	.option nopic
	.attribute arch, "rv32i2p1_m2p0_a2p1_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.file 0 "/home/bsheafer/riscv/bonky-boot" "src/uart.c"
	.align	1
	.globl	print
	.type	print, @function
print:
.LFB0:
	.file 1 "src/uart.c"
	.loc 1 11 26
	.cfi_startproc
.LVL0:
	.loc 1 12 2
	.loc 1 12 16
	.loc 1 12 8 is_stmt 0
	lbu	a5,0(a0)
	.loc 1 12 16
	beq	a5,zero,.L1
.LBB4:
.LBB5:
	.loc 1 23 37 is_stmt 1 discriminator 1
	.loc 1 23 9 discriminator 1
	li	a4,268435456
	lbu	a3,5(a4)
	andi	a3,a3,1
	beq	a3,zero,.L3
.L4:
	.loc 1 23 37 discriminator 1
	.loc 1 23 9 discriminator 1
	.loc 1 23 37 discriminator 1
	.loc 1 23 9 discriminator 1
	j	.L4
.L3:
	.loc 1 23 38 discriminator 2
	.loc 1 26 2
	.loc 1 26 12 is_stmt 0
	sb	a5,0(a4)
	.loc 1 28 2 is_stmt 1
.LBE5:
.LBE4:
	.loc 1 14 3
	.loc 1 12 8 is_stmt 0
	lbu	a5,1(a0)
	.loc 1 14 9
	addi	a0,a0,1
.LVL1:
	.loc 1 12 16 is_stmt 1
	bne	a5,zero,.L3
.L1:
	.loc 1 16 1 is_stmt 0
	ret
	.cfi_endproc
.LFE0:
	.size	print, .-print
	.align	1
	.globl	cputchar
	.type	cputchar, @function
cputchar:
.LFB1:
	.loc 1 18 22 is_stmt 1
	.cfi_startproc
.LVL2:
	.loc 1 19 2
	.loc 1 20 2
	.loc 1 23 2
	.loc 1 23 37 discriminator 1
	.loc 1 23 9 discriminator 1
	li	a4,268435456
	lbu	a5,5(a4)
	andi	a5,a5,1
	beq	a5,zero,.L12
.L13:
	.loc 1 23 37 discriminator 1
	.loc 1 23 9 discriminator 1
	.loc 1 23 37 discriminator 1
	.loc 1 23 9 discriminator 1
	j	.L13
.L12:
	.loc 1 23 38 discriminator 2
	.loc 1 26 2
	.loc 1 26 14 is_stmt 0
	li	a5,268435456
	sb	a0,0(a5)
	.loc 1 28 2 is_stmt 1
	.loc 1 29 1 is_stmt 0
	ret
	.cfi_endproc
.LFE1:
	.size	cputchar, .-cputchar
.Letext0:
	.file 2 "inc/types.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0xea
	.2byte	0x5
	.byte	0x1
	.byte	0x4
	.4byte	.Ldebug_abbrev0
	.uleb128 0x6
	.4byte	.LASF6
	.byte	0x1d
	.4byte	.LASF0
	.4byte	.LASF1
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	.Ldebug_line0
	.uleb128 0x1
	.byte	0x1
	.byte	0x8
	.4byte	.LASF2
	.uleb128 0x7
	.4byte	.LASF7
	.byte	0x2
	.byte	0x7
	.byte	0x13
	.4byte	0x26
	.uleb128 0x8
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x1
	.byte	0x2
	.byte	0x5
	.4byte	.LASF3
	.uleb128 0x9
	.4byte	.LASF8
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x1
	.4byte	0x73
	.uleb128 0xa
	.string	"c"
	.byte	0x1
	.byte	0x12
	.byte	0x13
	.4byte	0x39
	.uleb128 0x2
	.4byte	.LASF4
	.byte	0x13
	.4byte	0x73
	.uleb128 0x2
	.4byte	.LASF5
	.byte	0x14
	.4byte	0x73
	.byte	0
	.uleb128 0x3
	.4byte	0x2d
	.uleb128 0xb
	.4byte	.LASF9
	.byte	0x1
	.byte	0xb
	.byte	0x6
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xbf
	.uleb128 0xc
	.4byte	.LASF10
	.byte	0x1
	.byte	0xb
	.byte	0x12
	.4byte	0xbf
	.4byte	.LLST0
	.uleb128 0xd
	.4byte	0x47
	.4byte	.LBB4
	.4byte	.LBE4-.LBB4
	.byte	0x1
	.byte	0xd
	.byte	0x3
	.uleb128 0xe
	.4byte	0x54
	.uleb128 0x4
	.4byte	0x5e
	.uleb128 0x4
	.4byte	0x68
	.byte	0
	.byte	0
	.uleb128 0x3
	.4byte	0x26
	.uleb128 0xf
	.4byte	0x47
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x10
	.4byte	0x54
	.uleb128 0x1
	.byte	0x5a
	.uleb128 0x5
	.4byte	0x5e
	.4byte	0x10000005
	.uleb128 0x5
	.4byte	0x68
	.4byte	0x10000000
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 11
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.sleb128 4
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x1c
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x1f
	.uleb128 0x1b
	.uleb128 0x1f
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x57
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loclists,"",@progbits
	.4byte	.Ldebug_loc3-.Ldebug_loc2
.Ldebug_loc2:
	.2byte	0x5
	.byte	0x4
	.byte	0
	.4byte	0
.Ldebug_loc0:
.LLST0:
	.byte	0x4
	.uleb128 .LVL0-.Ltext0
	.uleb128 .LVL1-.Ltext0
	.uleb128 0x1
	.byte	0x5a
	.byte	0x4
	.uleb128 .LVL1-.Ltext0
	.uleb128 .LFE0-.Ltext0
	.uleb128 0x1
	.byte	0x5a
	.byte	0
.Ldebug_loc3:
	.section	.debug_aranges,"",@progbits
	.4byte	0x1c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	0
	.4byte	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF10:
	.string	"string"
.LASF7:
	.string	"uint8_t"
.LASF5:
	.string	"uart_thr"
.LASF6:
	.string	"GNU C17 13.2.0 -mabi=ilp32 -mtune=rocket -misa-spec=20191213 -march=rv32imac_zicsr -g -O2 -ffreestanding"
.LASF3:
	.string	"short int"
.LASF4:
	.string	"uart_lsr"
.LASF9:
	.string	"print"
.LASF2:
	.string	"char"
.LASF8:
	.string	"cputchar"
	.section	.debug_line_str,"MS",@progbits,1
.LASF0:
	.string	"src/uart.c"
.LASF1:
	.string	"/home/bsheafer/riscv/bonky-boot"
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
