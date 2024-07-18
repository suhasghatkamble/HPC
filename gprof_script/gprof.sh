#!/bin/bash

echo "Enter file path"
read filePath

if [ "${filePath##*.}" == "c" ]; then
    if gcc -pg "$filePath" -o "output"; then
        ./output
        executable_file="output"
        gprof $executable_file gmon.out > "analysis.txt"
    else
        echo "Compilation failed."
    fi

elif [ "${filePath##*.}" == "cpp" ]; then
    if g++ "$filePath" -o "output"; then
        ./output
        executable_file="output"
        gprof $executable_file ./"gmon.out" > "analysis.txt"
    else
        echo "Compilation failed."
    fi

else
    echo "The file is not a C or C++ source file."
fi

cat "analysis.txt"