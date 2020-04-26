#include <iostream>
#include <vector>
#include "VectorUtility.h"
#include "WbUart.hpp"

int main(int argc, char** argv)
{
	if(argc < 5)
	{

		std::cerr << "Usage: " << argv[0] << " [uart] [baud] [r/w] [address] [data if w]" << std::endl;
		return 0;
	}
	WbUart<uint8_t,8> uart(argv[1], std::atoi(argv[2]), true);
	if(argv[3][0] == 'w')
	{
		std::vector<uint8_t> vec = {std::atoi(argv[5])};
		uart.write(std::atoi(argv[4]), AddressMode::INCREMENT, vec.begin(), vec.end());
	} else {
		VectorUtility::print(uart.read(std::atoi(argv[4]), AddressMode::INCREMENT, 1));
	}

	return 0;
}
