simple: simple.s
	nasm -felf64 simple.s -o simple.o
	gcc -nostdlib -o simple simple.o

clean:
	rm -f simple.o simple
