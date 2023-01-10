#!/bin/sh

work=~/Documents/1.code/2.git/debug/public/resource
config=~/.config/clash
proxy=$work/fq/clash/proxy
provider=$proxy/provider

cp -f $config/provider/proxy/* $provider/
