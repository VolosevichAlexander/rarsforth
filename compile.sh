#!/bin/bash

set -e

if ! command -v riscv-none-elf-gcc &> /dev/null; then
    echo "Error: riscv-none-elf-gcc not found."
    exit 1
fi

echo "[1/2] Compiling C to RISC-V Assembly..."
riscv-none-elf-gcc -S forth.c -o forth.s -march=rv32im -mabi=ilp32 -O0 -fno-builtin -fno-stack-protector -fno-common

echo "[2/2] Patching assembly for RARS..."
python3 fix_rars.py forth.s

echo "Success! forth.s is ready."