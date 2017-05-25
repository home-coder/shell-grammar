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
var1=$1
var2=$2
echo "#################或 2, 使用-o， 但是要去掉一层中括号[] ##############################"
if [ $# -lt 2 ]; then
	echo "few parama"
elif [ ${var1} -eq 1 -o ${var2} -eq 2 ]; then
	echo "|| -o 相同"
fi

echo "###############################################"
var=$(expr 3 + 2)
val=$(pwd)
echo ${val}
echo "###############################################"

echo "数组"
arry=(
	1
	2
	1993
	1998
)
echo "all arry ${arry[*]}"

for var in ${arry[*]}; do
	echo ${var}
done

len=${#arry[*]}
echo ${len}
for((i=0; i<${len}; i++)); do
	echo ${arry[i]}
done

#请思考 ${path}/*.sh 代表什么， 一定要把这个东西考虑清楚了，说明白了
path="/home/java/daycode/shell-grammar"
len=`expr ${#path} + 1`
echo $len
for var in ${path}/*.sh; do
	file=${var:len}
	echo $file
done
