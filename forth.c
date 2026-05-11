#include "rars_lib.h"
#include <stddef.h>

#define STACK_SIZE 64
#define MEMORY_SIZE 65536
#define DICT_SIZE 256
#define NULL 0

#define STATE_ADDR   0x00
#define BASE_ADDR    0x02
#define IN_ADDR      0x04
#define BLK_ADDR     0x06
#define SCR_ADDR     0x08
#define CONTEXT_ADDR 0x0A
#define CURRENT_ADDR 0x0C
#define TIB_ADDR     0x10
#define TIB_SIZE     0x400
#define PAD_ADDR     0x410
#define WORD_BUF     0x470
#define HOLD_BUF     0x4B0
#define HOLD_END     0x4D0
#define HERE_START   0x4D0
#define BLOCKS_BASE  0x6000
#define BLOCK_SIZE   1024
#define NUM_BLOCKS   32

struct ForthVM {
    int dsp; int dstack[STACK_SIZE];
    int rsp; int rstack[STACK_SIZE];
    unsigned char memory[MEMORY_SIZE];
    int here;
    int ip;
};
volatile struct ForthVM vm;

typedef void (*code_ptr)();

#define KIND_PRIMITIVE  0
#define KIND_COLON      1
#define KIND_VARIABLE   2
#define KIND_CONSTANT   3
#define KIND_DOES       4
#define KIND_VOCAB      5

struct Header {
    char name[32]; int name_len; code_ptr code; int param; int does_addr; int is_immediate; int kind; int vocab;
};
struct Header dict[DICT_SIZE];
int dict_len = 0;
int vocab_count = 1;  /* 0 = FORTH */

static int sext16(int v) {
    v &= 0xFFFF;
    if (v & 0x8000) v |= 0xFFFF0000;
    return v;
}

int cell_fetch(int addr) {
    addr &= 0xFFFF;
    int v = vm.memory[addr] | (vm.memory[(addr + 1) & 0xFFFF] << 8);
    if (v & 0x8000) v |= 0xFFFF0000;
    return v;
}
int ucell_fetch(int addr) {
    addr &= 0xFFFF;
    return vm.memory[addr] | (vm.memory[(addr + 1) & 0xFFFF] << 8);
}
void cell_store(int addr, int val) {
    addr &= 0xFFFF;
    vm.memory[addr] = val & 0xFF;
    vm.memory[(addr + 1) & 0xFFFF] = (val >> 8) & 0xFF;
}
int byte_fetch(int addr) {
    addr &= 0xFFFF;
    return vm.memory[addr];
}
void byte_store(int addr, int val) {
    addr &= 0xFFFF;
    vm.memory[addr] = val & 0xFF;
}

int my_strcmp(const char* s1, const char* s2) {
    while (*s1 && (*s1 == *s2)) { s1++; s2++; }
    return *(const unsigned char*)s1 - *(const unsigned char*)s2;
}
void my_strcpy(char* dest, const char* src) {
    while (*src) { *dest = *src; dest++; src++; }
    *dest = 0;
}
int digit_value(int c, int base) {
    int v;
    if (c >= '0' && c <= '9') v = c - '0';
    else if (c >= 'A' && c <= 'Z') v = c - 'A' + 10;
    else if (c >= 'a' && c <= 'z') v = c - 'a' + 10;
    else return -1;
    if (v >= base) return -1;
    return v;
}
int current_base() {
    int b = cell_fetch(BASE_ADDR);
    if (b < 2 || b > 36) b = 10;
    return b;
}
int is_number(const char* s) {
    int base = current_base();
    if (*s == '-') s++;
    if (!*s) return 0;
    while (*s) { if (digit_value((unsigned char)*s, base) < 0) return 0; s++; }
    return 1;
}
int my_atoi(const char* s) {
    int base = current_base();
    int sign = 1;
    if (*s == '-') { sign = -1; s++; }
    int res = 0;
    while (*s) {
        int v = digit_value((unsigned char)*s, base);
        if (v < 0) break;
        res = res * base + v;
        s++;
    }
    return res * sign;
}

void print_in_base(int n, int base) {
    if (n == 0) { print_char('0'); return; }
    int neg = 0;
    unsigned int u;
    if (n < 0) { neg = 1; u = (unsigned int)(-n) & 0xFFFF; }
    else        { u = (unsigned int)n & 0xFFFF; }
    char buf[20];
    int i = 0;
    while (u > 0) {
        int d = u % base;
        buf[i++] = (d < 10) ? ('0' + d) : ('A' + (d - 10));
        u /= base;
    }
    if (neg) print_char('-');
    while (i > 0) print_char(buf[--i]);
}

void print_in_base_unsigned(unsigned int u, int base) {
    if (u == 0) { print_char('0'); return; }
    char buf[20];
    int i = 0;
    while (u > 0) {
        int d = u % base;
        buf[i++] = (d < 10) ? ('0' + d) : ('A' + (d - 10));
        u /= base;
    }
    while (i > 0) print_char(buf[--i]);
}

void create_word_lv(const char* name, int real_len, code_ptr code, int param, int imm) {
    if (dict_len >= DICT_SIZE) { print_string("Dict Full!\n"); return; }
    int ni;
    int copy_len = (real_len < 31) ? real_len : 31;
    for (ni = 0; ni < copy_len; ni++) dict[dict_len].name[ni] = name[ni];
    dict[dict_len].name[ni] = 0;
    dict[dict_len].name_len = real_len;
    dict[dict_len].code = code;
    dict[dict_len].param = param;
    dict[dict_len].does_addr = 0;
    dict[dict_len].is_immediate = imm;
    dict[dict_len].kind = (code != NULL) ? KIND_PRIMITIVE : KIND_COLON;
    dict[dict_len].vocab = cell_fetch(CURRENT_ADDR);
    dict_len++;
}

