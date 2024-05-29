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
	lui	a0,%hi(.LC0)
	addi	sp,sp,-16
	addi	a0,a0,%lo(.LC0)
	sd	ra,8(sp)
	call	puts
	li	a3,470286336
	sb	zero,-4(a3)
	li	a4,470286336
	sb	zero,-3(a4)
	li	a5,470286336
	li	a4,-16
	sb	a4,-2(a5)
	ld	ra,8(sp)
	li	a0,0
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
	lui	a0,%hi(.LC1)
	addi	sp,sp,-16
	addi	a0,a0,%lo(.LC1)
	sd	ra,8(sp)
	call	puts
	li	a2,90
	li	a3,470286336
	sb	a2,-4(a3)
	li	a4,470286336
	sb	a2,-3(a4)
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
	lui	a0,%hi(.LC2)
	addi	sp,sp,-48
	addi	a0,a0,%lo(.LC2)
	sd	ra,40(sp)
	sd	zero,0(sp)
	sd	zero,8(sp)
	sd	zero,16(sp)
	sd	zero,24(sp)
	call	puts
	lui	a5,%hi(flash_boot_start_ptr)
	ld	a0,%lo(flash_boot_start_ptr)(a5)
	mv	a2,sp
	li	a1,4096
	call	sha256_easy_hash_hex
	li	a2,470286336
	mv	a5,sp
	addi	a2,a2,-288
	addi	a1,sp,32
	sub	a2,a2,a5
	j	.L10
.L18:
	beq	a5,a1,.L17
.L10:
	add	a4,a2,a5
	lbu	a3,0(a5)
	lbu	a4,0(a4)
	addi	a5,a5,1
	beq	a3,a4,.L18
	ld	ra,40(sp)
	li	a0,1
	addi	sp,sp,48
	jr	ra
.L17:
	lui	a0,%hi(.LC3)
	addi	a0,a0,%lo(.LC3)
	call	puts
	ld	ra,40(sp)
	li	a0,0
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
	lui	a0,%hi(.LC4)
	addi	sp,sp,-16
	addi	a0,a0,%lo(.LC4)
	sd	ra,8(sp)
	call	puts
	lui	a5,%hi(flash_boot_version_ptr)
	ld	a2,%lo(flash_boot_version_ptr)(a5)
	li	a5,470286336
	lbu	a4,-32(a5)
	lbu	a3,0(a2)
	bgtu	a4,a3,.L25
	li	a0,3
	beq	a4,a3,.L21
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
.L25:
	sb	a4,0(a2)
.L21:
	ld	ra,8(sp)
	li	a0,0
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
	lbu	a3,-4(a5)
	li	a4,90
	bne	a3,a4,.L27
	lbu	a3,-2(a5)
	li	a4,241
	beq	a3,a4,.L31
.L27:
	lui	a0,%hi(.LC6)
	addi	a0,a0,%lo(.LC6)
	call	puts
.L29:
	j	.L29
.L31:
	lui	a0,%hi(.LC5)
	addi	a0,a0,%lo(.LC5)
	call	puts
	call	user_app_main
.L28:
	j	.L28
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
	lui	a0,%hi(.LC7)
	addi	sp,sp,-16
	addi	a0,a0,%lo(.LC7)
	sd	ra,8(sp)
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
	.string	"\nERROR: Attempting to program previous version of boot code"
	.align	3
.LC12:
	.string	"\nERROR: Flash Boot validation failed. Integrity check failed"
	.text
	.align	1
	.globl	secure_boot_launcher
	.type	secure_boot_launcher, @function
secure_boot_launcher:
	lui	a0,%hi(.LC8)
	addi	sp,sp,-16
	addi	a0,a0,%lo(.LC8)
	sd	ra,8(sp)
	call	puts
	lui	a0,%hi(.LC9)
	addi	a0,a0,%lo(.LC9)
	call	puts
	lui	a0,%hi(.LC10)
	addi	a0,a0,%lo(.LC10)
	call	puts
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	puts
	li	a4,470286336
	sb	zero,-4(a4)
	li	a5,470286336
	li	a3,470286336
	sb	zero,-3(a5)
	li	a2,-16
	sb	a2,-2(a3)
	call	rom_boot_validate_version
	beq	a0,zero,.L35
	lui	a0,%hi(.LC11)
	addi	a0,a0,%lo(.LC11)
	call	puts
.L36:
	j	.L36
.L35:
	call	rom_boot_validate_flash_boot
	beq	a0,zero,.L37
	lui	a0,%hi(.LC12)
	addi	a0,a0,%lo(.LC12)
	call	puts
.L38:
	j	.L38
.L37:
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
