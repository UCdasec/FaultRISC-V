/*
 * Menu_lcd.c
 *
 *  Created on: May 16, 2023
 *      Author: HP
 */
#include "Menu_lcd.h"
#include "i2c-lcd.h"
#include "keypad.h"
#include "rfid.h"

int gtlen;
int gtxuong;
int gtmenu;

int demtong = 0;
int demmenu = 0;
int menupage = 0;
int count = 0;
int j;
int ok = 0;

void manhinhchinh(void) // Màn hình chính
{
	lcd_clear_display();
	HAL_Delay(10);
	lcd_goto_XY(1, 3);
	lcd_send_string("WELCOME TO");
	HAL_Delay(10);
	lcd_goto_XY(2, 4);
	lcd_send_string("MY HOME");
	HAL_Delay(60);
}

void menu_tong() // hiển thị menu tổng
{
	if (demmenu == 0)
	{
		lcd_clear_display();
		HAL_Delay(10);
		lcd_goto_XY(1, 0);
		lcd_send_string(">NHAP MAT KHAU");
		HAL_Delay(10);
		lcd_goto_XY(2, 0);
		lcd_send_string(" CAI DAT");
		HAL_Delay(60);
	}
	else if (demmenu == 1)
	{
		lcd_clear_display();
		HAL_Delay(10);
		lcd_goto_XY(1, 0);
		lcd_send_string(" NHAP MAT KHAU");
		HAL_Delay(10);
		lcd_goto_XY(2, 0);
		lcd_send_string(">CAI DAT");
		HAL_Delay(60);
	}
}

void chon_tong(void)
{ // chọn menu tong

	switch (demmenu)
	{
	case 0: // CÁI NÀY CHỈ ĐỂ TEST
		Matkhau();
		Keyscan();
		end = 0;
		i = 0;
		break;
	case 1: // CÁI NÀY CHỈ ĐỂ TEST
		admin();
		for (j = 0; j < 200; j++)
		{
			Checkadmin();
			HAL_Delay(20);
			if (ok == 1)
			{
				menupage = 1;
				demmenu = 0;
				ok = 0;
				break;
			}
		}
		break;
	}
}

void menu_caidat() // hiển thị menu cài đặt
{
	if (demmenu == 0)
	{
		lcd_clear_display();
		HAL_Delay(10);
		lcd_goto_XY(1, 0);
		lcd_send_string(">THEM THE");
		HAL_Delay(10);
		lcd_goto_XY(2, 0);
		lcd_send_string(" XOA THE");
		HAL_Delay(60);
	}
	else if (demmenu == 1)
	{
		lcd_clear_display();
		HAL_Delay(10);
		lcd_goto_XY(1, 0);
		lcd_send_string(" THEM THE");
		HAL_Delay(10);
		lcd_goto_XY(2, 0);
		lcd_send_string(">XOA THE");
		HAL_Delay(60);
	}
	else if (demmenu == 2)
	{
		lcd_clear_display();
		HAL_Delay(10);
		lcd_goto_XY(1, 0);
		lcd_send_string(">DOI MAT KHAU");
		HAL_Delay(10);
		lcd_goto_XY(2, 0);
		lcd_send_string(" BACK");
		HAL_Delay(60);
	}
	else if (demmenu == 3)
	{
		lcd_clear_display();
		HAL_Delay(10);
		lcd_goto_XY(1, 0);
		lcd_send_string(" DOI MAT KHAU");
		HAL_Delay(10);
		lcd_goto_XY(2, 0);
		lcd_send_string(">BACK");
		HAL_Delay(60);
	}
}

void chon_caidat(void) // chọn menu cài đặt
{
	switch (demmenu)
	{
	case 0: // CÁI NÀY CHỈ ĐỂ TEST
		themthe();
		for (int n = 0; n < 200; n++)
		{
			THEM_THE();
			if (ok == 1)
			{
				lcd_clear_display();
				HAL_Delay(10);
				lcd_goto_XY(1, 3);
				lcd_send_string("DA THEM THE");
				ok = 0;
				HAL_Delay(1000);
				break;
			}
			HAL_Delay(20);
		}
		menupage = 1;
		demmenu = 0;
		break;
	case 1: // CÁI NÀY CHỈ ĐỂ TEST
		xoathe();
		for (int n = 0; n < 200; n++)
		{
			XOA_THE();
			if (ok == 1)
			{
				lcd_clear_display();
				HAL_Delay(10);
				lcd_goto_XY(1, 3);
				lcd_send_string("DA XOA THE");
				ok = 0;
				HAL_Delay(1000);
				break;
			}
			HAL_Delay(20);
		}
		menupage = 1;
		demmenu = 0;
		break;
	case 2: // CÁI NÀY CHỈ ĐỂ TEST
		Doimatkhau();
		matkhaumoi();
		end = 0;
		break;
	case 3:
		menupage = 0;
		demmenu = 0;
		break;
	}
}

void Matkhau()
{
	lcd_clear_display();
	HAL_Delay(10);
	lcd_goto_XY(1, 0);
	lcd_send_string("  MOI BAN NHAP");
	lcd_goto_XY(2, 5);
}

void Doimatkhau()
{
	lcd_clear_display();
	HAL_Delay(10);
	lcd_goto_XY(1, 0);
	lcd_send_string("  MAT KHAU MOI");
	lcd_goto_XY(2, 5);
}

void admin()
{
	lcd_clear_display();
	HAL_Delay(10);
	lcd_goto_XY(1, 1);
	lcd_send_string("QUET THE ADMIN");
}

void themthe()
{
	lcd_clear_display();
	HAL_Delay(10);
	lcd_goto_XY(1, 2);
	lcd_send_string("QUET THE MOI");
}

void xoathe()
{
	lcd_clear_display();
	HAL_Delay(10);
	lcd_goto_XY(1, 2);
	lcd_send_string("MOI QUET THE");
}
