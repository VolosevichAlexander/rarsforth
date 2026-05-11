( Greatest common divisor by Euclidean algorithm )
: GCD ( a b -- gcd )
  BEGIN
    DUP 0>
  WHILE
    SWAP OVER MOD
  REPEAT
  DROP ;
12 8 GCD .
