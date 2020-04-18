
#include <vector>
#include "VectorUtility.h"
#include "WbUart.hpp"

int main(void)
{
	// N.B. Currently WbUart.hpp only supports constant address mode
	// So the data written/returned will be non-intuitive
	WbUart<uint8_t,8> uart("/dev/ttyUSB0", 460800);
	std::vector<uint8_t> wr_dat = {0xCA,0xFE,0xDE,0xAD,0xBE, 0xEF};
	//std::vector<uint8_t> wr_dat = {0xDE, 0xEF};
	uart.write(0,wr_dat.begin(), wr_dat.end());
	VectorUtility::print(uart.read(0,wr_dat.size()));

	return 0;
}
