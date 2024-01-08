cd ../../megasource/libs/lua-5.1.5

cmake -B out -G "Visual Studio 16 2019"

cmake --build out

cd ../../../mapf-sandbox/01

cmake -B out -G "Visual Studio 16 2019"

cmake --build out

love .