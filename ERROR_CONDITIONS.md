# RARS-FORTH Error Conditions

Соответствие требованию FORTH-79 § 6.1: «Each Standard System shall be provided
with a statement of the system action upon each of the error conditions as
identified in this Standard.»

Стандарт ([forth.txt:138-145](forth.txt#L138)) допускает следующие действия:
1. ignore, and continue
2. display a message
3. execute a particular word
4. interpret a block
5. return control to the text interpreter

## Общие error conditions (§ 4)

| # | Условие | Действие RARS-FORTH |
|---|---------|---------------------|
| 1 | Input stream exhausted before a required `<name>` (например, `: <EOL>`) | (2) Сообщение `CREATE: no name` / `FORGET: not found` / `[COMPILE]: no name` в зависимости от контекста, (5) возврат к text interpreter |
| 2 | Empty stack (underflow) | (2) Сообщение `S-Udf!`, (1) pop возвращает 0 — continue |
| 2 | Full stack (overflow) | (2) Сообщение `S-Ovf!`, (5) `exit_program()` — терминал не возвращается, но это допустимый действенный вариант |
| — | Return-stack underflow | (2) `R-Udf!`, (1) rpop возвращает 0 — continue |
| — | Return-stack overflow | (2) `R-Ovf!`, exit |
| 3 | Unknown word, не валидное число | (2) Сообщение `? <token>`, (5) возврат к text interpreter (продолжаем парсить следующий токен) |
| 4 | Incorrectly nested conditionals (например, `THEN` без `IF`) | (1) ignore, поведение неопределено (под-стек поломан, но программа не падает) |
| 5 | Interpretation of compile-only word (например, top-level `EXIT`) | (1) ignore, continue (см. [Phase 4](forth.c#L200)) |
| 6 | `FORGET` уровня системного слова | (1) ignore — мы просто переустанавливаем `dict_len` и `HERE`. Безопасность зависит от пользователя; при FORGET до системного слова система может стать неработоспособной |
| 7 | Insufficient space in dictionary | (2) `Dict Full!` (если переполнен `dict[]` массив) или `Mem Full!` (если HERE упёрся в конец `vm.memory`), (5) exit |

## Per-word error conditions

| Слово | Условие | Действие |
|-------|---------|----------|
| `BLOCK n`, `BUFFER n`, `LIST n`, `LOAD n` | `n < 0` или `n >= 32` | `BLOCK err` / `BUFFER err` / `LIST err` / `LOAD err`, push 0 (для BLOCK/BUFFER) |
| `EXECUTE addr` | `addr` вне `[0, dict_len)` | `Exec Err`, continue |
| `'` (tick) | имя не найдено | `Tick err` |
| `/`, `MOD`, `/MOD` | деление на 0 | push 0 (avoid trap) |
| `*/`, `*/MOD` | деление на 0 | push 0 |
| `U/MOD` | деление на 0 | push 0 0 |
| `WORD`, `CREATE`, `VARIABLE`, `CONSTANT`, `FORGET`, `[COMPILE]`, `:`, `VOCABULARY` | input stream exhausted | сообщение + continue (см. таблицу #1) |
| `PICK`, `ROLL` | `n < 1` или `n > depth` | `PICK err` / `ROLL err` |
| `-TRAILING` | `n < 0` | возвращает count = 0 |

## Стандартный механизм возврата к терминалу

- `QUIT` очищает return stack, сбрасывает STATE, возвращает управление к text interpreter (через `abort_flag`)
- `ABORT` очищает оба стека, сбрасывает STATE, возвращает управление (через `abort_flag`)
- `BYE` (нестандартное системное расширение) — `exit_program`

## Тестовое окружение (§ 6.2)

| Требование стандарта | RARS-FORTH |
|---------------------|------------|
| ≥ 2000 байт application dictionary | ~23 KiB (`0x4D0..0x5FFF`) |
| ≥ 64 байт data stack | 64 ячейки (16-bit), фактически хранятся как 64 × 4 байта в C |
| ≥ 48 байт return stack | 64 ячейки |
| 32 блока mass storage | 32 блока × 1024 байт в `vm.memory[0x6000..0xDFFF]` |
| ASCII терминал | RARS console через syscalls 4/8/11/12 |
