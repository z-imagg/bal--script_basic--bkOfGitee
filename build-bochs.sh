#!/usr/bin/env bash

source /bal/bash-simplify/dir_util.sh
getCurScriptDirName $0
#当前脚本文件 绝对路径 CurScriptF, 当前脚本文件 名 CurScriptNm, 当前脚本文件 所在目录 绝对路径 CurScriptNm
#CurScriptDir == /bal/script_basic/
cd $CurScriptDir && \

#获取调用者 是否开启了 bash -x  即 是否开启 bash 调试
#返回变量 _out_en_dbg, _out_dbg
get_out_en_dbg && \
echo "$_out_en_dbg,【$_out_dbg】" && \


bash $_out_dbg /bal/script_basic/build-libfmt.sh


BOCHS_SRC="/bal/bochs/bochs/" && \
cd $BOCHS_SRC && \
sudo apt install libx11-dev -y && \
sudo apt install gcc-multilib -y && \
sudo apt-get install g++ -y && \
sudo apt-get install build-essential && \
sh .conf.linux && \
make && \
file $BOCHS_SRC/bochs && \

_end=true