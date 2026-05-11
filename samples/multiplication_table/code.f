( N by N multiplication table with nested DO LOOP )
: MULT-TABLE ( n -- )
  DUP 1+ 1 DO
    DUP 1+ 1 DO
      I J *  .
    LOOP
    CR
  LOOP
  DROP ;
4 MULT-TABLE