void create_word(const char* name, code_ptr code, int param, int imm) {
    int len = 0;
    while (name[len]) len++;
    create_word_lv(name, len, code, param, imm);
}

void execute_dict(int id);
void eval(char* input);
int names_match(int i, const char* name, int len) {
    if (dict[i].name_len != len) return 0;
    int cmp = (len < 31) ? len : 31;
    for (int k = 0; k < cmp; k++) {
        if (dict[i].name[k] != name[k]) return 0;
    }
    return 1;
}

int find_id_lv(const char* name, int len) {
    int context = cell_fetch(CONTEXT_ADDR);
    for (int i = dict_len - 1; i >= 0; i--) {
        if (dict[i].vocab == context && names_match(i, name, len)) return i;
    }
    if (context != 0) {
        for (int i = dict_len - 1; i >= 0; i--) {
            if (dict[i].vocab == 0 && names_match(i, name, len)) return i;
        }
    }
    return -1;
}

int find_id(const char* name) {
    int len = 0;
    while (name[len]) len++;
    return find_id_lv(name, len);
}

void forth_init() {
    vm.dsp = 0; vm.rsp = 0;
    for(int i=0; i<MEMORY_SIZE; i++) vm.memory[i] = 0;
    cell_store(STATE_ADDR, 0);
    cell_store(BASE_ADDR, 10);
    cell_store(IN_ADDR, 0);
    cell_store(BLK_ADDR, 0);
    cell_store(SCR_ADDR, 0);
    cell_store(CONTEXT_ADDR, 0);
    cell_store(CURRENT_ADDR, 0);
    vm.here = HERE_START;
}
void push(int val) {
    if (vm.dsp < STACK_SIZE) vm.dstack[vm.dsp++] = sext16(val);
    else { print_string("S-Ovf!\n"); exit_program(); }
}
int pop() { if (vm.dsp > 0) return vm.dstack[--vm.dsp]; print_string("S-Udf!\n"); return 0; }
void rpush(int val) {
    if (vm.rsp < STACK_SIZE) vm.rstack[vm.rsp++] = sext16(val);
    else { print_string("R-Ovf!\n"); exit_program(); }
}
int rpop() { if (vm.rsp > 0) return vm.rstack[--vm.rsp]; print_string("R-Udf!\n"); return 0; }

int in_user_word = 0;
int exit_flag = 0;
int abort_flag = 0;

void execute_user_word(int start_addr) {
    int old_ip = vm.ip; vm.ip = start_addr;
    in_user_word++;
    while(1) {
        if (abort_flag) break;
        int token = cell_fetch(vm.ip); vm.ip += 2;
        if (token == -1) break;
        if (token >= 0 && token < dict_len) execute_dict(token);
        if (abort_flag) break;
        if (exit_flag) { exit_flag = 0; break; }
    }
    in_user_word--;
    vm.ip = old_ip;
}

void execute_dict(int id) {
    switch (dict[id].kind) {
    case KIND_PRIMITIVE: dict[id].code(); break;
    case KIND_COLON:     execute_user_word(dict[id].param); break;
    case KIND_VARIABLE:  push(dict[id].param); break;
    case KIND_CONSTANT:  push(cell_fetch(dict[id].param)); break;
    case KIND_DOES:
        push(dict[id].param);
        execute_user_word(dict[id].does_addr);
        break;
    case KIND_VOCAB:
        cell_store(CONTEXT_ADDR, dict[id].param);
        break;
    }
}

void comma(int val) {
    if (vm.here + 1 < MEMORY_SIZE) { cell_store(vm.here, val); vm.here += 2; }
    else { print_string("Mem Full!\n"); exit_program(); }
}
void c_comma(int val) {
    if (vm.here < MEMORY_SIZE) { byte_store(vm.here, val); vm.here += 1; }
    else { print_string("Mem Full!\n"); exit_program(); }
}

void w_add() { int b = pop(); int a = pop(); push(a + b); }
void w_sub() { int b = pop(); int a = pop(); push(a - b); }
void w_mul() { int b = pop(); int a = pop(); push(a * b); }
void w_div() { int b = pop(); int a = pop(); push(b ? a/b : 0); }
void w_mod() { int b = pop(); int a = pop(); push(b ? a%b : 0); }
void w_div_mod() { int b = pop(); int a = pop(); if(!b){push(0);push(0);return;} push(a%b); push(a/b); }

void w_one_plus()  { push(pop() + 1); }
void w_one_minus() { push(pop() - 1); }
void w_two_plus()  { push(pop() + 2); }
void w_two_minus() { push(pop() - 2); }

void w_abs()    { int n = pop(); push(n < 0 ? -n : n); }
void w_negate() { push(-pop()); }
void w_min()    { int b = pop(); int a = pop(); push(a < b ? a : b); }
void w_max()    { int b = pop(); int a = pop(); push(a > b ? a : b); }

void w_mul_div()     { int n3 = pop(); int n2 = pop(); int n1 = pop(); if(!n3){push(0);return;} push((n1*n2)/n3); }
void w_mul_div_mod() { int n3 = pop(); int n2 = pop(); int n1 = pop(); if(!n3){push(0);push(0);return;} int p = n1*n2; push(p%n3); push(p/n3); }

void w_zero_eq() { push(pop() == 0 ? 1 : 0); }
void w_zero_lt() { push(pop() <  0 ? 1 : 0); }
void w_zero_gt() { push(pop() >  0 ? 1 : 0); }

