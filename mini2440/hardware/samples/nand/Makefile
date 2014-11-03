CFLAGS	= -c -Wall
OBJS := head.o init.o nand.o main.o

nand.bin : $(OBJS)
	ld -Tnand.lds $^ -o nand.elf
	objcopy -O binary -S nand.elf $@
	objdump -D -m arm nand.elf > nand.dis

%.o:%.c
	gcc $(CFLAGS) $< -o $@

%.o:%.S
	gcc $(CFLAGS) $< -o $@

clean:
	rm -f $(OBJS) *.dis *.bin *.elf
