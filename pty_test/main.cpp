#include <iostream>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>

int main(void)
{
	// Open /dev/ptmx to create the master side of the pty
	int fd = posix_openpt(O_RDWR);

	// Set the permissions of the slave side to match the master side
	int ret = grantpt(fd);

	// Unlock the slave side
	ret = unlockpt(fd);

	std::cout << "The slave side is named: " << ptsname(fd) << std::endl;

	while(1)
	{
		char data[128];
		ret = read(fd, data, sizeof(data)-1); // N.B. this blocks!
		if(ret > 0)
		{
			// Null terminate to make into string
			data[ret] = '\0';
			std::cout << std::endl << std::endl << "(Got " <<strlen(data) << " bytes): " << data << std::endl;
		}
	}

	close(fd);
	return 0;
}
