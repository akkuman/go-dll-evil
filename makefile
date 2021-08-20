x86_path = i686-w64-mingw32
x64_path = x86_64-w64-mingw32
cc32 = $(x86_path)-gcc
cc64 = $(x64_path)-gcc
dlltool32 = /usr/$(x86_path)/bin/dlltool
dlltool64 = /usr/$(x64_path)/bin/dlltool


mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(dir $(mkfile_path))

build-dll-x86:
	$(cc32) add.cpp -shared -o add.dll
	$(cc32) add.cpp -shared -o _add.dll
build-dll-x64:
	$(cc64) add.cpp -shared -o add.dll
	$(cc64) add.cpp -shared -o _add.dll
build-main-x86:
	$(cc32) main.cpp -o main.exe
build-main-x64:
	$(cc64) main.cpp -o main.exe
build-evil-x86:
	$(cc32) -shared -o add.dll evil.cpp functions.def
build-evil-x64:
	$(cc64) -shared -o add.dll evil.cpp functions.def

# 配置环境变量
build-goevil-x86: export CC=$(cc32)
build-goevil-x86: export GO111MODULE=off
build-goevil-x86: export CGO_ENABLED=1
build-goevil-x86: export GOOS=windows
build-goevil-x86: export GOARCH=386
build-goevil-x86:
	# export GOARCH=386
	# 从 def 生成 exp
	$(dlltool32) --input-def functions.def --output-exp functions.exp
	go build -buildmode=c-shared -o add.dll -ldflags="-extldflags=-Wl,$(current_dir)functions.exp" main.go
	echo "generate add.dll success"

# 配置环境变量
build-goevil-x64: export CC=$(cc64)
build-goevil-x64: export GO111MODULE=off
build-goevil-x64: export CGO_ENABLED=1
build-goevil-x64: export GOOS=windows
build-goevil-x64: export GOARCH=amd64
build-goevil-x64:
	# export GOARCH=amd64
	# 从 def 生成 exp
	$(dlltool64) --input-def functions.def --output-exp functions.exp
	go build -buildmode=c-shared -o add.dll -ldflags="-extldflags=-Wl,$(current_dir)functions.exp" main.go
	echo "generate add.dll success"

