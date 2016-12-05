#!/bin/bash

abort()
{
    echo >&2 '
***************
*** ABORTED ***
***************
'
    echo "An error occurred. Exiting..." >&2
    exit 1
}

trap 'abort' 0

set -e


TEMPLATE_NAME="Cell\ \&\ Cell\ Source\ 2.xctemplate/"
TEMPLATE_PAHT="/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File\ Templates/ImoTableView/"
PATH_TO_MOVE=$TEMPLATE_PAHT
BASEDIR=$(dirname "$0")

echo $PATH_TO_MOVE$TEMPLATE_NAME
#echo $BASEDIR/$TEMPLATE_NAME

sudo rm -rf $PATH_TO_MOVE$TEMPLATE_NAME
#cp -Rf $BASEDIR./$TEMPLATE_NAME $PATH_TO_MOVE



trap : 0

echo >&2 '
************
*** DONE *** 
************
'