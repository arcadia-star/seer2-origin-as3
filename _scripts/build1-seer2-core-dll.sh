ZIP_FILE="../out/Seer2CoreDLL.swc"
OUTPUT_FILE="../out/Seer2CoreDLL.swf"

# 提取 library.swf，添加7个零字节，然后进行 zlib 压缩
# 注意：zlib.compress 输出 zlib 格式（含头部和 Adler-32 校验）
{
    printf \x00\x00\x00\x00\x00\x00\x00
    unzip -p $ZIP_FILE library.swf | python -c "import sys, zlib; sys.stdout.buffer.write(zlib.compress(sys.stdin.buffer.read()))"
} > $OUTPUT_FILE
