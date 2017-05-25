#!/bin/bash

echo $#
if [ "$#" -eq 2 ];then
    ROOTPATH=$1
    APKPATH=$2
    APKPATH=`echo ${APKPATH%/*}`
    echo $ROOTPATH
    echo "print log to ReadMe.txt"
    cd $ROOTPATH

    app_lists=`find $APKPATH | grep ".apk" | grep -vE "Bluetooth|CertInstaller|HTMLViewer|KeyChain|Wallpapers|MDummyAPK|MTv|UserDictionaryProvider|PacProcessor"`

    README=$ROOTPATH/ReadMe.txt
    GITLOG=$ROOTPATH/GitLog.txt
    if [ -f $README ];then
        rm $README
    fi

    if [ -f $GITLOG ];then
        rm $GITLOG
    fi

    for app in $app_lists
    do
        #    echo $app
        info=`out/host/linux-x86/bin/aapt dump badging $app  | grep -E "package: name=|application: label="`
        apkName=`echo $app | awk -F"/" '{print $NF}'`
        appName=`echo $info | grep "application: label=" | awk -F"'" '{print $8}'`
        packageName=`echo $info | grep "package: name=" | awk -F"'" '{print $2}'`
        versionCode=`echo $info | grep "versionCode=" | awk -F"'" '{print $4}'`
        versionName=`echo $info | grep "versionName=" | awk -F"'" '{print $6}'`
        echo "apkName="$apkName >> $README
        echo "appName="$appName >> $README
        echo "packageName="$packageName >> $README
        echo "versionCode="$versionCode >> $README
        echo "versionName="$versionName >> $README
        echo "==="  >> $README
    done

    repo forall -c " echo "========" ; pwd ; git branch -a | grep '\->' ; git log -n 2; echo "" " >> $GITLOG
    echo "========" >> $GITLOG

    cd $ROOTPATH/cantv
    echo "" >> $GITLOG

    for var in ${app_lists}
    do
        apkName=app/`echo $var | awk -F"app/" '{print $2}'`

        if [ -f $apkName ];then
            echo "--------" $apkName "--------"  >> $GITLOG
            git log -n 1 $apkName >> $GITLOG
            echo "" >> $GITLOG
            echo "" >> $GITLOG
        fi
    done

    cd -

else
    echo "printlog error---"
fi
