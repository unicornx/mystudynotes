已知一个数x的原码，求其补码b：
if (x >= 0)
	b = x //转成二进制形式
else
	b = ~|x| + 1 //转成二进制形式
	
已知一个二进制数b的补码，求原码x
if (b >= 0) //最高位位为0
	x = b //转成十进制形式
else
	x = ~b + 1 //转成十进制形式

参考：http://www.cnblogs.com/youxin/archive/2012/07/03/2575504.html


AT&T汇编语法

http://blog.csdn.net/jnu_simba/article/details/11747901
为何用.S而不是.s


	