ARM处理器架构  
----
有一本很好的讲arm架构的书：《ARM System Developer's Guide》  
就像所有的RISC处理器,arm采用load-store体系结构.也就是说它含有两条不同的指令类型来出入处理器.load指令将数据从内存拷贝到寄存器,store指令是将数据从寄存器拷贝到内存.没有直接操作内存中数据的数据处理指令.数据的处理离不开寄存器.


下面介绍ARM处理器的几个关键分量:
 - 寄存器,
 - 当前程序状态寄存器
 - 流水线


ARM的编译链接相关问题  
----

ARM中的RO、RW和ZI DATA说明[http://blog.csdn.net/jamestaosh/article/details/4348385]  
该文章中的例子比较好

运行时域和加载时域（运行地址和加载地址）[http://blog.csdn.net/yam_killer/article/details/7909308]  
lds 文件

scatter 文件  
试图搞懂MDK程序下载到flash(二)--分散加载文件scatter[http://blog.csdn.net/mybelief321/article/details/8941238]  
这个blog有不少不错的嵌入式学习总结，值得看看

[ARM应用系统开发详解──基于S3C4510B的系统设计](http://wenku.baidu.com/view/d3eaa04769eae009581bece2.html)  
这里有汇编，链接的命令参数的含义，可以对照着GUI看。  

[arm加载域和运行域的理解](http://19831028.blog.51cto.com/1333653/675523)

[RO,RW,ZI 和scatter file详解](http://19831028.blog.51cto.com/1333653/540221)

arm中映像文件，输入段，输出端，域的介绍  
http://www.eamonning.com/blog/view/267

ADS & AXD  
----
 
AXD  
[AXD 调试问题](http://wenku.baidu.com/view/b9636063caaedd3383c4d3e2.html)  
首先要明确一点的是ADS(AXD) 在线debug时要将编译好的运行时代码download到ARM的相应地址上去,这里这个download的地址，就是arm上存储部件的地址，必须是RAM型的存储特性才可以被AXD进行download，如果这个地址域被映射成是Flash存储器，AXD是download不了的，虽然AXD不报错，但可以  通过在AXD下用dissambly 查看一下，如果是flash则看不到正确的指令。  
AXD调试没有什么特别的，他的工作原理是将编译好的运行时映像download到ARM相应地址中去，然后捕获arm 的PC 强制其到 ADS中的entry point 所设置的映像入口地址上，然后你一点击run，pc就从这个入口地址取指，后面该咋执行就咋执行去了。实际代码的硬件运行环境就是ARM芯片的运行环境。 

读“嵌入式系统原理与应用” P40 原文*“可以看到可读写数据段和可读写预留空间内的符号地址被汇编成为0xc00，但需注意：可读写数据段和可读写预留空间段的位置仍在只读段之后，并没有加载到指定内存空间...”*  
-我的理解是在AXD调试过程中，AXD只是将bin文件逐个字节地从本地文件拷贝到内存中，并不会因为我们在ADS的配置中将RWBase配置为0xc00就将某些段move到指定的地址。但我们在ADS中的配置信息会影响到ARM Linker的过程，即链接的符号解析过程。观察Low Level Symbols，Str2的地址此时变为0xc00。这意味着如果代码段中有对Str2的引用则代码段中的Str2就会被解释为0xc00开始的段内的地址。  
![](./001.png)


[ads1.2实例](http://wenku.baidu.com/view/602ace7da26925c52cc5bf90.html)  
图文并茂，可以参考一下。  

[ads1.2使用手册](http://wenku.baidu.com/view/27a2a2886529647d272852ae.html)  


ADS1.2的OPTION中的IMAGE ENTRY POINT是就是程序运行的时候，应该执行的第一条指令的地址。  


Bootloader
----
[ARM的位置无关程序设计在Bootloader中的应用](http://www.mcuol.com/tech/107/26052.htm)  


ARM & C
----
[最简单的C程序(STM32版的helloworld)](http://wiki.csie.ncku.edu.tw/embedded/Lab19/stm32-prog.pdf)  



S3C2440  
----

S3C2440释疑[http://blog.163.com/dingmz_frcmyblog/blog/static/2173040232013111425920546/]  
提了几个不错的问题，但回答不是很对。可以用来搜集为常用问题对待  


s3c2440系统时钟  
http://blog.csdn.net/dreamcatcher100/article/details/9374559  
我们用最清晰的线路来绘制一下时钟的产生过程：外部时钟源→通过寄存器MPLLCON得到FCLK→再通过寄存器CLKDIVN得到HCLK和PCLK。这个配置过程在启动文件中就已完成。


杂  
----
[ARM指令中特殊符号意义](http://19831028.blog.51cto.com/1333653/683052)


读书笔记：  
《嵌入式系统原理与应用》  
**[Q]** P42，工程里只有Test_Frame.s,不能加Init_Data.s，一加上编译就会报错：A1105E: Area directive missing。难道对GET引入的.s文件是不可以加入工程的吗？  
