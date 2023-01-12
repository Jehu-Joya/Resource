#!/bin/sh

work=~/Documents/1.code/2.git/debug/public/resource
config=~/.config/clash
rule=$work/fq/clash/rule
provider=$rule/provider

cp -f $config/provider/rule/* $provider/
