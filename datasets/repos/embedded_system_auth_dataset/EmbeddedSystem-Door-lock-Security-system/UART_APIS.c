/*
 * Uart Drive.c
 *
 * Created: 25/09/2017 07:35:28 م
 * Author : SHIKO
 */ 

#include <avr/io.h>
#include "UART_Drive.h"
#include "UART_Cfg.h"

int main(void)
{
    /* Replace with your application code */
    while (1) 
    {
    }
}
// Configure Function for UART Drive (Micro-control abstraction layer)
void UART_int ()  
{ 
	 UCSRB |= 1 <<4 ;  // Enable Rx 
	 UCSRB |= 1 <<3 ;  // Enable Tx
	 
	 UCSRC |= 1 <<7 ;   // Choose UCSRC Write 
	 UCSRC |= 1 <<2 ;   // Data Bits number "8bit"
	 UCSRC |= 1 <<1 ;   // Data Bits number "8bit"
	
	 UBRRL = (uint8_t) BUDR ;  // Low Bouad Rate 
	 UBRRH = (uint8_t) BUDR>>8 ;  // High Boud Rate 
	 state = 1 ;
}

Check_Type UART_Write(uint8_t Data)
{
	 Check_Type RetValue ; 
	if (state == 1)
	{
		while (!(UCSRA & 1<<5)) // Wait Empty Pin 
		{
			UDR = Data ; 
		} 

	 RetValue = Check_ok ; 
	}else {		RetValue = Check_Nok ;}
		return RetValue; 
}

uint8_t UART_Read()
{
	if (state == 1)
	   {
		while (!(UCSRA & 1<<7)); // Complete Reading 
	    }else {UDR = 0 ;}
		return UDR ; 
	}

uint8_t UART_String (char * Data) // Write  string
{
	while ((*Data) =! NULL)
	{ 
		 UART_Write(*Data); 
		 Data ++ ; 
	}
}