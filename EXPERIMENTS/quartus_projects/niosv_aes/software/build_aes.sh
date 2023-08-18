#!/bin/bash
APP="my_app"
APP="${2:-$APP}"
SRCS="./*.c"
SRCS="${3:-$SRCS}"
BASE=0x00000000
BASE="${4:-$BASE}"
END=0x000001FF
END="${5:-$END}"
WIDTH=32
WIDTH="${6:-$WIDTH}"
/opt/22.1std/niosv/bin/niosv-app -a=$APP  --bsp-dir=$1 --srcs=$SRCS
cd $1
cmake CMakeLists.txt
make -c $1 -j 4
cd -
elf2hex --input="./${1}/${1}.elf" --base=$BASE --end=$END --width=$WIDTH
