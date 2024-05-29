	.file	"secure_rom_boot.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	rom_boot_handle_error
	.type	rom_boot_handle_error, @function
rom_boot_handle_error:
.L2:
	j	.L2
	.size	rom_boot_handle_error, .-rom_boot_handle_error
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"\nNOTE: Invalidating flash boot flags"
	.text
	.align	1
	.globl	rom_boot_invalidate_checks
	.type	rom_boot_invalidate_checks, @function
rom_boot_invalidate_checks:
	addi	sp,sp,-16
	sd	ra,8(sp)
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	puts
	li	a5,470286336
	sb	zero,-4(a5)
	li	a5,470286336
	sb	zero,-3(a5)
	li	a5,470286336
	li	a4,-16
	sb	a4,-2(a5)
	li	a0,0
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	rom_boot_invalidate_checks, .-rom_boot_invalidate_checks
	.section	.rodata.str1.8
	.align	3
.LC1:
	.string	"\nNOTE: Enabling all flash boot flags and magic number"
	.text
	.align	1
	.globl	rom_boot_valid_success
	.type	rom_boot_valid_success, @function
rom_boot_valid_success:
	addi	sp,sp,-16
	sd	ra,8(sp)
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	puts
	li	a5,470286336
	li	a4,90
	sb	a4,-4(a5)
	li	a5,470286336
	sb	a4,-3(a5)
	li	a5,470286336
	li	a4,-15
	sb	a4,-2(a5)
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	rom_boot_valid_success, .-rom_boot_valid_success
	.section	.rodata.str1.8
	.align	3
.LC2:
	.string	"\nNOTE: Initiating flash boot validation"
	.align	3
.LC3:
	.string	"\nNOTE: Flash Boot validation successful"
	.text
	.align	1
	.globl	rom_boot_validate_flash_boot
	.type	rom_boot_validate_flash_boot, @function
rom_boot_validate_flash_boot:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	sd	zero,0(sp)
	sd	zero,8(sp)
	sd	zero,16(sp)
	sd	zero,24(sp)
	lui	a0,%hi(.LC2)
	addi	a0,a0,%lo(.LC2)
	call	puts
	mv	s0,sp
	mv	a2,s0
	li	a1,4096
	lui	a5,%hi(flash_boot_start_ptr)
	ld	a0,%lo(flash_boot_start_ptr)(a5)
	call	sha256_easy_hash_hex
	addi	a1,sp,32
	mv	a5,s0
	li	a2,470286336
	addi	a2,a2,-288
	sub	a2,a2,s0
.L9:
	add	a4,a2,a5
	lbu	a3,0(a5)
	lbu	a4,0(a4)
	bne	a3,a4,.L11
	addi	a5,a5,1
	bne	a5,a1,.L9
	lui	a0,%hi(.LC3)
	addi	a0,a0,%lo(.LC3)
	call	puts
	li	a0,0
	j	.L14
.L11:
	li	a0,1
.L14:
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	rom_boot_validate_flash_boot, .-rom_boot_validate_flash_boot
	.section	.rodata.str1.8
	.align	3
.LC4:
	.string	"\nNOTE: Validating the boot version"
	.text
	.align	1
	.globl	rom_boot_validate_version
	.type	rom_boot_validate_version, @function
rom_boot_validate_version:
	addi	sp,sp,-16
	sd	ra,8(sp)
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	call	puts
	li	a5,470286336
	addi	a5,a5,-32
	lbu	a5,0(a5)
	lui	a4,%hi(flash_boot_version_ptr)
	ld	a3,%lo(flash_boot_version_ptr)(a4)
	lbu	a4,0(a3)
	bgtu	a5,a4,.L21
	li	a0,3
	bne	a5,a4,.L18
	li	a0,0
	j	.L18
.L21:
	sb	a5,0(a3)
	li	a0,0
.L18:
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	rom_boot_validate_version, .-rom_boot_validate_version
	.section	.rodata.str1.8
	.align	3
.LC5:
	.string	"\nNOTE: Launching user application"
	.align	3
.LC6:
	.string	"\nERROR: Flash not valid. Not launching user application"
	.text
	.align	1
	.globl	rom_boot_launch_app
	.type	rom_boot_launch_app, @function
