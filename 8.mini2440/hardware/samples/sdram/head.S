@*************************************************************************
@ File：head.S
@ 功能：设置SDRAM，将程序复制到SDRAM，然后跳到SDRAM继续执行
@*************************************************************************       

.equ	BWSCON,		0x48000000	@ 寄存器BWSCON的地址
.equ	SDRAM_BASE,	0x30000000

.text
.global _start
_start:
	bl	disable_watch_dog	@ 关闭WATCHDOG，否则CPU会不断重启
	bl	memsetup		@ 设置存储控制器
	bl	copy2sdram		@ 复制代码到SDRAM中
	ldr	pc, =on_sdram		@ 跳到SDRAM中继续执行，原因：
					@ 编译完后根据ld的-Ttext 0x3000000
					@ 参数，计算得到这里on_sdram的值是
					@ 0x30000010,这正是指令被拷贝到SDRAM后
					@ 下一条指令“ldr sp, =0x34000000”的绝
					@ 对地址，所以程序接着执行on_sdram后的
					@ 指令。

on_sdram:
	ldr	sp, =0x34000000		@ 设置堆栈
	bl	main
halt_loop:
	b	halt_loop

disable_watch_dog:
	@ 往WATCHDOG寄存器写0即可
	mov	r1,	#0x53000000
	mov	r2,	#0x0
	str	r2,	[r1]
	mov	pc,	lr		@ 返回

copy2sdram:
	@ 将Steppingstone的4K数据全部复制到SDRAM中去
	@ Steppingstone起始地址为0x00000000，SDRAM中起始地址为0x30000000
	mov	r1,	#0
	ldr	r2,	=SDRAM_BASE
	mov	r3,	#4*1024
1:  
	ldr	r4,	[r1],#4	@ 从Steppingstone读取4字节的数据，并让源地址加4
	str	r4,	[r2],#4	@ 将此4字节的数据复制到SDRAM中，并让目地地址加4
	cmp	r1,	r3	@ 判断是否完成：源地址等于Steppingstone的未地址？
	bne	1b		@ 若没有复制完，继续
	mov	pc,     lr	@ 返回

memsetup:
	@ 设置存储控制器以便使用SDRAM等外设
	mov	r1,	#BWSCON		@ 存储控制器的13个寄存器的开始地址
	adrl	r2,	mem_cfg_val	@ 这13个值的起始存储地址
	add	r3,	r1, #52		@ 13*4 = 54
1:
	ldr	r4,	[r2], #4	@ 读取设置值，并让r2加4
	str	r4,	[r1], #4	@ 将此值写入寄存器，并让r1加4
	cmp	r1,	r3		@ 判断是否设置完所有13个寄存器
	bne	1b			@ 若没有写成，继续
	mov	pc,	lr		@ 返回

.align 4
mem_cfg_val:
	@ 存储控制器13个寄存器的设置值
	@ BWSCON,用于配置8个Bank，每4位控制一个Bank
	@ BANKCONx(x为0~5)用于配置Bank外接设备的访问时序
	@ BANKCONx(x为6~7)可以外接SRAM和SDRAM
	@ REFRESH - 刷新控制
	@ BANKSIZE - Bank容量设置 
	.long	0x22000000	@ BWSCON,用于配置8个Bank
#	.long	0x22011110	@ BWSCON
	.long	0x00000700	@ BANKCON0，
	.long	0x00000700	@ BANKCON1
	.long	0x00000700	@ BANKCON2
	.long	0x00000700	@ BANKCON3  
	.long	0x00000700	@ BANKCON4
	.long	0x00000700	@ BANKCON5
	.long	0x00018005	@ BANKCON6
	.long	0x00018005	@ BANKCON7
#	.long	0x008C07A3	@ REFRESH
	.long	0x008C04F3	@ REFRESH
	.long	0x000000B1	@ BANKSIZE
	.long	0x00000030	@ MRSRB6
	.long	0x00000030	@ MRSRB7
