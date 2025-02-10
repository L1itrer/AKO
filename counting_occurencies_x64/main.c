#include <stdio.h>
#include <stdbool.h>

extern void* wystapienia(void* obszar, unsigned int n);
extern void sortuj(void* tablica, unsigned int n);
extern float liczba_pi(unsigned int n);

int main()
{
	unsigned char tablica[] = {1, 3, 4,3, 45, 32, 3 ,4 ,56 ,7, 8, 9,9,5 ,4, 42, 2,2,2,2,2,2,2,2,2,2,0,0,0};
	size_t n = sizeof(tablica) / sizeof(tablica[0]);
	void* occurences = wystapienia(tablica, n);

	for (int i = 0;i < 256;++i)
	{
		void* number = (char*)occurences + i * 5 + 1;
		printf("%d: %u | ", *((char*)occurences + i * 5), *(int*)(number));
		if (i % 8 == 0) printf("\n");
	}

	printf("\n------------- AFTER SORT -------------\n\n");
	sortuj(occurences, n);
	for (int i = 0;i < 256;++i)
	{
		void* number = (char*)occurences + i * 5 + 1;
		printf("%d: %d | ", *((char*)occurences + i * 5), *(int*)(number));
		if (i % 8 == 0) printf("\n");
	}

	return 0;
}