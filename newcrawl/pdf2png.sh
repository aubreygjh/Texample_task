#!/bin/sh
path = $1
cd result
folders=$(ls $path)
for foldername in $folders
do
    mkdir -p ../tmpjpg/$foldername
    mkdir -p ../png/$foldername
    cd $foldername
    
# #transform pdf to jpg fisrt in order to avoid transparent background
    mogrify -path ../../tmpjpg/$foldername -trim -density 144 -units PixelsPerInch  -format jpg *.pdf[0]
    cd ../../tmpjpg/$foldername
# #transform jpg to png
    mogrify -path ../../png/$foldername -format png *.jpg
    cd ../../result
done
rm -r ../tmpjpg
echo pdf-to-png finished