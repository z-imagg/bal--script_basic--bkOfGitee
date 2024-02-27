#!/usr/bin/env bash


source /app_spy/bash-simplify/dir_util.sh
getCurScriptDirName $0
#当前脚本文件 绝对路径 CurScriptF, 当前脚本文件 名 CurScriptNm, 当前脚本文件 所在目录 绝对路径 CurScriptNm
#CurScriptDir == /app_spy/script_basic/
cd $CurScriptDir && \

#获取调用者 是否开启了 bash -x  即 是否开启 bash 调试
#返回变量 _out_en_dbg, _out_dbg
get_out_en_dbg && \
echo "$_out_en_dbg,【$_out_dbg】" && \


export LIB_CTk_CXX_FLAGS="  "
bash $_out_dbg build-clang-add-funcIdAsm-release_x.sh
unset LIB_CTk_CXX_FLAGS
#构建的Release版本 :
# -rwxrwxr-x 1 zz zz 874K  7月 24 13:13 /app_spy/clang-funcSpy/build/lib/libClnFuncSpy.so
