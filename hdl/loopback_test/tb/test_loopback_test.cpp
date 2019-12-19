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

	ClockGen clk(uut.getTime(), 1e-9, 50e6);
	Uart<vluint8_t> uart(uut.uut->uart_tx, uut.uut->uart_rx);


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
			break;
		}
	}
}
