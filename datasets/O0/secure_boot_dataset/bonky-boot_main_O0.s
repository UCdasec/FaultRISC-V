	.file	"main.c"
	.option nopic
	.attribute arch, "rv32i2p1_m2p0_a2p1_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.file 0 "/home/bsheafer/riscv/bonky-boot" "src/main.c"
	.globl	signature
	.data
	.align	2
	.type	signature, @object
	.size	signature, 128
signature:
	.ascii	"\314E#\002\336=|Y\"\373-\276y\212Y)H\305\347\321l(\255\334@\225"
	.ascii	"\232Os\037\n\214\302\251\314\"#A\360\331\3614P\274\377\312\264"
	.ascii	"\005\276\243T\265\227\223\3115G$\355\226\320\253p\257\036\376"
	.ascii	"\373\314\026\252\340\221\223b\316\331\372\332\374\r\354:v\025"
	.ascii	"\t\370\261\360U\b\232\352\242\376yH\205v-N3\r\3751\270\274\317"
	.ascii	"\367\n\272NL\203='\3202A0\341H\031\333\346\001\217\243|"
	.globl	data_len
	.section	.srodata,"a"
	.align	2
	.type	data_len, @object
	.size	data_len, 4
data_len:
	.word	10
	.globl	data
	.data
	.align	2
	.type	data, @object
	.size	data, 10
data:
	.ascii	"bonky-boot"
	.section	.rodata
	.align	2
.LC0:
	.string	"\nHello from the best ISA\n"
	.align	2
.LC1:
	.string	"[!] Invalid Signature!\n"
	.align	2
.LC2:
	.string	"[~] Blocking Execution\n"
	.align	2
.LC3:
	.string	"[+] Valid Signature\n"
	.align	2
.LC4:
	.string	"[~] Transferring Execution ...\n"
	.text
	.align	1
	.globl	__main
	.type	__main, @function
__main:
.LFB0:
	.file 1 "src/main.c"
	.loc 1 24 19
	.cfi_startproc
	addi	sp,sp,-48
	.cfi_def_cfa_offset 48
	sw	ra,44(sp)
	sw	s0,40(sp)
	.cfi_offset 1, -4
	.cfi_offset 8, -8
	addi	s0,sp,48
	.cfi_def_cfa 8, 0
	.loc 1 27 2
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	print
	.loc 1 31 2
	li	a5,10
	addi	a4,s0,-48
	mv	a2,a4
	mv	a1,a5
	lui	a5,%hi(data)
	addi	a0,a5,%lo(data)
	call	sha256
	.loc 1 35 2
	call	numeri_init
	.loc 1 36 6
	addi	a5,s0,-48
	mv	a1,a5
	lui	a5,%hi(signature)
	addi	a0,a5,%lo(signature)
	call	rsa_verify
	mv	a5,a0
	.loc 1 36 5 discriminator 1
	bne	a5,zero,.L2
	.loc 1 37 3
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	print
	.loc 1 38 3
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	print
.L3:
	.loc 1 39 8
	j	.L3
.L2:
	.loc 1 43 2
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	print
	.loc 1 44 2
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	print
.L4:
	.loc 1 45 7
	j	.L4
	.cfi_endproc
.LFE0:
	.size	__main, .-__main
