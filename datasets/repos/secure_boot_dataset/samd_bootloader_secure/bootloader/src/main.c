/**
*
* \brief Secure UART bootloader for SAM D10
*
* Copyright (c) 2018 Microchip Technology Inc.
*
* SPDX-License-Identifier: Apache-2.0
*
* Licensed under the Apache License, Version 2.0 (the "License"); you may
* not use this file except in compliance with the License.
* You may obtain a copy of the Licence at
* 
 * http://www.apache.org/licenses/LICENSE-2.0
* 
 * Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an AS IS BASIS, WITHOUT
* WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*
*/

//-----------------------------------------------------------------------------
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdalign.h>
#include "samd21.h"
#include "spritz.h"

//-----------------------------------------------------------------------------
#define BOOTLOADER_FLASH_AREA_SIZE    4096

//-----------------------------------------------------------------------------
#define BL_REQ_PORT           0 // PA
#define BL_REQ_PIN            PIN_PA15

#define UART_TX_PORT          0 // PA
#define UART_TX_PIN           PIN_PA22C_SERCOM3_PAD0
#define UART_TX_MUX           MUX_PA22C_SERCOM3_PAD0

#define UART_RX_PORT          0 // PA
#define UART_RX_PIN           PIN_PA23C_SERCOM3_PAD1
#define UART_RX_MUX           MUX_PA23C_SERCOM3_PAD1

#define UART_SERCOM           SERCOM3
#define UART_SERCOM_PMUX      HAL_GPIO_PMUX_C
#define UART_SERCOM_GCLK_ID   SERCOM3_GCLK_ID_CORE
#define UART_SERCOM_APBCMASK  PM_APBCMASK_SERCOM3
#define UART_SERCOM_TXPO      SERCOM_USART_CTRLA_TXPO(0)
#define UART_SERCOM_RXPO      SERCOM_USART_CTRLA_RXPO(1)

#define UART_BAUDRATE         115200

#define BOOTLOADER_SIZE       (BOOTLOADER_FLASH_AREA_SIZE - 256)
#define USER_DATA_SIZE        256
#define SECURITY_KEY_OFFSET   (FLASH_ADDR + BOOTLOADER_SIZE)
#define APPLICATION_START     (FLASH_ADDR + BOOTLOADER_SIZE + USER_DATA_SIZE)

#define PAGE_SIZE             NVMCTRL_PAGE_SIZE
#define ERASE_BLOCK_SIZE      NVMCTRL_ROW_SIZE
#define PAGES_IN_ERASE_BLOCK  NVMCTRL_ROW_PAGES

#define TIMER_INTERVAL        100 // ms

#define GUARD_SIZE            4
#define OFFSET_SIZE           4
#define SIZE_SIZE             4
#define KEY_SIZE              16
#define NONCE_SIZE            16
#define MAC_SIZE              16
#define ARB_WORD_SIZE         4
#define DATA_SIZE             ERASE_BLOCK_SIZE

#define CMD_UNLOCK_SIZE       (GUARD_SIZE + OFFSET_SIZE + SIZE_SIZE + NONCE_SIZE)
#define CMD_DATA_SIZE         (GUARD_SIZE + OFFSET_SIZE + DATA_SIZE + MAC_SIZE)
#define CMD_VERIFY_SIZE       (GUARD_SIZE)
#define CMD_RESET_SIZE        (GUARD_SIZE + ARB_WORD_SIZE * 4)

#define WORDS(x)              ((int)((x) / sizeof(uint32_t)))

#define ALIGN_MASK            0xffffff00 // 256 bytes

#define BL_REQUEST            0x78656c41

#define DEFAULT_KEY           { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf }

enum
{
  BL_CMD_UNLOCK    = 0xa0,
  BL_CMD_DATA      = 0xa1,
  BL_CMD_VERIFY    = 0xa2,
  BL_CMD_RESET     = 0xa3,
};

enum
{
  BL_RESP_OK          = 0x50,
  BL_RESP_ERROR       = 0x51,
  BL_RESP_INVALID     = 0x52,
  BL_RESP_VERIFY_OK   = 0x53,
  BL_RESP_VERIFY_FAIL = 0x54,
};

