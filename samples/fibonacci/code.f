( k-th Fibonacci number: F_0 = 0, F_1 = 1, F_k = F_k-1 + F_k-2 )
: FIB ( k -- F_k )
  DUP 0= IF DROP 0 EXIT THEN
  DUP 1 = IF DROP 1 EXIT THEN
  0 1 ROT 1 - 0 DO
    SWAP OVER +
  LOOP
  SWAP DROP ;
10 FIB .
