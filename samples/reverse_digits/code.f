( Print decimal digits of N in reverse order )
: REV-DIG ( n -- )
  BEGIN
    DUP 10 MOD .
    10 /
    DUP 0=
  UNTIL
  DROP ;
12345 REV-DIG