void w_and() { int b = pop(); int a = pop(); push(a & b); }
void w_or()  { int b = pop(); int a = pop(); push(a | b); }
void w_xor() { int b = pop(); int a = pop(); push(a ^ b); }

void w_u_lt() {
    unsigned int b = (unsigned int)(pop() & 0xFFFF);
    unsigned int a = (unsigned int)(pop() & 0xFFFF);
    push(a < b ? 1 : 0);
}
void w_u_mul() {
    unsigned int b = (unsigned int)(pop() & 0xFFFF);
    unsigned int a = (unsigned int)(pop() & 0xFFFF);
    unsigned int p = a * b;
    push((int)(p & 0xFFFF));
    push((int)((p >> 16) & 0xFFFF));
}
void w_u_div_mod() {
    unsigned int b  = (unsigned int)(pop() & 0xFFFF);
    unsigned int hi = (unsigned int)(pop() & 0xFFFF);
    unsigned int lo = (unsigned int)(pop() & 0xFFFF);
    if (b == 0) { push(0); push(0); return; }
    unsigned int d = (hi << 16) | lo;
    push((int)((d % b) & 0xFFFF));
    push((int)((d / b) & 0xFFFF));
}

void w_to_r()    { rpush(pop()); }
void w_r_from()  { push(rpop()); }
void w_r_fetch() { if (vm.rsp > 0) push(vm.rstack[vm.rsp-1]); }

void w_q_dup() {
    if (vm.dsp > 0 && vm.dstack[vm.dsp-1] != 0) push(vm.dstack[vm.dsp-1]);
}

void w_pick() {
    int n = pop();
    if (n < 1 || n > vm.dsp) { print_string("PICK err\n"); push(0); return; }
    push(vm.dstack[vm.dsp - n]);
}
void w_roll() {
    int n = pop();
    if (n < 1 || n > vm.dsp) { print_string("ROLL err\n"); return; }
    int t = vm.dstack[vm.dsp - n];
    for (int i = vm.dsp - n; i < vm.dsp - 1; i++) vm.dstack[i] = vm.dstack[i + 1];
    vm.dstack[vm.dsp - 1] = t;
}

void w_plus_store() {
    int addr = pop();
    int n = pop();
    cell_store(addr, cell_fetch(addr) + n);
}

void w_cmove() {
    int n = pop(); int dst = pop(); int src = pop();
    if (n <= 0) return;
    for (int i = 0; i < n; i++) byte_store(dst + i, byte_fetch(src + i));
}
void w_move() {
    int n = pop(); int dst = pop(); int src = pop();
    if (n <= 0) return;
    for (int i = 0; i < n; i++) cell_store(dst + i*2, cell_fetch(src + i*2));
}
void w_fill() {
    int b = pop(); int n = pop(); int addr = pop();
    if (n <= 0) return;
    for (int i = 0; i < n; i++) byte_store(addr + i, b);
}
void w_count() {
    int addr = pop();
    int n = byte_fetch(addr);
    push(addr + 1); push(n);
}
void w_type() {
    int n = pop(); int addr = pop();
    if (n <= 0) return;
    for (int i = 0; i < n; i++) print_char((char)byte_fetch(addr + i));
}
void w_dash_trailing() {
    int n = pop(); int addr = pop();
    if (n < 0) { push(addr); push(0); return; }
    while (n > 0 && byte_fetch(addr + n - 1) == ' ') n--;
    push(addr); push(n);
}

char tmp_buf[256];

void w_word() {
    int delim = pop() & 0xFF;
    int in = cell_fetch(IN_ADDR);
    int base = TIB_ADDR;
    while (1) {
        int c = byte_fetch(base + in);
        if (c == 0) break;
        if (c != delim) break;
        in++;
    }
    int start = in;
    while (1) {
        int c = byte_fetch(base + in);
        if (c == 0 || c == delim) break;
        in++;
    }
    int len = in - start;
    if (len > 31) len = 31;
    byte_store(WORD_BUF, len);
    for (int i = 0; i < len; i++) byte_store(WORD_BUF + 1 + i, byte_fetch(base + start + i));
    int actual = byte_fetch(base + in);
    byte_store(WORD_BUF + 1 + len, actual);
    if (actual != 0) in++;
    cell_store(IN_ADDR, in);
    push(WORD_BUF);
}

void w_find() {
    push(' ');
    w_word();
    int word_addr = pop();
    int len = byte_fetch(word_addr);
    if (len == 0) { push(0); return; }
    char name[32];
    int copy_len = (len < 31) ? len : 31;
    for (int i = 0; i < copy_len; i++) name[i] = (char)byte_fetch(word_addr + 1 + i);
    name[copy_len] = 0;
    int id = find_id(name);
    if (id < 0) push(0);
    else push(id);
}

void w_expect() {
    int n = pop(); int addr = pop();
    if (n <= 0) return;
    int max = (n < 255) ? n : 255;
    read_string(tmp_buf, max + 1);
    int len = 0;
    for (int i = 0; i < max; i++) {
        char c = tmp_buf[i];
        if (c == 0) break;
        if (c == '\n') break;
        byte_store(addr + len, (unsigned char)c);
        len++;
    }
    byte_store(addr + len, 0);
    if (len + 1 < n) byte_store(addr + len + 1, 0);
}

void w_query() {
    read_string(tmp_buf, 81);
    int len = 0;
    for (int i = 0; i < 80; i++) {
        char c = tmp_buf[i];
        if (c == 0 || c == '\n') break;
        byte_store(TIB_ADDR + len, (unsigned char)c);
        len++;
    }
    byte_store(TIB_ADDR + len, 0);
    cell_store(IN_ADDR, 0);
    cell_store(BLK_ADDR, 0);
}

