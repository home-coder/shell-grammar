#!/bin/bash

#==================================
# 这是一个本地使用编译脚本
#=================================

#=====================================================
if [ $# -lt 1 ]; then
echo -e "\033[33m \

    * Usage: Please read the tail of canbuild.sh for introductions, example:\n \
	        1.shell# ./canbuild.sh all\n \
	        2.shell# ./canbuild.sh sync branch_name\n \
		etc ...\n \

    * Add: Lichee have supported some another build methods already !!\
\033[0m\n"
exit;
fi
#====================================================

#top Time & Location
BUILD_TIME=`date +%Y%m%d%H%M`
ROOT_PWD=`pwd`
ANDROID_PWD=$ROOT_PWD/../Allwinner-a33
UBOOTDIR=$ROOT_PWD/brandy
KERDIR=$ROOT_PWD/linux-3.4
#platform config
ANDROID_PRODUCT=astar_d7
BUILD_MODE=eng #eng or user
PRODUCT_OUT=astar-d7
export LICHEE_CHIP=sun8iw5p1
export LICHEE_PLATFORM=android
export LICHEE_KERN_VER=linux-3.4
export LICHEE_BOARD=d7
DEFAULT_PACK_DEBUG=uart0

#error id
E_BUILD_UBOO=-1
E_BUILD_KERNEL=-2
E_BUILD_BOOTIMAGE=-3
E_BUILD_ANDROID=-4

#tmp out,phonix suit
IMG_OUT_DIR=$ANDROID_PWD/out/target/product/$PRODUCT_OUT
SUIT_IMG_OUT=$ROOT_PWD/tools/pack

#core thread
HOST_PROCESSOR=`cat /proc/cpuinfo | grep processor | wc -l`
BUILD_THREAD=$(expr $HOST_PROCESSOR \* 2)

function repo_sync () {
	branch=$1
#	repo sync
#	git checkout $branch
	repo init -b $branch && repo start $branch --all
}

function build_uboot () {
		cd $UBOOTDIR	
		. build.sh
		cd -
		cd $ANDROID_PWD
		source build/envsetup.sh
		lunch $ANDROID_PRODUCT-$BUILD_MODE
		pack
		#update timestamp
		DEFAULT_IMG_NAME="${LICHEE_CHIP}_${LICHEE_PLATFORM}_${LICHEE_BOARD}_${DEFAULT_PACK_DEBUG}.img"
		mv $SUIT_IMG_OUT/$DEFAULT_IMG_NAME $SUIT_IMG_OUT/${ANDROID_PRODUCT}-${BUILD_TIME}.img
		echo -e "\033[32m imagename = $SUIT_IMG_OUT/${ANDROID_PRODUCT}-${BUILD_TIME}.img replaced \033[0m\n\n"
		cd -

        return 0
}

function build_kernel_only () {
		cd $KERDIR
		export ARCH=arm
		export CROSS_COMPILE=`pwd`/../out/sun8iw5p1/android/common/buildroot/external-toolchain/bin/arm-linux-gnueabi-
        make || { return $E_BUILD_KERNEL;}

        return 0
}

function build_kernel () {
		. build.sh
		cd $ANDROID_PWD
		source build/envsetup.sh
		lunch $ANDROID_PRODUCT-$BUILD_MODE
		pack
		#update timestamp
		DEFAULT_IMG_NAME="${LICHEE_CHIP}_${LICHEE_PLATFORM}_${LICHEE_BOARD}_${DEFAULT_PACK_DEBUG}.img"
		mv $SUIT_IMG_OUT/$DEFAULT_IMG_NAME $SUIT_IMG_OUT/${ANDROID_PRODUCT}-${BUILD_TIME}.img
		echo -e "\033[32m imagename = $SUIT_IMG_OUT/${ANDROID_PRODUCT}-${BUILD_TIME}.img replaced \033[0m\n\n"

		return 0
}

function build_bootimage () {
	cd $ANDROID_PWD
        source build/envsetup.sh
        lunch $ANDROID_PRODUCT-$BUILD_MODE
        make bootimage || { return $E_BUILD_BOOTIMAGE;}

        return 0
}

function build_android () {
	#build a33
	cd $ANDROID_PWD
        if [[ $1 == "clean" || $1 == "distclean" ]]; then
                source build/envsetup.sh
                lunch $ANDROID_PRODUCT-$BUILD_MODE
                make clean || { return $E_CLEAN_ANDROID;}
                return 0
        fi  
	source build/envsetup.sh
	lunch $ANDROID_PRODUCT-$BUILD_MODE
	extract-bsp
        make -j$BUILD_THREAD || { return $E_BUILD_ANDROID;}
	pack
	
	#update timestamp
	DEFAULT_IMG_NAME="${LICHEE_CHIP}_${LICHEE_PLATFORM}_${LICHEE_BOARD}_${DEFAULT_PACK_DEBUG}.img"
	mv $SUIT_IMG_OUT/$DEFAULT_IMG_NAME $SUIT_IMG_OUT/${ANDROID_PRODUCT}-${BUILD_TIME}.img
	echo -e "\033[32m imagename = $SUIT_IMG_OUT/${ANDROID_PRODUCT}-${BUILD_TIME}.img replaced \033[0m\n\n"
	cd -

    return 0
}

function build_all () {
	#build lichee
	. build.sh
	#build a33
	 build_android $1
}

function build_full () {
	#build brandy
	cd $UBOOTDIR
	. build.sh
	cd -
	. build.sh
	build_android $1
}

function build_recovery () {
        source build/envsetup.sh
        lunch $ANDROID_PRODUCT-$BUILD_MODE
	echo -e "\033[31m out: $OTA_OUT \033[0m"
	return 0
}
 
case "$1" in

sync )
repo_sync $2
;;

#uboot, pack
uboot )
build_uboot $2
;;

#kernel, pack
kernel )
build_kernel $2
;;

#just kernel
kernel_only )
build_kernel_only $2
;;

bootimage )
build_bootimage $2
;;

#仅仅编译Android源码
android )
build_android $2
;;

#经常要编译kernel和Android，但是一般不会编译uboot,选择此switch
all )
build_all $2
;;

#全部编译，uboot kernel android
full )
build_full $2
;;

OTA )
build_recovery $2
;;

esac

