#!/bin/bash

echo "Enter the generation name : "
read gen

echo "Enter the full path to store file : "
read store_path

echo "Enter the file name"
read file_name

case "$gen" in
  ("xehpg_256xve" | "xehpg_512xve" | "gen12_tgl" | "gen12_tg1" | "gen11_icl" | "gen9_gt2" | "gen9_gt3" | "gen9_gt4")
    echo "advisor --collect=offload --config=$gen --project-dir=./$store_path --./ $file_name"
    module load advisor/latest
    advisor --collect=offload --config=$gen --project-dir=./$store_path -- ./$file_name
    ;;
  *)
    echo "The name $gen is not available."
    ;;
esac