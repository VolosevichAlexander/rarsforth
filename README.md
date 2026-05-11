# Интерпретатор языка программирования Forth для симулятора RARS

**Автор: Волосевич Александр Андреевич, студент БПИ242 НИУ ВШЭ**

Реализация полностью соответствует стандарту **FORTH-79** (с одним явным
расширением `BYE`). Соответствие подтверждается тестами фаз 0..12 и
демонстрационными примерами.

## Сборка и запуск

Требуется:

1. **RISC-V GCC Toolchain** для компиляции C в ассемблер RISC-V.
   Скачать можно здесь: https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack/releases
2. **Python 3** для патчинга ассемблерного кода под формат RARS.
3. **RARS Simulator** (rars1_6.jar лежит в корне репозитория).
4. **Java Runtime (JRE)** для запуска RARS.

Утилиты `riscv-none-elf-gcc`, `python` (или `py`) и `java` должны быть доступны в PATH.

### Сборка

Запустите `compile.bat` (Windows) или `./compile.sh` (Linux/macOS).
Скрипт вызывает gcc для генерации `forth.s` и затем `fix_rars.py` для
приведения ассемблера к виду, понятному RARS.

### Запуск в GUI

1. Откройте `forth.s` в RARS.
2. В `Settings` включите `Initialize Program Counter to global 'main' if defined`.
3. F3 чтобы ассемблировать.
4. F5 чтобы запустить.
5. Вводите Forth-команды в `Run I/O` окне. `BYE` завершает программу.

### Автоматический запуск (тесты и примеры)

Скрипты `test.bat` (Windows) и `test.sh` (Linux/macOS, Git Bash на Windows)
запускают RARS в неинтерактивном режиме, читая stdin из файла и записывая
вывод в файл:

```bash
./test.sh input.txt output.txt
```

или

```cmd
test.bat input.txt output.txt
```

Скрипт удаляет `forth.blk` перед запуском (чтобы предыдущие
SAVE-BUFFERS не загрязняли состояние), затем зовёт RARS.

## Соответствие стандарту FORTH-79

Реализован полный Required Word Set FORTH-79:
- **Nucleus**: стек, арифметика, return-стек, побитовые операции, циклы.
- **Interpreter**: парсер, словарь, pictured numeric output, ABORT/QUIT/EXPECT/QUERY.
- **Compiler**: `:` `;` `IMMEDIATE` `[` `]` `LITERAL` `CREATE` `DOES>`
  `FORGET` `COMPILE` `[COMPILE]` `VOCABULARY` `DEFINITIONS`.
- **Device**: 32 блока по 1024 байта, BLOCK/BUFFER/UPDATE/EMPTY-BUFFERS/SAVE-BUFFERS/LIST/LOAD/SCR.

Архитектурные требования стандарта:
- 16-битная знаковая арифметика, флаг true равен 1.
- Байт-адресуемая память, ячейка ровно 2 байта.
- VARIABLE выделяет ровно 2 байта.
- Адресация по модулю 65536.
- Длина имени до 31 символа, различение по длине + первым 31 символам.
- Адресное пространство и стеки удовлетворяют тестовому минимуму § 6.2.

Расширения сверх стандарта:
- `BYE` (system extension) для завершения программы.
- `HEX` и `BL` из Reference Word Set.
- `RECURSE` (общепринятое расширение).

Документ [`ERROR_CONDITIONS.md`](ERROR_CONDITIONS.md) описывает действия системы
на каждое error condition по требованию § 6.1.

Допустимый лейбл: **«FORTH-79 Standard with `BYE` system extension»**.

## Структура репозитория

```
forth.c              исходник интерпретатора на C
forth.s              сгенерированный ассемблер RISC-V (после compile)
rars_lib.h           inline-обёртки над RARS syscalls
fix_rars.py          патчер gcc-ассемблера под RARS
compile.bat          сборка на Windows
compile.sh           сборка на Linux/macOS
test.bat             запуск тестов на Windows
test.sh              запуск тестов на Linux/macOS
ERROR_CONDITIONS.md  документ по § 6.1 стандарта
forth.txt            оригинальный текст стандарта FORTH-79
rars.wiki/           документация RARS
rars-master/         исходники RARS (для отладки взаимодействия)

tests/               регрессионные тесты по фазам разработки
  phase0..phase12.input.txt        вход для теста
  phase0..phase12.output.txt       ожидаемый вывод
  phase0..phase12.description.txt  описание каждой фазы

samples/             демонстрационные примеры
  hello_world/          вывод "Hello, World!" через ."
  fibonacci/            k-е число Фибоначчи через DO LOOP
  gcd/                  НОД через BEGIN WHILE REPEAT
  factorial/            факториал через DO LOOP
  is_prime/             проверка на простоту с LEAVE и +LOOP
  sum_squares/          сумма квадратов через аккумулятор
  reverse_digits/       печать цифр в обратном порядке
  counter/              счётчик в VARIABLE
  fizzbuzz/             FizzBuzz с вложенными IF ELSE THEN
  multiplication_table/ таблица умножения через nested DO LOOP
  каждая папка содержит:
    code.f          читаемый исходник
    description.txt описание примера
    input.txt       вход для test.sh / test.bat
    output.txt      зафиксированный вывод
```

## Прогон тестов

Любая фаза:

```bash
./test.sh tests/phase0.input.txt /tmp/out.txt
diff tests/phase0.output.txt /tmp/out.txt
```

Любой пример:

```bash
./test.sh samples/fibonacci/input.txt /tmp/out.txt
diff samples/fibonacci/output.txt /tmp/out.txt
```