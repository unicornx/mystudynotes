参考 "mini2440用户手册 -20100925.pdf"的附录“使用 H-JTAG 快速烧写BIOS 到开发板”，2. 2 安装并设置H-JTAG。

注意对(3)设置初始化脚本，hfc文件需要匹配板子的nandflash的类型。参考2. 3 设置Flash 型号并烧写BIOS的，因为我的板子的nandflash类型是SAMSUNG K9F2G08U0B，所以需要使用对应的hfc文件：mini-s3c2440+k9f2G08.hfc

使用AXD连接HJTAG时也需要配置，参考手册“4.2 使用HJTAG进行代码调试”。



