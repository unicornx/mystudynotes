chipset = 多个block
block = 多个page
page = 字节 + scatter
对256MB的nand flash，每个page是2K字节+64个字节的scat部分，一共2048+64=2112个字节，一个字节认为是一列，即一个单元，所以这一共2112个单元需要至少12bit才可以对地址进行编码

相关寄存器
NFCONF - nand flash 配置寄存器

[怎么看时序图--nand flash的读操作详解](http://blog.chinaunix.net/uid-28852942-id-3992727.html)
1) 命令锁存时序图：
从时序图上可知，首先CE片选先发生，保证选中nand器件，然后CLE上升沿发生开始使能命令锁存，ALE下降，关闭地址锁存，Command的IOx开始，等待以上三者都稳定之后，WE发生一次上升跳变，此时Command的数据就进入nand器件的锁存器，此时nandflash就可以从锁存器中得到命令数据了。

[S3C2440 操作汇总（7.NAND芯片的读写及ECC检验软硬件实现](http://bbs.ednchina.com/BLOG_ARTICLE_1991316.HTM)

http://www.chinadmd.com/search.do?nkey=nand+flash+%E8%A3%B8%E6%9D%BF%E9%A9%B1%E5%8A%A8%E5%8F%8A%E5%85%B6%E6%97%B6%E5%BA%8F%E5%9B%BE%E8%AF%A6%E8%A7%A3