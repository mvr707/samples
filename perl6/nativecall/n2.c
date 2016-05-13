#include <stdio.h>

int hello(int i)
{
	printf("Hello World from C (%d)\n", i);

	i *= 10;
	return i;
}
