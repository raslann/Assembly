#include<stdio.h>
#include<stdlib.h>
#include "bbsorter.h"

/**
 * This function doesn't take any parameters: Type long *
 * In this function user can input any number of long integers using scanf. 
 * Then I return a pointer to the list with the number of items in the list inserted before the
 * first long integer. User can end the input by typing anything other than a number.
 * Written by: Taha Raslan Raslan@nyu.edu YEAR: 2013
 *
 */
long * bbsorter() {
    long maximum = 10; //Maximum Capacity I can store in the first array
    long * array1 = (long *) malloc(sizeof (long) *maximum); //Just Allocated space up to 1 long int * my maximum variable so array can hold size = maximum
    long tempVar = 0; //Just a variable I use to store the number from scanf into. Then after check if the return from scanf was 0 or 1 I insert it into the array
    long temp1 = 0; //This is the variable I use to swap the highest and the lowest in the inline assembly sort (The temp variable for swap).
    long i = 1; //This is my index for inserting into the array from scan f and the loop. It is also the counter. I set two counters, but both work perfectly.
    long cnt = 1; //This is just like variable i, it is a counter when the elements gets put inside the array
    long swap = 1; //This is my boolean for the sort, to check if a swap has been made. The while loop checks if its true or false.
    long test = 1; //This is the return I get from scanf to check if its 0 or 1.
    long z = 0; // This is the index I use to copy into my temporary list ret
    long s = 0; // This is the index I use to print my list at the end
    long j = 1; // This is my index for the sort that I use. array1[j] and array1[j-1], array1[j+1]

    while (test != 0) {
        printf("Enter a number: ");
        array1[i] = (long) malloc(sizeof (long)); // Here I allocate the array1
        test = scanf("%ld", &tempVar); //My scanf using %ld as constraints

        if (test != 0) {
            array1[0] = cnt; //I set the first element to the counter Before I accept any numbers(Just like assignment asked.)
            array1[i] = tempVar; //My temp var that I use in scanf, now I insert that tempvar into the array.
            i++;
            cnt++;

        } 
	else {

            printf("I ended your input list, now I will sort your list: \n");

        }

        if (cnt == maximum) { //I check if the counter as reached its maximum, if so then I multiply by 2 and copy into the new array.
            //cnt++;
            //i++;
            maximum *= 2;
            long *ret = (long *) malloc(sizeof (long) *maximum);
		/*
		 * Here I do the copy into ret from array1
		 *
		 */
            for (z = 0; z < cnt; z++) {
                ret[z] = array1[z];

            }
            free(array1); // I free the pointer pretty much.
            array1 = ret; //Allocate the pointer to ret
            ret = NULL;   //Set ret to NULL then I will free it after.
            free(ret);   //I free it.


        }

    } // Finish first while loop
    /**
     * The Size of the array is in the 0th element and that is 
     *
     */
    //array1[0] = cnt;
    printf("\nTotal Elements in the Array are(Including the size in the 0th Element) : %ld\n", cnt);

    printf("\nNumber of Elements I sorted: %ld\n", cnt - 1); //I subtract one since I want the # of items sorted instead of the total of items in the list.

    /*
     * BI-DIRECTIONAL SORT AKA COCKTAIL SORT. 
     * Here I begin my inline assembly code for 64 bit and 32 bit. First one is 64 bit.. after the else is 32 bit. There were very few minor changes between them
     * All 64 bit instructions had the suffix q and then for the index that I was using, I changed it from 8 to 4.
     */
#ifdef __LP64__
    __asm__("whileLoop:\n\t"

            "movq $0, %4\n\t"

            /* This is the first For Loop */

            "movq $1, %2\n\t" // I set j = 1, I set this to 1 because i start with 1, for a normal array that starts from 0 just change to 0
            "Greatest:\n\t" //This label is to : Begin the first for loop				
            "movq (%1, %2, 8), %0 \n\t" //I copy array[j] to temp
            "incq %2\n\t" //I increment it so its j+1

            "cmpq %0, (%1, %2, 8) \n\t" //j+1 is less than jmp
            "jl sh2\n\t" //I check if j+1 is less than j, if it is then I want to jump to a label that does the swap.
            "jmp sh3\n\t" //If its not less than I should continue with the loop

            "sh2: \n\t" //This is my swap label
            "xchgq (%1, %2, 8), %0 \n\t" // I execute the swap with the temp.
            "decq %2 \n\t" //I decrement the index to get back to j
            "movq %0, (%1, %2, 8) \n\t" //Then I move j+1 into temp
            "movq $1, %4\n\t" //I set my boolean swap to 1

            "sh3: \n\t" //This was the label to jump to if I dont want to do the swap. If it did the swap it would go normally through it
            "cmpq %2, %3\n\t" // I compare j and the size. If it doesn't reach the size keep jumping. If cnt is greater than keep jmping.
            "jg Greatest\n\t"

            /* This is the second For Loop 
	     * This loop is very similar to the first loop, except that it starts from the opposite ( the end of the array) direction.
	     * Then it decrements down. Till it reaches $1(since I started at 1) if I start at 0 then it will cmpl with $0
	     *
	     */

            "movq %3, %2\n\t" // I set j = cnt
            "least:\n\t" //Begin the second loop				
            "movq (%1, %2, 8), %0 \n\t" //I copy array[j] to temp
            "decq %2\n\t" //I increment it so its j-1

            "cmpq %0, (%1, %2, 8) \n\t" //j-1 is greater than jmp
            "jg sh4\n\t"
            "jmp sh5\n\t"

            "sh4: \n\t"
            "xchgq (%1, %2, 8), %0 \n\t" // This is where the swapping happens with the temp variable
            "incq %2 \n\t"		// I put back the index since I decremented it on top
            "movq %0, (%1, %2, 8) \n\t" // Then I assign j-1 = j
            "movq $1, %4\n\t"		//My boolean is set to 1 since a swap happened

            "sh5: \n\t"
            "cmpq $1, %2\n\t" //I set this to 1 because i start with 1, for a normal array that starts from 0 just change to 0
            "jg least\n\t"

            //"movl $0, %4\n\t"

            //"cmpl $0, %4\n\t" //break statement if(scan == 1) then break out of the loop
            //"je done\n\t"

            /*
	     * This is the Big While Loop Condition
	     * 
	     * */
            "cmpq $1, %4\n\t" //Jump if the swap is 1 if swap gets set something else(0) it will stop(meaning all elements have been sorted).
            "je whileLoop\n\t" //jump if equal to whileLoop(starts the while loop again)
            "done:\n\t"//Useless but I have it to indicate for you that the while loop is done.

	/*
	*
	*My Constraints, I dont use any registers manually, I just use r to do it for me.
	* temp1 = Variable I will be outputting to for the swap
	* array1 is a pointer to my array
	* j = my index that I will be using
	* cnt = total number of elements in the array
	* swap = my boolean to end the while loop(the biggest loop) 1 = true, 0 = false.
	*/

            : "=&r"(temp1)

            : "r" (array1), "r" (j), "m" (cnt), "r"(swap));

#else
	/**
	* This is the same documentation as above, except you switch movq to movl and 4 to 8 for the index
	*
	*/
    __asm__("whileLoop:\n\t"

            "movl $0, %4\n\t"

            /* This is the first For Loop */

            "movl $1, %2\n\t" // I set j = 1 I set this to 1 because i start with 1, for a normal array that starts from 0 just change to 0
            "Greatest:\n\t" //Begin the second loop				
            "movl (%1, %2, 4), %0 \n\t" //I copy array[j] to temp
            "incl %2\n\t" //I increment it so its j+1

            "cmpl %0, (%1, %2, 4) \n\t" //j+1 is less than jmp
            "jl sh2\n\t" //I check if j+1 is less than j, if it is then I want to jump to a label that does the swap.
            "jmp sh3\n\t"

            "sh2: \n\t"
            "xchgl	(%1, %2, 4), %0 \n\t"
            "decl %2 \n\t" //I reset back the index since I incremented it on top
            "movl %0, (%1, %2, 4) \n\t"
            "movl $1, %4\n\t"

            "sh3: \n\t" //label to go to the jump comparison for the loop
            "cmpl %2, %3\n\t"
            "jg Greatest\n\t"

            /* This is the second For Loop */

       	    /* This is the second For Loop 
	     * This loop is very similar to the first loop, except that it starts from the opposite ( the end of the array) direction.
	     * Then it decrements down. Till it reaches $1(since I started at 1) if I start at 0 then it will cmpl with $0
	     *
	     */

            "movl %3, %2\n\t" // I set j = cnt
            "least:\n\t" //Begin the second loop				
            "movl (%1, %2, 4), %0 \n\t" //I copy array[j] to temp
            "decl %2\n\t" //I increment it so its j-1

            "cmpl %0, (%1, %2, 4) \n\t" //j-1 is greater than jmp
            "jg sh4\n\t"
            "jmp sh5\n\t"

            "sh4: \n\t"
            "xchgl	(%1, %2, 4), %0 \n\t" //I do the swap to the temp variable
            "incl %2 \n\t"			//Reset the index since I decremented
            "movl %0, (%1, %2, 4) \n\t"		// do the swap
            "movl $1, %4\n\t"			//I set my boolean

            "sh5: \n\t"
            "cmpl $1, %2\n\t" //I set this to 1 because i start with 1, for a normal array that starts from 0 just change to 0
            "jg least\n\t"

            //"movl $0, %4\n\t"

            //"cmpl $0, %4\n\t" //break statement if(scan == 1) then break out of the loop
            //"je done\n\t"

            "cmpl $1, %4\n\t"
            "je whileLoop\n\t"
            "done:\n\t"

	/*
	*
	*My Constraints, I dont use any registers manually, I just use r to do it for me.
	* temp1 = Variable I will be outputting to for the swap
	* array1 is a pointer to my array
	* j = my index that I will be using
	* cnt = total number of elements in the array
	* swap = my boolean to end the while loop(the biggest loop) 1 = true, 0 = false.
	*/


            : "=&r"(temp1)

            : "r" (array1), "r" (j), "m" (cnt), "r"(swap));
#endif

    /**
     *Here I print the sorted array.
     */

    for (s = 1; s < cnt; s++) {

        printf("Element#%ld = %ld\n", s, array1[s]);
    }


    return array1;


}
