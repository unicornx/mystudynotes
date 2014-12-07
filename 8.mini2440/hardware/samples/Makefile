GPIO =		led_asm \
		led_c \
		led_marquee \
		led_twinkle \

STORAGE = 	sdram \
		nand

SECTIONS = $(GPIO) $(STORAGE)

all :
	@echo "begin compile ALL examples ......................."
	for dir in $(SECTIONS); do $(MAKE) -C $$dir || exit "$$?"; done
	@echo "compile ALL examples finished successfully! ......"

.PHONY : clean
clean :
	for dir in $(SECTIONS); do $(MAKE) -C $$dir clean || exit "$$?"; done


	