void w_abort() {
    vm.dsp = 0; vm.rsp = 0;
    cell_store(STATE_ADDR, 0);
    abort_flag = 1;
    exit_flag = 0;
}

void w_quit_word() {
    vm.rsp = 0;
    cell_store(STATE_ADDR, 0);
    abort_flag = 1;
    exit_flag = 0;
}

void w_bl() { push(32); }
void w_79_standard() { /* Sentinel asserting FORTH-79 Standard. No action. */ }

int read_next_name(char* out) {
    push(' ');
    w_word();
    int word_addr = pop();
    int len = byte_fetch(word_addr);
    if (len == 0) { out[0] = 0; return 0; }
    int cl = (len < 31) ? len : 31;
    for (int i = 0; i < cl; i++) out[i] = (char)byte_fetch(word_addr + 1 + i);
    out[cl] = 0;
    return cl;
}

void w_create() {
    char name[32];
    if (read_next_name(name) == 0) { print_string("CREATE: no name\n"); return; }
    create_word(name, NULL, vm.here, 0);
    dict[dict_len - 1].kind = KIND_VARIABLE;
}

void w_vocabulary() {
    char name[32];
    if (read_next_name(name) == 0) { print_string("VOCABULARY: no name\n"); return; }
    create_word(name, NULL, vocab_count, 0);
    dict[dict_len - 1].kind = KIND_VOCAB;
    vocab_count++;
}

void w_does() {
    if (dict_len == 0) return;
    int target = dict_len - 1;
    dict[target].kind = KIND_DOES;
    dict[target].does_addr = vm.ip;
    exit_flag = 1;
}

void w_compile() {
    int t = cell_fetch(vm.ip);
    vm.ip += 2;
    comma(t);
}

void w_bracket_compile() {
    char name[32];
    if (read_next_name(name) == 0) { print_string("[COMPILE]: no name\n"); return; }
    int id = find_id(name);
    if (id < 0) { print_string("? "); print_string(name); print_string("\n"); return; }
    comma(id);
}

/* === Double numbers === */
static unsigned int pack_d(int lo, int hi) {
    return ((unsigned int)(hi & 0xFFFF) << 16) | (unsigned int)(lo & 0xFFFF);
}
static void push_d(unsigned int d) {
    push((int)(d & 0xFFFF));
    push((int)((d >> 16) & 0xFFFF));
}

void w_d_plus() {
    int hi2 = pop(); int lo2 = pop();
    int hi1 = pop(); int lo1 = pop();
    unsigned int d1 = pack_d(lo1, hi1);
    unsigned int d2 = pack_d(lo2, hi2);
    push_d(d1 + d2);
}
void w_d_lt() {
    int hi2 = pop(); int lo2 = pop();
    int hi1 = pop(); int lo1 = pop();
    int d1 = (int)pack_d(lo1, hi1);
    int d2 = (int)pack_d(lo2, hi2);
    push(d1 < d2 ? 1 : 0);
}
void w_d_negate() {
    int hi = pop(); int lo = pop();
    unsigned int d = pack_d(lo, hi);
    push_d((unsigned int)(-(int)d));
}

/* === Pictured numeric output === */
int hold_ptr;

void w_less_sharp()    { hold_ptr = HOLD_END; }
void w_hold() {
    int c = pop() & 0xFF;
    if (hold_ptr > HOLD_BUF) { hold_ptr--; byte_store(hold_ptr, c); }
}
static void sharp_one() {
    int hi = pop(); int lo = pop();
    unsigned int u = pack_d(lo, hi);
    int base = current_base();
    unsigned int digit = u % base;
    unsigned int quot  = u / base;
    int c = (digit < 10) ? ('0' + (int)digit) : ('A' + (int)digit - 10);
    if (hold_ptr > HOLD_BUF) { hold_ptr--; byte_store(hold_ptr, c); }
    push_d(quot);
}
void w_sharp()   { sharp_one(); }
void w_sharp_s() {
    do {
        sharp_one();
        int hi = vm.dstack[vm.dsp-1];
        int lo = vm.dstack[vm.dsp-2];
        if (pack_d(lo, hi) == 0) break;
    } while (1);
}
void w_sharp_greater() {
    pop(); pop();
    int len = HOLD_END - hold_ptr;
    push(hold_ptr);
    push(len);
}
void w_sign() {
    int n = pop();
    if (n < 0) {
        if (hold_ptr > HOLD_BUF) { hold_ptr--; byte_store(hold_ptr, '-'); }
    }
}

/* === Mass storage (block buffers in vm.memory) === */
int block_dirty[NUM_BLOCKS];
int last_block = -1;
unsigned char tib_save[TIB_SIZE];
char load_buf[BLOCK_SIZE + 1];

int block_addr(int n) {
    if (n < 0 || n >= NUM_BLOCKS) return -1;
    return BLOCKS_BASE + n * BLOCK_SIZE;
}

void w_block() {
    int n = pop();
    int addr = block_addr(n);
    if (addr < 0) { print_string("BLOCK err\n"); push(0); return; }
    last_block = n;
    push(addr);
}
void w_buffer() {
    int n = pop();
    int addr = block_addr(n);
    if (addr < 0) { print_string("BUFFER err\n"); push(0); return; }
    last_block = n;
    push(addr);
}
void w_update() { if (last_block >= 0) block_dirty[last_block] = 1; }
void w_empty_buffers() {
    for (int i = 0; i < NUM_BLOCKS; i++) block_dirty[i] = 0;
    last_block = -1;
}
const char BLK_FILE[] = "forth.blk";

