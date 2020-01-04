#include <iostream>
#include "Vloopback_test.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

#include "../hdl_common/sim/verilator/VerilatedModel.hpp"
#include "../hdl_common/sim/other/ClockGen.hpp"
#include "../hdl_common/sim/other/Uart.hpp"

int main(int argc, char** argv)
{
	const bool recordVcd = true;

	VerilatedModel<Vloopback_test> uut(argc,argv,recordVcd);

	const double timeinterval = 1e-9;

	ClockGen clk(uut.getTime(), timeinterval, 50e6);

	const int bit_interval = static_cast<int>((1.0/9600.0)/timeinterval);

	std::cout  << "Bit interval: " << bit_interval << std::endl;

	Uart<vluint8_t> uart(uut.uut->uart_tx, uut.uut->uart_rx, bit_interval);


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
		if(uut.getTime() == 10000000)
		{
			std::cout << "Timed out" << std::endl;
			//break;
		}
	}
}
