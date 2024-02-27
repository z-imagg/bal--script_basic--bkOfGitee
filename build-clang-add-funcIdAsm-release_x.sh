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


#下载安装llvm15
bash $_out_dbg llvm15_dl_install.sh && \

#构建libfmt
bash $_out_dbg build-libfmt.sh && \

(bash setup--nlohmann--json.sh && \
bash setup--yhirose--cpp-httplib.sh && \
BUILD_HOME=/app_spy/clang-funcSpy/build/ && \
mkdir -p $BUILD_HOME && \
rm -fr $BUILD_HOME/* && \
cd $BUILD_HOME && \

#构建的Release版本 : build_release_0.sh
# LIB_CTk_CXX_FLAGS="  "
# -rwxrwxr-x 1 zz zz 874K  7月 24 13:13 /app_spy/clang-funcSpy/build/lib/libCTk.so

#构建的Release版本,带调试信息(变量名称和行号),  当出现问题方便排查: build_release_1.sh
#LIB_CTk_CXX_FLAGS=" -fno-omit-frame-pointer -Wall   -O0    -g1"
# -rwxrwxr-x 1 zz zz 4.6M  7月 24 14:50 lib/libCTk.so

#构建的Release版本,带调试信息(变量名称和行号、局部变量),  当出现问题方便排查:  build_release_2.sh
# LIB_CTk_CXX_FLAGS=" -fno-omit-frame-pointer -Wall   -O0    -g2"
# -rwxrwxr-x 1 zz zz 27M  7月 24 15:03 /app_spy/clang-funcSpy/build/lib/libCTk.so

cmakeInstall && \

cmake -DCMAKE_BUILD_TYPE=Release   -DCMAKE_CXX_FLAGS="$LIB_CTk_CXX_FLAGS"   -DCMAKE_C_FLAGS="$LIB_CTk_CXX_FLAGS"  ..  && \
#-DCMAKE_VERBOSE_MAKEFILE=True
make -j8 && \
ls -lh $BUILD_HOME/lib/lib*.so)



## 构建Release版本且有带局部变量名字的调试信息 以定位问题
#> GCC  调试信息不同级别选项 ：
#- `-g1`：生成最基本的调试信息，包括变量名称和行号信息。
#- `-g2`：除了基本的调试信息外，还包括局部变量的类型信息。
#- `-g3`：除了 `-g2` 提供的信息外，还包括宏定义和宏展开的内容。
