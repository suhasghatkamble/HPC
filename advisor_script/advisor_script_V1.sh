#!/bin/bash
echo "Enter the generation name : "
read gen

echo "Enter the full path to store file : "
read store_path

echo "Enter the file name"
read file_name

echo "advisor --collect = offload --config=$gen --project-dir=./$store_path -- ./$file_name"

module load advisor/latest
advisor --collect=offload --config=$gen --project-dir=./$store_path -- ./$file_name
