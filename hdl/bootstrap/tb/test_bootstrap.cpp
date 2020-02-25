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
	std::vector<unsigned char> dat = {
		1,1,0x01,  // SS high
		1,1,0x00,  // SS low
		1,2,0x55,  // Send data
		0,2,       // Read result
		1,2,0xAA,  // Send data
		0,2,       // Read result
		1,1,0x01   // SS high
	};
	uart_tx_file.write((char *)dat.data(), dat.size()); // We seem to be sending a couple of bonus characters at the end as well. I'm not sure why...
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
		if(uut.getTime() == 35000000)
		{
			std::cout << "Timed out" << std::endl;
			break;
		}
	}
}
