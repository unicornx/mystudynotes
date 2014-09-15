ex2-1中ldr的伪操作的理解

0000000c行指令将地址0x00000020处的一个字load到r2,该值就是str标号的地址值0x00000040
0x00000020是所有代码之后，满足书上P35所述“在没有指定数据缓冲池的情况下，默认从从所有指令代码之后开始”。  
![](./ex2.1-1.PNG)  
根据对齐的要求，str1从第65个字节处开始。  
Init_DATA.s中的“BEQ %F2”, "%F2"是对局部标号的引用形式，[参考](http://www.cnblogs.com/hoys/archive/2010/12/01/1892578.html)  


ex2-2

	AREA  led_Bram,CODE,READONLY		;定义一个代码段，名为led_Bram0
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


