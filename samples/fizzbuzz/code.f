( Classic FizzBuzz from 1 to N )
: FIZZBUZZ ( n -- )
  1+ 1 DO
    I 15 MOD 0= IF ." FizzBuzz "
    ELSE I 3 MOD 0= IF ." Fizz "
    ELSE I 5 MOD 0= IF ." Buzz "
    ELSE I .
    THEN THEN THEN
  LOOP ;
15 FIZZBUZZ
