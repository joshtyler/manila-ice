#include <iostream>
#include <fstream>
#include "Vtop.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

#include "verilator/VerilatedModel.hpp"
#include "other/ClockGen.hpp"
#include "other/Uart.hpp"

int main(int argc, char** argv)
{
	const bool recordVcd = true;

	VerilatedModel<Vtop> uut(argc,argv,recordVcd);

	const double timeinterval = 1e-9;

	ClockGen clk(uut.getTime(), timeinterval, 50e6);

	const int bit_interval = static_cast<int>((1.0/9600.0)/timeinterval);

	Uart<vluint8_t> uart(uut.uut->uart_tx, uut.uut->uart_rx, bit_interval);

	std::ofstream uart_tx_file(uart.get_slave_name().c_str(), std::ios::out | std::ios::binary);
	if(!uart_tx_file)
	{
		std::cerr << "Could not open UART tx file" << std::endl;
		exit(1);
	}
	uint8_t dat [6] = {1,0,0x55, 1,0,0xAA};
	uart_tx_file.write(reinterpret_cast<char *>(dat), sizeof(dat));
	uart_tx_file.flush();

	uut.addPeripheral(&uart);
	ClockBind clkDriver(clk,uut.uut->clk);
	uut.addClock(&clkDriver);

	while(true)
	{
		if(uut.eval() == false)
		{
			break;
		}

		// Break on timeout
		if(uut.getTime() == 8000000)
		{
			std::cout << "Timed out" << std::endl;
			break;
		}
	}
}
