# puerts for lua

## build

``` bash
mkdir build
cd build
cmake ..
cmake --build . --config Release
```

## run hello.lua

``` bash
git clone https://github.com/puerts/puerts_hello_addon.git
cd puerts_hello_addon/
mkdir build
cd build/
cmake ..
cmake --build . --config Release
cd ..
lua hello.lua
```
