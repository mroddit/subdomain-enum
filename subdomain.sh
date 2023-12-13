#!/bin/bash
#created by Mr.0ddit
echo "#################################################"
echo "#                                               #"
echo "#                   Mr.0ddit                    #"
echo "#                                               #"
echo "#################################################"



echo -n "Enter Your Domain:"
read domain

mkdir -p $domain $domain/aquatone $domain/wabackurls

subfinder -d $domain |tee -a $domain/s1.txt

assetfinder --subs-only $domain |tee -a $domain/s2.txt

(curl -s https://crt.sh/\?q\=%25.$domain\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u | tee -a $domain/s3.txt)

cat *.txt | grep -E *$domain | sort -u | tee -a $domain/s4.txt

cat $domain/s4.txt | httpx | tee -a $domain/s5.txt

cat $domain/s5.txt | httprobe | tee -a $domain/s6.txt

cat $domain/*.txt | grep -E *.$domain | sort -u | tee -a $domain/main.txt

rm -rf $domain/s1.txt $domain/s2.txt $domain/s3.txt $domain/s4.txt $domain/s5.txt $domain/s6.txt

cat $domain/main.txt | aquatone -ports large > aquatone/file.txt 

cat $domain/main.txt | waybackurls > $domain/wabackurls/row.txt 
cat $domain/wabackurls/wayback.txt | egrep -v "\.woff|\.ttf|\.eot|\.png|\.jpeg|\.jpg|\.svg|\.css|\.ico|\.html" | sed 's/:80//g;s/443//g' | sort -u >> wayback.txt


#cat main.txt | waybackurls > wayback.txt | egrep -V "\.woff|\.ttf|\.eot|\.png|\.jpeg|\.jpg|\.svg|\.css|\.ico|\.html" | sed 's/:80//g;s/443//g' | sort -u


#cat $domain/main.txt | aquatone -ports large > aquatone/0.txt | tee -a $domain/aquatone/0.txt

















