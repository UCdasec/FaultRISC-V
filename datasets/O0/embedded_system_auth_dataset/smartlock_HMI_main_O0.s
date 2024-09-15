	.file	"HMI_main.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata
	.align	3
.LC0:
	.string	"new password"
	.align	3
.LC1:
	.string	"repeat password"
	.align	3
.LC2:
	.string	"enter password"
	.align	3
.LC3:
	.string	"old password"
	.text
	.align	1
	.globl	uartMsgInetrruptHandler
	.type	uartMsgInetrruptHandler, @function
uartMsgInetrruptHandler:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	lui	a5,%hi(recieved_data)
	lbu	a5,%lo(recieved_data)(a5)
	andi	a5,a5,0xff
	sext.w	a5,a5
	addiw	a3,a5,-77
	sext.w	a4,a3
	li	a5,43
	bgtu	a4,a5,.L15
	slli	a5,a3,32
	srli	a5,a5,32
	slli	a4,a5,2
	lui	a5,%hi(.L4)
	addi	a5,a5,%lo(.L4)
	add	a5,a4,a5
	lw	a5,0(a5)
	jr	a5
	.section	.rodata
	.align	2
	.align	2
.L4:
	.word	.L13
	.word	.L15
	.word	.L15
	.word	.L15
	.word	.L15
	.word	.L15
	.word	.L15
	.word	.L15
	.word	.L15
	.word	.L15
	.word	.L15
	.word	.L15
	.word	.L15
	.word	.L15
	.word	.L15
	.word	.L15
	.word	.L15
	.word	.L15
	.word	.L15
	.word	.L15
	.word	.L15
	.word	.L15
	.word	.L15
	.word	.L15
	.word	.L15
	.word	.L12
	.word	.L11
	.word	.L15
	.word	.L15
	.word	.L15
	.word	.L15
	.word	.L15
	.word	.L10
	.word	.L9
	.word	.L8
	.word	.L7
	.word	.L15
	.word	.L6
	.word	.L5
	.word	.L15
	.word	.L15
	.word	.L15
	.word	.L15
	.word	.L3
	.text
.L5:
	li	a0,97
	call	UART_transmit
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	HMI_askForPassword
	j	.L14
.L6:
	li	a0,97
	call	UART_transmit
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	HMI_askForPassword
	j	.L14
.L9:
	li	a0,97
	call	UART_transmit
	call	HMI_matchError
	j	.L14
.L10:
	li	a0,97
	call	UART_transmit
	call	HMI_success
	j	.L14
.L7:
	li	a0,97
	call	UART_transmit
	call	HMI_updated
	j	.L14
.L12:
	li	a0,97
	call	UART_transmit
	call	HMI_firstTimeMSG
	j	.L14
.L11:
	li	a0,97
	call	UART_transmit
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	HMI_askForPassword
	j	.L14
.L8:
	li	a0,97
	call	UART_transmit
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	HMI_askForPassword
	j	.L14
.L3:
	li	a0,97
	call	UART_transmit
	call	HMI_alarm
	j	.L14
.L13:
	li	a0,97
	call	UART_transmit
	call	HMI_displayMainMenu
	j	.L14
.L15:
	nop
.L14:
	nop
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	uartMsgInetrruptHandler, .-uartMsgInetrruptHandler
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	lui	a5,%hi(buzzer)
	addi	a0,a5,%lo(buzzer)
	call	DIO_initChannel
	lui	a5,%hi(downbutton)
	addi	a0,a5,%lo(downbutton)
	call	EINT_init
	lui	a5,%hi(upbutton)
	addi	a0,a5,%lo(upbutton)
	call	EINT_init
	lui	a5,%hi(selectbutton)
	addi	a0,a5,%lo(selectbutton)
	call	EINT_init
	call	LCD_init
	lui	a5,%hi(uart)
	addi	a0,a5,%lo(uart)
	call	UART_init
	lui	a5,%hi(uartMsgInetrruptHandler)
	addi	a0,a5,%lo(uartMsgInetrruptHandler)
	call	UART_setcallback
	li	a5,95
	lbu	a5,0(a5)
	andi	a4,a5,0xff
	li	a5,95
	ori	a4,a4,-128
	andi	a4,a4,0xff
	sb	a4,0(a5)
.L17:
	j	.L17
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
