#ifndef RARS_LIB_H
#define RARS_LIB_H


static inline void __attribute__((always_inline)) print_int(int val) {
    int __tmp = val;
    asm volatile ("mv a0, %0\n\tli a7, 1\n\tecall" : : "r"(__tmp) : "a0", "a7");
}

static inline void __attribute__((always_inline)) print_string(const char* str) {
    const char* __tmp = str;
    asm volatile ("mv a0, %0\n\tli a7, 4\n\tecall" : : "r"(__tmp) : "a0", "a7");
}

static inline int __attribute__((always_inline)) read_int() {
    int res;
    asm volatile ("li a7, 5\n\tecall\n\tmv %0, a0" : "=r"(res) : : "a0", "a7");
    return res;
}

static inline void __attribute__((always_inline)) read_string(char* buf, int max_len) {
    char* __t_buf = buf; int __t_len = max_len;
    asm volatile ("mv a0, %0\n\tmv a1, %1\n\tli a7, 8\n\tecall" : : "r"(__t_buf), "r"(__t_len) : "a0", "a1", "a7");
}

static inline void __attribute__((always_inline)) exit_program() {
    asm volatile ("li a7, 10\n\tecall");
}

static inline void __attribute__((always_inline)) print_char(char c) {
    int __tmp = (int)c;
    asm volatile ("mv a0, %0\n\tli a7, 11\n\tecall" : : "r"(__tmp) : "a0", "a7");
}

static inline char __attribute__((always_inline)) read_char() {
    int res;
    asm volatile ("li a7, 12\n\tecall\n\tmv %0, a0" : "=r"(res) : : "a0", "a7");
    return (char)res;
}

#endif
