#!/usr/bin/env bash

PROJECT_NAME="$1"
REPO="$2"
SOLC="$3"
shift
shift
shift

REPO_NAME=${REPO##*/}

cd ~
echo "Cloning $PROJECT_NAME from $REPO to $REPO_NAME"
git clone "$REPO"
cd "$REPO_NAME"
npm install
echo "Running run_on_hardhat on sourceroots '$@'"
run_on_hardhat . "$@" --collect_data --solc "$SOLC" --solang_parser

echo "Concatenate summary.md to ~/summary.md"
[ ! -e summary.md ] && { echo "summary.md does not exist"; exit 1; }
echo "" >> ~/summary.md
echo "## $PROJECT_NAME Summary" >> ~/summary.md
echo "" >> ~/summary.md
cat summary.md >> ~/summary.md

echo "Moving summary.json to $HOME/${REPO_NAME}_summary.json"
[ ! -e summary.json ] && { echo "summary.json does not exist"; exit 1; }
mv summary.json "$HOME/${REPO_NAME}_summary.json"