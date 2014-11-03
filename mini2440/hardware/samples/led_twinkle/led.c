#define	GPBCON	(*(volatile unsigned long *)0x56000010)
#define	GPBDAT	(*(volatile unsigned long *)0x56000014)

#define	GPB5_out	(1<<(5*2))

#define DELAY_TIME	0x3ffff

#define LED_ON	0x00000000 /* 四个LED对应的管脚全部设置为低电平 */
#define LED_OFF	0x000001e0 /* 四个LED对应的管脚全部设置为高电平 */

void  delay(unsigned long dly)
{
	for(; dly > 0; dly--);
}

int main(int argc, char *argv[])
{
	// 将LED1对应的GPB5的引脚配置为输出
	GPBCON = GPB5_out;

	while (1) {
		GPBDAT = LED_ON;
		delay(DELAY_TIME);
		
		GPBDAT = LED_OFF;
		delay(DELAY_TIME);
	}

	return 0;
}
