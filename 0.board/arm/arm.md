[关于ARM的几个基本概念浅析](http://blog.csdn.net/nuecai/article/details/8039642)

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

首先要了解image结构的概念，最好的方法就是参考[ARM 链接器用户指南](http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0206ic/index.html)  

ENTRY  
参考[ARM](http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0489c/Chdibhie.html)  


[ARM中的RO、RW和ZI DATA说明](http://blog.csdn.net/jamestaosh/article/details/4348385)  
该文章中的例子比较好

有关“运行时域”和“加载时域”的一些概念：  
直接参考ARM链接器用户指南[3.1.2.映像的加载视图和执行视图](http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0206ic/index.html)或者[英文版](http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0206ic/Cacbdbbc.html)  
[运行时域和加载时域](http://blog.csdn.net/yam_killer/article/details/7909308)    
[arm加载域和运行域的理解](http://19831028.blog.51cto.com/1333653/675523)  
有关“域”，有些书上叫“region”不过看ARM的说法似乎叫"view"。
代码里定义的叫Input sections,可以随便定义，在汇编过程中Input sections会被组合成Output sections, 域只有两个，一个是load view，还有一个是execution view。load view描述image的内容从哪里被load，execution view描述的是image被load到SDRAM中的何处位置并以该位置为基准开始执行，所以linker计算的都是execution view中的地址。load view的地址只是描述image静态存储的排放位置问题。    

lds 文件

scatter 文件  
试图搞懂MDK程序下载到flash(二)--分散加载文件scatter[http://blog.csdn.net/mybelief321/article/details/8941238]  
这个blog有不少不错的嵌入式学习总结，值得看看

[ARM应用系统开发详解──基于S3C4510B的系统设计](http://wenku.baidu.com/view/d3eaa04769eae009581bece2.html)  
这里有汇编，链接的命令参数的含义，可以对照着GUI看。  



[RO,RW,ZI 和scatter file详解](http://19831028.blog.51cto.com/1333653/540221)

arm中映像文件，输入段，输出端，域的介绍  
http://www.eamonning.com/blog/view/267

ARM官方工具软件比较
----
[ARM DS-5 RVDS MDK-ARM 三款ARM官方工具软件比较区别选择](http://www.myir-tech.com/resource/493.asp)  
[ARM开发工具下载大全](http://www.eeboard.com/bbs/thread-24787-1-1.html)

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

参考资料：  
[AXD 调试经验，使用及问题](http://blog.csdn.net/lq_automatic/article/details/7019021)  
[AXD 调试汇总（整理来源于网页）](http://blog.chinaunix.net/uid-26947004-id-3310216.html)  
[ARM编程进阶之三 —— 裸机硬件的控制方法与例程](http://scyangzhu.wordpress.com/2010/03/02/arm%E7%BC%96%E7%A8%8B%E8%BF%9B%E9%98%B6%E4%B9%8B%E4%B8%89-%E2%80%94%E2%80%94-%E8%A3%B8%E6%9C%BA%E7%A1%AC%E4%BB%B6%E7%9A%84%E6%8E%A7%E5%88%B6%E6%96%B9%E6%B3%95%E4%B8%8E%E4%BE%8B%E7%A8%8B/)  

ARM & C
----
在ADS环境下直接使用C语言编程
参考["ADS及RVDS中ARM C库 __main函数执行流程图（截至ARM官方手册）"](http://blog.csdn.net/jg_ben/article/details/6648048)  
可以回答“嵌入式系统原理与应用”P57，程序载入AXD环境后虽然ROBase被设置为0x0，但程序入口点的地址不是0x0的问题。可以看到0x0是__main,以及在low-level-symbols中看到的很多符号地址的大致含义等。
但带来一个问题**[Q]有关程序入口点的含义(Image entry point)**

参考：  
[使用ARM标准C库进行嵌入式应用程序开发](http://wenku.baidu.com/view/bb96fdc4aa00b52acfc7ca58.html)  
[最简单的C程序(STM32版的helloworld)](http://wiki.csie.ncku.edu.tw/embedded/Lab19/stm32-prog.pdf)  
[ARM嵌入式软件编程经验谈](http://www.embedu.org/Column/Column02.htm)  


杂  
----
[ARM指令中特殊符号意义](http://19831028.blog.51cto.com/1333653/683052)


读书笔记：  
《嵌入式系统原理与应用》  
**[Q]** P42，工程里只有Test_Frame.s,不能加Init_Data.s，一加上编译就会报错：A1105E: Area directive missing。难道对GET引入的.s文件是不可以加入工程的吗？  

