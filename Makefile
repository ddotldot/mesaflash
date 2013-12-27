
# target (linux, windows)
TARGET = linux

CC = gcc
RM = rm -f
MATHLIB = -lm
OPT = -O0

#DEBUG = -g -pedantic -Wall -Wextra
#DEBUG = -g -Wall -Wextra
DEBUG = -g

ifeq ($(TARGET),linux)
	INCLUDE = -I/usr/include
	BIN = mesaflash
	LIBS = -lpci
endif

ifeq ($(TARGET),windows)
	MINGW = c:/MinGW
	INCLUDE = -I$(MINGW)/include
	BIN = mesaflash.exe
	LIBS = -lwsock32 libpci.dll winio32.dll
	DEBUG += -mno-ms-bitfields
endif

CFLAGS = $(INCLUDE) $(OPT) $(DEBUG) $(MATHLIB)

objects = common.o lbp16.o lbp.o bitfile.o hostmot2.o spi_eeprom.o anyio.o eth_boards.o epp_boards.o usb_boards.o pci_boards.o
objects += sserial_module.o spi_access_hm2.o spi_access_io.o spi_access_gpio.o spi_boards.o spilbp.o main.o

headers = eth_boards.h pci_boards.h epp_boards.h usb_boards.h spi_boards.h anyio.h hostmot2.h lbp16.h common.h spi_eeprom.h
headers += lbp.h spi_access_hm2.h spi_access_io.h spi_access_gpio.h spilbp.h bitfile.h sserial_module.h

all : $(objects)
	$(CC) -o $(BIN) $(objects) $(MATHLIB) $(LIBS)

main.o : main.c $(headers)
	$(CC) $(CFLAGS) -c main.c

anyio.o : anyio.c $(headers)
	$(CC) $(CFLAGS) -c anyio.c

eth_boards.o : eth_boards.c $(headers)
	$(CC) $(CFLAGS) -c eth_boards.c

pci_boards.o : pci_boards.c $(headers)
	$(CC) $(CFLAGS) -c pci_boards.c

epp_boards.o : epp_boards.c $(headers)
	$(CC) $(CFLAGS) -c epp_boards.c

usb_boards.o : usb_boards.c $(headers) 
	$(CC) $(CFLAGS) -c usb_boards.c

spi_boards.o : spi_boards.c $(headers)
	$(CC) $(CFLAGS) -c spi_boards.c

sserial_module.o : sserial_module.c $(headers)
	$(CC) $(CFLAGS) -c sserial_module.c

spi_access_hm2.o : spi_access_hm2.c $(headers)
	$(CC) $(CFLAGS) -c spi_access_hm2.c

spi_access_io.o : spi_access_io.c $(headers)
	$(CC) $(CFLAGS) -c spi_access_io.c

spi_access_gpio.o : spi_access_gpio.c $(headers)
	$(CC) $(CFLAGS) -c spi_access_gpio.c

lbp16.o : lbp16.c $(headers)
	$(CC) $(CFLAGS) -c lbp16.c

lbp.o : lbp.c $(headers)
	$(CC) $(CFLAGS) -c lbp.c

spilbp.o : spilbp.c $(headers)
	$(CC) $(CFLAGS) -c spilbp.c

hostmot2.o : hostmot2.c $(headers)
	$(CC) $(CFLAGS) -c hostmot2.c

spi_eeprom.o : spi_eeprom.c $(headers)
	$(CC) $(CFLAGS) -c spi_eeprom.c

bitfile.o : bitfile.c $(headers)
	$(CC) $(CFLAGS) -c bitfile.c

common.o : common.c $(headers)
	$(CC) $(CFLAGS) -c common.c

clean :
	$(RM) $(BIN) *.o
