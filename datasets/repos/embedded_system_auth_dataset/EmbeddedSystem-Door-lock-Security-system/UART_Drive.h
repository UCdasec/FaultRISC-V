/*
 * UART_Drive.h
 *
 * Created: 25/09/2017 09:16:21 م
 *  Author: SHIKO
 */ 


#ifndef UART_DRIVE_H_
#define UART_DRIVE_H_

typedef enum  Check_Type { Check_ok= 1 , Check_Nok  } Check_Type ;
uint8_t state =  0 ;

#define  BUDR  Ofosc/16*(Boud_Rate)-1
#define  NULL 0 
void UART_int () ;
Check_Type UART_Write(uint8_t Data );
uint8_t UART_Read();
uint8_t UART_String (char * Data); 

#endif /* UART_DRIVE_H_ */