#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* ================================================== */

double My_variable = 3.0;

/* ================================================== */

int fact(int n) {
	if (n <= 1) return 1;
	else return n*fact(n-1);
}

/* ================================================== */

int my_mod(int n, int m) {
	return (n % m);
}

/* ================================================== */

void calculate(int *i, int *j)
{
	int sum = *i + *j;
	int diff = abs(*i - *j);

	*i = sum;
	*j = diff;
}

/* ================================================== */

char *get_name()
{
	static char buf[100];

	int i = rand();
	sprintf(buf, "all is well %d", i);

	return buf;
}

void print_name(char *p)
{
	printf("%s\n", p);
}

/* ================================================== */

int sumup (int length, int array[])
{
	int result = 0;

	for (int i=0; i < length; i++) {
		result += array[i];
	}
	return result;
}

/* ================================================== */

typedef struct _SumDiff
{
	int sum;
	int diff;
} SumDiff;

SumDiff calculate_sum(int i, int j) {
	SumDiff res;
	res.sum = i + j;
	return res;
}

SumDiff calculate_diff(int i, int j) {
	SumDiff res;
	res.diff = abs(i - j);
	return res;
}

SumDiff *sumdiff (int i, int j) {
	SumDiff *result = calloc(1, sizeof(SumDiff));	/* static SumDiff result; */
	SumDiff tmp;

	tmp = calculate_sum(i, j);
	result->sum = tmp.sum;				/* result.sum = tmp.sum; */

	tmp = calculate_diff(i,j);
	result->diff = tmp.diff;			/* result.diff = tmp.diff; */

	return result;					/* return &result; */
}
	/* Notes: 
	
	   1) Internally C function can return structured data to another C function, 
	      but must return structure pointer to Perl6. Why? May be that is the current implementation 
	   2) For data integrity, "calloc" is better than "static" declaration of "result"
	   
	*/

/* ================================================== */

char **create_list(int size)
{
	char **my_array = calloc(size, sizeof(char *));
	
	printf("size of (char *) = %d\n", (int)sizeof(char *));

	printf("address of created array = 0x%lx\n", (unsigned long int) my_array);

	for (int i=0; i < size; i++) {
		char buf[100];
		sprintf(buf, "all is well %d - %d", i, rand());
		int len = strlen(buf);
  		my_array[i] = calloc(len, 1);
		printf("myarray[%d] (address, content) = (0x%lx, 0x%lx) %d\n", i, (unsigned long int) (my_array + i), (unsigned long int)my_array[i], len);
		sprintf(my_array[i], "%s", buf);
	}
	return my_array; /* array of strings */
}

void free_list(int size, char **p) 
{
	for (int i=0; i<size; i++) {
		free(p[i]);
		printf("free memory at 0x%lx\n", (unsigned long int) (p + i));
	}
	free(p);
	printf("Finally, free memory at 0x%lx\n", (unsigned long int) p);
}

/* ================================================== */
