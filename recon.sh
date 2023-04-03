#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: ./script.sh <domain>"
  exit 1
fi

domain="$1"

amass enum -d "$domain" -o "$domain"_amass.txt \
&& subfinder -d "$domain" -v >> "$domain"_subfinder.txt \
&& assetfinder "$domain" > "$domain"_assetfinder.txt \
&& sublist3r -d "$domain" -o "$domain"_sublister.txt \
&& curl -s "https://crt.sh/?q=%25.$domain&output=json" | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -uV > "$domain"_crt.txt
