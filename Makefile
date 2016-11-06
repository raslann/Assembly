#Taha Raslan
all: bbsort32 bbsort64

main.o: main.c
	gcc -Wall -c -m32 $^ -o $@

main64.o: main.c
	gcc -Wall -c $^ -o $@

bbsorter.o: bbsorter.c bbsorter.h
	gcc -Wall -S -m32 bbsorter.c -o bbsorter.s
	gcc -Wall -c -m32 bbsorter.c -o $@

bbsorter64.o: bbsorter.c bbsorter.h
	gcc -Wall -S bbsorter.c -o bbsorter64.s
	gcc -Wall -c bbsorter.c -o $@

bbsort32: bbsorter.o main.o
	gcc -Wall -m32 $^ -o $@

bbsort64: bbsorter64.o main64.o
	gcc -Wall  $^ -o $@

clean:
	rm *.o bbsort32 bbsort64
