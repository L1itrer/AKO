#include <stdio.h>

extern float add_floats_positive(float a, float b); // this function works for positive floats
///extern float add_floats(float a, float b);
///extern double add_double_positive(double a, double b);
extern float multiply_floats(float a, float b); // i'm quite certain that i made this work but
// it seems to be lost
 
 
 
 
//extern float divide_floats(float dividend, float divisor);
//extern double multiply_doubles(double a, double b);


int main()
{
	float a = 2.0f;
	float b = 1.1f;
	printf("%f + %f = %f\n", a, b, add_floats_positive(a, b));
	return 0;
}