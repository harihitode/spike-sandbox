###################################
## Change this for your environment
RVPATH?=${HOME}/llvm-riscv
TARGET_ARCH=--target=riscv32 -march=rv32imafc -mabi=ilp32f
###################################
CC=${RVPATH}/bin/clang
AS=${RVPATH}/bin/clang -c
AR=${RVPATH}/bin/llvm-ar
LD=${RVPATH}/bin/ld.lld
OBJDUMP=${RVPATH}/bin/llvm-objdump
OBJCOPY=${RVPATH}/bin/llvm-objcopy
CFLAGS=-nodefaultlibs -g -O3 -static -fno-builtin -I./ -mno-relax $(TARGET_ARCH)
ASFLAGS=-nodefaultlibs -mno-relax $(TARGET_ARCH)
LSCRIPT?=lscript.ld
LDFLAGS=-nodefaultlibs -T ${LSCRIPT} -L./ -z nognustack -mno-relax
ARFLAGS=rcs
# LDFLAGS+=-L${RVPATH}/lib/clang/18/lib/riscv32-unknown-elf/
# LDLIBS=-lclang_rt.builtins

.PHONY: all clean

all: main

main: main.o start.o
	$(CC) $(LDFLAGS) main.o start.o -o $@

clean:
	rm -rf *.o main
