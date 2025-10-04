#!/bin/sh

echo -e "\033[0;32mDang deploy len GitHub...\033[0m"

# Build trang web, neu thu muc public ton tai thi xoa di
# de dam bao moi thu duoc build moi hoan toan.
rm -rf public
hugo -D

# Di vao thu muc public
cd public

# Khoi tao Git, them remote va day code
git init
git add .
git commit -m "Rebuilding site $(date)"
git branch -M main
git remote add origin https://github.com/trannhathuy6524/trannhathuy6524.github.io.git
git push -f origin main

cd ..