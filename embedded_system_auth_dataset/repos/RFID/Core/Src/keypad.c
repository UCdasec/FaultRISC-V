/*
 * keypad.c
 *
 *  Created on: May 17, 2023
 *      Author: HP
 */
#include "keypad.h"
#include "i2c-lcd.h"
#include "rfid.h"
#include "Menu_lcd.h"

int Right[6] = {1, 4, 0, 5, 0, 2};
int Password[6];
int c = 1;
int i = 0;
int end = 0;
int key = 0;

void Keyscan(void)
{
	while (end == 0)
	{
		HAL_GPIO_WritePin(GPIOA, ROW_1, GPIO_PIN_RESET);
		HAL_GPIO_WritePin(GPIOA, ROW_2 | ROW_3 | ROW_4, GPIO_PIN_SET);
		if (!HAL_GPIO_ReadPin(GPIOB, COL_1))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_1))
			{
				Password[i] = 1;
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(10);
			}
		}
		if (!HAL_GPIO_ReadPin(GPIOB, COL_2))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_2))
			{
				Password[i] = 2;
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(10);
			}
		}
		if (!HAL_GPIO_ReadPin(GPIOB, COL_3))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_3))
			{
				Password[i] = 3;
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(10);
			}
		}
		if (!HAL_GPIO_ReadPin(GPIOB, COL_4))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_4))
			{
				Matkhau();
				i = 0;
			}
		}

		HAL_GPIO_WritePin(GPIOA, ROW_2, GPIO_PIN_RESET);
		HAL_GPIO_WritePin(GPIOA, ROW_1 | ROW_3 | ROW_4, GPIO_PIN_SET);
		if (!HAL_GPIO_ReadPin(GPIOB, COL_1))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_1))
			{
				Password[i] = 4;
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(10);
			}
		}
		if (!HAL_GPIO_ReadPin(GPIOB, COL_2))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_2))
			{
				Password[i] = 5;
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(10);
			}
		}
		if (!HAL_GPIO_ReadPin(GPIOB, COL_3))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_3))
			{
				Password[i] = 6;
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(10);
			}
		}
		if (!HAL_GPIO_ReadPin(GPIOB, COL_4))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_4))
			{
				Password[i] = 'B';
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(10);
			}
		}

		HAL_GPIO_WritePin(GPIOA, ROW_3, GPIO_PIN_RESET);
		HAL_GPIO_WritePin(GPIOA, ROW_2 | ROW_1 | ROW_4, GPIO_PIN_SET);
		if (!HAL_GPIO_ReadPin(GPIOB, COL_1))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_1))
			{
				Password[i] = 7;
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(10);
			}
		}
		if (!HAL_GPIO_ReadPin(GPIOB, COL_2))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_2))
			{
				Password[i] = 8;
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(10);
			}
		}
		if (!HAL_GPIO_ReadPin(GPIOB, COL_3))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_3))
			{
				Password[i] = 9;
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(10);
			}
		}
		if (!HAL_GPIO_ReadPin(GPIOB, COL_4))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_4))
			{
				Password[i] = 'C';
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(10);
			}
		}

		HAL_GPIO_WritePin(GPIOA, ROW_4, GPIO_PIN_RESET);
		HAL_GPIO_WritePin(GPIOA, ROW_2 | ROW_3 | ROW_1, GPIO_PIN_SET);
		if (!HAL_GPIO_ReadPin(GPIOB, COL_1))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_1))
			{
				end = 1;
			}
		}
		if (!HAL_GPIO_ReadPin(GPIOB, COL_2))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_2))
			{
				Password[i] = 0;
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(10);
			}
		}
		if (!HAL_GPIO_ReadPin(GPIOB, COL_3))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_3))
			{
				Password[i] = '#';
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(50);
			}
		}
		if (!HAL_GPIO_ReadPin(GPIOB, COL_4))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_4))
			{
				Password[i] = 'D';
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(50);
			}
		}
	}
	kiemtramatkhau();
	if (c == 0)
	{
		lcd_clear_display();
		HAL_Delay(10);
		lcd_goto_XY(1, 0);
		lcd_send_string("  SAI MAT KHAU");
		Buzzer(200, 1);
		c = 1;
		HAL_Delay(2000);
	}
	else if (c == 1)
	{
		lcd_clear_display();
		HAL_Delay(10);
		lcd_goto_XY(1, 0);
		lcd_send_string(" MAT KHAU DUNG");
		HAL_Delay(10);
		lcd_goto_XY(2, 0);
		lcd_send_string("MOI BAN VAO NHA");
		Buzzer(70, 3);
		Mocua();
	}
}

