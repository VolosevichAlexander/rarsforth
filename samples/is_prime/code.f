( Primality test for small positive integers )
: PRIME? ( n -- flag )
  DUP 2 < IF DROP 0 EXIT THEN
  DUP 2 = IF DROP 1 EXIT THEN
  DUP 2 MOD 0= IF DROP 0 EXIT THEN
  DUP 9 < IF DROP 1 EXIT THEN
  1 SWAP
  DUP 2 /
  3 DO
    DUP I MOD 0= IF
      SWAP DROP 0 SWAP
      LEAVE
    THEN
  2 +LOOP
  DROP ;
7 PRIME? .
9 PRIME? .
