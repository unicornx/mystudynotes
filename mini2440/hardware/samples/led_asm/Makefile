led.bin : led.S
	gcc -c led.S -o led.o 
	ld -Ttext 0x30000000 led.o -o led.elf
	objcopy -O binary -S led.elf led.bin
clean:
	rm -f *.bin *.elf *.o
