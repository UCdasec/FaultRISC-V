/*
 * Menu_lcd.h
 *
 *  Created on: May 16, 2023
 *      Author: HP
 */

#ifndef INC_MENU_LCD_H_
#define INC_MENU_LCD_H_
#include "stm32f1xx_hal.h"
#include "i2c-lcd.h"
#include "keypad.h"
#include "rfid.h"

extern int gtlen;
extern int gtxuong;
extern int gtmenu;

extern int demtong;
extern int demmenu;
extern int menupage;
extern int count;
extern int j;
extern int ok;

void manhinhchinh(void); // Màn hình chính

void menu_tong(); // hiển thị menu tổng

void menu_mocua(); // hiển thị menu mở cửa

void chon_tong(void); // chọn menu tong

void chon_mocua(void); // chọn menu mocua

void menu_caidat(); // hiển thị menu cài đặt

void chon_caidat(void); // chọn menu cài đặt

void Matkhau(void);

void Doimatkhau(void);

void admin(void);

void themthe(void);

void xoathe(void);

#endif /* INC_MENU_LCD_H_ */
