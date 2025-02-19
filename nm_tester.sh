#!/bin/bash

rm -rf ko_files diffs
mkdir -p nm_outputs ft_nm_outputs diffs ko_files

cd ../
make

GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"
ORANGE="\e[33m"
testfiles_dir="nm_tester/testfiles"
ko_files_dir="nm_tester/ko_files"
diffs_dir="nm_tester/diffs"
nm_outputs_dir="nm_tester/nm_outputs"
ft_nm_outputs_dir="nm_tester/ft_nm_outputs"

for file in ${testfiles_dir}/mytest/*; do
    base_name=$(basename "$file")

    nm "$file" > "${nm_outputs_dir}/${base_name}" 2> "${nm_outputs_dir}/${base_name}"

    ./ft_nm "$file" > "${ft_nm_outputs_dir}/${base_name}" 2> "${ft_nm_outputs_dir}/${base_name}"

    diff "${nm_outputs_dir}/${base_name}" "${ft_nm_outputs_dir}/${base_name}" > "${diffs_dir}/${base_name}.diff"
	if [ -s "${diffs_dir}/${base_name}.diff" ]; then
		mv "${diffs_dir}/${base_name}.diff" "${ko_files_dir}/${base_name}.diff"
		echo -e "${RED}[KO]${RESET} : $base_name (dir:mytest)"
		echo -n -e "${ORANGE}Expected:${RESET}"
		cat "${nm_outputs_dir}/${base_name}" | head -n 5
		echo -e "${ORANGE}see ${diffs_dir}/${base_name}.diff for info.${RESET}"
	else
		echo -e "${GREEN}[OK]${RESET} : $base_name (dir:mytest)"
	fi

done

for file in ${testfiles_dir}/mandatory/*; do
    base_name=$(basename "$file")

    nm "$file" > "${nm_outputs_dir}/${base_name}" 2> "${nm_outputs_dir}/${base_name}"

    ./ft_nm "$file" > "${ft_nm_outputs_dir}/${base_name}" 2> "${ft_nm_outputs_dir}/${base_name}"

    diff "${nm_outputs_dir}/${base_name}" "${ft_nm_outputs_dir}/${base_name}" > "${diffs_dir}/${base_name}.diff"
	if [ -s "${diffs_dir}/${base_name}.diff" ]; then
		mv "${diffs_dir}/${base_name}.diff" "ko_files/${base_name}.diff"
		echo -e "${RED}[KO]${RESET} : $base_name (dir:mandatory)"
		echo -n -e "${ORANGE}Expected:${RESET}"
		cat "${nm_outputs_dir}/${base_name}" | head -n 5
		echo -e "${ORANGE}see ${diffs_dir}/${base_name}.diff for info.${RESET}"
	else
		echo -e "${GREEN}[OK]${RESET} : $base_name (dir:mandatory)"
	fi

done


for file in ${testfiles_dir}/test_bad_file/*; do
    base_name=$(basename "$file")

    nm "$file" > "${nm_outputs_dir}/${base_name}" 2> "${nm_outputs_dir}/${base_name}"

    ./ft_nm "$file" > "${ft_nm_outputs_dir}/${base_name}" 2> "${ft_nm_outputs_dir}/${base_name}"

    diff "${nm_outputs_dir}/${base_name}" "${ft_nm_outputs_dir}/${base_name}" > "${diffs_dir}/${base_name}.diff"
	if [ -s "${diffs_dir}/${base_name}.diff" ]; then
		mv "${diffs_dir}/${base_name}.diff" "ko_files/${base_name}.diff"
		echo -e "${RED}[KO]${RESET} : $base_name (dir:test_bad_file)"
		echo -n -e "${ORANGE}Expected:${RESET}"
		cat "${nm_outputs_dir}/${base_name}" | head -n 5
		echo -e "${ORANGE}see ${diffs_dir}/${base_name}.diff for info.${RESET}"
	else
		echo -e "${GREEN}[OK]${RESET} : $base_name (dir:test_bad_file)"
	fi

done


for file in ${testfiles_dir}/good_files/*; do
    base_name=$(basename "$file")

    nm "$file" > "${nm_outputs_dir}/${base_name}" 2> "${nm_outputs_dir}/${base_name}"

    ./ft_nm "$file" > "${ft_nm_outputs_dir}/${base_name}" 2> "${ft_nm_outputs_dir}/${base_name}"

    diff "${nm_outputs_dir}/${base_name}" "${ft_nm_outputs_dir}/${base_name}" > "${diffs_dir}/${base_name}.diff"
	if [ -s "${diffs_dir}/${base_name}.diff" ]; then
		mv "${diffs_dir}/${base_name}.diff" "ko_files/${base_name}.diff"
		echo -e "${RED}[KO]${RESET} : $base_name (dir:good_files)"
		echo -n -e "${ORANGE}Expected:${RESET}"
		cat "${nm_outputs_dir}/${base_name}" | head -n 5
		echo -e "${ORANGE}see ${diffs_dir}/${base_name}.diff for info.${RESET}"
	else
		echo -e "${GREEN}[OK]${RESET} : $base_name (dir:good_files)"
	fi

done

for file in ${testfiles_dir}/bad_files/*; do
    base_name=$(basename "$file")

    nm "$file" > "${nm_outputs_dir}/${base_name}" 2> "${nm_outputs_dir}/${base_name}"

    ./ft_nm "$file" > "${ft_nm_outputs_dir}/${base_name}" 2> "${ft_nm_outputs_dir}/${base_name}"

    diff "${nm_outputs_dir}/${base_name}" "${ft_nm_outputs_dir}/${base_name}" > "${diffs_dir}/${base_name}.diff"
	if [ -s "${diffs_dir}/${base_name}.diff" ]; then
		mv "${diffs_dir}/${base_name}.diff" "ko_files/${base_name}.diff"
		echo -e "${RED}[KO]${RESET} : $base_name (dir:bad_files)"
		echo -n -e "${ORANGE}Expected:${RESET}"
		cat "${nm_outputs_dir}/${base_name}" | head -n 1
		echo -e "${ORANGE}see ${diffs_dir}/${base_name}.diff for info.${RESET}"
	else
		echo -e "${GREEN}[OK]${RESET} : $base_name (dir:bad_files)"
	fi

done

rm -rf ${nm_outputs_dir} ${ft_nm_outputs_dir}
