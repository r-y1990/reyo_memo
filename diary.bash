#!/bin/bash

echo "タイトルを入力してください"
read title

hugo new post/diary/${title}/index.md
