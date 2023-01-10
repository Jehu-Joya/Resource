#!/bin/sh

work=~/Documents/1.code/2.git/debug/public/resource

cd $work/config/clash/rule

rm -rfv bak/*.yaml

while read file_name file_url; do
	wget -O ${file_name} -c ${file_url}
done <rule.txt

cd $work
