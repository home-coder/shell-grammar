#!/bin/bash
echo "hello world"

echo "========================="
echo "What is your name?"
#read PERSON
echo "Hello, $PERSON"

echo "========================="
val1="hello val1"
echo "${val1} world"
val1="wold val111"
echo "${val1} hello"

#readonly val1
val1="readonly"
unset val1
echo "${val1} NULL ?"

echo "#################或 1##############################"
if [ $# -lt 3 ]; then
	echo "lt 3"
else
	echo ">= 3"
	if [[ $1 == 1 || $2 == 2 ]]; then
		echo "$1"
	else
		echo "not $1"
	fi
fi

#http://c.biancheng.net/cpp/view/2736.html
echo "#################或 2##############################"
if [[ $1 == 1 -o $2 == 2 ]]; then
	echo "|| -o 相同"
fi

echo "###############################################"
var=$(expr 3 + 2)
val=$(pwd)
echo ${val}
echo "###############################################"
