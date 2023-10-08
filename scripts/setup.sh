#!/bin/bash
set -e

# determine the platform based on the domain
LEETCODE_BASE_URL="leetcode.com"
BAEKJOON_BASE_URL="acmicpc.net"
ALGOSPOT_BASE_URL="algospot.com"

if [[ "$1" == *"$LEETCODE_BASE_URL"* ]]; then
	platform="leetcode"
	problem_id=$(echo "$1" | grep -oE 'problems/([^/]+)' | sed -e 's/problems\///' -e 's/\///')
elif [[ "$1" == *"$BAEKJOON_BASE_URL"* ]]; then
	platform="baekjoon"
	problem_id=$(echo "$1" | grep -oE 'problem/([0-9]+)' | sed -e 's/problem\///' -e 's/\///')
elif [[ "$1" == *"$ALGOSPOT_BASE_URL"* ]]; then
	platform="algospot"
	problem_id=$(echo "$1" | grep -oE 'problem/read/([^/]+)' | sed -e 's/problem\/read\///' -e 's/\///')
else
	echo "ERROR: Invalid URL"
	exit 1
fi

# create directories and files
pushd `dirname $0` > /dev/null
SCRIPT_PATH=$(pwd -P)
popd > /dev/null

dir_name="$SCRIPT_PATH/../$platform/$problem_id"
file_name="$problem_id.cpp" # TODO: add options
readme_name="README.md"
mkdir -p "$dir_name"
cp "$SCRIPT_PATH/template/sample.cpp" "$dir_name/$file_name" # TODO: add options
touch "$dir_name/$readme_name"
cat > "$dir_name/$readme_name" << EOF
# Note

EOF
echo "$platform/$problem_id is created"

# TODO: crawl input.txt from problem description
# TODO: crawl README.md from problem description
#
