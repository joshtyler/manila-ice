#include <stdint.h>
#include <stdbool.h>

#define reg_uart_data (*(volatile uint32_t*)0x02000008)
#define reg_leds (*(volatile uint32_t*)0x03000000)

void putchar(char c)
{
	if (c == '\n')
		putchar('\r');
	reg_uart_data = c;
}

void print(const char *p)
{
	while (*p)
		putchar(*(p++));
}

char getchar()
{
	int32_t c = reg_uart_data;
	return c;
}

// --------------------------------------------------------

void main()
{
	reg_leds = 0x55;

	print("Hello\n");
	while(1)
	{
		char c = getchar();
		putchar(c);
		reg_leds++;
	}
}
