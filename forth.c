#include "rars_lib.h"
#include <stddef.h> 

#define STACK_SIZE 64
#define MEMORY_SIZE 8192 
#define DICT_SIZE 256
#define NULL 0 

struct ForthVM {
    int dsp; int dstack[STACK_SIZE];
    int rsp; int rstack[STACK_SIZE];
    int memory[MEMORY_SIZE]; 
    int state; 
    int here;  
    int ip;    
};
volatile struct ForthVM vm; 

typedef void (*code_ptr)();
struct Header {
    char name[16]; code_ptr code; int param; int is_immediate;
};
struct Header dict[DICT_SIZE];
int dict_len = 0;

int my_strcmp(const char* s1, const char* s2) {
    while (*s1 && (*s1 == *s2)) { s1++; s2++; }
    return *(const unsigned char*)s1 - *(const unsigned char*)s2;
}
void my_strcpy(char* dest, const char* src) {
    while (*src) { *dest = *src; dest++; src++; }
    *dest = 0;
}
int is_number(const char* s) {
    if (*s == '-') s++; if (!*s) return 0;
    while (*s) { if (*s < '0' || *s > '9') return 0; s++; } return 1;
}
int my_atoi(const char* s) {
    int res = 0; int sign = 1; if (*s == '-') { sign = -1; s++; }
    while (*s >= '0' && *s <= '9') { res = res * 10 + (*s - '0'); s++; } return res * sign;
}

void create_word(const char* name, code_ptr code, int param, int imm) {
    if (dict_len >= DICT_SIZE) { print_string("Dict Full!\n"); return; }
    my_strcpy(dict[dict_len].name, name);
    dict[dict_len].code = code; dict[dict_len].param = param; dict[dict_len].is_immediate = imm;
    dict_len++;
}
int find_id(const char* name) {
    for(int i = dict_len - 1; i >= 0; i--) {
        if (my_strcmp(dict[i].name, name) == 0) return i;
    }
    return -1;
}

void forth_init() {
    vm.dsp = 0; vm.rsp = 0;
    for(int i=0; i<MEMORY_SIZE; i++) vm.memory[i] = 0;
    vm.state = 0; vm.here = 100; 
}
void push(int val) { if (vm.dsp < STACK_SIZE) vm.dstack[vm.dsp++] = val; else { print_string("S-Ovf!\n"); exit_program(); } }
int pop() { if (vm.dsp > 0) return vm.dstack[--vm.dsp]; print_string("S-Udf!\n"); return 0; }
void rpush(int val) { if (vm.rsp < STACK_SIZE) vm.rstack[vm.rsp++] = val; else { print_string("R-Ovf!\n"); exit_program(); } }
int rpop() { if (vm.rsp > 0) return vm.rstack[--vm.rsp]; print_string("R-Udf!\n"); return 0; }

void execute_user_word(int start_addr) {
    int old_ip = vm.ip; vm.ip = start_addr;
    while(1) {
        int token = vm.memory[vm.ip++]; 
        if (token == -1) break; 
        if (token >= 0 && token < dict_len) {
            if (dict[token].code != NULL) dict[token].code(); 
            else execute_user_word(dict[token].param);
        }
    }
    vm.ip = old_ip; 
}

void comma(int val) { if (vm.here < MEMORY_SIZE) vm.memory[vm.here++] = val; else { print_string("Mem Full!\n"); exit_program(); } }

void w_add() { int b = pop(); int a = pop(); push(a + b); }
void w_sub() { int b = pop(); int a = pop(); push(a - b); }
void w_mul() { int b = pop(); int a = pop(); push(a * b); }
void w_div() { int b = pop(); int a = pop(); push(b ? a/b : 0); }
void w_mod() { int b = pop(); int a = pop(); push(b ? a%b : 0); }
void w_div_mod() { int b = pop(); int a = pop(); if(!b){push(0);push(0);return;} push(a%b); push(a/b); }

void w_dup() { if (vm.dsp > 0) push(vm.dstack[vm.dsp-1]); }
void w_drop(){ pop(); }
void w_swap(){ int b = pop(); int a = pop(); push(b); push(a); }
void w_over(){ if (vm.dsp > 1) push(vm.dstack[vm.dsp-2]); }
void w_rot() { int c=pop(); int b=pop(); int a=pop(); push(b); push(c); push(a); } 

void w_dot() { print_int(pop()); print_string(" "); }
void w_cr()  { print_string("\n"); }
void w_emit() { char c = (char)pop(); print_char(c); }
void w_key() { push((int)read_char()); }

