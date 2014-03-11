arm中映像文件，输入段，输出端，域的介绍  
http://www.eamonning.com/blog/view/267







elf
man elf
The ELF Object File Format by Dissection http://www.linuxjournal.com/article/1060  
A classic guide to elf wrote by kernel master


notes for 深入理解计算机系统 有关重定位章节
Relocating PC-Relative References
那个例子
text段的起始地址是0x80483b4
call指令的offset是0x06，所以call指令的地址是0x80483ba
汇编器将初始值设置为0xfffffffc（-4）是有特定目的的，正好是x86-32位情况下一个call命令的参数的长度。而PC在运行时正好在这个call指令的后面“PC always points to the instructionfollowing the current instruction. On a different machine with different instruction sizes and encodings, the assembler for that machine would use a different bias.”。  

注意Runtime CPU 执行指令的方式：  
1. push PC onto stack  
2. PC <- PC + 0x9 = 0x80483bf + 0x9 = 0x80483c8  


0x80483b4 <- start of section text  
0x80483b5  
0x80483b6  
0x80483b7  
0x80483b8  
0x80483b9  
0x80483ba <- 1-byte opcode 0xe8 "call"   
0x80483bb 0xfc <- r.offset, notify ld to modify from this position  
0x80483bc 0xff  
0x80483bd 0xff  
0x80483be 0xff  
0x80483bf <- Run time PC此时位置在这里，所以根据运行时CPU执行指令的方式，计算是需要0x80483c8 - 0x80483bb + (-4)，，即在PC上加上（swap的地址和r.offset之间的偏移值）之后还要往后退4个字节，这就是（-4），即0xfffffffc的由来  
0x80483c0  
0x80483c1  
0x80483c2  
0x80483c3  
0x80483c4  
0x80483c5  
0x80483c6  
0x80483c7  
0x80483c8 <- swap function address  

另参考 http://stackoverflow.com/questions/12412064/meaning-of-r-386-32-r-386-pc32-in-rel-text-section-of-elf  
R_386_32 is useful for static data, as shown here, since the compiler just loads the relocated symbol address into some register and then treats it as a pointer. R_386_PC32 is useful for function references since it can be used as an immediate argument to call.   


