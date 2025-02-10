#include <stdio.h>
#include <stdlib.h>
#include <Windows.h>
#include <stdint.h>

extern float liczba_pi(int n);

typedef struct PalindromeStruct {
	wchar_t* pointer;
	int length;
}PalindromeStruct;

void* palindrom(wchar_t* tekst)
{
	PalindromeStruct* palindromes = calloc(1024, sizeof(PalindromeStruct));
	// powiedzmy ¿e nie ma wiêcej ni¿ 1024 palindromy
	int relative_a = 0, relative_b = 2;
	int palindrome_tracker = 0;
	while (tekst[relative_b] != 0)
	{
		if (tekst[relative_a] == tekst[relative_b])
		{
			int palindrome_length = 1;
			int tempa = relative_a;
			int tempb = relative_b;
			while (tekst[relative_a] == tekst[relative_b])
			{
				palindrome_length += 2;
				palindromes[palindrome_tracker].pointer = &tekst[relative_a];
				palindromes[palindrome_tracker].length = palindrome_length;
				palindrome_tracker += 1;
				relative_a -= 1;
				relative_b += 1;
			} 
			relative_a = tempa;
			relative_b = tempb;
		}
		relative_a += 1;
		relative_b += 1;
	}
	return palindromes;
}
extern float test();

int main()
{
	//wchar_t* tekst = L"ppkajakuhjejkubalelabuk";
	//PalindromeStruct* palindromy = palindrom(tekst);
	//int i = 0;
	//while (palindromy[i].pointer != NULL)
	//{
	//	wprintf(L"%.*s %d\n", palindromy[i].length, palindromy[i].pointer, palindromy[i].length);
	//	++i;
	//}
	//printf("%f\n", liczba_pi(2));
	printf("%f\n", test());
	return 0;
}