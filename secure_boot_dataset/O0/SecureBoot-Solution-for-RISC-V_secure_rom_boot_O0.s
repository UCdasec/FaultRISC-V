	.file	"secure_rom_boot.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	flash_boot_curr_version
	.section	.sbss,"aw",@nobits
	.type	flash_boot_curr_version, @object
	.size	flash_boot_curr_version, 1
flash_boot_curr_version:
	.zero	1
	.globl	flash_boot_start_ptr
	.section	.sdata,"aw"
	.align	3
	.type	flash_boot_start_ptr, @object
	.size	flash_boot_start_ptr, 8
flash_boot_start_ptr:
	.dword	469800132
	.globl	flash_boot_end_ptr
	.align	3
	.type	flash_boot_end_ptr, @object
	.size	flash_boot_end_ptr, 8
flash_boot_end_ptr:
	.dword	470285684
	.globl	flash_boot_version_ptr
	.align	3
	.type	flash_boot_version_ptr, @object
	.size	flash_boot_version_ptr, 8
flash_boot_version_ptr:
	.dword	flash_boot_curr_version
	.text
	.align	1
	.globl	rom_boot_handle_error
	.type	rom_boot_handle_error, @function
rom_boot_handle_error:
	addi	sp,sp,-16
	sd	s0,8(sp)
	addi	s0,sp,16
.L2:
	j	.L2
	.size	rom_boot_handle_error, .-rom_boot_handle_error
	.section	.rodata
	.align	3
.LC0:
	.string	"\nNOTE: Invalidating flash boot flags"
	.text
	.align	1
	.globl	rom_boot_invalidate_checks
	.type	rom_boot_invalidate_checks, @function
rom_boot_invalidate_checks:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	puts
	li	a5,470286336
	addi	a5,a5,-4
	sd	a5,-24(s0)
	li	a5,470286336
	addi	a5,a5,-2
	sd	a5,-32(s0)
	ld	a5,-24(s0)
	sb	zero,0(a5)
	ld	a5,-24(s0)
	addi	a5,a5,1
	sb	zero,0(a5)
	ld	a5,-32(s0)
	li	a4,-16
	sb	a4,0(a5)
	li	a5,0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	rom_boot_invalidate_checks, .-rom_boot_invalidate_checks
	.section	.rodata
	.align	3
.LC1:
	.string	"\nNOTE: Enabling all flash boot flags and magic number"
	.text
	.align	1
	.globl	rom_boot_valid_success
	.type	rom_boot_valid_success, @function
rom_boot_valid_success:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	puts
	li	a5,470286336
	addi	a5,a5,-4
	sd	a5,-24(s0)
	li	a5,470286336
	addi	a5,a5,-2
	sd	a5,-32(s0)
	ld	a5,-24(s0)
	li	a4,90
	sb	a4,0(a5)
	ld	a5,-24(s0)
	addi	a5,a5,1
	li	a4,90
	sb	a4,0(a5)
	ld	a5,-32(s0)
	li	a4,-15
	sb	a4,0(a5)
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	rom_boot_valid_success, .-rom_boot_valid_success
	.section	.rodata
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
	addi	sp,sp,-80
	sd	ra,72(sp)
	sd	s0,64(sp)
	addi	s0,sp,80
	li	a5,16
	sb	a5,-25(s0)
	sb	zero,-17(s0)
	sd	zero,-72(s0)
	sd	zero,-64(s0)
	sd	zero,-56(s0)
	sd	zero,-48(s0)
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	puts
	li	a5,470286336
	addi	a5,a5,-288
	sd	a5,-40(s0)
	lui	a5,%hi(flash_boot_start_ptr)
	ld	a5,%lo(flash_boot_start_ptr)(a5)
	addi	a4,s0,-72
	mv	a2,a4
	li	a1,4096
	mv	a0,a5
	call	sha256_easy_hash_hex
	sw	zero,-24(s0)
	j	.L7
