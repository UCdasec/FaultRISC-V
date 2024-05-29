/**
*
* \brief Spritz algorithm implementation
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

/*- Includes ----------------------------------------------------------------*/
#include "spritz.h"

/*- Implementations ---------------------------------------------------------*/

//-----------------------------------------------------------------------------
void spritz_initialize_state(spritz_state_t *state)
{
  state->i = 0;
  state->j = 0;
  state->k = 0;
  state->z = 0;
  state->a = 0;
  state->w = 1;

  for (int v = 0; v < SPRITZ_N; v++)
    state->s[v] = v;
}

//-----------------------------------------------------------------------------
void spritz_absorb(spritz_state_t *state, uint8_t *data, uint32_t size)
{
  for (uint32_t v = 0; v < size; v++)
    spritz_absorb_byte(state, data[v]);
}

//-----------------------------------------------------------------------------
void spritz_absorb_byte(spritz_state_t *state, int b)
{
  spritz_absorb_nibble(state, b & 0x0f);
  spritz_absorb_nibble(state, b >> 4);
}

//-----------------------------------------------------------------------------
void spritz_absorb_nibble(spritz_state_t *state, int x)
{
  int t;

  if (SPRITZ_N / 2 == state->a)
    spritz_shuffle(state);

  t = state->s[state->a];
  state->s[state->a] = state->s[SPRITZ_N / 2 + x];
  state->s[SPRITZ_N / 2 + x] = t;

  state->a++;
}

//-----------------------------------------------------------------------------
void spritz_absorb_stop(spritz_state_t *state)
{
  if (SPRITZ_N / 2 == state->a)
    spritz_shuffle(state);

  state->a++;
}

//-----------------------------------------------------------------------------
void spritz_shuffle(spritz_state_t *state)
{
  spritz_whip(state);
  spritz_crush(state);
  spritz_whip(state);
  spritz_crush(state);
  spritz_whip(state);

  state->a = 0;
}

//-----------------------------------------------------------------------------
void spritz_whip(spritz_state_t *state)
{
  for (int v = 0; v < 2 * SPRITZ_N; v++)
    spritz_update(state);

  state->w += 2;
}

//-----------------------------------------------------------------------------
void spritz_crush(spritz_state_t *state)
{
  for (int v = 0; v < SPRITZ_N / 2; v++)
  {
    int i = SPRITZ_N - 1 - v;
    int sv = state->s[v];
    int si = state->s[i];

    if (sv > si)
    {
      state->s[v] = si;
      state->s[i] = sv;
    }
  }
}

//-----------------------------------------------------------------------------
void spritz_squeeze(spritz_state_t *state, uint8_t *data, uint32_t size)
{
  if (state->a > 0)
    spritz_shuffle(state);

  for (uint32_t v = 0; v < size; v++)
    data[v] = spritz_drip(state);
}

//-----------------------------------------------------------------------------
uint8_t spritz_drip(spritz_state_t *state)
{
  if (state->a > 0)
    spritz_shuffle(state);

  spritz_update(state);

  return spritz_output(state);
}

//-----------------------------------------------------------------------------
void spritz_update(spritz_state_t *state)
{
  uint8_t t;

  state->i += state->w;
  t = state->j + state->s[state->i];
  state->j = state->k + state->s[t];
  state->k = state->i + state->k + state->s[state->j];

  t = state->s[state->i];
  state->s[state->i] = state->s[state->j];
  state->s[state->j] = t;
}

//-----------------------------------------------------------------------------
uint8_t spritz_output(spritz_state_t *state)
{
  uint8_t t;

  t = state->z + state->k;
  t = state->i + state->s[t];
  t = state->j + state->s[t];
  state->z = state->s[t];

  return state->z;
}

