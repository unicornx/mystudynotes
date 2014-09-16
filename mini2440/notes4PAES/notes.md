ex2-1
----
ldr的伪操作的理解  
0000000c行指令将地址0x00000020处的一个字load到r2,该值就是str标号的地址值0x00000040
0x00000020是所有代码之后，满足书上P35所述“在没有指定数据缓冲池的情况下，默认从从所有指令代码之后开始”。  
![](./ex2.1-1.PNG)  
根据对齐的要求，str1从第65个字节处开始。  
Init_DATA.s中的“BEQ %F2”, "%F2"是对局部标号的引用形式，[参考](http://www.cnblogs.com/hoys/archive/2010/12/01/1892578.html)  


ex2-2
----
	AREA  led_Bram,CODE,READONLY	;定义一个代码段，名为led_Bram0
	ENTRY							;指定汇编程序的入口点
		LDR		R0,=0x53000000		;关闭看门狗
		LDR		R1,=0x0
		STR		R1,[R0]
		LDR		R0,=0x56000010		;R0设为GPBCON寄存器地址
		LDR     R1,=0x15400			;00000000000000010101010000000000
									;GPB5 [11:10] 01(Output) -> LED1
									;GPB6 [13:12] 01(Output) -> LED2
									;GPB7 [15:14] 01(Output) -> LED3
									;GPB8 [17:16] 01(Output) -> LED4
									;将第10位到第16位设置为Output
		STR		R1,[R0]
		LDR		R0,=0x56000018		;R0设为GPBUP寄存器地址
		LDR     R1,=0x1e0			;111100000 第5位到第8位设置为1，disabled
		STR    	R1,[R0]             ;设置GPBUP，对LED1和LED4对应的电阻禁止上拉，
									;禁止的目的是要让后继的GPBDAT控制起作用。
									;(If the port pull-up register is enabled
									;then the pull-up resisters work without
									;pin’s functional setting).
		LDR		R3,=0x56000014		;R3设为GPBDAT寄存器地址
	MAIN_LOOP
		LDR     	R4,=0x00		;R4为输出内容，先灭等
		STR     	R4,[R3]			;GPBDAT输出00，LEDn为低电平，电流产生，灯亮
		LDR     	R4,=0x1e0		;R4为输出内容，第5位到第8位设置为1
		STR     	R4,[R3]			;GPBDAT输出f0，LED熄灭
		B       	MAIN_LOOP		;死循环
	END								;汇编程序结束标识。

ex2-5  
----
参考：  
http://blog.csdn.net/mybelief321/article/details/8914299 - 这个
http://blog.csdn.net/vanson18/article/details/6780674 - 这个有一些基本概念的介绍

	;MDIV=92, PDIV=1, SDIV=1, so according to fomula @7-20 S3C2440
	;manual,FCLK=400MHz
	;咱们经常用的就是FCLK=400MHz和FCLK=200MHz
	;for 400Mhz, MDIV=92, PDIV=1, SDIV=1
	;for 200Mhz, MDIV=92, PDIV=4, SDIV=1
    MPLL	EQU	((0x5c<<12)|(0x01<<4)|(0x01))
	
	;分频比
	;当CLKDIV_VAL=0 时，FCLK：HCLK：PCLK=1：1：1
	;当CLKDIV_VAL=1 时，FCLK：HCLK：PCLK=1：1：2
	;当CLKDIV_VAL=2 时，FCLK：HCLK：PCLK=1：2：2
	;当CLKDIV_VAL=3 时，FCLK：HCLK：PCLK=1：2：4
	;当CLKDIV_VAL=4 时，FCLK：HCLK：PCLK=1：4：4
	;当CLKDIV_VAL=5 时，FCLK：HCLK：PCLK=1：4：8
	;当CLKDIV_VAL=6 时，FCLK：HCLK：PCLK=1：3：3
	;当CLKDIV_VAL=7 时，FCLK：HCLK：PCLK=1：3：6	
	SCALE	EQU	((0x0<<3)|(0x2<<1)|(0x01))		;FCLK:HCLK:PCLK = 1:4:8

	GET	2440Reg_addr.inc

	AREA  MyCode,CODE,READONLY	;定义一个代码段，名为MyCode
	ENTRY						;指定汇编程序的入口点

		LDR		R0,= WTCON		;关闭看门狗
		LDR		R1,=0x0
		STR		R1,[R0]

		;开始设置时钟
		;第1步：设置分频比
		LDR		R0,=CLKDIVN
		LDR		R1,=SCALE			
		STR		R1,[R0]

		;第2步，对分频后的补充设置，参考S3C2440 UM Page7-9
		;当HDIVN==0的时候,FCLK:HCLK:PCLK=1：1：1,此时CPU的主频和快速总线时钟频率
		;一致，此时总线模式为“快速总线模式”。如果不是这个比例，或者说HDIVN!=0的时候，
		;这个时候我们总线上的频率和CPU的频率就不一样了，所以我们要把总线模式改为异步
		;总线模式。（S3C2440不支持同步总线模式）
		;MRC和MCR是协处理器相关命令
		MRC    	p15, 0, R1, c1, c0, 0	;读出控制寄存器
		ORR    	R1, R1, #0xC0000000		;设置asynchronous bus mode
    	MCR    	p15, 0, R1, c1, c0, 0	;写入控制寄存器

		;第3步，设置主频FCLK
		LDR		R0,=MPLLCON
		LDR		R1,=MPLL			;设置FCLK
		STR		R1,[R0]
		GET		Led_Flicker.s

		;第4步，软件工作：等待locktime时间，让新的Fclk生效
		;根据PAES Page47，该操作可选
	END								;汇编程序结束标识。

ex2-7 
----
SDRAM  
参考[唐攀的blog](http://blog.csdn.net/mr_raptor/article/details/6555786)  
有个地方自己解释一下：关于为何SDRAM的地址是A0~A12，最大寻址8M。实际上一片SDRAM（就mini2440的情况）是32MB。它是由16b * 4M * 4bank,即由四组bank组成，每组bank包含4M个单元，每个单元有16bit，即2个字节。所以总容量为(2B * 4M) * 4bank;前面为8M个字节，可以用A0~A12寻址，另外的bank号用BA0和BA1来标识。所以一片内存容量为32MB  

两片SDRAM并联，共享地址线(ADDR2~ADDR14[A0~A12],ADDR24[BA0],ADDR25[BA1])。CPU通过GCS片选区分这两片SDRAM。  

		LDR 	R0,=SMRDATA		;SMRDATA数据开始地址
		LDR 	R1,=BWSCON    	;BWSCON地址
		ADD    	R2, R0, #52   	;SMRDATA数据结束地址,52是13个DCD的总长度
	0	;通过循环SMRDATA的表数据初始化SDRAM
		LDR 	R3, [R0], #4	;读出数据
		STR    	R3, [R1], #4	;写入寄存器
		CMP    	R2, R0 			;判断是否结束
		BNE    	%B0				;逆向返回标号0
		MOV		PC,LR			;初始化SDRAM返回
	SMRDATA
		;对BWSCON，只对Bank7和Bank6有设置为"0010"，其他都缺省值,参考唐攀的解释
    	DCD 	0x22000000		;BWSCON
		DCD    	0x00000700     	;BANKCON0
    	DCD    	0x00000700     	;BANKCON1
     	DCD    	0x00000700     	;BANKCON2
     	DCD    	0x00000700     	;BANKCON3  
    	DCD    	0x00000700     	;BANKCON4
    	DCD    	0x00000700     	;BANKCON5
    	DCD    	0x00018005      ;BANKCON6
    	DCD    	0x00018005     	;BANKCON7
    	DCD    	0x008c04f3      ;REFRESH
    	DCD    	0x000000b1      ;BANKSIZE
    	DCD    	0x00000030     	;MRSRB6
    	DCD   	0x00000030     	;MRSRB7
	END						;包含文件内的汇编结束伪指令



