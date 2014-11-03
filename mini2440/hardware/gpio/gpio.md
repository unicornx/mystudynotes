参考S3C2440用户手册第九章-I/O PORTS

GPxCON：配置(CONfigure)引脚功能
GPxDAT：对引脚读/写数据
GPxUP：设置是否使用内部上拉电阻
http://zh.wikipedia.org/zh-cn/上拉电阻
上拉电阻可以使引脚即使在未连接外部组件的时候也能保持确定的逻辑电平.

LED点灯例子

注，LED亮，对应的位设置为0-低电平LED才会导通。

led_asm是演示用汇编点亮一个LED的例子  
led_c是对应led_asm演示用C点亮一个LED的例子，后面的例子主要以C为主  
led_twinkle是演示对一个LED反复点亮和灭的例子，点亮和灭灯的代码可以优化为函数或者宏
led_marquee是演示跑马灯，这个跑马灯的显示有点复杂，最好改写为逐个点亮点灭的例子。

