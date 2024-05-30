/*
 * rfid.c
 *
 *  Created on: May 17, 2023
 *      Author: HP
 */
#include "rfid.h"
#include "rc522.h"
#include "i2c-lcd.h"
#include "Menu_lcd.h"

uint8_t DATATEST[4] = {0x00, 0x00, 0x00, 0x00};
uint8_t DATA_RIGHT[3][4] = {{0x32, 0xC1, 0x75, 0x1E}, {0x00, 0x00, 0x00, 0x00}, {0x00, 0x00, 0x00, 0x00}};
uint8_t tt_1;
uint8_t CHECK = 1, DOOR = 0;
uint8_t UID[4];
uint8_t TagType;

int QUET_THE(uint8_t DATA_RIGHT[3][4], uint8_t UID[4])
{
	for (int i = 0; i < 3; i++)
	{
		for (int j = 0; j < 4; j++)
		{
			if (UID[j] == DATA_RIGHT[i][j])
			{
				CHECK = CHECK * 1;
			}
			else
			{
				CHECK = 0;
			}
		}
		if (CHECK == 1)
		{
			break;
		}
		if (i < 2)
		{
			if (CHECK == 0)
			{
				CHECK = 1;
			}
		}
	}
	return CHECK;
}

void QUET_THE2(uint8_t DATA_RIGHT[3][4], uint8_t UID[4]) // THEM THE
{
	for (int i = 0; i < 3; i++)
	{
		for (int j = 0; j < 4; j++)
		{
			if (DATA_RIGHT[i][j] == DATATEST[j])
			{
				CHECK = CHECK * 1;
			}
			else
			{
				CHECK = 0;
			}
		}
		if (CHECK == 1)
		{
			for (int m = 0; m < 4; m++)
			{
				DATA_RIGHT[i][m] = UID[m];
			}
			ok = 1;
			break;
		}
		else if (CHECK == 0)
		{
			CHECK = 1;
		}
	}
	if (ok == 0)
	{
		lcd_clear_display();
		HAL_Delay(10);
		lcd_goto_XY(1, 0);
		lcd_send_string(" HET DUNG LUONG");
		HAL_Delay(1000);
	}
}

void QUET_THE3(uint8_t DATA_RIGHT[3][4], uint8_t UID[4]) // XOA THE
{
	for (int i = 1; i < 3; i++)
	{
		for (int j = 0; j < 4; j++)
		{
			if (UID[j] == DATA_RIGHT[i][j])
			{
				CHECK = CHECK * 1;
			}
			else
			{
				CHECK = 0;
			}
		}
		if (CHECK == 1)
		{
			for (int m = 0; m < 4; m++)
			{
				DATA_RIGHT[i][m] = 0x00;
			}
			ok = 1;
			break;
		}
		else if (CHECK == 0)
		{
			CHECK = 1;
		}
	}
	if (ok == 0)
	{
		lcd_clear_display();
		HAL_Delay(10);
		lcd_goto_XY(1, 0);
		lcd_send_string("KHONG CO THE NAY");
		HAL_Delay(1000);
	}
}

int QUET_THE4(uint8_t DATA_RIGHT[3][4], uint8_t UID[4])
{
	for (int i = 0; i < 4; i++)
	{
		if (UID[i] == DATA_RIGHT[0][i])
		{
			CHECK = CHECK * 1;
		}
		else
		{
			CHECK = 0;
		}
	}
	return CHECK;
}

void Buzzer(int Time, int Loop)
{
	uint8_t i;
	for (i = 0; i < Loop; i++)
	{
		HAL_GPIO_WritePin(GPIOB, GPIO_PIN_11, GPIO_PIN_RESET);
		HAL_Delay(Time);
		HAL_GPIO_WritePin(GPIOB, GPIO_PIN_11, GPIO_PIN_SET);
		HAL_Delay(Time);
	}
}

void Mocua(){
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_5, GPIO_PIN_SET);
	HAL_Delay(10000);
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_5, GPIO_PIN_RESET);
}

void Kiemtrarfid()
{
	if (MFRC522_Check(&TagType)) // Check any card
	{
		if (MFRC522_ReadCardSerial(&UID)) // Read ID
		{
			tt_1 = QUET_THE(DATA_RIGHT, UID);
			if (tt_1 == 1)
			{
				lcd_clear_display();
				HAL_Delay(10);
				lcd_goto_XY(1, 3);
				lcd_send_string("THE HOP LE");
				lcd_goto_XY(2, 1);
				lcd_send_string("MOI BAN VAO NHA");
				Buzzer(70, 3);
				Mocua();
			}
			else
			{
				lcd_clear_display();
				HAL_Delay(10);
				lcd_goto_XY(1, 0);
				lcd_send_string("THE KHONG HOP LE ");
				Buzzer(200, 1);
				CHECK = 1;
				HAL_Delay(1000);
			}
		}
	}
}

void Checkadmin()
{
	if (MFRC522_Check(&TagType)) // Check any card
	{
		if (MFRC522_ReadCardSerial(&UID)) // Read ID
		{
			tt_1 = QUET_THE4(DATA_RIGHT, UID);
			if (tt_1 == 1)
			{
				ok = 1;
			}
			else
			{
				lcd_clear_display();
				HAL_Delay(10);
				lcd_goto_XY(1, 0);
				lcd_send_string("THE KHONG HOP LE ");
				Buzzer(200, 1);
				CHECK = 1;
				HAL_Delay(1000);
			}
		}
	}
}

void THEM_THE()
{
	if (MFRC522_Check(&TagType)) // Check any card
	{
		if (MFRC522_ReadCardSerial(&UID)) // Read ID
		{
			QUET_THE2(DATA_RIGHT, UID);
		}
	}
}

void XOA_THE()
{
	if (MFRC522_Check(&TagType)) // Check any card
	{
		if (MFRC522_ReadCardSerial(&UID)) // Read ID
		{
			QUET_THE3(DATA_RIGHT, UID);
		}
	}
}