void w_save_buffers() {
    int fd = open_file(BLK_FILE, 1);
    if (fd < 0) { print_string("SAVE-BUFFERS err\n"); return; }
    for (int n = 0; n < NUM_BLOCKS; n++) {
        write_file(fd, (const void*)&vm.memory[BLOCKS_BASE + n * BLOCK_SIZE], BLOCK_SIZE);
    }
    close_file(fd);
    for (int i = 0; i < NUM_BLOCKS; i++) block_dirty[i] = 0;
}
void load_blocks_file() {
    /* RARS 1.6 bug workaround: openFile with O_RDONLY on missing file leaks
       the filename in its file-table. Touch the file via append-write first
       so it exists (FileOutputStream creates empty); then read normally. */
    int fd = open_file(BLK_FILE, 9);
    if (fd >= 0) close_file(fd);

    fd = open_file(BLK_FILE, 0);
    if (fd < 0) return;
    for (int n = 0; n < NUM_BLOCKS; n++) {
        int got = read_file(fd, (void*)&vm.memory[BLOCKS_BASE + n * BLOCK_SIZE], BLOCK_SIZE);
        if (got <= 0) break;
    }
    close_file(fd);
}
void w_list() {
    int n = pop();
    int addr = block_addr(n);
    if (addr < 0) { print_string("LIST err\n"); return; }
    last_block = n;
    cell_store(SCR_ADDR, n);
    for (int line = 0; line < 16; line++) {
        for (int col = 0; col < 64; col++) {
            int c = byte_fetch(addr + line * 64 + col);
            if (c == 0) c = ' ';
            print_char((char)c);
        }
        print_char('\n');
    }
}
void w_load() {
    int n = pop();
    int addr = block_addr(n);
    if (addr < 0) { print_string("LOAD err\n"); return; }
    int saved_blk = cell_fetch(BLK_ADDR);
    int saved_in = cell_fetch(IN_ADDR);
    for (int i = 0; i < TIB_SIZE; i++) tib_save[i] = byte_fetch(TIB_ADDR + i);

    for (int i = 0; i < BLOCK_SIZE; i++) load_buf[i] = (char)byte_fetch(addr + i);
    load_buf[BLOCK_SIZE] = 0;

    cell_store(BLK_ADDR, n);
    eval(load_buf);

    cell_store(BLK_ADDR, saved_blk);
    for (int i = 0; i < TIB_SIZE; i++) byte_store(TIB_ADDR + i, tib_save[i]);
    cell_store(IN_ADDR, saved_in);
}

/* === CONVERT === */
void w_convert() {
    int addr = pop();
    int hi = pop(); int lo = pop();
    unsigned int d = pack_d(lo, hi);
    int base = current_base();
    int p = addr + 1;
    while (1) {
        int c = byte_fetch(p);
        int v = digit_value(c, base);
        if (v < 0) break;
        d = d * (unsigned int)base + (unsigned int)v;
        p++;
    }
    push_d(d);
    push(p);
}

void w_forget() {
    char name[32];
    if (read_next_name(name) == 0) { print_string("FORGET: no name\n"); return; }
    int id = find_id(name);
    if (id < 0) { print_string("FORGET: not found\n"); return; }
    if (dict[id].param >= HERE_START
        && dict[id].kind != KIND_PRIMITIVE
        && dict[id].kind != KIND_CONSTANT) {
        vm.here = dict[id].param;
    }
    dict_len = id;
}

void w_dup() { if (vm.dsp > 0) push(vm.dstack[vm.dsp-1]); }
void w_drop(){ pop(); }
void w_swap(){ int b = pop(); int a = pop(); push(b); push(a); }
void w_over(){ if (vm.dsp > 1) push(vm.dstack[vm.dsp-2]); }
void w_rot() { int c=pop(); int b=pop(); int a=pop(); push(b); push(c); push(a); }

void w_dot() { int n = pop(); print_in_base(n, current_base()); print_char(' '); }
void w_u_dot() { unsigned int u = (unsigned int)(pop() & 0xFFFF); print_in_base_unsigned(u, current_base()); print_char(' '); }
void w_cr()  { print_string("\n"); }
void w_emit() { char c = (char)pop(); print_char(c); }
void w_key() { push((int)read_char()); }
void w_space()  { print_char(' '); }
void w_spaces() { int n = pop(); for (int i = 0; i < n; i++) print_char(' '); }
void w_hex()  { cell_store(BASE_ADDR, 16); }
void w_question() { int addr = pop(); push(cell_fetch(addr)); w_dot(); }

void w_eq() { push(pop() == pop() ? 1 : 0); }
void w_gt() { int b = pop(); int a = pop(); push(a > b ? 1 : 0); }
void w_lt() { int b = pop(); int a = pop(); push(a < b ? 1 : 0); }

void w_store()   { int addr = pop(); int val = pop(); cell_store(addr, val); }
void w_fetch()   { int addr = pop(); push(cell_fetch(addr)); }
void w_c_store() { int addr = pop(); int val = pop(); byte_store(addr, val); }
void w_c_fetch() { int addr = pop(); push(byte_fetch(addr)); }

void w_here()  { push(vm.here); }
void w_allot() { vm.here += pop(); }

void w_comma_op()   { comma(pop()); }
void w_c_comma_op() { c_comma(pop()); }

