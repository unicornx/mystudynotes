参考 [H-Jtag V1.0 烧写Nand Flash](http://blog.csdn.net/dearwind153/article/details/7184224)

选择NOR方式启动，打开H-JTAG连接上ARM920T
![](./1.png)

Flasher->Start H-Flasher


打开Flash-Selection界面，在chipset列表的最下面有一个NAND-FLASH选项。
![](./2.png)

点开后会看到我的mini2440对应的Nandflash的型号：SAMSUNG K9F2G08U0B
![](./3.png)


进入Configuration设置好RAM的Start Address,否则在对nandflash操作时会报如下错误：
![](./4.png)
![](./5.png)

进入Progarmming界面，点击Check；如果想擦除NAND Flash 可以点击“Erase”
![](./6.png)