//-----------------------------------------------------------------------------
__attribute__ ((used, section(".key"))) uint8_t security_key_flash[KEY_SIZE] = DEFAULT_KEY;
static uint8_t security_key[KEY_SIZE];
static uint32_t *ram = (uint32_t *)HMCRAMC0_ADDR;
static int uart_command = 0;
static alignas(4) uint8_t uart_buffer[CMD_DATA_SIZE];
static alignas(4) uint8_t flash_data[DATA_SIZE];
static uint32_t flash_addr = 0;
static bool flash_data_ready = false;
static bool flash_verify_ok = false;
static uint32_t unlock_begin = 0;
static uint32_t unlock_end = 0;
static uint8_t session_key[16];

//-----------------------------------------------------------------------------
#define CONFIGURE_PMUX(dir) \
  do { \
    PORT->Group[UART_##dir##_PORT].PINCFG[UART_##dir##_PIN].reg |= PORT_PINCFG_PMUXEN; \
    if (UART_##dir##_PIN & 1) \
      PORT->Group[UART_##dir##_PORT].PMUX[UART_##dir##_PIN >> 1].bit.PMUXO = UART_##dir##_MUX; \
    else \
      PORT->Group[UART_##dir##_PORT].PMUX[UART_##dir##_PIN >> 1].bit.PMUXE = UART_##dir##_MUX; \
  } while (0)

//-----------------------------------------------------------------------------
static void sys_init(void)
{
  SYSCTRL->OSC8M.bit.PRESC = 0;
  PM->AHBMASK.reg |= PM_AHBMASK_NVMCTRL;
  PM->APBBMASK.reg |= PM_APBBMASK_NVMCTRL;
  NVMCTRL->CTRLB.reg = NVMCTRL_CTRLB_CACHEDIS;

  for (int i = 0; i < KEY_SIZE; i++)
    security_key[i] = security_key_flash[i];
}

//-----------------------------------------------------------------------------
static void run_application(void)
{
  uint32_t msp = *(uint32_t *)(APPLICATION_START);
  uint32_t reset_vector = *(uint32_t *)(APPLICATION_START + 4);

  if (0xffffffff == msp)
    return;

  __set_MSP(msp);

  asm("bx %0"::"r" (reset_vector));
}

//-----------------------------------------------------------------------------
static bool bl_request(void)
{
  PORT->Group[BL_REQ_PORT].DIRCLR.reg = (1 << BL_REQ_PIN);
  PORT->Group[BL_REQ_PORT].OUTSET.reg = (1 << BL_REQ_PIN);
  PORT->Group[BL_REQ_PORT].PINCFG[BL_REQ_PIN].reg = PORT_PINCFG_INEN | PORT_PINCFG_PULLEN;

  // Cheap delay. This should give at leat 1 ms delay.
  for (int i = 0; i < 2000; i++)
    asm("nop");

  if (0 == (PORT->Group[BL_REQ_PORT].IN.reg & (1 << BL_REQ_PIN)))
    return true;

  if (BL_REQUEST == ram[0] && BL_REQUEST == ram[1] &&
      BL_REQUEST == ram[2] && BL_REQUEST == ram[3])
  {
    ram[0] = 0;
    return true;
  }

  return false;
}

//-----------------------------------------------------------------------------
static void timer_reset(void)
{
  SysTick->CTRL = 0;
  SysTick->LOAD = (F_CPU / 1000u) * TIMER_INTERVAL;
  SysTick->VAL = SysTick->LOAD;
  SysTick->CTRL = SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_ENABLE_Msk;
}

//-----------------------------------------------------------------------------
static bool timer_expired(void)
{
  return (SysTick->CTRL & SysTick_CTRL_COUNTFLAG_Msk) > 0;
}

//-----------------------------------------------------------------------------
static void uart_init(void)
{
  CONFIGURE_PMUX(RX);
  CONFIGURE_PMUX(TX);

  PM->APBCMASK.reg |= UART_SERCOM_APBCMASK;

  GCLK->CLKCTRL.reg = GCLK_CLKCTRL_ID(UART_SERCOM_GCLK_ID) |
      GCLK_CLKCTRL_CLKEN | GCLK_CLKCTRL_GEN(0);

  UART_SERCOM->USART.CTRLA.reg =
      SERCOM_USART_CTRLA_DORD | SERCOM_USART_CTRLA_MODE_USART_INT_CLK |
      SERCOM_USART_CTRLA_FORM(4/*Auto-baud*/) | SERCOM_USART_CTRLA_SAMPR(1) |
      UART_SERCOM_TXPO | UART_SERCOM_RXPO;

  UART_SERCOM->USART.CTRLB.reg = SERCOM_USART_CTRLB_RXEN | SERCOM_USART_CTRLB_TXEN |
      SERCOM_USART_CTRLB_CHSIZE(0/*8 bits*/);

  #define BAUD_VAL (F_CPU / (16 * UART_BAUDRATE))
  #define FP_VAL   ((F_CPU / UART_BAUDRATE - 16 * BAUD_VAL) / 2)

  UART_SERCOM->USART.BAUD.reg = 
      SERCOM_USART_BAUD_FRACFP_BAUD(BAUD_VAL) |
      SERCOM_USART_BAUD_FRACFP_FP(FP_VAL);

  UART_SERCOM->USART.CTRLA.reg |= SERCOM_USART_CTRLA_ENABLE;
}

//-----------------------------------------------------------------------------
static void send_response(int resp)
{
  while (0 == UART_SERCOM->USART.INTFLAG.bit.DRE);
  UART_SERCOM->USART.DATA.reg = resp;
}

//-----------------------------------------------------------------------------
static void uart_sync(void)
{
  while (0 == UART_SERCOM->USART.INTFLAG.bit.TXC);
}

//-----------------------------------------------------------------------------
static void uart_task(void)
{
  static int ptr = 0;
  static int command = 0;
  static int size = 0;
  int data;

  if (uart_command)
    return;

  if (0 == UART_SERCOM->USART.INTFLAG.bit.RXC)
    return;

  data = UART_SERCOM->USART.DATA.reg;

  if (timer_expired())
    command = 0;

  if (0 == command)
  {
    ptr = 0;
    command = data;
    uart_buffer[0] = 0;

    if (BL_CMD_UNLOCK == command)
      size = CMD_UNLOCK_SIZE;
    else if (BL_CMD_DATA == command)
      size = CMD_DATA_SIZE;
    else if (BL_CMD_VERIFY == command)
      size = CMD_VERIFY_SIZE;
    else if (BL_CMD_RESET == command)
      size = CMD_RESET_SIZE;
    else
      size = 0;
  }
  else if (ptr < size)
  {
    uart_buffer[ptr++] = data;
  }

  if (ptr == size)
  {
    uart_command = command;
    command = 0;
  }

  timer_reset();
}

//-----------------------------------------------------------------------------
static bool icmp(uint8_t *a, uint8_t *b, int size)
{
  for (int i = 0; i < size; i++)
  {
    if (a[i] != b[i])
      return false;
  }

  return true;
}

//-----------------------------------------------------------------------------
static void command_task(void)
{
  uint32_t *word_buf = (uint32_t *)uart_buffer;

  if (BL_REQUEST != word_buf[0])
  {
    send_response(BL_RESP_ERROR);
  }
  else if (BL_CMD_UNLOCK == uart_command)
  {
    uint32_t begin = (word_buf[1] & ALIGN_MASK);
    uint32_t end = begin + (word_buf[2] & ALIGN_MASK);

    if (end > begin && end <= FLASH_SIZE)
    {
      spritz_state_t state;

      spritz_initialize_state(&state);
      spritz_absorb(&state, security_key, KEY_SIZE);
      spritz_absorb(&state, uart_buffer, CMD_UNLOCK_SIZE);
      spritz_squeeze(&state, session_key, KEY_SIZE);

      unlock_begin = begin;
      unlock_end = end;
      flash_verify_ok = true;
      send_response(BL_RESP_OK);
    }
    else
    {
      unlock_end = 0;
      flash_verify_ok = false;
      send_response(BL_RESP_ERROR);
    }
  }
  else if (BL_CMD_DATA == uart_command)
  {
    spritz_state_t state;

    flash_addr = word_buf[1];

    if (unlock_begin <= flash_addr && flash_addr < unlock_end)
    {
      uint8_t *their_mac = &uart_buffer[CMD_DATA_SIZE - MAC_SIZE];
      uint8_t my_mac[MAC_SIZE];

      spritz_initialize_state(&state);
      spritz_absorb(&state, session_key, KEY_SIZE);
      spritz_absorb_byte(&state, 'A');
      spritz_absorb(&state, uart_buffer, CMD_DATA_SIZE - MAC_SIZE);
      spritz_squeeze(&state, my_mac, MAC_SIZE);

      if (icmp(their_mac, my_mac, MAC_SIZE))
      {
        spritz_initialize_state(&state);
        spritz_absorb(&state, session_key, KEY_SIZE);
        spritz_absorb_byte(&state, 'E');
        spritz_absorb(&state, uart_buffer, GUARD_SIZE + OFFSET_SIZE);

        for (int i = 0; i < DATA_SIZE; i++)
          flash_data[i] = uart_buffer[GUARD_SIZE + OFFSET_SIZE + i] - spritz_drip(&state);

        flash_data_ready = true;

        send_response(BL_RESP_OK);
      }
      else
      {
        send_response(BL_RESP_ERROR);
      }
    }
    else
    {
      send_response(BL_RESP_ERROR);
    }
  }
  else if (BL_CMD_VERIFY == uart_command)
  {
    send_response(flash_verify_ok ? BL_RESP_VERIFY_OK : BL_RESP_VERIFY_FAIL);
  }
  else if (BL_CMD_RESET == uart_command)
  {
    // Unrolling the loop here saves significant amount of Flash
    ram[0] = word_buf[1];
    ram[1] = word_buf[2];
    ram[2] = word_buf[3];
    ram[3] = word_buf[4];

    send_response(BL_RESP_OK);
    uart_sync();

    NVIC_SystemReset();
  }
  else
  {
    send_response(BL_RESP_INVALID);
  }

  uart_command = 0;
}

//-----------------------------------------------------------------------------
static void flash_task(void)
{
  uint32_t *dst = (uint32_t *)flash_addr;
  uint32_t *src = (uint32_t *)flash_data;

  NVMCTRL->ADDR.reg = flash_addr >> 1;

  // Lock region size is always bigger than the row size
  NVMCTRL->CTRLA.reg = NVMCTRL_CTRLA_CMDEX_KEY | NVMCTRL_CTRLA_CMD_UR;

  while (0 == NVMCTRL->INTFLAG.bit.READY)
    uart_task();

  NVMCTRL->CTRLA.reg = NVMCTRL_CTRLA_CMDEX_KEY | NVMCTRL_CTRLA_CMD_ER;

  while (0 == NVMCTRL->INTFLAG.bit.READY)
    uart_task();

  for (int page = 0; page < PAGES_IN_ERASE_BLOCK; page++)
  {
    for (int i = 0; i < WORDS(PAGE_SIZE); i++)
      dst[i] = src[i];

    while (0 == NVMCTRL->INTFLAG.bit.READY)
      uart_task();

    flash_verify_ok &= icmp((uint8_t *)src, (uint8_t *)dst, PAGE_SIZE);

    src += WORDS(PAGE_SIZE);
    dst += WORDS(PAGE_SIZE);
  }

  flash_data_ready = false;
}

//-----------------------------------------------------------------------------
__attribute__ ((noinline)) // Prevent LTO from inlining main() into the reset handler
int main(void)
{
  if (!bl_request())
    run_application();

  sys_init();
  uart_init();

  while (1)
  {
    uart_task();

    if (flash_data_ready)
      flash_task();
    else if (uart_command)
      command_task();
  }

  return 0;
}

