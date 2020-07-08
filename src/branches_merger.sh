#!/bin/bash 

RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
NC='\033[0m'

if [ "$1" == "" ]
then
    echo "Missing name of source branch"
    exit 1
fi

branch_name=$1
echo "$branch_name"

if [ "`git branch --list ${branch_name}`" ]
then
    echo "Branch name $branch_name found"
else
    echo "Branch name $branch_name doesn't exists"
    exit 1
fi

for var in "${@:2}"
do
    echo "Checking: $var"
    if [ "`git branch --list ${var}`" ]
    then
        echo "Branch name $var found"
        git checkout $var
        git merge $branch_name
        git push
    else
        echo "Branch name $var doesn't exists"
        exit 1
    fi
done

git checkout $branch_name

exit 0