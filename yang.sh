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

echo "单个数组元素的长度"
arry=(
	hello
	nihao
	llist
	struct
)

n=0
for var in ${arry[*]}; do
	echo ${var} size is ${#arry[n++]}
done

echo ===========function again====================
arry=(
	hello
	798uiddd
	mstarlianfake
	witchisyourlove
)

function print_str() {
	echo $1
}

i=0
for var in ${arry[*]}; do
	len=${#arry[i++]}
	case ${len} in
		8)
		print_str ${arry[i-1]}
		;;
	esac
done

echo ============dir ops======================
for var in `ls`; do
	if [[ -d ${var} ]]; then
		cd ${var}
		ls
		cd -
	fi
done

echo ===========google *.sh================

path1="/home/java/daycode/shell-grammar"
path2="/home/java/daycode/shell-command"
path3="/home/java/daycode/shell-symbol"

len=$(expr ${#path1} + 1)
echo ${len}

pathall=(
	${path1}
	${path2}
	${path3}
)

compfile="yang.sh"
for var in ${pathall[*]}; do
	for filesh in ${var}/*.sh; do
		echo ${filesh}
		file=${filesh:$(expr ${#var} + 1)}
		echo ${file}
		if [[ ${file} = ${compfile} ]]; then
			echo ======${var}/yang.sh
		else
			echo ======not find======
		fi
	done
done

path="/home/java/daycode/shell-grammar"
for var in ${path}/*.sh; do
	echo $var
done

#请思考 ${path}/*.sh 代表什么， 一定要把这个东西考虑清楚了，说明白了
path="/home/java/daycode/shell-grammar"
len=`expr ${#path} + 1`
echo $len
for var in ${path}/*.sh; do
	echo $var #/home/java/daycode/shell-grammar/*.sh
	file=${var:len}
	echo $file
	if [ $file != yang.sh ]; then
		mv $file change$file
	fi
done

echo '=================替换命令(将结果值保存在左值 如$(), ``两个作用相同) again================='


echo ============ip test, 1.shell使用数组中的元素 2. 如何使用gawk===============

#egre = grep -E, 
function check_line_isip() {
if echo $1 |egrep -q '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$' ; then
	pall[0]=`echo $1 |gawk -F'.' '{print $1}'`
	pall[1]=`echo $1 |gawk -F'.' '{print $2}'`
	pall[2]=`echo $1 |gawk -F'.' '{print $3}'`
	pall[3]=`echo $1 |gawk -F'.' '{print $4}'`
	echo "${pall[0]} ${pall[1]} ${pall[2]} ${pall[3]}"
	flag=0
	for var in ${pall[*]}; do
		if [[ ${var} -gt 255 || ${var} -lt 0 ]]; then
			echo "it is not ip, a correct ip like 192.168.112.206"
		else
			flag=$(expr $flag + 1)
		fi
	done
	if [[ $flag -eq 4 ]]; then
		echo "$1 is a correct ip"
	fi
fi
}

while read line; do
	if [[ $line = 'q' ]]; then
		break
	fi
	check_line_isip $line
	break
done

echo ===============checkip again after 端午================
function checkip_again() {
	slip=(
		$(echo $1 | gawk -F '.' '{for(i=1; i<=NF; i++) print $i}')
	)
	flag=0
	for var in ${slip[*]}; do
		if [[ $var -gt 255 || $var -lt 0 ]]; then
			echo "not a valid ip"
			break
		fi
		flag=$(expr $flag + 1)
	done
	if [[ $flag -eq 4 ]]; then
		echo "is a valid ip"
	fi
}

while read line; do
	if [[ ${line} = "q" ]]; then
		break
	fi
	checkip_again $line
done

echo ================declare =============
declare -i time_stop_s=$(date +%s)
echo ${time_stop}
