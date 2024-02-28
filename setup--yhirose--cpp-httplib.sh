#!/usr/bin/env bash


source /app_spy/bash-simplify/func.sh

source /app_spy/bash-simplify/dir_util.sh

#当前脚本文件名, 此处 CurScriptF=setup--yhirose--cpp-httplib.sh
CurScriptF=$(pwd)/$0





#1. 下载git仓库 yhirose/cpp-httplib.git


#https://github.com/yhirose/cpp-httplib.git
REPO_HOME="/app_spy/yhirose--cpp-httplib"
GitDir="$REPO_HOME/"
Ver="app_spy/v0.14.2a"
CmtId="37f8dc43829994e6cb2d1b78136cab320da8e546"

gitCko_tagBrc_asstCmtId $GitDir $Ver $CmtId

#2. 软链接 到 include目录下
inc_dir="/app_spy/clang-funcSpy/include/cpp_httplib" && \
[ -e $inc_dir ] || ln -s  $REPO_HOME $inc_dir && \
_=end