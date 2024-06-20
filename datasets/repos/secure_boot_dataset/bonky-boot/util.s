	.file	"util.c"
	.option nopic
	.attribute arch, "rv32i2p1_m2p0_a2p1_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.file 0 "/home/bsheafer/riscv/bonky-boot" "src/util.c"
	.align	1
	.globl	int_pow
	.type	int_pow, @function
int_pow:
.LFB0:
	.file 1 "src/util.c"
	.loc 1 1 32
	.cfi_startproc
.LVL0:
	.loc 1 2 2
	.loc 1 4 2
.LBB2:
	.loc 1 4 7
	.loc 1 4 20 discriminator 1
.LBE2:
	.loc 1 1 32 is_stmt 0
	mv	a4,a0
.LBB3:
	.loc 1 4 20 discriminator 1
	ble	a1,zero,.L4
	.loc 1 4 11
	li	a5,0
.LBE3:
	.loc 1 2 6
	li	a0,1
.LVL1:
.L3:
.LBB4:
	.loc 1 5 3 is_stmt 1
	.loc 1 4 28 is_stmt 0 discriminator 3
	addi	a5,a5,1
.LVL2:
	.loc 1 5 7
	mul	a0,a0,a4
.LVL3:
	.loc 1 4 28 is_stmt 1 discriminator 3
	.loc 1 4 20 discriminator 1
	bne	a1,a5,.L3
	ret
.LVL4:
.L4:
.LBE4:
	.loc 1 2 6 is_stmt 0
	li	a0,1
.LVL5:
	.loc 1 8 2 is_stmt 1
	.loc 1 9 1 is_stmt 0
	ret
	.cfi_endproc
.LFE0:
	.size	int_pow, .-int_pow
	.align	1
	.globl	int_sqrt
	.type	int_sqrt, @function
int_sqrt:
.LFB1:
	.loc 1 11 21 is_stmt 1
	.cfi_startproc
.LVL6:
	.loc 1 12 2
	.loc 1 11 21 is_stmt 0
	mv	a1,a0
	.loc 1 12 5
	ble	a0,zero,.L12
	.loc 1 17 6
	mv	a3,a0
	.loc 1 16 6
	li	a4,1
	.loc 1 18 6
	li	a0,0
.LVL7:
.L11:
.LBB5:
	.loc 1 21 3 is_stmt 1
	.loc 1 23 4
	.loc 1 26 4
	.loc 1 21 27 is_stmt 0
	sub	a5,a3,a4
	.loc 1 21 35
	srai	a5,a5,1
	.loc 1 21 7
	add	a5,a5,a4
.LVL8:
	.loc 1 22 3 is_stmt 1
	.loc 1 22 16 is_stmt 0
	div	a2,a1,a5
	.loc 1 22 6
	bgt	a5,a2,.L9
	.loc 1 23 9
	addi	a4,a5,1
.LVL9:
	.loc 1 24 4 is_stmt 1
	.loc 1 24 11 is_stmt 0
	mv	a0,a5
.LBE5:
	.loc 1 20 14 is_stmt 1
	ble	a4,a3,.L11
	ret
.LVL10:
.L9:
.LBB6:
	.loc 1 26 10 is_stmt 0
	addi	a3,a5,-1
.LVL11:
.LBE6:
	.loc 1 20 14 is_stmt 1
	ble	a4,a3,.L11
	ret
.LVL12:
.L12:
	.loc 1 13 10 is_stmt 0
	li	a0,0
.LVL13:
	.loc 1 31 1
	ret
	.cfi_endproc
.LFE1:
	.size	int_sqrt, .-int_sqrt
