#include<stdio.h>
#include<stdlib.h>
#include "bbsorter.h" /** Main Code */

/**
*
* Takes no Parameters, this is the main function
* I call the function bb sorter and I free it after.
* Taha Raslan
*
*/
int main(){

long int *b = NULL;
b =  bbsorter();

free(b);
return 0;

}

