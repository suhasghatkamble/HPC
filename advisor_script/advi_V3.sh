#!/bin/bash

while true; do
  echo "Enter the generation name : "
  read gen

  case "$gen" in
    ("xehpg_256xve" | "xehpg_512xve" | "gen12_tgl" | "gen12_tg1" | "gen11_icl" | "gen9_gt2" | "gen9_gt3" | "gen9_gt4")
      break
      ;;
    *)
      echo "The name $gen is not available. Please try again."
      ;;
  esac
done

echo "Enter the full path to store file : "
read store_path

echo "Enter the file name"
read file_name

echo "advisor --collect=offload --config=$gen --project-dir=./$store_path -- ./$file_name"
module load advisor/latest
advisor --collect=offload --config=$gen --project-dir=./$store_path -- ./$file_name