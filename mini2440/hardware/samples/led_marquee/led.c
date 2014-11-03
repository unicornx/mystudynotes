#define	GPBCON	(*(volatile unsigned long *)0x56000010)
#define	GPBDAT	(*(volatile unsigned long *)0x56000014)

#define	GPB5_out	(1<<(5*2))
#define	GPB6_out	(1<<(6*2))
#define	GPB7_out	(1<<(7*2))
#define	GPB8_out	(1<<(8*2))

#define DELAY_TIME	0xfffff

void  delay(unsigned long dly)
{
	for(; dly > 0; dly--);
}

int main(int argc, char *argv[])
{
	unsigned long i = 0;
	
	// 将LED1-4对应的GPB5/6/7/8四个引脚设为输出
	GPBCON = GPB5_out|GPB6_out|GPB7_out|GPB8_out;	
	
	// ...111111111
	// ...111011111
	// ...110111111
	// ...110011111
	// ...101111111
	// ...101011111
	// ...100111111
	// ...100011111
	// ...
	while(1){
		delay(DELAY_TIME);
		
		/*
		 * 根据i的值，点亮LED1-4, 实现类似跑马灯的功能
		 */
		GPBDAT = (~(i << 5));
		if(++i == 0x10)
			i = 0;
	}

	return 0;
}
