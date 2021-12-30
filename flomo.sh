#!/bin/sh

usage()
{
   # Display Help
   echo "flomo shell app"
   echo
   echo "usage: flomo -a/--api API"
   echo "       flomo api https://help.flomoapp.com/advance/api.html"
   echo "usage: flomo -t/--tag TAG -m/--msg MSG"
   echo "usage: flomo -m/--msg MSG"
   echo "usage: flomo MSG"
   echo "usage: flomo -h"
   echo
   echo "options:"
   echo "-a/--api 添加 flomo api"
   echo "-t/--tag flomo 信息标签"
   echo "-m/--msg flomo 信息"
   echo "-h/--help 帮助信息"
   echo
}

function expand(){
  echo `sh -c "echo $1"`
}

FLOMO_PATH='$HOME/.flomo'
EXPAND_PATH=`expand $FLOMO_PATH`
API_PATH=`expand $EXPAND_PATH/api`

touchapi() {
    if [ -d "$EXPAND_PATH" ]; then
        touch $API_PATH
    else
        mkdir $HOME/.flomo
        touch $API_PATH
    fi
}

api() {
    if [ -z $1 ]; then
        API=`head -n 1 $API_PATH`
        echo $API
        exit
    fi

    if [ -f "$API_PATH" ]; then
        echo $1 > $API_PATH
    else
        touchapi
        echo $1 > $API_PATH
    fi
}

msg() {
    #   echo send msg $*
    
    if [ -f "$API_PATH" ]; then
        API=`head -n 1 $API_PATH`
        MSG=$*
        echo 'send "'$*'" to flomo'
        curl -s $API -H 'Content-Type: application/json' -d '{"content": "'"$*"'"}' > /dev/null 2>&1
    else
        echo "!!! Please set api first !!!"
        echo 
        usage
        exit 1
    fi
}

tag=
while [ "$1" != "" ]; do
    case $1 in
        -a | --api )            shift
                                api $1
                                exit
                                ;;
        -t | --tag )            shift
                                tag=" #$1"
                                ;;
        -m | --msg )            shift
                                msg $1$tag
                                exit
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     msg $@
                                exit
                                ;;
    esac
    shift
done
usage