.Letext0:
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0xe9
	.2byte	0x5
	.byte	0x1
	.byte	0x4
	.4byte	.Ldebug_abbrev0
	.uleb128 0x4
	.4byte	.LASF6
	.byte	0x1d
	.4byte	.LASF0
	.4byte	.LASF1
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	.Ldebug_line0
	.uleb128 0x5
	.4byte	.LASF7
	.byte	0x1
	.byte	0xb
	.byte	0x5
	.4byte	0x8e
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x8e
	.uleb128 0x6
	.string	"x"
	.byte	0x1
	.byte	0xb
	.byte	0x12
	.4byte	0x8e
	.4byte	.LLST4
	.uleb128 0x1
	.4byte	.LASF2
	.byte	0x10
	.4byte	0x8e
	.4byte	.LLST5
	.uleb128 0x1
	.4byte	.LASF3
	.byte	0x11
	.4byte	0x8e
	.4byte	.LLST6
	.uleb128 0x1
	.4byte	.LASF4
	.byte	0x12
	.4byte	0x8e
	.4byte	.LLST7
	.uleb128 0x3
	.4byte	.LLRL8
	.uleb128 0x2
	.string	"mid"
	.byte	0x15
	.byte	0x7
	.4byte	0x8e
	.4byte	.LLST9
	.byte	0
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x8
	.4byte	.LASF8
	.byte	0x1
	.byte	0x1
	.byte	0x5
	.4byte	0x8e
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x9
	.4byte	.LASF5
	.byte	0x1
	.byte	0x1
	.byte	0x11
	.4byte	0x8e
	.4byte	.LLST0
	.uleb128 0xa
	.string	"exp"
	.byte	0x1
	.byte	0x1
	.byte	0x1b
	.4byte	0x8e
	.uleb128 0x1
	.byte	0x5b
	.uleb128 0x2
	.string	"res"
	.byte	0x2
	.byte	0x6
	.4byte	0x8e
	.4byte	.LLST1
	.uleb128 0x3
	.4byte	.LLRL2
	.uleb128 0x2
	.string	"i"
	.byte	0x4
	.byte	0xb
	.4byte	0x8e
	.4byte	.LLST3
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
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
	.sleb128 6
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
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
	.uleb128 0x3
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x4
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
	.uleb128 0x5
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
	.uleb128 0x49
	.uleb128 0x13
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
	.uleb128 0x6
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
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x7
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
	.uleb128 0x8
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
	.uleb128 0x49
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
	.uleb128 0x9
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
.LLST4:
	.byte	0x4
	.uleb128 .LVL6-.Ltext0
	.uleb128 .LVL7-.Ltext0
	.uleb128 0x1
	.byte	0x5a
	.byte	0x4
	.uleb128 .LVL7-.Ltext0
	.uleb128 .LVL12-.Ltext0
	.uleb128 0x1
	.byte	0x5b
	.byte	0x4
	.uleb128 .LVL12-.Ltext0
	.uleb128 .LVL13-.Ltext0
	.uleb128 0x1
	.byte	0x5a
	.byte	0x4
	.uleb128 .LVL13-.Ltext0
	.uleb128 .LFE1-.Ltext0
	.uleb128 0x1
	.byte	0x5b
	.byte	0
.LLST5:
	.byte	0x4
	.uleb128 .LVL7-.Ltext0
	.uleb128 .LVL12-.Ltext0
	.uleb128 0x1
	.byte	0x5e
	.byte	0
.LLST6:
	.byte	0x4
	.uleb128 .LVL7-.Ltext0
	.uleb128 .LVL12-.Ltext0
	.uleb128 0x1
	.byte	0x5d
	.byte	0
.LLST7:
	.byte	0x4
	.uleb128 .LVL7-.Ltext0
	.uleb128 .LVL9-.Ltext0
	.uleb128 0x1
	.byte	0x5a
	.byte	0x4
	.uleb128 .LVL9-.Ltext0
	.uleb128 .LVL10-.Ltext0
	.uleb128 0x1
	.byte	0x5f
	.byte	0x4
	.uleb128 .LVL10-.Ltext0
	.uleb128 .LVL12-.Ltext0
	.uleb128 0x1
	.byte	0x5a
	.byte	0
