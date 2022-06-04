#include "print_io.h"

void putchar(uint32_t c)
{
	if (c == '\n')
		putchar('\r');
	reg_uart_data = c;
//	reg_uart1_data = c;
}

void print(const char *p)
{
	while (*p)
		putchar(*(p++));
}

void print_hex(uint32_t v, int digits)
{
	for (int i = digits - 1; i >= 0; i--) {
		char c = "0123456789abcdef"[(v >> (4*i)) & 15];
		putchar(c);
	}
} 

void print_bin(uint32_t v, int digits)
{
	for (int i = digits - 1; i >= 0; i--) {
		char c = "01"[(v >> (i)) & 1];
		putchar(c);
	}

}

void print_dec(uint32_t v)
{
	if (v >= 2000) {
		print("OVER");
		return;
	}
	else if (v >= 1000) { putchar('1'); v -= 1000; }
	else putchar(' ');

	if 	(v >= 900) { putchar('9'); v -= 900; }
	else if	(v >= 800) { putchar('8'); v -= 800; }
	else if	(v >= 700) { putchar('7'); v -= 700; }
	else if	(v >= 600) { putchar('6'); v -= 600; }
	else if	(v >= 500) { putchar('5'); v -= 500; }
	else if	(v >= 400) { putchar('4'); v -= 400; }
	else if	(v >= 300) { putchar('3'); v -= 300; }
	else if	(v >= 200) { putchar('2'); v -= 200; }
	else if	(v >= 100) { putchar('1'); v -= 100; }
	else putchar('0');

	if 	(v >= 90) { putchar('9'); v -= 90; }
	else if	(v >= 80) { putchar('8'); v -= 80; }
	else if	(v >= 70) { putchar('7'); v -= 70; }
	else if	(v >= 60) { putchar('6'); v -= 60; }
	else if	(v >= 50) { putchar('5'); v -= 50; }
	else if	(v >= 40) { putchar('4'); v -= 40; }
	else if	(v >= 30) { putchar('3'); v -= 30; }
	else if	(v >= 20) { putchar('2'); v -= 20; }
	else if	(v >= 10) { putchar('1'); v -= 10; }
	else putchar('0');

	if 	(v >= 9) { putchar('9'); v -= 9; }
	else if	(v >= 8) { putchar('8'); v -= 8; }
	else if	(v >= 7) { putchar('7'); v -= 7; }
	else if	(v >= 6) { putchar('6'); v -= 6; }
	else if	(v >= 5) { putchar('5'); v -= 5; }
	else if	(v >= 4) { putchar('4'); v -= 4; }
	else if	(v >= 3) { putchar('3'); v -= 3; }
	else if	(v >= 2) { putchar('2'); v -= 2; }
	else if	(v >= 1) { putchar('1'); v -= 1; }
	else putchar('0');
}

void print_digit(uint32_t v)
{
    v &= (uint32_t)0x000F;

    if (v == 9) { putchar('9'); }
    else if (v == 8) { putchar('8'); }
    else if (v == 7) { putchar('7'); }
    else if (v == 6) { putchar('6'); }
    else if (v == 5) { putchar('5'); }
    else if (v == 4) { putchar('4'); }
    else if (v == 3) { putchar('3'); }
    else if (v == 2) { putchar('2'); }
    else if (v == 1) { putchar('1'); }
    else if (v == 0) { putchar('0'); }
    else if (v == 10) { putchar('a'); }
    else if (v == 11) { putchar('b'); }
    else if (v == 12) { putchar('c'); }
    else if (v == 13) { putchar('d'); }
    else if (v == 14) { putchar('e'); }
    else if (v == 15) { putchar('f'); }
    else putchar('*');
}

//char getchar_prompt(char *prompt)
//{
//	int32_t c = -1;
//
//	uint32_t cycles_begin, cycles_now, cycles;
//	__asm__ volatile ("rdcycle %0" : "=r"(cycles_begin));
//
////	reg_leds = ~0;
//
//	if (prompt)
//		print(prompt);
//
//	while (c == -1) {
//		__asm__ volatile ("rdcycle %0" : "=r"(cycles_now));
//		cycles = cycles_now - cycles_begin;
//		if (cycles > 12000000) {
//			if (prompt)
//				print(prompt);
//			cycles_begin = cycles_now;
////			reg_leds = ~reg_leds;
//		}
//		c = reg_uart_data;
//	}
//
////	reg_leds = 0;
//	return c;
//}

//uint32_t getchar()
//{
//	int32_t c = -1;
//	while (c == -1) {
//		c = reg_uart_data;
//	}
//	return c;
//}
//
//void cmd_echo()
//{
//	print("Return to menu by sending '!'\n\n");
//	uint32_t c;
//	while ((c = getchar()) != '!') {
//		if (c == '\r')
//		    putchar('\n');
//        else {
//		    putchar(c);
////		    reg_gpio_data = c >> 4;
//		    reg_gpio_data = c;
//        }
//    }
//}