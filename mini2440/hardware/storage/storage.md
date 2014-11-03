SDRAM  
参考
[唐攀的blog](http://blog.csdn.net/mr_raptor/article/details/6555786)  
[S3C2440与SDRAM的地址连线分析](http://www.360doc.com/content/11/0914/17/7715138_148241178.shtml)

解释：
- 什么是片选

- mini2440的SDRAM的大小怎么计算
一片SDRAM总容量是32MB。它是由16b * 4M * 4bank,即由四组逻辑bank组成，每个bank包含4M个单元，每个单元是16个bit，即2个字节，即每个逻辑Bank的容量是8MB，一片SDRAM的总容量为(2B * 4M) * 4bank = 32MB。
 
- 为何SDRAM的地址线用A0~A12，只有13根线就够了。
SDRAM内部是一个存储阵列。可以把它想象成一个表格。和表格的检索原理一样，先指定行，再指定列，就可以准确找到所需要的存储单元。这个表格称为逻辑BANK。目前的SDRAM基本都是4个BANK。寻址的流程就是先指定BANK地址，再指定行地址，最后指定列地址。这就是SDRAM的寻址原理。查看HY57V561620F的资料，这个SDRAM有13根行地址线(RA0-RA12),9根列地址线(CA0-CA8), 2根BANK选择线(BA0-BA1)。其中每个逻辑Bank上的4M个内存单元（4M=2^2*2^20=2^22），正好用13行*9列个单元一一对应。同时由于SDRAM的地址引脚是复用的,在读写SDRAM存储单元时，操作过程是将读写的每个单元的地址分两次输入到SDRAM芯片中的行/列地址锁存器，第一次输入行地址，第二次输入列地址，所以可以复用A0-A12，只要共13根地址线就足够了。

- 为何S3C2440和SDRAM之间连线时，SDRAM的A0是和S3C2440的ADDR2连
因为在mini2440上，设计思路是把两片32MB的SDRAM并联，即共用CPU的ADDR2~ADDR14的13根地址线，但数据线分开，第一片SDRAM使用DATA0~DATA15，第二片SDRAM使用DATA16~DATA31，两个SDRAM的CS片选都和CPU的nGCS6连接。达到的效果就是当CPU指定一个SDRAM的地址时，通过同时选中两片SDRAM，并在数据线上同时取到两片SDRAM的两个单元，共4个字节的内容。换句话说，CPU上的地址单位和SDRAM上的地址单位是1：4的概念。所以物理联线时，屏蔽CPU的低四位，结果就是忽略CPU的ADDR0和ADDR1，从CPU的ADDR2开始和SDRAM的A0连接。

- ldrb指令是如何实现取字的部分字节
我们不需要关心，取单个字节的操作会由S3C2440内部的的SDRAM控制器实现，不需程序员操作。SDRAM控制器会操作DQMx管脚，影响SDRAM的LDQM和UDQM，屏蔽不需要的字节。