.L11:
	lw	a5,-24(s0)
	addi	a5,a5,-16
	add	a5,a5,s0
	lbu	a3,-56(a5)
	lw	a5,-24(s0)
	ld	a4,-40(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a3
	bne	a4,a5,.L8
	li	a5,1
	sb	a5,-17(s0)
	j	.L15
.L8:
	sb	zero,-17(s0)
	j	.L10
.L15:
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
.L7:
	lw	a5,-24(s0)
	sext.w	a4,a5
	li	a5,31
	ble	a4,a5,.L11
.L10:
	lbu	a5,-17(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L12
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	puts
	li	a5,0
	j	.L14
.L12:
	li	a5,1
.L14:
	mv	a0,a5
	ld	ra,72(sp)
	ld	s0,64(sp)
	addi	sp,sp,80
	jr	ra
	.size	rom_boot_validate_flash_boot, .-rom_boot_validate_flash_boot
	.section	.rodata
	.align	3
.LC4:
	.string	"\nNOTE: Validating the boot version"
	.text
	.align	1
	.globl	rom_boot_validate_version
	.type	rom_boot_validate_version, @function
rom_boot_validate_version:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	puts
	li	a5,470286336
	addi	a5,a5,-32
	sd	a5,-24(s0)
	ld	a5,-24(s0)
	lbu	a4,0(a5)
	lui	a5,%hi(flash_boot_version_ptr)
	ld	a5,%lo(flash_boot_version_ptr)(a5)
	lbu	a5,0(a5)
	bleu	a4,a5,.L17
	lui	a5,%hi(flash_boot_version_ptr)
	ld	a5,%lo(flash_boot_version_ptr)(a5)
	ld	a4,-24(s0)
	lbu	a4,0(a4)
	sb	a4,0(a5)
	li	a5,0
	j	.L18
.L17:
	ld	a5,-24(s0)
	lbu	a4,0(a5)
	lui	a5,%hi(flash_boot_version_ptr)
	ld	a5,%lo(flash_boot_version_ptr)(a5)
	lbu	a5,0(a5)
	bne	a4,a5,.L19
	li	a5,0
	j	.L18
.L19:
	li	a5,3
.L18:
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	rom_boot_validate_version, .-rom_boot_validate_version
	.section	.rodata
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
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	li	a5,470286336
	addi	a5,a5,-4
	sd	a5,-24(s0)
	li	a5,470286336
	addi	a5,a5,-2
	sd	a5,-32(s0)
	ld	a5,-24(s0)
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,90
	bne	a4,a5,.L21
	ld	a5,-32(s0)
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,241
	bne	a4,a5,.L21
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	puts
	call	user_app_main
.L22:
	j	.L22
.L21:
	lui	a5,%hi(.LC6)
	addi	a0,a5,%lo(.LC6)
	call	puts
	call	rom_boot_handle_error
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	rom_boot_launch_app, .-rom_boot_launch_app
	.section	.rodata
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
	sd	s0,0(sp)
	addi	s0,sp,16
	lui	a5,%hi(.LC7)
	addi	a0,a5,%lo(.LC7)
	call	puts
	lui	a5,%hi(flash_boot_start_ptr)
	ld	a5,%lo(flash_boot_start_ptr)(a5)
	addi	a5,a5,4
	li	a4,-1
	sb	a4,0(a5)
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	malicious_code, .-malicious_code
	.section	.rodata
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
	sd	s0,0(sp)
	addi	s0,sp,16
	lui	a5,%hi(.LC8)
	addi	a0,a5,%lo(.LC8)
	call	puts
	lui	a5,%hi(.LC9)
	addi	a0,a5,%lo(.LC9)
	call	puts
	lui	a5,%hi(.LC10)
	addi	a0,a5,%lo(.LC10)
	call	puts
	call	rom_boot_invalidate_checks
	mv	a5,a0
	beq	a5,zero,.L25
	lui	a5,%hi(.LC11)
	addi	a0,a5,%lo(.LC11)
	call	puts
	call	rom_boot_handle_error
.L25:
	call	rom_boot_validate_version
	mv	a5,a0
	beq	a5,zero,.L26
	lui	a5,%hi(.LC12)
	addi	a0,a5,%lo(.LC12)
	call	puts
	call	rom_boot_handle_error
.L26:
	call	rom_boot_validate_flash_boot
	mv	a5,a0
	beq	a5,zero,.L27
	lui	a5,%hi(.LC13)
	addi	a0,a5,%lo(.LC13)
	call	puts
	call	rom_boot_handle_error
.L27:
	call	rom_boot_valid_success
	call	rom_boot_launch_app
.L28:
	j	.L28
	.size	secure_boot_launcher, .-secure_boot_launcher
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
