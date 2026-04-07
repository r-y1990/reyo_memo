#!/bin/bash

echo "タイトルを入力してください"
read title

hugo new post/gamemo/${title}/index.md
