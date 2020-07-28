#include <string.h>

void *memcpy(void *destination, const void *source, size_t num)
{
	char *csrc = (char *)source;
	char *cdest = (char *)destination;

	for(size_t i=0; i<num; i++)
	{
		cdest[i] = csrc[i];
	}
}
void *memset(void *ptr, int value, size_t num)
{
	char *cptr = (char *)ptr;
	for(size_t i=0; i<num; i++)
	{
		cptr[i] = value;
	}
}

size_t strlen (const char * str)
{
	size_t ret;
	for(ret=0; str[ret] != '\0'; ret++);
	return ret;
}

char * strncpy ( char * destination, const char * source, size_t num )
{
	size_t i;
	for(i=0; i<num; i++)
	{
		destination[i] = source[i];
		if(source[i] == '\0')
		{
			break;
		}
	}
	for(; i<num; i++)
	{
		destination[i] = '\0';
	}
}
