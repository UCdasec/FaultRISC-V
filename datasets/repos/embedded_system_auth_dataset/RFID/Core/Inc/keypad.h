/*
 * keypad.h
 *
 *  Created on: May 17, 2023
 *      Author: HP
 */

#ifndef INC_KEYPAD_H_
#define INC_KEYPAD_H_
#include "stm32f1xx_hal.h"
#include "i2c-lcd.h"
#include "rfid.h"
#include "Menu_lcd.h"

#define ROW_1 GPIO_PIN_11 // A8
#define ROW_2 GPIO_PIN_10 // A9
#define ROW_3 GPIO_PIN_9  // A10
#define ROW_4 GPIO_PIN_8  // A11

#define COL_1 GPIO_PIN_15 // B12
#define COL_2 GPIO_PIN_14 // B13
#define COL_3 GPIO_PIN_13 // B14
#define COL_4 GPIO_PIN_12 // B15

extern int Right[];
extern int Password[];
extern int c;
extern int i;
extern int end;
extern int key;

void Keyscan(void);
void kiemtramatkhau(void);
void matkhaumoi(void);

#endif /* INC_KEYPAD_H_ */
