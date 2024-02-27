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



#如果clang插件不存在，则构建插件
clPlgSo='/bal/clang-add-funcIdAsm/build/lib/libCTk.so' && \
#clang插件在30分钟后 必定会被重新编译
{ fileModifiedInNSeconds $clPlgSo "30*3600" || bash $_out_dbg /bal/script_basic/build-clang-add-funcIdAsm-release_0.sh ;}


#miniconda activate
miniconda3Activate && \

pip install lark
pip install plumbum

interceptor=/bal/cmd-wrap/interceptor.py
chmod +x $interceptor

fake_bin=/bal/bin
mkdir -p $fake_bin

export PATH=$fake_bin:$PATH
export PYTHONPATH=/bal/cmd-wrap/lark_parser/:$PYTHONPATH

#BashRcF=~/.bashrc
#grep fake_bin $BashRcF || { echo '
#fake_bin=/bal/bin
#export PATH=$fake_bin:$PATH
#export PYTHONPATH=/bal/cmd-wrap/lark_parser/:$PYTHONPATH
#' | tee -a $BashRcF ;}

#重命名上一次的日志文件们
gFLs=$(find /bal/  -maxdepth 1  -regex '/bal/g-[0-9]+\.log' | xargs -I% echo -n "% ") && \
( mvFile_AppendCurAbsTime_multi $gFLs || : ) && \

#记录初始的环境变量名字列表
chmod +x /bal/cmd-wrap/env-diff-show.sh
ignore_env_name_list_f=/bal/.ignore_env_name_list.txt
env | cut -d= -f1 > $ignore_env_name_list_f
echo "CONDA_EXE
CONDA_PREFIX
CONDA_PROMPT_MODIFIER
_CE_CONDA
CONDA_SHLVL
CONDA_PYTHON_EXE
CONDA_DEFAULT_ENV
" >> $ignore_env_name_list_f

sudo mkdir -p $fake_bin && sudo chown -R $(id -gn).$(whoami) $fake_bin

fake_clang=$fake_bin/clang
#fake_clangPP=$fake_bin/clang++
# fake_gcc=$fake_bin/i686-linux-gnu-gcc
#fake_gpp=$fake_bin/i686-linux-gnu-g++

#安装被拦截clang举例:
{ { [ -L $fake_clang ] && unlink $fake_clang ;} || : ;} && ln -v -s $interceptor $fake_clang

#安装被拦截clang++举例:
#ln -v -s $interceptor $fake_clangPP

#安装被拦截gcc举例:
# unlink $fake_gcc && ln -v -s $interceptor $fake_gcc

#安装被拦截g++举例:
#ln -v -s $interceptor $fake_gpp


#由于 /bal/bin/clang  在 PATH 中 比 /usr/bin/gcc 更先被搜索到

#请求 假的 /bal/bin/clang 时 ，发生转发:
#/bal/bin/clang ---软连接---> interceptor.py -----由route_tab.py转发---->  $CLANG_HOME_BIN/clang

#请求 假的 /bal/bin/gcc 时 ，发生转发:
#/bal/bin/i686-linux-gnu-gcc ---软连接---> interceptor.py -----由route_tab.py转发---->  /usr/bin/i686-linux-gnu-gcc-11



#卸载被拦截clang举例:
#unlink $fake_clang

#卸载被拦截clang++举例:
#unlink  $fake_clangPP

#卸载被拦截gcc举例:
#unlink  $fake_gcc

#卸载被拦截g++举例:
#unlink  $fake_gpp
