/*
 * GccApplication5.c
 *
 * Created: 28/9/2017 9:02:04 AM
 * Author : MOHAMMED-PC
 */ 
#include "GPIO.h"
#include "GPIO_Cfg.h"
#include "LCD.h"
#include "LCD_Cfg.h"
#include "keyPad_Drive.h"
#include <avr/io.h>
#include "eeprom.h"
#include "interrupt.h"
#include "avr/interrupt.h"

int main(void)
{
	GPIO_Init();
	LCD_Init();
	interrupt_Init();
	sei();
	unsigned char error= 0;
	EEPROM_write(10,error);
	int i ;
	unsigned char Password[4] = {'0','1','2','3'};
		for (i=0; i < 4; i++)
	{
		EEPROM_write(i,Password[i]);
	}
	uint8_t  Matched = 0 ;
	uint8_t try = 0 ; 
	uint8_t Flag = 0 ;
	unsigned char KeyPad_Com ;
	GPIO_Write(15,0x00);
	LCD_SetCursPos(0,0);
	LCD_DispString("Enter Password");
	
	while(1)
	{
		error =EEPROM_read(10);
		if (error < 3)
		{
			Flag = 0; 
           KeyPad_Com = getkey();
            if (KeyPad_Com !='F')
            {
	
         	LCD_SetCursPos(try,1);
	        LCD_DispChar(KeyPad_Com);
 	
       	if ( KeyPad_Com == Password[try] )
	       {
	     	Matched++;
	        }
	          try++;
	
	  if(KeyPad_Com=='=')
    {
		if((try == 5)&&(--try==Matched))
		{
			LCD_Clear();
			LCD_SetCursPos(0,0);
			LCD_DispString("Right Password");
			GPIO_Write(15,0xff);
		}else
		{
			LCD_Clear();
			LCD_SetCursPos(0,0);
			LCD_DispString("Wrong Password");
			try = 0 ;
			Matched = 0;
			error++ ;
			EEPROM_write(10,error);
			Delay(80000000);
			LCD_Clear();
			LCD_SetCursPos(0,0);
			LCD_DispString("Enter Password");
	  }
    }
   }	
  }else	
    { if (Flag == 0)
		{
	  LCD_Clear();
      LCD_SetCursPos(0,0);
      LCD_DispString("Blocked Password");
	  Flag=1;
		}
	  }	
 }
	return 0;
}

ISR(INT0_vect)
{
	LCD_Clear();
	LCD_SetCursPos(0,0);
	LCD_DispString("System Reseted");
	EEPROM_write(10,0);
	Delay(80000000);
	main();
}