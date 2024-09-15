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
int main(void)
{
	GPIO_Init();
	LCD_Init();
	LCD_SetCursPos(0,0);
	LCD_DispString("Enter Password: ");
	uint8_t error = 0;
	EEPROM_write(10,error);
	int i ; 
	unsigned char Password[4] = {'0','1','2','3'};
		for (i=0; i < 4; i++)
		{
			EEPROM_write(i,Password[i]);
		}
	unsigned char LoopIndex;
	i = 0 ;
	int j =0 ; 
	LCD_SetCursPos(0,1);
	while(1)
	{
		if (error <= 2)
		{
		LoopIndex = getkey() ;
		if(LoopIndex != 'F')
		{
           if (LoopIndex == Password[i] ){i++;}	
			   j++;	
			   LCD_DispChar('*');	
		} 
		if (j==3)
		{
		if(i==j){GPIO_Write(15,0xff);}
		else {
			error ++ ;
			 EEPROM_write(10,error); 
			 i=0;
			 j=0 ;
		}
		}
		}else{LCD_DispString("Door Locked");}
	}
	return 0;
	}
	
	
	
		
