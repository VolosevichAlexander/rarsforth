#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Usage: ./run.sh INPUTFILE OUTPUTFILE"
    exit 1
fi
rm -f forth.blk
java -jar ../rars1_6.jar nc sm forth.s < "$1" > "$2"