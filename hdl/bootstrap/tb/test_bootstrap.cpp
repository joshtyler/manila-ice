#include <iostream>
#include <fstream>
#include "Vtop.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

#include "verilator/VerilatedModel.hpp"
#include "other/ClockGen.hpp"
#include "other/Uart.hpp"
#include "other/SpiSlave.hpp"
#include "other/FlashSpiDevice.hpp"

int main(int argc, char** argv)
{
	const bool recordVcd = true;

	VerilatedModel<Vtop> uut(argc,argv,recordVcd);

	const double timeinterval = 1e-9;

	ClockGen clk(uut.getTime(), timeinterval, 50e6);

	FlashSpiDevice flashDev;

	SpiSlave<vluint8_t,vluint8_t> spiflash(uut.uut->sck, uut.uut->mosi, uut.uut->miso, uut.uut->ss, &flashDev);

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
		1,2,0x90,  // Send data (read ID)
		0,2,       // Read result
		1,2,0x00,  // Send data (addr1)
		0,2,       // Read result
		1,2,0x00,  // Send data (addr2)
		0,2,       // Read result
		1,2,0x00,  // Send data (addr3)
		0,2,       // Read result
		1,2,0x00,  // Dummy to get ID
		0,2,       // Read result
		1,1,0x01   // SS high
	};
	uart_tx_file.write((char *)dat.data(), dat.size()); // We seem to be sending a couple of bonus characters at the end as well. I'm not sure why...
	uart_tx_file.flush();


	uut.addPeripheral(&uart);
	uut.addPeripheral(&spiflash);
	ClockBind clkDriver(clk,uut.uut->clk);
	uut.addClock(&clkDriver);

	while(true)
	{
		if(uut.eval() == false)
		{
			break;
		}

		// Break on timeout
		if(uut.getTime() == 70000000)
		{
			std::cout << "Timed out" << std::endl;
			break;
		}
	}
}
