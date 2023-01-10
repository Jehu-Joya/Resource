#!/bin/sh
time=$(date '+%Y.%m.%d %H:%M:%S')
echo "proxies:\n  - {name: "$time 无节点", server: apple.com, port: 443, type: vmess, uuid: 86155150-d86d-42e2-af55-986e3d72323a, alterId: 0, cipher: auto, tls: false, skip-cert-verify: true, network: ws, ws-opts: {path: /Patti, headers: {Host: apple.com}}, udp: true}"