rom_boot_launch_app:
	addi	sp,sp,-16
	sd	ra,8(sp)
	li	a5,470286336
	lbu	a4,-4(a5)
	li	a5,90
	bne	a4,a5,.L23
	li	a5,470286336
	lbu	a4,-2(a5)
	li	a5,241
	beq	a4,a5,.L27
.L23:
	lui	a0,%hi(.LC6)
	addi	a0,a0,%lo(.LC6)
	call	puts
.L25:
	j	.L25
.L27:
	lui	a0,%hi(.LC5)
	addi	a0,a0,%lo(.LC5)
	call	puts
	call	user_app_main
.L24:
	j	.L24
	.size	rom_boot_launch_app, .-rom_boot_launch_app
	.section	.rodata.str1.8
	.align	3
.LC7:
	.string	"\nWARN: Corrupting device code"
	.text
	.align	1
	.globl	malicious_code
	.type	malicious_code, @function
malicious_code:
	addi	sp,sp,-16
	sd	ra,8(sp)
	lui	a0,%hi(.LC7)
	addi	a0,a0,%lo(.LC7)
	call	puts
	lui	a5,%hi(flash_boot_start_ptr)
	ld	a5,%lo(flash_boot_start_ptr)(a5)
	li	a4,-1
	sb	a4,4(a5)
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	malicious_code, .-malicious_code
	.section	.rodata.str1.8
	.align	3
.LC8:
	.string	"\n************************************************************"
	.align	3
.LC9:
	.string	"*     ECE 751 - Implemntation of Secure Boot on RISC-V     *"
	.align	3
.LC10:
	.string	"************************************************************"
	.align	3
.LC11:
	.string	"\nERROR: Error in invalidating flash checks"
	.align	3
.LC12:
	.string	"\nERROR: Attempting to program previous version of boot code"
	.align	3
.LC13:
	.string	"\nERROR: Flash Boot validation failed. Integrity check failed"
	.text
	.align	1
	.globl	secure_boot_launcher
	.type	secure_boot_launcher, @function
secure_boot_launcher:
	addi	sp,sp,-16
	sd	ra,8(sp)
	lui	a0,%hi(.LC8)
	addi	a0,a0,%lo(.LC8)
	call	puts
	lui	a0,%hi(.LC9)
	addi	a0,a0,%lo(.LC9)
	call	puts
	lui	a0,%hi(.LC10)
	addi	a0,a0,%lo(.LC10)
	call	puts
	call	rom_boot_invalidate_checks
	beq	a0,zero,.L31
	lui	a0,%hi(.LC11)
	addi	a0,a0,%lo(.LC11)
	call	puts
.L32:
	j	.L32
.L31:
	call	rom_boot_validate_version
	beq	a0,zero,.L33
	lui	a0,%hi(.LC12)
	addi	a0,a0,%lo(.LC12)
	call	puts
.L34:
	j	.L34
.L33:
	call	rom_boot_validate_flash_boot
	beq	a0,zero,.L35
	lui	a0,%hi(.LC13)
	addi	a0,a0,%lo(.LC13)
	call	puts
.L36:
	j	.L36
.L35:
	call	rom_boot_valid_success
	call	rom_boot_launch_app
	.size	secure_boot_launcher, .-secure_boot_launcher
	.globl	flash_boot_version_ptr
	.globl	flash_boot_end_ptr
	.globl	flash_boot_start_ptr
	.globl	flash_boot_curr_version
	.section	.sbss,"aw",@nobits
	.type	flash_boot_curr_version, @object
	.size	flash_boot_curr_version, 1
flash_boot_curr_version:
	.zero	1
	.section	.sdata,"aw"
	.align	3
	.type	flash_boot_version_ptr, @object
	.size	flash_boot_version_ptr, 8
flash_boot_version_ptr:
	.dword	flash_boot_curr_version
	.type	flash_boot_end_ptr, @object
	.size	flash_boot_end_ptr, 8
flash_boot_end_ptr:
	.dword	470285684
	.type	flash_boot_start_ptr, @object
	.size	flash_boot_start_ptr, 8
flash_boot_start_ptr:
	.dword	469800132
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
