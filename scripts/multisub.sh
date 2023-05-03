#!/bin/bash

cwd=$(pwd)

for sub in $(find . -name 'sub.sh')
do
dir=$(dirname $sub)
cd $dir
echo "I am in $dir to submit $sub ..."
bsub < sub.sh
cd $cwd
done

