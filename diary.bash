#!/bin/bash

echo "タイトルを入力してください"
read title

hugo new -k diary post/diary/${title}/index.md