.LLST9:
	.byte	0x4
	.uleb128 .LVL8-.Ltext0
	.uleb128 .LVL12-.Ltext0
	.uleb128 0x1
	.byte	0x5f
	.byte	0
.LLST0:
	.byte	0x4
	.uleb128 .LVL0-.Ltext0
	.uleb128 .LVL1-.Ltext0
	.uleb128 0x1
	.byte	0x5a
	.byte	0x4
	.uleb128 .LVL1-.Ltext0
	.uleb128 .LVL4-.Ltext0
	.uleb128 0x1
	.byte	0x5e
	.byte	0x4
	.uleb128 .LVL4-.Ltext0
	.uleb128 .LVL5-.Ltext0
	.uleb128 0x1
	.byte	0x5a
	.byte	0x4
	.uleb128 .LVL5-.Ltext0
	.uleb128 .LFE0-.Ltext0
	.uleb128 0x1
	.byte	0x5e
	.byte	0
.LLST1:
	.byte	0x4
	.uleb128 .LVL0-.Ltext0
	.uleb128 .LVL1-.Ltext0
	.uleb128 0x2
	.byte	0x31
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL1-.Ltext0
	.uleb128 .LVL4-.Ltext0
	.uleb128 0x1
	.byte	0x5a
	.byte	0x4
	.uleb128 .LVL4-.Ltext0
	.uleb128 .LFE0-.Ltext0
	.uleb128 0x2
	.byte	0x31
	.byte	0x9f
	.byte	0
.LLST3:
	.byte	0x4
	.uleb128 .LVL0-.Ltext0
	.uleb128 .LVL1-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL1-.Ltext0
	.uleb128 .LVL2-.Ltext0
	.uleb128 0x1
	.byte	0x5f
	.byte	0x4
	.uleb128 .LVL2-.Ltext0
	.uleb128 .LVL3-.Ltext0
	.uleb128 0x3
	.byte	0x7f
	.sleb128 -1
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL3-.Ltext0
	.uleb128 .LVL4-.Ltext0
	.uleb128 0x1
	.byte	0x5f
	.byte	0x4
	.uleb128 .LVL4-.Ltext0
	.uleb128 .LFE0-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
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
	.section	.debug_rnglists,"",@progbits
.Ldebug_ranges0:
	.4byte	.Ldebug_ranges3-.Ldebug_ranges2
.Ldebug_ranges2:
	.2byte	0x5
	.byte	0x4
	.byte	0
	.4byte	0
.LLRL2:
	.byte	0x4
	.uleb128 .LBB2-.Ltext0
	.uleb128 .LBE2-.Ltext0
	.byte	0x4
	.uleb128 .LBB3-.Ltext0
	.uleb128 .LBE3-.Ltext0
	.byte	0x4
	.uleb128 .LBB4-.Ltext0
	.uleb128 .LBE4-.Ltext0
	.byte	0
.LLRL8:
	.byte	0x4
	.uleb128 .LBB5-.Ltext0
	.uleb128 .LBE5-.Ltext0
	.byte	0x4
	.uleb128 .LBB6-.Ltext0
	.uleb128 .LBE6-.Ltext0
	.byte	0
.Ldebug_ranges3:
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF3:
	.string	"right"
.LASF8:
	.string	"int_pow"
.LASF7:
	.string	"int_sqrt"
.LASF6:
	.string	"GNU C17 13.2.0 -mabi=ilp32 -mtune=rocket -misa-spec=20191213 -march=rv32imac_zicsr -g -O2 -ffreestanding"
.LASF4:
	.string	"result"
.LASF2:
	.string	"left"
.LASF5:
	.string	"base"
	.section	.debug_line_str,"MS",@progbits,1
.LASF0:
	.string	"src/util.c"
.LASF1:
	.string	"/home/bsheafer/riscv/bonky-boot"
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
