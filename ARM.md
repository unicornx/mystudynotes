ARM处理器架构  
有一本很好的讲arm架构的书：《ARM System Developer's Guide》  
就像所有的RISC处理器,arm采用load-store体系结构.也就是说它含有两条不同的指令类型来出入处理器.load指令将数据从内存拷贝到寄存器,store指令是将数据从寄存器拷贝到内存.没有直接操作内存中数据的数据处理指令.数据的处理离不开寄存器.


下面介绍ARM处理器的几个关键分量:
 - 寄存器,
 - 当前程序状态寄存器
 - 流水线
 
 
AXD  
[AXD 调试问题](http://wenku.baidu.com/view/b9636063caaedd3383c4d3e2.html)  
首先要明确一点的是ADS(AXD) 在线debug时要将编译好的运行时代码download到ARM的相应地址上去,这里这个download的地址，就是arm上存储部件的地址，必须是RAM型的存储特性才可以被AXD进行download，如果这个地址域被映射成是Flash存储器，AXD是download不了的，虽然AXD不报错，但可以  通过在AXD下用dissambly 查看一下，如果是flash则看不到正确的指令。  
AXD调试没有什么特别的，他的工作原理是将编译好的运行时映像download到ARM相应地址中去，然后捕获arm 的PC 强制其到 ADS中的entry point 所设置的映像入口地址上，然后你一点击run，pc就从这个入口地址取指，后面该咋执行就咋执行去了。实际代码的硬件运行环境就是ARM芯片的运行环境。 

[ads1.2实例](http://wenku.baidu.com/view/602ace7da26925c52cc5bf90.html)  
图文并茂，可以参考一下。  

[ads1.2使用手册](http://wenku.baidu.com/view/27a2a2886529647d272852ae.html)  


[ARM应用系统开发详解──基于S3C4510B的系统设计](http://wenku.baidu.com/view/d3eaa04769eae009581bece2.html)  
这里有汇编，链接的命令参数的含义，可以对照着GUI看。  




