( Counter using a VARIABLE )
VARIABLE CNT
0 CNT !

: NEXT ( -- )
  CNT @ 1+ DUP CNT ! . ;

: RESET ( -- )
  0 CNT ! ;

NEXT NEXT NEXT
RESET
NEXT NEXT
