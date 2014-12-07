led.bin : crt0.S led.c
	gcc -c crt0.S -o crt0.o
	gcc -c led.c -o led.o
#	ld -Ttext 0x30000000 crt0.o led.o -o led.elf
	ld -Ttext 0x00000000 crt0.o led.o -o led.elf
	objcopy -O binary -S led.elf led.bin
	objdump -D -m arm led.elf > led.dis

clean:
	rm -f *.dis *.bin *elf *.o
