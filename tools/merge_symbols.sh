#! /bin/bash
#
# Merge mach-O files in two folders as fat files.
# Argument path should not contain any white space.
#
# How to use:
# sh merge_symbols.sh <path_to_extracted_arm64e_symbols> <path_to_extracted_arm64_symbols>
#

function merge_two_symbol_folders(){
    for file in `ls $1`
    do
        if [ -d $1"/"$file ] && [ -d $2"/"$file ]
        then
            merge_two_symbol_folders $1"/"$file $2"/"$file
        else
            lipo -info $1"/"$file
            if [ $? -eq 0 ]
            then
                lipo -create $1"/"$file $2"/"$file -o $1"/"$file
                if [ $? -ne 0 ]
                then
                    echo "merge symbol error:" $1"/"$file
                fi
            fi
        fi
    done
}

# Move symbol file with much more files to left
find $1 -type f | wc -l
count1=$(($?))
find $2 -type f | wc -l
count2=$(($?))

if [ $count1 -lt $count2 ]
then
    merge_two_symbol_folders $2 $1
    echo "symbols are merged into: " $2
else
    merge_two_symbol_folders $1 $2
    echo "symbols are merged into: " $1
fi