void w_eq() { push(pop() == pop() ? -1 : 0); }
void w_gt() { int b = pop(); int a = pop(); push(a > b ? -1 : 0); }
void w_lt() { int b = pop(); int a = pop(); push(a < b ? -1 : 0); }

void w_store() { int addr = pop(); int val = pop(); if(addr>=0 && addr<MEMORY_SIZE) vm.memory[addr]=val; }
void w_fetch() { int addr = pop(); if(addr>=0 && addr<MEMORY_SIZE) push(vm.memory[addr]); else push(0); }

void w_c_store() { int addr = pop(); int val = pop(); if(addr>=0 && addr<MEMORY_SIZE) vm.memory[addr] = val & 0xFF; }
void w_c_fetch() { int addr = pop(); if(addr>=0 && addr<MEMORY_SIZE) push(vm.memory[addr] & 0xFF); else push(0); }

void w_here()  { push(vm.here); }
void w_allot() { vm.here += pop(); }

void w_comma_op() { comma(pop()); }


void w_literal() {
    int val = pop();
    comma(find_id("LIT"));
    comma(val);
}

void w_exit_prog() { exit_program(); }
void w_lit() { int val = vm.memory[vm.ip++]; push(val); }
void w_branch0() { int off = vm.memory[vm.ip++]; if(pop() == 0) vm.ip = off; }
void w_branch() { int off = vm.memory[vm.ip]; vm.ip = off; }

void w_execute() {
    int token = pop();
    if (token >= 0 && token < dict_len) {
        if (dict[token].code != NULL) dict[token].code();
        else execute_user_word(dict[token].param);
    } else {
        print_string("Exec Err\n");
    }
}

void w_do_run() { int start = pop(); int limit = pop(); rpush(limit); rpush(start); }
void w_loop_run() { int idx = rpop(); int limit = rpop(); idx++; if (idx < limit) { rpush(limit); rpush(idx); vm.ip = vm.memory[vm.ip]; } else { vm.ip++; } }
void w_i() { if (vm.rsp > 0) push(vm.rstack[vm.rsp-1]); }

void w_print_str() { int len = vm.memory[vm.ip++]; for(int i=0; i<len; i++) print_char((char)vm.memory[vm.ip++]); }


int creating_word = 0;
int tick_pending = 0; 

void w_colon() { creating_word = 1; }
void w_semicolon() { comma(-1); vm.state = 0; }
void w_lbracket() { vm.state = 0; }
void w_rbracket() { vm.state = 1; }
void w_immediate() { if (dict_len > 0) dict[dict_len-1].is_immediate = 1; }
void w_tick() { tick_pending = 1; }

void w_if() { comma(find_id("0BRANCH")); push(vm.here); comma(0); }
void w_then() { int addr = pop(); vm.memory[addr] = vm.here; }
void w_else() { comma(find_id("BRANCH")); int ad2 = vm.here; comma(0); int ad1 = pop(); vm.memory[ad1] = vm.here; push(ad2); }
void w_begin() { push(vm.here); }
void w_until() { comma(find_id("0BRANCH")); comma(pop()); }
void w_do() { comma(find_id("(DO)")); push(vm.here); }
void w_loop() { comma(find_id("(LOOP)")); int addr = pop(); comma(addr); }
void w_recurse() { comma(dict_len - 1); }

void w_docon() { } 


int mode_var = 0;

