
#include <vector>
#include "VectorUtility.h"
#include "WbUart.hpp"

int main(void)
{
	WbUart<uint8_t,8> uart("/dev/ttyUSB0", 460800);
	std::vector<uint8_t> wr_dat = {0xCA,0xFE,0xDE,0xAD,0xBE, 0xEF};
	uart.write(0, AddressMode::INCREMENT, wr_dat.begin(), wr_dat.end());
	VectorUtility::print(uart.read(0, AddressMode::INCREMENT, wr_dat.size()));

	return 0;
}
