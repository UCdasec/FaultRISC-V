	.file	"HMI_main.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
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
	lui	a5,%hi(recieved_data)
	lbu	a5,%lo(recieved_data)(a5)
	addiw	a5,a5,-77
	andi	a3,a5,0xff
	li	a4,43
	bgtu	a3,a4,.L15
	addi	sp,sp,-16
	sd	ra,8(sp)
	slli	a5,a3,2
	lui	a4,%hi(.L4)
	addi	a4,a4,%lo(.L4)
	add	a5,a5,a4
	lw	a5,0(a5)
	jr	a5
	.section	.rodata
	.align	2
	.align	2
.L4:
	.word	.L13
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L12
	.word	.L11
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L10
	.word	.L9
	.word	.L8
	.word	.L7
	.word	.L1
	.word	.L6
	.word	.L5
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L1
	.word	.L3
	.text
.L5:
	li	a0,97
	call	UART_transmit
	lui	a0,%hi(.LC0)
	addi	a0,a0,%lo(.LC0)
	call	HMI_askForPassword
.L1:
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
.L6:
	li	a0,97
	call	UART_transmit
	lui	a0,%hi(.LC1)
	addi	a0,a0,%lo(.LC1)
	call	HMI_askForPassword
	j	.L1
.L9:
	li	a0,97
	call	UART_transmit
	call	HMI_matchError
	j	.L1
.L10:
	li	a0,97
	call	UART_transmit
	call	HMI_success
	j	.L1
.L7:
	li	a0,97
	call	UART_transmit
	call	HMI_updated
	j	.L1
.L12:
	li	a0,97
	call	UART_transmit
	call	HMI_firstTimeMSG
	j	.L1
.L11:
	li	a0,97
	call	UART_transmit
	lui	a0,%hi(.LC2)
	addi	a0,a0,%lo(.LC2)
	call	HMI_askForPassword
	j	.L1
.L8:
	li	a0,97
	call	UART_transmit
	lui	a0,%hi(.LC3)
	addi	a0,a0,%lo(.LC3)
	call	HMI_askForPassword
	j	.L1
.L3:
	li	a0,97
	call	UART_transmit
	call	HMI_alarm
	j	.L1
.L13:
	li	a0,97
	call	UART_transmit
	call	HMI_displayMainMenu
	j	.L1
.L15:
	ret
	.size	uartMsgInetrruptHandler, .-uartMsgInetrruptHandler
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sd	ra,8(sp)
	lui	a0,%hi(buzzer)
	addi	a0,a0,%lo(buzzer)
	call	DIO_initChannel
	lui	a0,%hi(downbutton)
	addi	a0,a0,%lo(downbutton)
	call	EINT_init
	lui	a0,%hi(upbutton)
	addi	a0,a0,%lo(upbutton)
	call	EINT_init
	lui	a0,%hi(selectbutton)
	addi	a0,a0,%lo(selectbutton)
	call	EINT_init
	call	LCD_init
	lui	a0,%hi(uart)
	addi	a0,a0,%lo(uart)
	call	UART_init
	lui	a0,%hi(uartMsgInetrruptHandler)
	addi	a0,a0,%lo(uartMsgInetrruptHandler)
	call	UART_setcallback
	li	a4,95
	lbu	a5,0(a4)
	ori	a5,a5,128
	sb	a5,0(a4)
.L19:
	j	.L19
	.size	main, .-main
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
