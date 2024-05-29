/**
*
* \brief Spritz algorithm interface
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

#ifndef _SPRITZ_H_
#define _SPRITZ_H_

/*- Includes ----------------------------------------------------------------*/
#include <stdint.h>
#include <stdbool.h>

/*- Definitions -------------------------------------------------------------*/
#define SPRITZ_N   256

/*- Types -------------------------------------------------------------------*/
typedef struct
{
  uint8_t  s[SPRITZ_N];
  uint8_t  i;
  uint8_t  j;
  uint8_t  k;
  uint8_t  z;
  uint8_t  a;
  uint8_t  w;
} spritz_state_t;

/*- Prototypes --------------------------------------------------------------*/
void spritz_initialize_state(spritz_state_t *state);
void spritz_absorb(spritz_state_t *state, uint8_t *data, uint32_t size);
void spritz_absorb_byte(spritz_state_t *state, int b);
void spritz_absorb_nibble(spritz_state_t *state, int x);
void spritz_absorb_stop(spritz_state_t *state);
void spritz_shuffle(spritz_state_t *state);
void spritz_whip(spritz_state_t *state);
void spritz_crush(spritz_state_t *state);
void spritz_squeeze(spritz_state_t *state, uint8_t *data, uint32_t size);
uint8_t spritz_drip(spritz_state_t *state);
void spritz_update(spritz_state_t *state);
uint8_t spritz_output(spritz_state_t *state);

#endif // _SPRITZ_H_

