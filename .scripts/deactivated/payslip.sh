#!/bin/bash 






full_path="$HOME/Documents/payslip"
path=$( ls -d $HOME/Documents/payslip/*/*)


for p in $path ; do

year=$(echo $p | awk -F / '{print $6}')
month=$( echo $p | awk -F / '{print $NF}' )

cd $full_path/$year/$month


check_pdf=$(ls $full_path/$year/$month | grep pdf)
check_gpg=$(ls $full_path/$year/$month | grep gpg)
zip_file=$(ls $full_path/$year/$month | grep zip )

[ -z "$check_pdf" ] && unzip "$full_path/$year/$month/$zip_file" 

pdf_file=$(ls $full_path/$year/$month | grep pdf )

rm  "$full_path/$year/$month/$zip_file" 2> /dev/null

mv  "$full_path/$year/$month/$pdf_file" "$full_path/$year/$month/$month.pdf" 2> /dev/null

[ -z $check_gpg ] && gpg2 --encrypt -r karlfredin@gmail.com "$full_path/$year/$month/$month.pdf"

[ -z $check_gpg ] || rm "$full_path/$year/$month/$month.pdf"

done



















































