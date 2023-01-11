#!/bin/sh

green(){
	echo "\033[32m\033[01m$1\033[0m"
}

red(){
	echo "\033[31m\033[01m$1\033[0m"
}

yellow(){
	echo "\033[33m\033[01m$1\033[0m"
}

function clash(){
	yellow "============================="
	echo   "                             "
	yellow "            clash            "
	echo   "                             "
	yellow "============================="
	echo   "                             "
	green "0. Exit current script "
    green "1. Install dependence "
    green "2. Capture node "
    green "3. Lightweight speed measurement "
    green "4. Streaming media unlocking test "
    green "5. Temporary script "
	echo   "                             "
	read -p "Please enter options: " Input
	case "$Input" in
	0) exit ;;
    1) Dependence ;;
    2) nodeCatch ;;
    3) LiteSpeedTest ;;
    4) MediaUnlockTest ;;
    5) Temp ;;
	*) red "Invalid input" && clash ;;
	esac
}

function Dependence(){
    proxy
    sleep 3
    #clash $config/Country.mmdb
    wget -O $config/Country.mmdb.bak -c https://ghproxy.com/https://raw.githubusercontent.com/Loyalsoldier/geoip/release/Country.mmdb
    mv -f $config/Country.mmdb.bak $config/Country.mmdb
    #URLignore node_moudles init
	cd $utils/URLignore && yrm use taobao && yarn
    sleep 3
    unproxy
    cd $work
	echo
    clash
}

function nodeCatch(){
    proxy
    sleep 3
    chmod +x $subconverter/subconverter
    nohup $subconverter/subconverter > /dev/null 2>&1 &
    rm -rf $subconverter/cache/*
	gsed -i '1,1d' $bak/bak-public.yaml #从文件$bak/bak-public.yaml中删除第一行
	gsed -i "1i\\"$'\n'""$'\n' $bak/bak-public.yaml #在文件$bak/bak-public.yaml的第一行插入一个换行符
	cat $provider/public-clash.yaml $bak/bak-public.yaml > $bak/temp.yaml
    mv -f $bak/temp.yaml $bak/bak-public.yaml
	gsed -i '1002,$d' $bak/bak-public.yaml #从文件$bak/bak-public.yaml的第1002行开始，删除到文件末尾的所有行
	gsed -i "$ a \\"$'\n'""$'\n' $bak/bak-public.yaml #在文件$bak/bak-public.yaml的末尾添加一个换行符
	cp -f $bak/bak-public.yaml $sub/bak-public.yaml
	$subconverter/subconverter -g --artifact "public-base64"
	base64 -d -i $sub/public-base64 -o $utils/URLignore/url
    remark
    subformat
    sleep 3
    unproxy
    cd $work
	echo
    clash
}

function LiteSpeedTest(){
    proxy
    sleep 3
    cd $utils
    rm -rf lite
    wget -O lite.gz -c https://ghproxy.com/https://github.com/xxf098/LiteSpeedTest/releases/download/v0.14.1/lite-darwin-arm64-v0.14.1.gz
    atool -x lite.gz
    chmod +x lite
    rm -rf lite.gz
    open -a /Applications/iTerm.app ./lite
    open -a /System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app http://127.0.0.1:10888
    open $provider
    sleep 3
    unproxy
    #vim怎么清空当前文本 Q3:%d
    vim $utils/URLignore/url
    remark
    subformat
    sleep 3
    unproxy
    sh $proxy/proxy-push.sh
    proxy
    cd $work
	echo
    clash
}

function MediaUnlockTest(){
    proxy
    sleep 3
    cd $utils
    rm -rf unlock-test
    wget -O unlock-test -c https://unlock.moe/latest/unlock-test_darwin_arm64
    chmod +x unlock-test
    ./unlock-test
    sleep 3
    unproxy
    cd $work
	echo
    clash
}


function Temp(){
    proxy
    sleep 3
    red "Under construction"
    sleep 3
    unproxy
	echo
	exit
}

function remark(){
    cd $utils/URLignore
    yarn start
    mv -f $utils/URLignore/out $bak/bak-url
    base64 -b 0 -i $bak/bak-url -o $sub/public-base64

	#mkdir -p $proxy/nodeCatch/
	#split -l 300 $bak/bak-url $proxy/nodeCatch/ #开始单个单个文件测试
    #cat $proxy/nodeCatch/* > $utils/nodesCatch/url #测试完成后
    #rm -rf $proxy/nodeCatch
    #base64 -b 0 -i $utils/nodesCatch/url -o $sub/public-base64

    $subconverter/subconverter -g --artifact "public-clash"
    mv -f $sub/public-clash.yaml $provider/public-clash.yaml
    #$subconverter/subconverter -g --artifact "self-clash"
    #mv -f $sub/self-clash.yaml $provider/self-clash.yaml
    #$subconverter/subconverter -g --artifact "public-loon"
    #$subconverter/subconverter -g --artifact "self-loon"
    #$subconverter/subconverter -g --artifact "temp"

    cd $proxy
    line=$(wc -l < bak/bak-url)
    time=$(date '+%Y.%m.%d %H:%M:%S')
    echo "$time >>> $line" >> $proxy/log.txt
    gsed -i '1!G;h;$!d' $proxy/log.txt #反转文件$proxy/log.txt的排序
    gsed -i '10,$d' $proxy/log.txt #从文件$proxy/log.txt的第10行开始，删除到文件末尾的所有行
    gsed -i '1!G;h;$!d' $proxy/log.txt #反转文件$proxy/log.txt的排序
}

function subformat(){
	gsed -i '/^$/d' $provider/*.yaml $bak/*.yaml #在文件$provider/*.yaml和文件$bak/*.yaml里运行
	gsed -i '/^\s*$/d' $provider/*.yaml $bak/*.yaml #在文件$provider/*.yaml和文件$bak/*.yaml里运行
    gsed -i '/�/d' $provider/*.yaml $bak/*.yaml #在文件$provider/*.yaml和文件$bak/*.yaml里去除�所在行
    gsed -i 's@\[SS\]@[SSS]@g;s@\[Trojan\]@[TJN]@g;s@\[VMess\]@[VMS]@g' $provider/*.yaml #合并三个替换规则
}

function proxy(){
    open -a /Applications/Clash\ for\ Windows.app
    open -a /Applications/Clash\ for\ Windows.app
	export http_proxy=http://127.0.0.1:7890 https_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890
}

function unproxy(){
	unset all_proxy && unset http_proxy && unset https_proxy
    killall Clash\ for\ Windows
    killall Clash\ for\ Windows
}

#A1: 使用rm命令可以删除mac上的垃圾文件，例如：rm -rf ~/Library/Caches/*
#COMMAND="$1"

work=~/Documents/1.code/2.git/debug/public/resource
config=~/.config/clash
proxy=$work/fq/clash/proxy
utils=$proxy/utils
bak=$proxy/bak
provider=$proxy/provider
subconverter=$utils/nodesCatch/subconverter
sub=$subconverter/sub

cd ~
find ./ -name ".DS_Store" -depth -exec rm -rfv {} \;
cd $work
reset
clash
