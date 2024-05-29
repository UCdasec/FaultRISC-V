	.file	"rsa.c"
	.option nopic
	.attribute arch, "rv32i2p1_m2p0_a2p1_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.file 0 "/home/bsheafer/riscv/bonky-boot" "src/rsa.c"
	.align	1
	.globl	rsa_verify
	.type	rsa_verify, @function
rsa_verify:
.LFB0:
	.file 1 "src/rsa.c"
	.loc 1 18 52
	.cfi_startproc
.LVL0:
	addi	sp,sp,-32
	.cfi_def_cfa_offset 32
	sw	ra,28(sp)
	sw	s0,24(sp)
	sw	s1,20(sp)
	.cfi_offset 1, -4
	.cfi_offset 8, -8
	.cfi_offset 9, -12
	mv	s0,a1
	sw	s2,16(sp)
	sw	s3,12(sp)
	sw	s4,8(sp)
	.cfi_offset 18, -16
	.cfi_offset 19, -20
	.cfi_offset 20, -24
	.loc 1 18 52 is_stmt 0
	mv	s4,a0
	.loc 1 20 2 is_stmt 1
.LVL1:
	.loc 1 21 2
	.loc 1 21 16 is_stmt 0
	call	numeri_alloc
.LVL2:
	mv	s3,a0
.LVL3:
	.loc 1 22 2 is_stmt 1
	.loc 1 22 14 is_stmt 0
	call	numeri_alloc
.LVL4:
	mv	s2,a0
.LVL5:
	.loc 1 23 2 is_stmt 1
	.loc 1 23 14 is_stmt 0
	call	numeri_alloc
.LVL6:
	mv	s1,a0
	.loc 1 26 2
	li	a2,128
	mv	a1,s4
	mv	a0,s3
.LVL7:
	.loc 1 26 2 is_stmt 1
	call	numeri_load
.LVL8:
	.loc 1 29 2
	lui	a1,%hi(.LANCHOR0)
	li	a2,128
	addi	a1,a1,%lo(.LANCHOR0)
	mv	a0,s2
	call	numeri_load
.LVL9:
	.loc 1 32 2
	li	a1,65536
	addi	a1,a1,1
	mv	a3,s1
	mv	a2,s2
	mv	a0,s3
	call	numeri_pow
.LVL10:
	.loc 1 35 2
.LBB2:
	.loc 1 35 7
	.loc 1 35 37 discriminator 1
	mv	a1,s0
	addi	a5,s1,35
	addi	a7,s1,3
	j	.L3
.LVL11:
.L9:
	beq	a5,a7,.L8
.LVL12:
.L3:
	.loc 1 36 3
	.loc 1 35 67 discriminator 2
	.loc 1 35 37 discriminator 1
	.loc 1 36 6 is_stmt 0
	lbu	a6,0(a1)
	lbu	a4,0(a5)
	.loc 1 35 37 discriminator 1
	addi	a1,a1,1
.LVL13:
	addi	a5,a5,-1
	.loc 1 36 6
	beq	a6,a4,.L9
	.loc 1 37 20
	li	s0,0
.LVL14:
.L2:
.LBE2:
	.loc 1 43 2 is_stmt 1
	mv	a0,s3
	call	numeri_free
.LVL15:
	.loc 1 44 2
	mv	a0,s2
	call	numeri_free
.LVL16:
	.loc 1 45 2
	mv	a0,s1
	call	numeri_free
.LVL17:
	.loc 1 47 2
	.loc 1 48 1 is_stmt 0
	lw	ra,28(sp)
	.cfi_remember_state
	.cfi_restore 1
	mv	a0,s0
	lw	s0,24(sp)
	.cfi_restore 8
.LVL18:
	lw	s1,20(sp)
	.cfi_restore 9
.LVL19:
	lw	s2,16(sp)
	.cfi_restore 18
.LVL20:
	lw	s3,12(sp)
	.cfi_restore 19
.LVL21:
	lw	s4,8(sp)
	.cfi_restore 20
.LVL22:
	addi	sp,sp,32
	.cfi_def_cfa_offset 0
	jr	ra
.LVL23:
.L8:
	.cfi_restore_state
	.loc 1 20 7
	li	s0,1
.LVL24:
.LBB3:
	j	.L2
.LBE3:
	.cfi_endproc
