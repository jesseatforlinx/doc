#!/usr/bin/env bash
set -e

if [[ -z "$CHANGED_FILES" ]]; then
    echo "未检测到 md 或 image 变化, 不生成PDF。"
    exit 0
fi

# 保存需要构建的目录集合（避免重复构建）
declare -A build_dirs

# 遍历变更的文件，找到对应的文档目录
while IFS= read -r file; do
    [[ -z "$file" ]] && continue

    # 向上查找，直到找到 conf.py
    dir=$(dirname "$file")
    while [[ "$dir" != "." && "$dir" != "/" ]]; do
        if [[ -f "$dir/conf.py" ]]; then
            build_dirs["$dir"]=1
            break
        fi
        dir=$(dirname "$dir")
    done
done <<< "$CHANGED_FILES"

# 构建所有找到的目录
for dir in "${!build_dirs[@]}"; do
    echo "Building PDF for $dir"
    outdir="docs_build/${dir#platform/}"

    rm -rf "$dir/_build/latex"
    sphinx-build -M latexpdf "$dir" "$dir/_build"

    mkdir -p "$outdir/_static"
    cp "$dir/_build/latex"/*.pdf "$outdir/_static/"
    echo "PDF copied to $outdir/_static"
done
