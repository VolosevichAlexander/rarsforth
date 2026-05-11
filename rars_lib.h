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

static inline int __attribute__((always_inline)) open_file(const char* path, int flags) {
    const char* __p = path; int __f = flags; int res;
    asm volatile (
        "mv a0, %1\n\tmv a1, %2\n\tli a7, 1024\n\tecall\n\tmv %0, a0"
        : "=r"(res) : "r"(__p), "r"(__f) : "a0", "a1", "a7"
    );
    return res;
}

static inline void __attribute__((always_inline)) close_file(int fd) {
    int __t = fd;
    asm volatile ("mv a0, %0\n\tli a7, 57\n\tecall" : : "r"(__t) : "a0", "a7");
}

static inline int __attribute__((always_inline)) read_file(int fd, void* buf, int len) {
    int __1 = fd; void* __2 = buf; int __3 = len; int res;
    asm volatile (
        "mv a0, %1\n\tmv a1, %2\n\tmv a2, %3\n\tli a7, 63\n\tecall\n\tmv %0, a0"
        : "=r"(res) : "r"(__1), "r"(__2), "r"(__3) : "a0", "a1", "a2", "a7"
    );
    return res;
}

static inline int __attribute__((always_inline)) write_file(int fd, const void* buf, int len) {
    int __1 = fd; const void* __2 = buf; int __3 = len; int res;
    asm volatile (
        "mv a0, %1\n\tmv a1, %2\n\tmv a2, %3\n\tli a7, 64\n\tecall\n\tmv %0, a0"
        : "=r"(res) : "r"(__1), "r"(__2), "r"(__3) : "a0", "a1", "a2", "a7"
    );
    return res;
}

#endif
