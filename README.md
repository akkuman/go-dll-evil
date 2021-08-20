# 有关 dll 的 golang windows 恶意代码示例

以下均以x64作为示例，如果需要x86，将x64替换为x86即可

## 本人测试环境/依赖

为了一些后续的工作开展，我选择了linux来进行开发，而不是windows

- Ubuntu
- mingw-w64
- gcc

## 使用/尝试

首先下载项目

```shell
git clone https://github.com/akkuman/go-dll-evil
cd go-dll-evil
```

### golang dll 转发

#### 原始程序编译

1. main.cpp 生成主程序 main.exe，该程序调用 add.dll 进行加法运算

```shell
make build-main-x64
```

2. add.cpp 生成原始的 `add.dll` 和 `_add.dll`，这两个dll完全一样，`_add.dll` 主要是为了后面进行 dll 转发使用

```shell
make build-dll-x64
```

3. 将 main.exe 与刚才生成的 add.dll 拷到windows，命令行执行 main.exe，可以看到正确输出了 `result: 300`

#### 编译转发 dll

1. 将 evil.cpp 与 functions.def 一起编译，生成转发 dll（转发至 _add.dll）

```shell
make build-build-evil-x64
```

2. 将 _add.dll 与刚才生成的 add.dll 拷入刚才的windows目录下，执行 main.exe，可以看到正确输出了 `result: 300`，转发成功

#### 借助 Golang 编译转发 dll

1. 将 def 与 go 一起编译，生成转发 dll（转发至 _add.dll）

```shell
make build-goevil-x64
```

2. 将 _add.dll 与刚才生成的 add.dll 拷入刚才的windows目录下，执行 main.exe，可以看到正确输出了 `result: 300`，转发成功

### golang dll 转发 + 恶意 dllmain

1. 进入目录 dllmain

```shell
cd dllmain
```

2. 将 c 和 go 一起编译，链接时带上 def，生成恶意转发 dll（转发至 _add.dll）

```shell
make build-evil-x64
```

2. 将 _add.dll 与刚才生成的 add.dll 拷入刚才的windows目录下，执行 main.exe，可以看到正确输出了 `result: 300`，转发成功，同时出现了我们插入的恶意对话框示例

## 参考资料

- [golang dllmain](https://github.com/NaniteFactory/dllmain)