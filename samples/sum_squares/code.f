( Sum of squares from 1 to N )
: SUM-SQ ( n -- sum )
  0 SWAP 1+ 1 DO
    I I * +
  LOOP ;
4 SUM-SQ .