void w_state()   { push(STATE_ADDR); }
void w_base()    { push(BASE_ADDR); }
void w_in()      { push(IN_ADDR); }
void w_blk()     { push(BLK_ADDR); }
void w_scr()     { push(SCR_ADDR); }
void w_pad()     { push(PAD_ADDR); }
void w_context() { push(CONTEXT_ADDR); }
void w_current() { push(CURRENT_ADDR); }
void w_decimal() { cell_store(BASE_ADDR, 10); }
void w_depth()   { push(vm.dsp); }
void w_definitions() { cell_store(CURRENT_ADDR, cell_fetch(CONTEXT_ADDR)); }

void w_literal() {
    int val = pop();
    comma(find_id("LIT"));
    comma(val);
}

void w_exit() {
    if (in_user_word > 0) exit_flag = 1;
    /* Top-level EXIT: error condition (interpretation of compile-only word).
       Per FORTH-79 sec.4, valid system actions include "ignore, and continue".
       We choose to ignore silently. */
}
void w_bye() { exit_program(); }
void w_lit() { int val = cell_fetch(vm.ip); vm.ip += 2; push(val); }
void w_branch0() { int off = ucell_fetch(vm.ip); vm.ip += 2; if(pop() == 0) vm.ip = off; }
void w_branch() { int off = ucell_fetch(vm.ip); vm.ip = off; }

void w_execute() {
    int v = pop();
    if (v >= 0 && v < dict_len && dict[v].kind == KIND_PRIMITIVE) {
        dict[v].code();
        return;
    }
    for (int i = dict_len - 1; i >= 0; i--) {
        if (dict[i].kind != KIND_PRIMITIVE && dict[i].param == v) {
            execute_dict(i);
            return;
        }
    }
    if (v >= 0 && v < dict_len) { execute_dict(v); return; }
    print_string("Exec Err\n");
}

void w_do_run() { int start = pop(); int limit = pop(); rpush(limit); rpush(start); }
void w_loop_run() {
    int idx = rpop(); int limit = rpop(); idx++;
    if (idx < limit) { rpush(limit); rpush(idx); vm.ip = ucell_fetch(vm.ip); }
    else { vm.ip += 2; }
}
void w_plus_loop_run() {
    int n = pop();
    int idx = rpop(); int limit = rpop();
    int new_idx = idx + n;
    int cont;
    if (n >= 0) cont = (new_idx < limit);
    else        cont = (new_idx >= limit);
    if (cont) { rpush(limit); rpush(new_idx); vm.ip = ucell_fetch(vm.ip); }
    else      { vm.ip += 2; }
}
void w_i() { if (vm.rsp > 0) push(vm.rstack[vm.rsp-1]); }
void w_j() { if (vm.rsp >= 3) push(vm.rstack[vm.rsp-3]); }
void w_leave() {
    if (vm.rsp >= 2) {
        int idx = vm.rstack[vm.rsp-1];
        vm.rstack[vm.rsp-2] = idx;
    }
}

void w_print_str() {
    int len = cell_fetch(vm.ip); vm.ip += 2;
    for(int i=0; i<len; i++) { print_char((char)byte_fetch(vm.ip)); vm.ip += 1; }
    if (vm.ip & 1) vm.ip += 1;
}

int creating_word = 0;
int tick_pending = 0;

void w_colon() { creating_word = 1; }
void w_semicolon() { comma(find_id("EXIT")); cell_store(STATE_ADDR, 0); }
void w_lbracket() { cell_store(STATE_ADDR, 0); }
void w_rbracket() { cell_store(STATE_ADDR, 1); }
void w_immediate() { if (dict_len > 0) dict[dict_len-1].is_immediate = 1; }
void w_tick() { tick_pending = 1; }

void w_if()    { comma(find_id("0BRANCH")); push(vm.here); comma(0); }
void w_then()  { int addr = pop(); cell_store(addr, vm.here); }
void w_else()  { comma(find_id("BRANCH")); int ad2 = vm.here; comma(0); int ad1 = pop(); cell_store(ad1, vm.here); push(ad2); }
void w_begin() { push(vm.here); }
void w_until() { comma(find_id("0BRANCH")); comma(pop()); }
void w_do()    { comma(find_id("(DO)")); push(vm.here); }
void w_loop()  { comma(find_id("(LOOP)")); int addr = pop(); comma(addr); }
void w_plus_loop() { comma(find_id("(+LOOP)")); int addr = pop(); comma(addr); }
void w_while() { comma(find_id("0BRANCH")); push(vm.here); comma(0); }
void w_repeat() {
    int while_addr = pop();
    int begin_addr = pop();
    comma(find_id("BRANCH"));
    comma(begin_addr);
    cell_store(while_addr, vm.here);
}
void w_recurse(){ comma(dict_len - 1); }

int mode_var = 0;
char token_buf[64];

