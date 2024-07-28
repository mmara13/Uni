CC=/usr/bin/gcc-11
obj-m += descendants_kernel.o
CFLAGS=-g
all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean

