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
echo "" >> ~/summary.md
echo "## $PROJECT_NAME Summary" >> ~/summary.md
echo "" >> ~/summary.md
cat summary.md >> ~/summary.md
mv summary.json "~/${REPO_NAME}_summary.json"