void eval(char* input) {
    int i = 0;
    while (i < TIB_SIZE - 1 && input[i]) {
        if (input[i] == '\n' || input[i] == '\r') break;
        byte_store(TIB_ADDR + i, (unsigned char)input[i]);
        i++;
    }
    byte_store(TIB_ADDR + i, 0);
    cell_store(IN_ADDR, 0);
    abort_flag = 0;

    while (1) {
        if (abort_flag) { abort_flag = 0; return; }
        int in = cell_fetch(IN_ADDR);
        while (1) {
            int c = byte_fetch(TIB_ADDR + in);
            if (c == 0) { cell_store(IN_ADDR, in); return; }
            if (c > 32) break;
            in++;
        }
        int c0 = byte_fetch(TIB_ADDR + in);

        if (c0 == '(') {
            in++;
            while (1) {
                int c = byte_fetch(TIB_ADDR + in);
                if (c == 0) break;
                in++;
                if (c == ')') break;
            }
            cell_store(IN_ADDR, in);
            continue;
        }

        if (c0 == '.' && byte_fetch(TIB_ADDR + in + 1) == '"') {
            in += 2;
            if (byte_fetch(TIB_ADDR + in) == ' ') in++;
            int str_start = in;
            int slen = 0;
            while (1) {
                int c = byte_fetch(TIB_ADDR + in);
                if (c == 0 || c == '"') break;
                in++; slen++;
            }
            int compiling = (cell_fetch(STATE_ADDR) == 1);
            if (compiling) {
                comma(find_id("(.\")")); comma(slen);
                for (int j = 0; j < slen; j++) c_comma(byte_fetch(TIB_ADDR + str_start + j));
                if (vm.here & 1) c_comma(0);
            } else {
                for (int j = 0; j < slen; j++) print_char((char)byte_fetch(TIB_ADDR + str_start + j));
            }
            if (byte_fetch(TIB_ADDR + in) == '"') in++;
            cell_store(IN_ADDR, in);
            continue;
        }

        int tlen = 0;
        int real_len = 0;
        while (1) {
            int c = byte_fetch(TIB_ADDR + in);
            if (c == 0 || c <= 32) break;
            if (tlen < 31) token_buf[tlen++] = (char)c;
            if (real_len < 255) real_len++;
            in++;
        }
        token_buf[tlen] = 0;
        if (byte_fetch(TIB_ADDR + in) != 0) in++;
        cell_store(IN_ADDR, in);

        int compiling = (cell_fetch(STATE_ADDR) == 1);

        if (tick_pending) {
            int id = find_id_lv(token_buf, real_len);
            if (id != -1) {
                int value = (dict[id].kind == KIND_PRIMITIVE) ? id : dict[id].param;
                if (compiling) { comma(find_id("LIT")); comma(value); }
                else { push(value); }
            } else { print_string("Tick err\n"); }
            tick_pending = 0;
        }
        else if (mode_var > 0) {
            if (mode_var == 1) {
                create_word_lv(token_buf, real_len, NULL, vm.here, 0);
                dict[dict_len - 1].kind = KIND_VARIABLE;
                cell_store(vm.here, 0);
                vm.here += 2;
            }
            if (mode_var == 2) {
                int val = pop();
                create_word_lv(token_buf, real_len, NULL, vm.here, 0);
                dict[dict_len - 1].kind = KIND_CONSTANT;
                cell_store(vm.here, val);
                vm.here += 2;
            }
            mode_var = 0;
        }
        else if (creating_word) {
            create_word_lv(token_buf, real_len, NULL, vm.here, 0);
            creating_word = 0;
            cell_store(STATE_ADDR, 1);
        }
        else {
            int id = find_id_lv(token_buf, real_len);

            if (my_strcmp(token_buf, "VARIABLE") == 0) { mode_var = 1; }
            else if (my_strcmp(token_buf, "CONSTANT") == 0) { mode_var = 2; }
            else if (id != -1) {
                if (compiling && dict[id].is_immediate == 0) {
                    comma(id);
                } else {
                    execute_dict(id);
                }
            }
            else if (is_number(token_buf)) {
                int num = my_atoi(token_buf);
                if (compiling) { comma(find_id("LIT")); comma(num); }
                else { push(num); }
            }
            else { print_string("? "); print_string(token_buf); print_string("\n"); }
        }
    }
}

char input_buffer[512];

