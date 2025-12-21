#!/bin/bash

# Chinese Writing Kit
# 一键安装中文写作规范到你的项目

set -e

REPO_URL="https://raw.githubusercontent.com/carolyn-sun/chinese-writing-kit/main"
TARGET_DIR=".github/instructions"
TARGET_FILE="chinese-writing-kit.instructions.md"

echo "📝 Chinese Writing Kit"
echo "================================="
echo ""

# 检查是否在 git 仓库中
if [ ! -d ".git" ]; then
    echo "⚠️  警告：当前目录不是 git 仓库根目录。"
    read -p "是否继续安装？(y/N) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "已取消安装。"
        exit 1
    fi
fi

# 创建 .github 目录
if [ ! -d "$TARGET_DIR" ]; then
    echo "📁 创建 $TARGET_DIR 目录..."
    mkdir -p "$TARGET_DIR"
fi

# 检查文件是否已存在
if [ -f "$TARGET_DIR/$TARGET_FILE" ]; then
    echo "⚠️  文件已存在：$TARGET_DIR/$TARGET_FILE"
    read -p "是否覆盖？(y/N) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "已取消安装。"
        exit 1
    fi
fi

# 下载文件
echo "⬇️  正在下载 $TARGET_FILE..."
if curl -fsSL "$REPO_URL/$TARGET_FILE" -o "$TARGET_DIR/$TARGET_FILE"; then
    echo ""
    echo "✅ 安装成功！"
    echo ""
    echo "文件已保存到：$TARGET_DIR/$TARGET_FILE"
    echo ""
    echo "下一步："
    echo "  1. 提交更改：git add $TARGET_DIR/$TARGET_FILE && git commit -m 'Add Chinese Writing Kit'"
    echo "  2. 推送到远程仓库：git push"
    echo ""
    echo "GitHub Copilot 会自动读取此文件并应用中文写作规范。"
else
    echo ""
    echo "❌ 下载失败，请检查网络连接或手动下载文件。"
    exit 1
fi
