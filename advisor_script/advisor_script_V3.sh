#!/bin/bash
gpu_name=("xehpg_256xve","xehpg_512xve","gen12_tgl","gen12_tg1","gen11_icl","gen9_gt2","gen9_gt3","gen9_gt4")


echo "Enter the generation name : "
read gen


found=false
for name in "${gpu_name[@]}"; do
  if [[ "$name" == "$gen" ]]; then
    found=true
    break
  fi
done

echo "Enter the full path to store file : "
read store_path

echo "Enter the file name"
read file_name


if [[ $found == true ]]; then

echo "advisor --collect=offload --config=$gen --project-dir=./$store_path -- ./$file_name"
module load advisor/latest
advisor --collect=offload --config=$gen --project-dir=./$store_path -- ./$file_name

else
  echo "The name $gen is not available."
fi