.LFE0:
	.size	rsa_verify, .-rsa_verify
	.section	.rodata
	.align	2
	.set	.LANCHOR0,. + 0
	.type	modulus, @object
	.size	modulus, 128
modulus:
	.ascii	"\363BW\270\343\207\365\024tK)V\320\332H'=@\300\302\206h\250\235"
	.ascii	"\305\261\b\263\227G\0231\236\314-\241\277\030\f\324\004\236\304"
	.ascii	"\257>\332VS\3405\261\300\020v\354\007\254&<j\036\342z\373_\275"
	.ascii	"\323\214p\364\365\347\034\215_\b\345\314\211\234\020+\212\303"
	.ascii	"N7k\315\331U$*;\304\027P}\260?\001\204\031\023lly\251\317\013"
	.ascii	"\230\307\265\240\234aX\201#\255ir\271\335\217C\312\347\264"
	.text
.Letext0:
	.file 2 "inc/types.h"
	.file 3 "inc/numeri.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x2be
	.2byte	0x5
	.byte	0x1
	.byte	0x4
	.4byte	.Ldebug_abbrev0
	.uleb128 0x10
	.4byte	.LASF24
	.byte	0x1d
	.4byte	.LASF0
	.4byte	.LASF1
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	.Ldebug_line0
	.uleb128 0x5
	.byte	0x8
	.byte	0x7
	.4byte	.LASF2
	.uleb128 0x5
	.byte	0x4
	.byte	0x7
	.4byte	.LASF3
	.uleb128 0x3
	.4byte	.LASF5
	.byte	0x2
	.byte	0x2
	.byte	0xe
	.4byte	0x40
	.uleb128 0x5
	.byte	0x1
	.byte	0x8
	.4byte	.LASF4
	.uleb128 0x3
	.4byte	.LASF6
	.byte	0x2
	.byte	0x7
	.byte	0x13
	.4byte	0x40
	.uleb128 0x6
	.4byte	0x47
	.uleb128 0x3
	.4byte	.LASF7
	.byte	0x2
	.byte	0x9
	.byte	0x13
	.4byte	0x69
	.uleb128 0x6
	.4byte	0x58
	.uleb128 0x11
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x3
	.4byte	.LASF8
	.byte	0x2
	.byte	0xb
	.byte	0x13
	.4byte	0x69
	.uleb128 0x5
	.byte	0x2
	.byte	0x5
	.4byte	.LASF9
	.uleb128 0x12
	.4byte	.LASF13
	.2byte	0x104
	.byte	0x3
	.byte	0x6
	.byte	0x10
	.4byte	0xb3
	.uleb128 0x7
	.4byte	.LASF10
	.byte	0x7
	.4byte	0x34
	.byte	0
	.uleb128 0x7
	.4byte	.LASF11
	.byte	0x8
	.4byte	0xb3
	.byte	0x1
	.uleb128 0x7
	.4byte	.LASF12
	.byte	0x9
	.4byte	0xc3
	.byte	0x4
	.byte	0
	.uleb128 0x8
	.4byte	0x47
	.4byte	0xc3
	.uleb128 0x9
	.4byte	0x2d
	.byte	0x2
	.byte	0
	.uleb128 0x8
	.4byte	0x47
	.4byte	0xd3
	.uleb128 0x9
	.4byte	0x2d
	.byte	0xff
	.byte	0
	.uleb128 0x3
	.4byte	.LASF13
	.byte	0x3
	.byte	0xa
	.byte	0x3
	.4byte	0x83
	.uleb128 0x13
	.4byte	.LASF14
	.byte	0x1
	.byte	0x6
	.byte	0x17
	.4byte	0x64
	.4byte	0x10001
	.uleb128 0x8
	.4byte	0x53
	.4byte	0xff
	.uleb128 0x9
	.4byte	0x2d
	.byte	0x7f
	.byte	0
	.uleb128 0x6
	.4byte	0xef
	.uleb128 0x14
	.4byte	.LASF15
	.byte	0x1
	.byte	0x7
	.byte	0x16
	.4byte	0xff
	.uleb128 0x5
	.byte	0x3
	.4byte	modulus
	.uleb128 0xa
	.4byte	.LASF16
	.byte	0x22
	.4byte	0x126
	.uleb128 0x2
	.4byte	0x126
	.byte	0
	.uleb128 0xd
	.4byte	0xd3
	.uleb128 0xa
	.4byte	.LASF17
	.byte	0x3c
	.4byte	0x14a
	.uleb128 0x2
	.4byte	0x126
	.uleb128 0x2
	.4byte	0x58
	.uleb128 0x2
	.4byte	0x126
	.uleb128 0x2
	.4byte	0x126
	.byte	0
	.uleb128 0xa
	.4byte	.LASF18
	.byte	0x19
	.4byte	0x164
	.uleb128 0x2
	.4byte	0x126
	.uleb128 0x2
	.4byte	0x164
	.uleb128 0x2
	.4byte	0x70
	.byte	0
	.uleb128 0x15
	.byte	0x4
	.uleb128 0x16
	.4byte	.LASF19
	.byte	0x3
	.byte	0x16
	.byte	0x9
	.4byte	0x126
	.4byte	0x178
	.uleb128 0x17
	.byte	0
	.uleb128 0x18
	.4byte	.LASF25
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.4byte	0x34
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x2bc
	.uleb128 0xe
	.4byte	.LASF20
	.byte	0x1a
	.4byte	0x2bc
	.4byte	.LLST0
	.uleb128 0xe
	.4byte	.LASF21
	.byte	0x2e
	.4byte	0x2bc
	.4byte	.LLST1
	.uleb128 0xf
	.4byte	.LASF22
	.byte	0x14
	.byte	0x7
	.4byte	0x34
	.4byte	.LLST2
	.uleb128 0xb
	.string	"sig"
	.byte	0x15
	.4byte	0x126
	.4byte	.LLST3
	.uleb128 0xb
	.string	"n"
	.byte	0x16
	.4byte	0x126
	.4byte	.LLST4
	.uleb128 0xb
	.string	"h"
	.byte	0x17
	.4byte	0x126
	.4byte	.LLST5
	.uleb128 0x19
	.4byte	.LLRL6
	.4byte	0x1fc
	.uleb128 0xf
	.4byte	.LASF23
	.byte	0x23
	.byte	0xe
	.4byte	0x70
	.4byte	.LLST7
	.byte	0
	.uleb128 0xc
	.4byte	.LVL2
	.4byte	0x166
	.uleb128 0xc
	.4byte	.LVL4
	.4byte	0x166
	.uleb128 0xc
	.4byte	.LVL6
	.4byte	0x166
	.uleb128 0x4
	.4byte	.LVL8
	.4byte	0x14a
	.4byte	0x237
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x5a
	.uleb128 0x2
	.byte	0x83
	.sleb128 0
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x5b
	.uleb128 0x2
	.byte	0x84
	.sleb128 0
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x5c
	.uleb128 0x2
	.byte	0x8
	.byte	0x80
	.byte	0
	.uleb128 0x4
	.4byte	.LVL9
	.4byte	0x14a
	.4byte	0x25a
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x5a
	.uleb128 0x2
	.byte	0x82
	.sleb128 0
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x5b
	.uleb128 0x5
	.byte	0x3
	.4byte	.LANCHOR0
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x5c
	.uleb128 0x2
	.byte	0x8
	.byte	0x80
	.byte	0
	.uleb128 0x4
	.4byte	.LVL10
	.4byte	0x12b
	.4byte	0x283
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x5a
	.uleb128 0x2
	.byte	0x83
	.sleb128 0
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x5b
	.uleb128 0x5
	.byte	0xc
	.4byte	0x10001
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x5c
	.uleb128 0x2
	.byte	0x82
	.sleb128 0
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x5d
	.uleb128 0x2
	.byte	0x79
	.sleb128 0
	.byte	0
	.uleb128 0x4
	.4byte	.LVL15
	.4byte	0x116
	.4byte	0x297
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x5a
	.uleb128 0x2
	.byte	0x83
	.sleb128 0
	.byte	0
	.uleb128 0x4
	.4byte	.LVL16
	.4byte	0x116
	.4byte	0x2ab
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x5a
	.uleb128 0x2
	.byte	0x82
	.sleb128 0
	.byte	0
	.uleb128 0x1a
	.4byte	.LVL17
	.4byte	0x116
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x5a
	.uleb128 0x2
	.byte	0x79
	.sleb128 0
	.byte	0
	.byte	0
	.uleb128 0xd
	.4byte	0x47
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x49
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.uleb128 0x7e
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
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
	.uleb128 0x4
	.uleb128 0x48
	.byte	0x1
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
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
	.uleb128 0x6
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 3
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 10
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 3
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 6
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
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
	.uleb128 0x21
	.sleb128 10
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x48
	.byte	0
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.sleb128 4
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0x21
	.sleb128 18
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0xf
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
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x10
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
	.uleb128 0x11
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
	.uleb128 0x12
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0x5
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x34
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
	.uleb128 0x1c
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x34
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
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x16
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
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x18
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
	.uleb128 0x19
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x48
	.byte	0x1
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
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
	.uleb128 .LVL2-1-.Ltext0
	.uleb128 0x1
	.byte	0x5a
	.byte	0x4
	.uleb128 .LVL2-1-.Ltext0
	.uleb128 .LVL22-.Ltext0
	.uleb128 0x1
	.byte	0x64
	.byte	0x4
	.uleb128 .LVL22-.Ltext0
	.uleb128 .LVL23-.Ltext0
	.uleb128 0xa
	.byte	0xa3
	.uleb128 0x3
	.byte	0xa5
	.uleb128 0xa
	.uleb128 0x26
	.byte	0xa8
	.uleb128 0x2d
	.byte	0xa8
	.uleb128 0
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL23-.Ltext0
	.uleb128 .LFE0-.Ltext0
	.uleb128 0x1
	.byte	0x64
	.byte	0
