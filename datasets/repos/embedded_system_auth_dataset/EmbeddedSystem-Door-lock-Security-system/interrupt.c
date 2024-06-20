/*
 * CFile1.c
 *
 * Created: 29/09/2017 03:18:19 ص
 *  Author: SHIKO
 */
#include "avr/interrupt.h"

 void interrupt_Init()
 { 
	 GICR  |= 1<<INT0; 
	 MCUCR = 0xff ;
 }