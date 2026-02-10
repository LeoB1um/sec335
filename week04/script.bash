#!/bin/bash

while IFS= read -r line; do
	grep "$line" rockyou.txt  > $line.txt
done < users.txt
