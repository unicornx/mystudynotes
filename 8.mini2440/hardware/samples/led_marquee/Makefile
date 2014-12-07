CFLAGS	= -c -Wall
#CFLAGS	:= -c -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -ffreestanding #this can not work!!!

leds.bin : crt0.S  led.c
	gcc $(CFLAGS) crt0.S -o crt0.o 
	gcc $(CFLAGS) led.c -o led.o 
#	ld -Ttext 0x30000000 crt0.o led.o -o led.elf
	ld -Tled.lds  crt0.o led.o -o led.elf
	objcopy -O binary -S led.elf led.bin
	objdump -D -m arm led.elf > led.dis
clean:
	rm -f *.dis *.bin *.elf *.o