void kiemtramatkhau()
{
	for (i = 0; i < 6; i++)
	{
		if (Password[i] != Right[i])
		{
			c = 0;
		}
		else
		{
			c = c * 1;
		}
	}
}

void matkhaumoi()
{
	while (end == 0)
	{
		HAL_GPIO_WritePin(GPIOA, ROW_1, GPIO_PIN_RESET);
		HAL_GPIO_WritePin(GPIOA, ROW_2 | ROW_3 | ROW_4, GPIO_PIN_SET);
		if (!HAL_GPIO_ReadPin(GPIOB, COL_1))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_1))
			{
				Right[i] = 1;
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(10);
			}
		}
		if (!HAL_GPIO_ReadPin(GPIOB, COL_2))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_2))
			{
				Right[i] = 2;
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(10);
			}
		}
		if (!HAL_GPIO_ReadPin(GPIOB, COL_3))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_3))
			{
				Right[i] = 3;
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(10);
			}
		}
		if (!HAL_GPIO_ReadPin(GPIOB, COL_4))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_4))
			{
				Doimatkhau();
				i = 0;
			}
		}

		HAL_GPIO_WritePin(GPIOA, ROW_2, GPIO_PIN_RESET);
		HAL_GPIO_WritePin(GPIOA, ROW_1 | ROW_3 | ROW_4, GPIO_PIN_SET);
		if (!HAL_GPIO_ReadPin(GPIOB, COL_1))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_1))
			{
				Right[i] = 4;
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(10);
			}
		}
		if (!HAL_GPIO_ReadPin(GPIOB, COL_2))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_2))
			{
				Right[i] = 5;
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(10);
			}
		}
		if (!HAL_GPIO_ReadPin(GPIOB, COL_3))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_3))
			{
				Right[i] = 6;
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(10);
			}
		}
		if (!HAL_GPIO_ReadPin(GPIOB, COL_4))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_4))
			{
				Right[i] = 'B';
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(10);
			}
		}

		HAL_GPIO_WritePin(GPIOA, ROW_3, GPIO_PIN_RESET);
		HAL_GPIO_WritePin(GPIOA, ROW_2 | ROW_1 | ROW_4, GPIO_PIN_SET);
		if (!HAL_GPIO_ReadPin(GPIOB, COL_1))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_1))
			{
				Right[i] = 7;
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(10);
			}
		}
		if (!HAL_GPIO_ReadPin(GPIOB, COL_2))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_2))
			{
				Right[i] = 8;
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(10);
			}
		}
		if (!HAL_GPIO_ReadPin(GPIOB, COL_3))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_3))
			{
				Right[i] = 9;
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(10);
			}
		}
		if (!HAL_GPIO_ReadPin(GPIOB, COL_4))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_4))
			{
				Right[i] = 'C';
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(10);
			}
		}

		HAL_GPIO_WritePin(GPIOA, ROW_4, GPIO_PIN_RESET);
		HAL_GPIO_WritePin(GPIOA, ROW_2 | ROW_3 | ROW_1, GPIO_PIN_SET);
		if (!HAL_GPIO_ReadPin(GPIOB, COL_1))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_1))
			{
				end = 1;
			}
		}
		if (!HAL_GPIO_ReadPin(GPIOB, COL_2))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_2))
			{
				Right[i] = 0;
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(10);
			}
		}
		if (!HAL_GPIO_ReadPin(GPIOB, COL_3))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_3))
			{
				Right[i] = '#';
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(50);
			}
		}
		if (!HAL_GPIO_ReadPin(GPIOB, COL_4))
		{
			HAL_Delay(150);
			if (!HAL_GPIO_ReadPin(GPIOB, COL_4))
			{
				Right[i] = 'D';
				i = i + 1;
				lcd_send_string("*");
				HAL_Delay(50);
			}
		}
	}
}
