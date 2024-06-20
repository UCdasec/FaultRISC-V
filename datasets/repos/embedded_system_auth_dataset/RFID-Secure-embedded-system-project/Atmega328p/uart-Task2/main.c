/*
 * uart-Task2.c
 *
 * Created: 1/16/2021 2:34:59 PM
 * Author : Jayod
 */ 

//define the board
#define __AVR_ATmega328P__

#define F_CPU 16000000UL
#define BAUD 9600
#define UBRR_VALUE ((F_CPU/16/BAUD)-1)

// define pins
#define  D4 eS_PORTD4
#define  D5 eS_PORTD5
#define  D6 eS_PORTD6
#define  D7 eS_PORTD7
#define  RS eS_PORTB1
#define  EN eS_PORTB0

#include <avr/io.h>
#include <util/delay.h>

#include <avr/interrupt.h>
#include <avr/sfr_defs.h>
#include <string.h>
#include <stdlib.h>
#include "LCD.h"		//include LCD library
#include "SWseriale.h" // include softwareSerial library


unsigned char rx; //Define variable for storing received character for USART 


void Config_USART(void)  // Configuration of USART 
{
	UBRR0L = (unsigned char) UBRR_VALUE; //setting UBRR0 Lower byte
	UBRR0H = (unsigned char) (UBRR_VALUE>>8); //setting URR0 upper byte
	
	UCSR0B |= (1<<TXEN0);  // enable transmitter
	UCSR0B |= (1<<RXEN0);  //enable receiver 
	UCSR0C |= (1<<UCSZ01) | (1<<UCSZ00); //set 8 bit data
	
}

unsigned char USART_Receive(void) // Serial Received function
{
	//while(!(UCSR0A & (1<<RXC0)));
	if((UCSR0A & (1<<RXC0))){ //check whether data received
		return UDR0;	//get and return received data from buffer
	}else{
		return NULL;	//return NULL if not received data
	}
}

void USART_Transmit(unsigned char data[2])  // Serial transmitter function
{
	while(!(UCSR0A & (1<<UDRE0)));  //check transmitter buffer
	UDR0= data;  //put data buffer and send the data
}

void Gate(void){  // define function for control gate(servo  motor)
	PORTC = 0x01;
	_delay_us(1000);
	PORTC = 0x00;
	_delay_ms(2000);

	//Rotate Motor to 90 degree
	PORTC = 0x01;
	_delay_us(1500);
	PORTC = 0x00;

	_delay_ms(2000);

	//Rotate Motor to 180 degree
	PORTC = 0x01;
	//_delay_us(2000);
	PORTC = 0x00;

	//_delay_ms(2000);
	
	//Rotate Motor to 0 degree
	PORTC = 0x01;
	_delay_us(1000);
	PORTC = 0x00;
}

int main(void)
{
	DDRB |= 0B00100000;
	Config_USART();
	DDRB |=(1<<PORTB5);		//portB pin5 as output
	//PORTB |=(1<<PORTB5);	// portB pin 5 as HIGH

	sei();
	SWseriale_begin(); // Initialize INT1, Timer2, Pin 3 (Input) and Pin 4 (Output)
	
	Lcd4_Init();   // LCD initialization
	Lcd4_Set_Cursor(1,0);  //LCD cursor set
	
	Lcd4_Write_String("Swipe the Card");
	DDRC = 0x01; //Makes RC0 output pin
	PORTC = 0x00;
	
	while (1)
	{
		 if (SWseriale_available()){ // Checks if any character has been received
			 uint8_t temp = SWseriale_read(); // Reads one character from SWseriale received data buffer
			  USART_Transmit(temp);	 //transmit the int
		 }
		 rx= USART_Receive();//reads character from hardware serial
		 // rx is a char is received from desktop application inform whether the user is valid or not
		 if(rx=='K'){   // K-> user Vaild 
			  Lcd4_Write_String("Access Grant");
			  PORTB |= 0B00100000;  //portB pin 5 as HIGH -> for buzzer
			  _delay_ms(200);
			  PORTB &= 0B11011111;  //portB pin 5 as LOW
			  _delay_ms(200);
			  rx= 'O';  // Reset variable
			 Gate();  //gate open function
			 Lcd4_Clear();
		 }
		 else if(rx == 'X'){  // X -> user unotherized
			 Lcd4_Write_String("Access Denied"); 
			 PORTB |= 0B00100000;  //portD pin 5 as HIGH (13)
			 _delay_ms(3000);
			 PORTB &= 0B11011111;  //portD pin 5 as LOW
			 _delay_ms(200);
			  rx= 'O';
			  Lcd4_Clear();	 
		 }	
	}
	return 0;
}



