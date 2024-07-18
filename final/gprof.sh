#!/bin/bash


echo "Enter file ABSOLUTE path"
read filePath

if [ "${filePath##*.}" == "c" ]; then
    if gcc -pg "$filePath" -std=c99 -o "output"; then
        ./output
        executable_file="output"
        gprof $executable_file gmon.out > "analysis.txt"
    else
        echo "Compilation failed."
    fi

elif [ "${filePath##*.}" == "cpp" ]; then
    if g++ "$filePath" -std=c99 -o "output"; then
        ./output
        executable_file="output"
        gprof $executable_file ./"gmon.out" > "analysis.txt"
    else
        echo "Compilation failed."
    fi

else
    echo "The file is not a C or C++ source file."
fi

vim "analysis.txt"