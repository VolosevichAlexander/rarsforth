riscv-none-elf-gcc -S forth.c -o forth.s -march=rv32im -mabi=ilp32 -O0 -fno-builtin -fno-stack-protector -fno-common
py fix_rars.py forth.s

