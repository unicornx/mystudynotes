CFLAGS	= -c -Wall

sdram.bin : head.S  leds.c
	gcc $(CFLAGS) head.S -o head.o 
	gcc $(CFLAGS) leds.c -o leds.o 
	ld -Ttext 0x30000000 head.o leds.o -o sdram.elf
	objcopy -O binary -S sdram.elf sdram.bin
	objdump -D -m arm  sdram.elf > sdram.dis
clean:
	rm -f *.dis *.bin *.elf *.o
