#ifndef _RAVENNA_IO_H_
#define _RAVENNA_IO_H_

//#include <stdint.h>
//#include <stdbool.h>

#include "defs_mpw-two-mfix.h"

void putchar(uint32_t c);
void print(const char *p);
void print_hex(uint32_t v, int digits);
void print_bin(uint32_t v, int digits);
void print_dec(uint32_t v);
void print_digit(uint32_t v);
char getchar_prompt(char *prompt);
uint32_t getchar();
void cmd_echo();

#endif
