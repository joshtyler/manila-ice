
#include <vector>
#include "VectorUtility.h"
#include "WbUart.hpp"

int main(void)
{

	WbUart<uint16_t,23> uart("/dev/ttyUSB0", 460800, true);
	std::vector<uint16_t> wr_dat = {0xCAFE,0xDEAD,0xBEEF};
	uart.write(0, AddressMode::INCREMENT, wr_dat.begin(), wr_dat.end());
	VectorUtility::print(uart.read(0, AddressMode::INCREMENT, wr_dat.size()));

	return 0;
}