.LLST1:
	.byte	0x4
	.uleb128 .LVL0-.Ltext0
	.uleb128 .LVL2-1-.Ltext0
	.uleb128 0x1
	.byte	0x5b
	.byte	0x4
	.uleb128 .LVL2-1-.Ltext0
	.uleb128 .LVL14-.Ltext0
	.uleb128 0x1
	.byte	0x58
	.byte	0x4
	.uleb128 .LVL14-.Ltext0
	.uleb128 .LVL23-.Ltext0
	.uleb128 0xa
	.byte	0xa3
	.uleb128 0x3
	.byte	0xa5
	.uleb128 0xb
	.uleb128 0x26
	.byte	0xa8
	.uleb128 0x2d
	.byte	0xa8
	.uleb128 0
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL23-.Ltext0
	.uleb128 .LVL24-.Ltext0
	.uleb128 0x1
	.byte	0x58
	.byte	0x4
	.uleb128 .LVL24-.Ltext0
	.uleb128 .LFE0-.Ltext0
	.uleb128 0xa
	.byte	0xa3
	.uleb128 0x3
	.byte	0xa5
	.uleb128 0xb
	.uleb128 0x26
	.byte	0xa8
	.uleb128 0x2d
	.byte	0xa8
	.uleb128 0
	.byte	0x9f
	.byte	0
