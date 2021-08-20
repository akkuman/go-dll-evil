x86_path = i686-w64-mingw32
x64_path = x86_64-w64-mingw32
cc32 = $(x86_path)-gcc
cc64 = $(x64_path)-gcc
dlltool32 = /usr/$(x86_path)/bin/dlltool
dlltool64 = /usr/$(x64_path)/bin/dlltool


mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(dir $(mkfile_path))

# 配置环境变量
build-evil-x86: export CC=$(cc32)
build-evil-x86: export GO111MODULE=off
build-evil-x86: export CGO_ENABLED=1
build-evil-x86: export GOOS=windows
build-evil-x86: export GOARCH=386
build-evil-x86:
	# export GOARCH=386
	# 从 def 生成 exp
	$(dlltool32) --input-def functions.def --output-exp functions.exp
	go build -buildmode=c-shared -o add.dll -ldflags="-extldflags=-Wl,$(current_dir)functions.exp"
	echo "generate add.dll success"

# 配置环境变量
build-evil-x64: export CC=$(cc64)
build-evil-x64: export GO111MODULE=off
build-evil-x64: export CGO_ENABLED=1
build-evil-x64: export GOOS=windows
build-evil-x64: export GOARCH=amd64
build-evil-x64:
	# export GOARCH=amd64
	# 从 def 生成 exp
	$(dlltool64) --input-def functions.def --output-exp functions.exp
	go build -buildmode=c-shared -o add.dll -ldflags="-extldflags=-Wl,$(current_dir)functions.exp"
	echo "generate add.dll success"
