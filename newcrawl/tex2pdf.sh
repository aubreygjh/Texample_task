#!/bin/sh
path=$1
cd result

folders=$(ls $path)
for foldername in $folders
do
    cd $foldername
    files=$(ls $path)
    echo $files
    for filename in $files
    do
        mainname=${filename%.*}
        typename=${filename##*.}
        case $typename in 
        "tex")
            echo "Compile!"
            echo $mainname
            latex ${filename}
            dviname=${mainname}".dvi"
            dvipdf ${dviname}
            rm ${mainname}".aux"
            rm ${mainname}".dvi"
            rm ${mainname}".log"
            rm ${mainname}".nav"
            rm ${mainname}".out"
            rm ${mainname}".toc"
            rm ${mainname}".snm"
            rm ${mainname}".vrb"
            ;;
        *)
            echo ${filename} is not a *.tex file
            ;;
        esac
    done
    cd ..
done
echo latexpdf compile finished