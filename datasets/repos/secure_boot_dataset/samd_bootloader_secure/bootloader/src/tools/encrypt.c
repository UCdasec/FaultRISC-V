// Compile: gcc -W -Wall -O2 --std=gnu11 encrypt.c -o encrypt

/*- Includes ----------------------------------------------------------------*/
#include <time.h>
#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <unistd.h>
#include <string.h>
#include <getopt.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

/*- Definitions -------------------------------------------------------------*/
#define SPRITZ_N   256

#define GUARD_SIZE            4
#define OFFSET_SIZE           4
#define SIZE_SIZE             4
#define KEY_SIZE              16
#define DATA_SIZE             256
#define MAC_SIZE              16
#define NONCE_SIZE            16

#define UNLOCK_COMMAND_SIZE   (GUARD_SIZE + OFFSET_SIZE + SIZE_SIZE + NONCE_SIZE)
#define DATA_COMMAND_SIZE     (GUARD_SIZE + OFFSET_SIZE + DATA_SIZE + MAC_SIZE)

#define DEFAULT_KEY           { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf }

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

/*- Variables ---------------------------------------------------------------*/
static const struct option long_options[] =
{
  { "help",      no_argument,        0, 'h' },
  { "file",      required_argument,  0, 'f' },
  { "key",       required_argument,  0, 'k' },
  { "offset",    required_argument,  0, 'o' },
  { 0, 0, 0, 0 }
};

static const char *short_options = "hf:k:o:";

static char *g_file = NULL;
static char *g_key = NULL;
static int g_offset = -1;

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

//-----------------------------------------------------------------------------
void error_exit(char *fmt, ...)
{
  va_list args;

  va_start(args, fmt);
  fprintf(stderr, "Error: ");
  vfprintf(stderr, fmt, args);
  fprintf(stderr, "\n");
  va_end(args);

  exit(1);
}

//-----------------------------------------------------------------------------
void perror_exit(char *text)
{
  perror(text);
  exit(1);
}

//-----------------------------------------------------------------------------
static void print_help(char *name)
{
  printf("Usage: %s [options]\n", name);
  printf("Options:\n");
  printf("  -h, --help                 print this help message and exit\n");
  printf("  -f, --file                 input file\n");
  printf("  -k, --key                  encryption key (16 hexadecimal values separated with ':')\n");
  printf("  -o, --offset <number>      destination offset (default 0x800)\n");
  exit(0);
}

//-----------------------------------------------------------------------------
static void parse_command_line(int argc, char **argv)
{
  int option_index = 0;
  int c;

  while ((c = getopt_long(argc, argv, short_options, long_options, &option_index)) != -1)
  {
    switch (c)
    {
      case 'h': print_help(argv[0]); break;
      case 'f': g_file = optarg; break;
      case 'k': g_key = optarg; break;
      case 'o': g_offset = (int)strtoul(optarg, NULL, 0); break;
      default: exit(1); break;
    }
  }

//  if (optind >= argc)
//    error_exit("malformed command line, use '-h' for more information");
}

//-----------------------------------------------------------------------------
static void parse_encryption_key(uint8_t *key, char *str)
{
  char *next = str;
  int len;
  bool ok = true;

  for (len = 0; len < KEY_SIZE; len++)
  {
    ok &= (0 != *next);

    key[len] = strtoul(next, &next, 16);

    ok &= ((KEY_SIZE - 1) == len) ? (0 == *next) : (':' == *next);

    next++;
  }

  if (!ok)
    error_exit("malformed encryption key");
}

//-----------------------------------------------------------------------------
static int load_file(char *name, uint8_t **data)
{
  struct stat stat;
  int r, fd, size;

  fd = open(name, O_RDONLY | O_BINARY);

  if (fd < 0)
    perror_exit("open() for read");

  fstat(fd, &stat);

  size = (stat.st_size + DATA_SIZE-1) & ~(DATA_SIZE-1);
  *data = malloc(size);

  memset(*data, 0xff, size);

  r = read(fd, *data, stat.st_size);

  if (r < 0)
    perror_exit("read()");

  close(fd);

  return size;
}

//-----------------------------------------------------------------------------
static int open_file(char *name)
{
  char *ename = strcat(name, ".enc");
  int fd;

  fd = open(ename, O_WRONLY | O_TRUNC | O_CREAT | O_BINARY, 0644);

  if (fd < 0)
    perror_exit("open() for write");

  return fd;
}

//-----------------------------------------------------------------------------
static void write_file(int fd, uint8_t *data, int size)
{
  int r = write(fd, data, size);

  if (r < 0)
    perror_exit("write()");
}

//-----------------------------------------------------------------------------
int main(int argc, char **argv)
{
  uint8_t encryption_key[KEY_SIZE] = DEFAULT_KEY;
  uint8_t session_key[KEY_SIZE];
  spritz_state_t state;
  spritz_state_t encrypt_state;
  spritz_state_t auth_state;
  uint32_t buf[128];
  uint8_t *byte_buf = (uint8_t *)buf;
  uint8_t *data;
  int size, fd;

  parse_command_line(argc, argv);

  if (NULL == g_file)
    error_exit("file name is required");

  if (g_key)
    parse_encryption_key(encryption_key, g_key);

  if (g_offset < 0)
    g_offset = 0x800;

  size = load_file(g_file, &data);

  fd = open_file(g_file);

  // NOTE: It is ok to use pseudo-random number generator here,
  // since security does not rely on nonce value.
  srand(time(NULL));

  buf[0] = 0x78656c41;
  buf[1] = g_offset;
  buf[2] = size;
  buf[3] = rand();
  buf[4] = rand();
  buf[5] = rand();
  buf[6] = rand();

  spritz_initialize_state(&state);
  spritz_absorb(&state, encryption_key, KEY_SIZE);
  spritz_absorb(&state, (uint8_t *)buf, UNLOCK_COMMAND_SIZE);
  spritz_squeeze(&state, session_key, KEY_SIZE);

  write_file(fd, (uint8_t *)buf, UNLOCK_COMMAND_SIZE);

  for (int i = 0; i < size; i += DATA_SIZE)
  {
    buf[0] = 0x78656c41;
    buf[1] = g_offset + i;

    spritz_initialize_state(&encrypt_state);
    spritz_absorb(&encrypt_state, session_key, KEY_SIZE);
    spritz_absorb_byte(&encrypt_state, 'E');
    spritz_absorb(&encrypt_state, byte_buf, GUARD_SIZE + OFFSET_SIZE);

    for (int j = 0; j < DATA_SIZE; j++)
      byte_buf[GUARD_SIZE + OFFSET_SIZE + j] = data[i + j] + spritz_drip(&encrypt_state);

    spritz_initialize_state(&auth_state);
    spritz_absorb(&auth_state, session_key, KEY_SIZE);
    spritz_absorb_byte(&auth_state, 'A');
    spritz_absorb(&auth_state, byte_buf, GUARD_SIZE + OFFSET_SIZE + DATA_SIZE);

    spritz_squeeze(&auth_state, &byte_buf[GUARD_SIZE + OFFSET_SIZE + DATA_SIZE], MAC_SIZE);

    write_file(fd, (uint8_t *)buf, DATA_COMMAND_SIZE);
  }

  close(fd);

  printf("Done\n");
}

