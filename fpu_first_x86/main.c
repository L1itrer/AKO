#include <stdio.h>
#include <stdlib.h>
#include <math.h>


extern void quadratic_func();
extern float srednia_harm(float* tablica, unsigned int n);
extern float nowy_exp(float x);
extern float exponent(float x, int n);
extern float factorial(int n);

float c_factorial(int n)
{
	float result = 1.0f;
	for (int i = n;i > 0;--i)
	{
		result *= (float)i;
	}
	return result;
}

float c_exponent(float x)
{
	float result = 1.0f;
	for (int i = 1;i < 20;++i)
	{
		result += powf(x, (float)i)/c_factorial(i);
	}
	return result;
}

const float x = 3.0f;
const int power = 4;
const int fact = 20;


int main()
{
	//printf("Factorial of %d is %f\n", fact, factorial(fact));
	//printf("%f do potegi %d wynosi %f\n", x, power, exponent(x, power));
	printf("Pierwsze 20 wyrazów ci¹gu dla x = %f to %f\n", x, nowy_exp(x));
	printf("Ten sam wynik uzywajac c  dla x = %f to %f\n", x, c_exponent(x));

	return 0;
}