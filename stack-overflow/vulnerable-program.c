#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[]) {
	char string[40];
	strcpy(string, argv[1]);
	printf("The message was: %s\n", string);
	printf("Program completed normally!\n\n");
	return 0;
}