.LLST2:
	.byte	0x4
	.uleb128 .LVL1-.Ltext0
	.uleb128 .LVL14-.Ltext0
	.uleb128 0x2
	.byte	0x31
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL14-.Ltext0
	.uleb128 .LVL18-.Ltext0
	.uleb128 0x1
	.byte	0x58
	.byte	0x4
	.uleb128 .LVL18-.Ltext0
	.uleb128 .LVL23-.Ltext0
	.uleb128 0x1
	.byte	0x5a
	.byte	0x4
	.uleb128 .LVL23-.Ltext0
	.uleb128 .LFE0-.Ltext0
	.uleb128 0x2
	.byte	0x31
	.byte	0x9f
	.byte	0
.LLST3:
	.byte	0x4
	.uleb128 .LVL3-.Ltext0
	.uleb128 .LVL4-1-.Ltext0
	.uleb128 0x1
	.byte	0x5a
	.byte	0x4
	.uleb128 .LVL4-1-.Ltext0
	.uleb128 .LVL21-.Ltext0
	.uleb128 0x1
	.byte	0x63
	.byte	0x4
	.uleb128 .LVL23-.Ltext0
	.uleb128 .LFE0-.Ltext0
	.uleb128 0x1
	.byte	0x63
	.byte	0
.LLST4:
	.byte	0x4
	.uleb128 .LVL5-.Ltext0
	.uleb128 .LVL6-1-.Ltext0
	.uleb128 0x1
	.byte	0x5a
	.byte	0x4
	.uleb128 .LVL6-1-.Ltext0
	.uleb128 .LVL20-.Ltext0
	.uleb128 0x1
	.byte	0x62
	.byte	0x4
	.uleb128 .LVL23-.Ltext0
	.uleb128 .LFE0-.Ltext0
	.uleb128 0x1
	.byte	0x62
	.byte	0
