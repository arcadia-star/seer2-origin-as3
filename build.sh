#!/bin/sh

OUT_DLL_PATH="out/Seer2CoreDLL.swc"
OUT_DLL_SWF_PATH="out/Seer2CoreDLL.swf"
PRIVATE_DLL_PATH_FILE=".private/cp_dll_path"

compc \
  -target-player 32 \
  -source-path src \
  -library-path lib/as3corelib.swc \
  -library-path lib/greensock-taomee.swc \
  -library-path lib/textLayout.swc \
  -output $OUT_DLL_PATH \
  -include-sources src \
  -warnings=false

# 提取 library.swf，添加7个零字节，然后进行 zlib 压缩
# 注意：zlib.compress 输出 zlib 格式（含头部和 Adler-32 校验）
unzip -p $OUT_DLL_PATH library.swf \
| python -c "import sys, zlib; sys.stdout.buffer.write( b'\x00'*7+zlib.compress(sys.stdin.buffer.read()))" \
> $OUT_DLL_SWF_PATH


if [ -f "$PRIVATE_DLL_PATH_FILE" ]; then
    mv $OUT_DLL_SWF_PATH $(cat "$PRIVATE_DLL_PATH_FILE" | tr -d '\n\r')
fi

