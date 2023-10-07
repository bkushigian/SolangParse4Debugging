#!/usr/bin/env bash

PROJECT_NAME="$1"
REPO="$2"
SOLC="$3"
REPO_NAME=$ echo ${REPO##*/}

cd ~
echo "Cloning $PROJECT_NAME at $REPO to $REPO_NAME"
git clone "$REPO"
cd "$REPO_NAME"
npm install
run_on_hardhat . contracts --collect_data --solc "$SOLC" --solang_parser
echo "" >> ~/summary.md
echo "## $PROJECT_NAME Summary" >> ~/summary.md
echo "" >> ~/summary.md
cat summary.md >> ~/summary.md
mv summary.json "~/${REPO_NAME}_summary.json"