.Letext0:
	.file 2 "inc/types.h"
	.file 3 "inc/rsa.h"
	.file 4 "inc/numeri.h"
	.file 5 "inc/uart.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x15c
	.2byte	0x5
	.byte	0x1
	.byte	0x4
	.4byte	.Ldebug_abbrev0
	.uleb128 0x9
	.4byte	.LASF16
	.byte	0x1d
	.4byte	.LASF0
	.4byte	.LASF1
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.4byte	.LASF2
	.byte	0x2
	.byte	0xe
	.4byte	0x31
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.4byte	.LASF5
	.uleb128 0x2
	.4byte	.LASF3
	.byte	0x7
	.byte	0x13
	.4byte	0x31
	.uleb128 0x2
	.4byte	.LASF4
	.byte	0x9
	.byte	0x13
	.4byte	0x4e
	.uleb128 0xa
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x2
	.4byte	.LASF6
	.byte	0xb
	.byte	0x13
	.4byte	0x4e
	.uleb128 0xb
	.4byte	0x55
	.uleb128 0x3
	.byte	0x2
	.byte	0x5
	.4byte	.LASF7
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.4byte	.LASF8
	.uleb128 0x6
	.4byte	0x38
	.4byte	0x83
	.uleb128 0x4
	.4byte	0x6c
	.byte	0x7f
	.byte	0
	.uleb128 0x5
	.4byte	.LASF9
	.byte	0xa
	.byte	0x9
	.4byte	0x73
	.uleb128 0x5
	.byte	0x3
	.4byte	signature
	.uleb128 0x5
	.4byte	.LASF10
	.byte	0x15
	.byte	0xe
	.4byte	0x60
	.uleb128 0x5
	.byte	0x3
	.4byte	data_len
	.uleb128 0x6
	.4byte	0x31
	.4byte	0xb5
	.uleb128 0x4
	.4byte	0x6c
	.byte	0x9
	.byte	0
	.uleb128 0x5
	.4byte	.LASF11
	.byte	0x16
	.byte	0x6
	.4byte	0xa5
	.uleb128 0x5
	.byte	0x3
	.4byte	data
	.uleb128 0x7
	.4byte	.LASF12
	.byte	0x3
	.byte	0x6
	.4byte	0x26
	.4byte	0xe0
	.uleb128 0x1
	.4byte	0xe0
	.uleb128 0x1
	.4byte	0xe0
	.byte	0
	.uleb128 0x8
	.4byte	0x38
	.uleb128 0xc
	.4byte	.LASF14
	.byte	0x4
	.byte	0x13
	.byte	0x6
	.4byte	0x26
	.4byte	0xf7
	.uleb128 0xd
	.byte	0
	.uleb128 0x7
	.4byte	.LASF13
	.byte	0x1
	.byte	0x10
	.4byte	0x38
	.4byte	0x116
	.uleb128 0x1
	.4byte	0xe0
	.uleb128 0x1
	.4byte	0x43
	.uleb128 0x1
	.4byte	0xe0
	.byte	0
	.uleb128 0xe
	.4byte	.LASF15
	.byte	0x5
	.byte	0x3
	.byte	0x6
	.4byte	0x128
	.uleb128 0x1
	.4byte	0x128
	.byte	0
	.uleb128 0x8
	.4byte	0x31
	.uleb128 0xf
	.4byte	.LASF17
	.byte	0x1
	.byte	0x18
	.byte	0x6
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x153
	.uleb128 0x10
	.4byte	.LASF18
	.byte	0x1
	.byte	0x19
	.byte	0xa
	.4byte	0x153
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.byte	0
	.uleb128 0x11
	.4byte	0x38
	.uleb128 0x4
	.4byte	0x6c
	.byte	0x1f
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 2
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
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
	.uleb128 0x4
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x5
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
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x21
	.sleb128 7
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.sleb128 4
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
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
	.uleb128 0xa
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
	.uleb128 0xb
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
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
	.uleb128 0xd
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0xe
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
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
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
	.uleb128 0x7c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
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
	.uleb128 0x11
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.byte	0
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
.LASF13:
	.string	"sha256"
.LASF6:
	.string	"size_t"
.LASF17:
	.string	"__main"
.LASF15:
	.string	"print"
.LASF11:
	.string	"data"
.LASF2:
	.string	"bool"
.LASF16:
	.string	"GNU C17 13.2.0 -mabi=ilp32 -mtune=rocket -misa-spec=20191213 -march=rv32imac_zicsr -g -O0 -ffreestanding"
.LASF3:
	.string	"uint8_t"
.LASF10:
	.string	"data_len"
.LASF5:
	.string	"char"
.LASF4:
	.string	"uint32_t"
.LASF14:
	.string	"numeri_init"
.LASF9:
	.string	"signature"
.LASF18:
	.string	"hash"
.LASF12:
	.string	"rsa_verify"
.LASF7:
	.string	"short int"
.LASF8:
	.string	"unsigned int"
	.section	.debug_line_str,"MS",@progbits,1
.LASF0:
	.string	"src/main.c"
.LASF1:
	.string	"/home/bsheafer/riscv/bonky-boot"
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
