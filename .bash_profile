

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node/
export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node/



#pidof copyq || copyq &


#jdk
export JAVA_HOME=/jdk8
# export JAVA_HOME=/jdk11
# export JAVA_HOME=/jdk17
export PATH=$JAVA_HOME/bin:$PATH

#通用可执行文件路径:/app/bin/
export  PATH=$PATH:/app/bin

function createSoftLink(){
    #若函数参数少于1个，则退出（退出码为35）
    [ $# -lt 2 ] && return 35
    RealF=$1
    FackF=$2
    
#若目标文件路径非文件 则退出（退出码为36）
    { [ -f $RealF ] || exit 36 ;} && \

#若链接路径不存在 则做软链接
    { [ -e $FackF ] || ln -s $RealF $FackF ;} 
    
}


grep "docker.bridge" /etc/hosts || echo "
#docker.bridge : docker （默认）桥接网络 网关地址.
172.17.0.1 docker0 dck docker.bridge
" | sudo tee -a /etc/hosts


#maven
createSoftLink /app/apache-maven-3.8.8/bin/mvn /app/bin/mvn

#/bal/script_basic/bin
export  PATH=$PATH:/bal/script_basic/bin

#cytoscape
createSoftLink /app/cytoscape-unix-3.10.1/cytoscape.sh /app/bin/cytoscape.sh

alias mspaint='/usr/bin/pinta'
alias apphome='cd /usr/share/applications/'
alias e='notepad--'
alias sudo='sudo '
alias p='/app/pycharm-2022.3/bin/pycharm.sh'
alias findigngit='find . -type f -not -path "*/\.git/*" '
alias bldm='multi_build=true bash /bal/bldLinux4RunOnBochs/build-linux4.14.259-on-x64_u22.04.3LTS.sh'
alias r='bash /bal/bldLinux4RunOnBochs/bochs2.7boot-grub4dos-linux4.14.259.sh'
alias disa='/app/Hopper-v4-5.13.5-Linux-demo/opt/hopper-v4/bin/Hopper'
alias drw='/app/cytoscape-unix-3.10.1/cytoscape.sh'
alias b4='cd /bal/bldLinux4RunOnBochs/'
alias c='source /app/miniconda3/bin/activate'
alias cda='conda deactivate'
alias mvnRMhtml='find ~/.m2/ -name _remote.repositories | xargs -I@ dirname @ | xargs -I% sh -c "file %/*.jar | grep HTML 1>/dev/null 2>/dev/null && rm -v %/*"'
alias mvnProxy7890='mvn -Dhttp.proxyHost=mechrev -Dhttp.proxyPort=7890 -Dhttps.proxyHost=mechrev -Dhttps.proxyPort=7890 '
alias mvnProxy7890DepSrc='mvnProxy7890 dependency:sources'
alias cp_progress='rsync --archive --verbose --progress '

rustc --version 2>/dev/null && \
{ export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup && \
export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup && \
source ~/.cargo/env ;}

SelfFP="/bal/script_basic/.bash_profile"
grep $SelfFP ~/.bashrc || echo "请手工添加以下内容到~/.bashrc的末尾: source $SelfFP 1>/dev/null 2>/dev/null"
#请手工添加以下内容到~/.bashrc的末尾: source /bal/script_basic/.bash_profile 1>/dev/null 2>/dev/null