void eval(char* input) {
    char* cursor = input;
    
    while (*cursor) {
        while (*cursor > 0 && *cursor <= 32) cursor++;
        if (*cursor == 0) break;

        if (*cursor == '(') {
             cursor++; while (*cursor && *cursor != ')') cursor++;
             if (*cursor == ')') cursor++; continue;
        }

        if (*cursor == '.' && *(cursor+1) == '"') {
            cursor += 2; if (*cursor == ' ') cursor++;
            char* str_start = cursor; int len = 0;
            while (*cursor && *cursor != '"') { len++; cursor++; }
            if (*cursor == '"') *cursor = 0; 
            if (vm.state == 1) {
                comma(find_id("(.\")")); comma(len); for(int i=0; i<len; i++) comma(str_start[i]);
            } else { print_string(str_start); }
            if (*cursor == 0) *cursor = '"'; cursor++; continue;
        }

        char* token_start = cursor;
        while (*cursor > 32) cursor++;
        int saved_char = *cursor; *cursor = 0; 

        if (tick_pending) {
            int id = find_id(token_start);
            if (id != -1) {
                if (vm.state == 1) { 
                    comma(find_id("LIT")); comma(id);
                } else { 
                    push(id);
                }
            } else { print_string("Tick err\n"); }
            tick_pending = 0; 
        }
        else if (mode_var > 0) {
            if (mode_var == 1) {
                create_word(token_start, NULL, vm.here, 0); 
                int data_addr = vm.here + 3; 
                vm.memory[vm.here++] = find_id("LIT"); vm.memory[vm.here++] = data_addr + 1; vm.memory[vm.here++] = -1; 
                vm.memory[vm.here++] = 0; 
            }
            if (mode_var == 2) {
                int val = pop(); create_word(token_start, NULL, vm.here, 0);
                vm.memory[vm.here++] = find_id("LIT"); vm.memory[vm.here++] = val; vm.memory[vm.here++] = -1;
            }
            mode_var = 0;
        }
        else if (creating_word) {
            create_word(token_start, NULL, vm.here, 0); creating_word = 0; vm.state = 1; 
        }
        else {
            int id = find_id(token_start);
            
            if (my_strcmp(token_start, "VARIABLE") == 0) { mode_var = 1; }
            else if (my_strcmp(token_start, "CONSTANT") == 0) { mode_var = 2; }
            else if (id != -1) {
                if (vm.state == 1 && dict[id].is_immediate == 0) {
                    comma(id); 
                } else {
                    if (dict[id].code != NULL) dict[id].code();
                    else execute_user_word(dict[id].param);
                }
            } 
            else if (is_number(token_start)) {
                int num = my_atoi(token_start);
                if (vm.state == 1) { comma(find_id("LIT")); comma(num); } else { push(num); }
            }
            else { print_string("? "); print_string(token_start); print_string("\n"); }
        }
        *cursor = saved_char; if (*cursor != 0) cursor++;
    }
}

char input_buffer[128]; 

void main() {
    forth_init();
    
    create_word("+", w_add, -1, 0); create_word("-", w_sub, -1, 0);
    create_word("*", w_mul, -1, 0); create_word("/", w_div, -1, 0);
    create_word("MOD", w_mod, -1, 0); create_word("/MOD", w_div_mod, -1, 0);
    
    create_word("DUP", w_dup, -1, 0); create_word("DROP", w_drop, -1, 0);
    create_word("SWAP", w_swap, -1, 0); create_word("OVER", w_over, -1, 0);
    create_word("ROT", w_rot, -1, 0);
    
    create_word(".", w_dot, -1, 0); create_word("CR", w_cr, -1, 0);
    create_word("EMIT", w_emit, -1, 0); create_word("KEY", w_key, -1, 0);
    
    create_word("=", w_eq, -1, 0); create_word(">", w_gt, -1, 0); create_word("<", w_lt, -1, 0);
    
    create_word("!", w_store, -1, 0); create_word("@", w_fetch, -1, 0);
    create_word("C!", w_c_store, -1, 0); create_word("C@", w_c_fetch, -1, 0); 
    create_word("HERE", w_here, -1, 0); create_word("ALLOT", w_allot, -1, 0);
    
    create_word(",", w_comma_op, -1, 0);
    create_word("LITERAL", w_literal, -1, 1);
    
    create_word("EXIT", w_exit_prog, -1, 0); create_word("LIT", w_lit, -1, 0);
    create_word("EXECUTE", w_execute, -1, 0); 

    create_word("0BRANCH", w_branch0, -1, 0); create_word("BRANCH", w_branch, -1, 0);
    create_word("(DO)", w_do_run, -1, 0); create_word("(LOOP)", w_loop_run, -1, 0);
    create_word("(.\")", w_print_str, -1, 0);

    create_word(":", w_colon, -1, 0); create_word(";", w_semicolon, -1, 1); 
    
    create_word("IF", w_if, -1, 1); create_word("THEN", w_then, -1, 1); create_word("ELSE", w_else, -1, 1);
    create_word("BEGIN", w_begin, -1, 1); create_word("UNTIL", w_until, -1, 1);
    create_word("DO", w_do, -1, 1); create_word("LOOP", w_loop, -1, 1); create_word("I", w_i, -1, 0);
    create_word("RECURSE", w_recurse, -1, 1);

    create_word("'", w_tick, -1, 1); 
    create_word("IMMEDIATE", w_immediate, -1, 1); 
    create_word("[", w_lbracket, -1, 1);
    create_word("]", w_rbracket, -1, 1);

    print_string("--- RARS FORTH 8.1 ---\n");
    print_string("ok> ");

    while(1) {
        read_string(input_buffer, 127);
        eval(input_buffer);
        print_string("ok> ");
    }
}