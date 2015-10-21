all: simple printf printf.obj

%.obj: %
	objdump -M intel -D $< > $@
simple: simple.s
	nasm -felf64 simple.s -o simple.o
	gcc -nostdlib -o simple simple.o
printf: printf.c
	gcc -o printf printf.c
clean:
	rm -f simple.o simple printf printf.obj
