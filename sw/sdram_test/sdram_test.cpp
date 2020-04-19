
#include <vector>
#include "VectorUtility.h"
#include "WbUart.hpp"

int main(void)
{

	WbUart<uint16_t,23> uart("/dev/ttyUSB0", 460800);
	std::vector<uint16_t> wr_dat = {0xCAFE,0xDEAD,0xBEEF};
	uart.write(0x0, AddressMode::INCREMENT, wr_dat.begin(), wr_dat.end());

	wr_dat = {0xABCD, 0xEF01};
	uart.write(0x0ABCDE, AddressMode::INCREMENT, wr_dat.begin(), wr_dat.end());


	VectorUtility::print(uart.read(0, AddressMode::INCREMENT, 3));
	VectorUtility::print(uart.read(0x0ABCDE, AddressMode::INCREMENT, 2));

	return 0;
}
