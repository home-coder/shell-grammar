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
	if [ $file != yang.sh ]; then
		mv $file change$file
	fi
done

echo "################################"
str="love you jingjing"
for i in `seq ${#str}`; do
	echo ${str:$i-1;1}
done

str="hello world"
len=${#str}
for ((i=0; i < ${len}; i++)); do
	echo "${str:i:1}"
done
echo "################################"
string="23456789"
echo ${string}
echo ${#string}

echo "##########  判断str 是否为空, 为什么加双中括号 [[ ]] #####################"
str="have a string"
if [[ ${str} ]]; then
	echo "have"
else
	echo "not have"
fi
str2="haveastring"
if [ ${str2} ]; then
	echo "str2 exist"
else
	echo "str2 not exist"
fi

echo "##########  判断文件是否存在######################"
file="/home/jiangxiujie/basic/shell-grammar/yang.sh"
if [ -e ${file} ]; then
	echo "file exist"
else
	echo "file not exist"
fi

echo "#########shell 中的各种括号() (()) [] [[]] {}"
(
	str="this string"
	var=4
	echo ${var}
)
echo ${str}
echo ${var}

map=(
	"abc"
	"desc"
)

for var in ${map[*]}; do
	echo "map = ${var}"
done

len=${#map}
echo ${len}
for ((i = 0; i < ${len}; i++)); do
	echo ${map[i]}
done

echo "#####################################"
am=3
if [[ ${am} -ne 3 ]]; then
	echo "${am} != 3"
else
	echo '${am} == 3'
fi

#file exist ?
file2="/home/jiangxiujie/basic/shell-grammar/yang.sh"
if [[ -e ${file2} ]]; then
	echo "exist file2"
fi

strarry=(
	and android output
)
echo ${strarry[*]}

function print_android() {
	echo "print android" "${strarry[*]}"
}

function print_kernel() {
	echo "print kernel"
	print_android ${strarry[*]}
}

case $1 in
android)
print_android
;;
kernel)
print_kernel ${strarry[*]}
;;
esac


echo "===========按行读取=================="
while read line; do
	echo $line
done < $1

while read line; do
	flag=0
	for var in $line; do
#		echo ${var}
		if [[ ${var} = "function" ]]; then
			flag=1
			break
		fi
	done
	if [[ $flag -eq 1 ]]; then
		echo $line
	fi
done < $1