.LLST5:
	.byte	0x4
	.uleb128 .LVL7-.Ltext0
	.uleb128 .LVL19-.Ltext0
	.uleb128 0x1
	.byte	0x59
	.byte	0x4
	.uleb128 .LVL23-.Ltext0
	.uleb128 .LFE0-.Ltext0
	.uleb128 0x1
	.byte	0x59
	.byte	0
.LLST7:
	.byte	0x4
	.uleb128 .LVL10-.Ltext0
	.uleb128 .LVL11-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL11-.Ltext0
	.uleb128 .LVL12-.Ltext0
	.uleb128 0x6
	.byte	0x7b
	.sleb128 0
	.byte	0x78
	.sleb128 0
	.byte	0x1c
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL12-.Ltext0
	.uleb128 .LVL13-.Ltext0
	.uleb128 0x8
	.byte	0x7b
	.sleb128 0
	.byte	0x78
	.sleb128 0
	.byte	0x1c
	.byte	0x23
	.uleb128 0x1
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL13-.Ltext0
	.uleb128 .LVL14-.Ltext0
	.uleb128 0x6
	.byte	0x7b
	.sleb128 0
	.byte	0x78
	.sleb128 0
	.byte	0x1c
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL14-.Ltext0
	.uleb128 .LVL15-1-.Ltext0
	.uleb128 0xd
	.byte	0x7b
	.sleb128 0
	.byte	0xa3
	.uleb128 0x3
	.byte	0xa5
	.uleb128 0xb
	.uleb128 0x26
	.byte	0xa8
	.uleb128 0x2d
	.byte	0xa8
	.uleb128 0
	.byte	0x1c
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL23-.Ltext0
	.uleb128 .LVL24-.Ltext0
	.uleb128 0x6
	.byte	0x7b
	.sleb128 0
	.byte	0x78
	.sleb128 0
	.byte	0x1c
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL24-.Ltext0
	.uleb128 .LFE0-.Ltext0
	.uleb128 0xd
	.byte	0x7b
	.sleb128 0
	.byte	0xa3
	.uleb128 0x3
	.byte	0xa5
	.uleb128 0xb
	.uleb128 0x26
	.byte	0xa8
	.uleb128 0x2d
	.byte	0xa8
	.uleb128 0
	.byte	0x1c
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
.LLRL6:
	.byte	0x4
	.uleb128 .LBB2-.Ltext0
	.uleb128 .LBE2-.Ltext0
	.byte	0x4
	.uleb128 .LBB3-.Ltext0
	.uleb128 .LBE3-.Ltext0
	.byte	0
.Ldebug_ranges3:
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF23:
	.string	"byte_idx"
.LASF8:
	.string	"size_t"
.LASF20:
	.string	"signature"
.LASF13:
	.string	"numeri"
.LASF24:
	.string	"GNU C17 13.2.0 -mabi=ilp32 -mtune=rocket -misa-spec=20191213 -march=rv32imac_zicsr -g -O2 -ffreestanding"
.LASF12:
	.string	"data"
.LASF5:
	.string	"bool"
.LASF2:
	.string	"long long unsigned int"
.LASF6:
	.string	"uint8_t"
.LASF4:
	.string	"char"
.LASF15:
	.string	"modulus"
.LASF7:
	.string	"uint32_t"
.LASF19:
	.string	"numeri_alloc"
.LASF22:
	.string	"signature_valid"
.LASF16:
	.string	"numeri_free"
.LASF17:
	.string	"numeri_pow"
.LASF21:
	.string	"hash"
.LASF25:
	.string	"rsa_verify"
.LASF18:
	.string	"numeri_load"
.LASF11:
	.string	"padding"
.LASF9:
	.string	"short int"
.LASF14:
	.string	"exponent"
.LASF3:
	.string	"unsigned int"
.LASF10:
	.string	"used"
	.section	.debug_line_str,"MS",@progbits,1
.LASF0:
	.string	"src/rsa.c"
.LASF1:
	.string	"/home/bsheafer/riscv/bonky-boot"
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
