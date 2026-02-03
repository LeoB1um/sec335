#!/bin/bash

sudo nmap -Pn -p 53 10.0.5.0/24 -oG dns-servers3.txt > /dev/null 2>&1

grep "/open/" dns-servers3.txt | awk '{print $2}' | sort -u
