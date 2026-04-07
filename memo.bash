#!/bin/bash

echo "タイトルを入力してください"
read title

hugo new post/memo/${title}/index.md