void main() {
    forth_init();
    load_blocks_file();

    create_word("+", w_add, -1, 0); create_word("-", w_sub, -1, 0);
    create_word("*", w_mul, -1, 0); create_word("/", w_div, -1, 0);
    create_word("MOD", w_mod, -1, 0); create_word("/MOD", w_div_mod, -1, 0);
    create_word("*/", w_mul_div, -1, 0); create_word("*/MOD", w_mul_div_mod, -1, 0);
    create_word("1+", w_one_plus, -1, 0); create_word("1-", w_one_minus, -1, 0);
    create_word("2+", w_two_plus, -1, 0); create_word("2-", w_two_minus, -1, 0);
    create_word("ABS", w_abs, -1, 0); create_word("NEGATE", w_negate, -1, 0);
    create_word("MIN", w_min, -1, 0); create_word("MAX", w_max, -1, 0);

    create_word("0=", w_zero_eq, -1, 0); create_word("NOT", w_zero_eq, -1, 0);
    create_word("0<", w_zero_lt, -1, 0); create_word("0>", w_zero_gt, -1, 0);

    create_word("AND", w_and, -1, 0); create_word("OR", w_or, -1, 0); create_word("XOR", w_xor, -1, 0);

    create_word("U<", w_u_lt, -1, 0);
    create_word("U*", w_u_mul, -1, 0);
    create_word("U/MOD", w_u_div_mod, -1, 0);

    create_word(">R", w_to_r, -1, 0); create_word("R>", w_r_from, -1, 0); create_word("R@", w_r_fetch, -1, 0);

    create_word("?DUP", w_q_dup, -1, 0);
    create_word("PICK", w_pick, -1, 0); create_word("ROLL", w_roll, -1, 0);
    create_word("+!", w_plus_store, -1, 0);

    create_word("CMOVE", w_cmove, -1, 0);
    create_word("MOVE", w_move, -1, 0);
    create_word("FILL", w_fill, -1, 0);
    create_word("COUNT", w_count, -1, 0);
    create_word("TYPE", w_type, -1, 0);
    create_word("-TRAILING", w_dash_trailing, -1, 0);

    create_word("WORD", w_word, -1, 0);
    create_word("FIND", w_find, -1, 0);
    create_word("EXPECT", w_expect, -1, 0);
    create_word("QUERY", w_query, -1, 0);
    create_word("ABORT", w_abort, -1, 0);
    create_word("QUIT", w_quit_word, -1, 0);
    create_word("BL", w_bl, -1, 0);

    create_word("CREATE", w_create, -1, 0);
    create_word("DOES>", w_does, -1, 0);
    create_word("COMPILE", w_compile, -1, 0);
    create_word("[COMPILE]", w_bracket_compile, -1, 1);
    create_word("FORGET", w_forget, -1, 0);

    create_word("D+", w_d_plus, -1, 0);
    create_word("D<", w_d_lt, -1, 0);
    create_word("DNEGATE", w_d_negate, -1, 0);
    create_word("<#", w_less_sharp, -1, 0);
    create_word("#", w_sharp, -1, 0);
    create_word("#S", w_sharp_s, -1, 0);
    create_word("#>", w_sharp_greater, -1, 0);
    create_word("HOLD", w_hold, -1, 0);
    create_word("SIGN", w_sign, -1, 0);
    create_word("CONVERT", w_convert, -1, 0);

    create_word("CONTEXT", w_context, -1, 0);
    create_word("CURRENT", w_current, -1, 0);
    create_word("VOCABULARY", w_vocabulary, -1, 0);
    create_word("DEFINITIONS", w_definitions, -1, 0);
    create_word("FORTH", NULL, 0, 0);
    dict[dict_len - 1].kind = KIND_VOCAB;

    create_word("BLOCK", w_block, -1, 0);
    create_word("BUFFER", w_buffer, -1, 0);
    create_word("UPDATE", w_update, -1, 0);
    create_word("EMPTY-BUFFERS", w_empty_buffers, -1, 0);
    create_word("SAVE-BUFFERS", w_save_buffers, -1, 0);
    create_word("LIST", w_list, -1, 0);
    create_word("LOAD", w_load, -1, 0);

    create_word("79-STANDARD", w_79_standard, -1, 0);

    create_word("DUP", w_dup, -1, 0); create_word("DROP", w_drop, -1, 0);
    create_word("SWAP", w_swap, -1, 0); create_word("OVER", w_over, -1, 0);
    create_word("ROT", w_rot, -1, 0);

    create_word(".", w_dot, -1, 0); create_word("U.", w_u_dot, -1, 0);
    create_word("CR", w_cr, -1, 0);
    create_word("EMIT", w_emit, -1, 0); create_word("KEY", w_key, -1, 0);
    create_word("SPACE", w_space, -1, 0); create_word("SPACES", w_spaces, -1, 0);
    create_word("HEX", w_hex, -1, 0);
    create_word("?", w_question, -1, 0);

    create_word("=", w_eq, -1, 0); create_word(">", w_gt, -1, 0); create_word("<", w_lt, -1, 0);

    create_word("!", w_store, -1, 0); create_word("@", w_fetch, -1, 0);
    create_word("C!", w_c_store, -1, 0); create_word("C@", w_c_fetch, -1, 0);
    create_word("HERE", w_here, -1, 0); create_word("ALLOT", w_allot, -1, 0);

    create_word(",", w_comma_op, -1, 0);
    create_word("C,", w_c_comma_op, -1, 0);
    create_word("LITERAL", w_literal, -1, 1);
    create_word("STATE", w_state, -1, 0);
    create_word("BASE", w_base, -1, 0);
    create_word(">IN", w_in, -1, 0);
    create_word("BLK", w_blk, -1, 0);
    create_word("SCR", w_scr, -1, 0);
    create_word("PAD", w_pad, -1, 0);
    create_word("DECIMAL", w_decimal, -1, 0);
    create_word("DEPTH", w_depth, -1, 0);

    create_word("EXIT", w_exit, -1, 0); create_word("BYE", w_bye, -1, 0);
    create_word("LIT", w_lit, -1, 0);
    create_word("EXECUTE", w_execute, -1, 0);

    create_word("0BRANCH", w_branch0, -1, 0); create_word("BRANCH", w_branch, -1, 0);
    create_word("(DO)", w_do_run, -1, 0); create_word("(LOOP)", w_loop_run, -1, 0);
    create_word("(+LOOP)", w_plus_loop_run, -1, 0);
    create_word("(.\")", w_print_str, -1, 0);

    create_word(":", w_colon, -1, 0); create_word(";", w_semicolon, -1, 1);

    create_word("IF", w_if, -1, 1); create_word("THEN", w_then, -1, 1); create_word("ELSE", w_else, -1, 1);
    create_word("BEGIN", w_begin, -1, 1); create_word("UNTIL", w_until, -1, 1);
    create_word("WHILE", w_while, -1, 1); create_word("REPEAT", w_repeat, -1, 1);
    create_word("DO", w_do, -1, 1); create_word("LOOP", w_loop, -1, 1);
    create_word("+LOOP", w_plus_loop, -1, 1);
    create_word("I", w_i, -1, 0); create_word("J", w_j, -1, 0);
    create_word("LEAVE", w_leave, -1, 0);
    create_word("RECURSE", w_recurse, -1, 1);

    create_word("'", w_tick, -1, 1);
    create_word("IMMEDIATE", w_immediate, -1, 1);
    create_word("[", w_lbracket, -1, 1);
    create_word("]", w_rbracket, -1, 1);

    print_string("ok> ");

    while(1) {
        read_string(input_buffer, 511);
        eval(input_buffer);
        print_string("ok> ");
    }
}
