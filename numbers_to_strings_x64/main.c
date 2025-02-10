#include <stdio.h>
#include <stdlib.h>
#include <Windows.h>

// i think this function takes two 64-bit numbers and converts them to an UTF-16 string
extern wchar_t* convert_to_string(long long* first, long long second);
unsigned int chuj = 0;

int zm = 0x2137;

typedef long long dluga;

int main()
{
	long long first = 0x0fffffffff;
	long long second = 42000;

	wchar_t* a = convert_to_string(&first, second);

	int lol = 20 + 20;

	MessageBox(0, a, a, 0);
	
	return 0;
}