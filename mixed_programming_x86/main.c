#include <stdio.h>
#include <Windows.h>
#include <sysinfoapi.h>
#include <stdint.h>

extern int find_max(int a, int b, int c);
extern int find_4_max(int a, int b, int c, int d);
extern void __stdcall sortowanie(int* arr, unsigned int n);
extern int opposite_number(int number);
extern void subtract_one(int** number);
extern int recursive_square(unsigned int a);
extern void calling_printf_example();
extern float avg_wg(int n, void* elements, void* weights);
extern void aktualna_godzina(char* buffer); //trzeba zalokowaæ bufor 3 znaków na t¹ funkcjê
extern unsigned int liczba_procesorow();
extern void nie_zadziala();

int main()
{
	//printf("\n");
	//calling_printf_example();
	nie_zadziala();

	return 0;
}