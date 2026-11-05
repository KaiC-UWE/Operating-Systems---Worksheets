all: src/task1 src/task1_2 src/task2_1 src/task2_2

src/task1: src/task1.asm src/driver.c src/asm_io.asm src/asm_io.inc
	nasm -f elf -I src/ src/task1.asm -o src/task1.o
	gcc -m32 -c src/driver.c -o src/driver.o
	nasm -f elf -I src/ src/asm_io.asm -o src/asm_io.o
	gcc -m32 src/task1.o src/driver.o src/asm_io.o -o src/task1

src/task1_2: src/task1_2.asm src/driver.c src/asm_io.asm src/asm_io.inc
	nasm -f elf -I src/ src/task1_2.asm -o src/task1_2.o
	gcc -m32 -c src/driver.c -o src/driver.o
	nasm -f elf -I src/ src/asm_io.asm -o src/asm_io.o
	gcc -m32 src/task1_2.o src/driver.o src/asm_io.o -o src/task1_2

src/task2_1: src/task2_1.asm src/driver.c src/asm_io.asm src/asm_io.inc
	nasm -f elf -I src/ src/task2_1.asm -o src/task2_1.o
	gcc -m32 -c src/driver.c -o src/driver.o
	nasm -f elf -I src/ src/asm_io.asm -o src/asm_io.o
	gcc -m32 src/task2_1.o src/driver.o src/asm_io.o -o src/task2_1

src/task2_2: src/task2_2.asm src/driver.c src/asm_io.asm src/asm_io.inc
	nasm -f elf -I src/ src/task2_2.asm -o src/task2_2.o
	gcc -m32 -c src/driver.c -o src/driver.o
	nasm -f elf -I src/ src/asm_io.asm -o src/asm_io.o
	gcc -m32 src/task2_2.o src/driver.o src/asm_io.o -o src/task2_2
