/*
 * rfid.h
 *
 *  Created on: May 17, 2023
 *      Author: HP
 */

#ifndef INC_RFID_H_
#define INC_RFID_H_
#include "stm32f1xx_hal.h"
#include "rc522.h"
#include "i2c-lcd.h"

extern uint8_t DATA_RIGHT[3][4];
extern uint8_t DATATEST[4];
extern uint8_t tt_1;
extern uint8_t CHECK, DOOR;
extern uint8_t UID[4];
extern uint8_t TagType;

int QUET_THE(uint8_t DATA_RIGHT[3][4], uint8_t UID[4]);
void Buzzer(int Time, int Loop);
void Kiemtrarfid(void);
void THEM_THE(void);
void Checkadmin(void);
void QUET_THE2(uint8_t DATA_RIGHT[3][4], uint8_t UID[4]);
void XOA_THE(void);
void QUET_THE3(uint8_t DATA_RIGHT[3][4], uint8_t UID[4]);
int QUET_THE4(uint8_t DATA_RIGHT[3][4], uint8_t UID[4]);

#endif /* INC_RFID_H_ */
