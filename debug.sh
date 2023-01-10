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

function debug(){
	yellow "============================="
	echo   "                             "
	yellow "            debug            "
	echo   "                             "
	yellow "============================="
	echo   "                             "
	green "0. Exit current script "
    green "1. Patch commits "
    green "2. Sync remote "
    green "3. clash script "
    green "4. Temporary script "
	echo   "                             "
	read -p "Please enter options: " Input
	case "$Input" in
	0) exit ;;
    1) Renew ;;
    2) Sync ;;
	3) clash ;;
    4) Temp ;;
	*) red "Invalid input" && debug ;;
	esac
}

function Renew(){
    proxy
	git add -A
	git commit --amend --no-edit --date=now --reset-author
	git push origin main
    unproxy
	echo
	debug
}

function Sync(){
    proxy
    git pull origin main
    unproxy
    echo
    debug
}

function clash(){
	chmod +x $work/fq/clash/clash.sh
	sh $work/fq/clash/clash.sh
}

function Temp(){
    proxy
    red "Under construction"
    unproxy
	echo
	exit
}

function proxy(){
	export http_proxy=http://127.0.0.1:7890 https_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890
}

function unproxy(){
	unset all_proxy && unset http_proxy && unset https_proxy
}

#A1: 使用rm命令可以删除mac上的垃圾文件，例如：rm -rf ~/Library/Caches/*
work=~/Documents/1.code/2.git/debug/public/resource
cd ~
find ./ -name ".DS_Store" -depth -exec rm -rfv {} \;
cd $work
reset
debug
