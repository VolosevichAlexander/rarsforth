import sys
import re

def fix_asm(filename):
    with open(filename, 'r') as f:
        lines = f.readlines()

    new_lines = []
    
    for line in lines:
        if any(x in line for x in [".section", ".bss", ".sbss", ".rodata"]):
            if ".text" not in line:
                new_lines.append(".data\n")
                continue

        match_zero = re.search(r'\.zero\s+(\d+)', line)
        if match_zero:
            size = match_zero.group(1)
            new_lines.append(f"\t.space {size}\n")
            continue

        if any(x in line for x in ['.attribute', '.size', '.type', '.ident', '.option', '.file']):
            continue
        
        if "lui" in line and "%hi" in line:
            new_lines.append(f"# DELETED LUI: {line}")
            continue

        match_addi = re.search(r'addi\s+(\w+),.*%lo\((.*)\)', line)
        if match_addi:
            reg = match_addi.group(1)
            label = match_addi.group(2)
            new_lines.append(f"\tla {reg}, {label}\n")
            continue

        match_lw = re.search(r'lw\s+(\w+),.*%lo\((.*)\)\(.*\)', line)
        if match_lw:
            reg = match_lw.group(1)
            label = match_lw.group(2)
            new_lines.append(f"\tla t6, {label}\n")
            new_lines.append(f"\tlw {reg}, 0(t6)\n")
            continue

        match_sw = re.search(r'sw\s+(\w+),.*%lo\((.*)\)\(.*\)', line)
        if match_sw:
            reg = match_sw.group(1)
            label = match_sw.group(2)
            new_lines.append(f"\tla t6, {label}\n")
            new_lines.append(f"\tsw {reg}, 0(t6)\n")
            continue

        new_lines.append(line)

    with open(filename, 'w') as f:
        f.writelines(new_lines)
    
    print(f"Fixed {filename}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python fix_rars.py file.s")
    else:
        fix_asm(sys.argv[1])
