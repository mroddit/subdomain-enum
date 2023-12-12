#!/bin/bash

echo -n "Enter Your Domain:"
read domain

mkdir -p $domain $domain/aquatone $domain/wabackurls

subfinder -d $domain |tee -a s1.txt

assetfinder --subs-only $domain |tee -a s2.txt

(curl -s https://crt.sh/\?q\=%25.$domain\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u | tee -a s3.txt)

cat *.txt | grep -E *$domain | sort -u | tee -a s4.txt

cat s4.txt | httpx | tee -a s5.txt

cat s5.txt | httprobe | tee -a s6.txt

cat *.txt | grep -E *.$domain | sort -u | tee -a main.txt

rm -rf s1.txt s2.txt s3.txt s4.txt s5.txt s6.txt

cat main.txt | aquatone -ports large | tee -a $domain/aquatone/0.txt

cat main.txt | waybackurls > $domain/wabackurls/wayback.txt | egrep -v "\.woff|\.ttf|\.eot|\.png|\.jpeg|\.jpg|\.svg|\.css|\.ico|\.html" | sed 's/:80//g;s/443//g' | sort -u 

















