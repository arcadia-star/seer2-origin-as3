## seer2-origin-as3

游戏 seer2.61.com 的核心类库

仓库分为三个主要分支

1. raw-ffdec https://github.com/arcadia-star/seer2-origin-as3/tree/raw-ffdec
    使用 ffdec 反编译后得到的代码文件，里面包含了炼金术生成的代码，较为臃肿，主要用于归档，研究加密算法
2. origin-idea https://github.com/arcadia-star/seer2-origin-as3/tree/origin-idea
    使用 ffdec-v20 反编译后，重写了炼金术相关代码、去除三方类库，仅保留了必须的代码，合并了 TaomeeCoreDLL, ClientAppDLL, ClientCoreDLL, 配合 fd 完全可以替代这三个 DLL，主要用于归档，学习 flash
3. main https://github.com/arcadia-star/seer2-origin-as3/tree/main
    基于 origin-idea 分支改造而来，主要用于改服


