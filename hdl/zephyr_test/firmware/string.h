#ifndef STRING_H
#define STRING_H

#include <stddef.h>

void *memcpy(void *destination, const void *source, size_t num);

void *memset(void *ptr, int value, size_t num);

size_t strlen (const char * str);

char * strncpy ( char * destination, const char * source, size_t num );

#endif
