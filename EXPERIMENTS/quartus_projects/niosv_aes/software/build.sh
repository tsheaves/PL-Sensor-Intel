#!/bin/bash
APP="my_app"
APP="${2:-$APP}"
SRCS="./*.c"
SRCS="${3:-$SRCS}"
BASE=0x00000000
BASE="${4:-$BASE}"
END=0x000001FF
END="${5:-$END}"
echo $END
WIDTH=32
WIDTH="${6:-$WIDTH}"
niosv-app -a=$APP  --bsp-dir=$1 --srcs=$SRCS
cd $2
cmake CMakeLists.txt
make -j 4
cd -
elf2hex --input="./${2}/${2}.elf" --base=$BASE --end=$END --width=$WIDTH --output="${2}.hex"
