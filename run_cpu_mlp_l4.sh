#!/bin/sh
echo "***mlp_l4 Benchmarking***"
echo "Usage ./run_cpu_mlp_l4.sh <numberofthreads> --> e.g: ./run_cpu_mlp_l4.sh 4"
#batch size 1
echo "**batch size 1**"
th mlp_l4.lua -gpu 0 -threads $1 -batch 1
#batch size 16
echo "**batch size 16**"
th mlp_l4.lua -gpu 0 -threads $1 -batch 16
#batch size 32
echo "**batch size 32**"
th mlp_l4.lua -gpu 0 -threads $1 -batch 32
#batch size 64
echo "**batch size 64**"
th mlp_l4.lua -gpu 0 -threads $1 -batch 64
#batch size 128
echo "**batch size 128**"
th mlp_l4.lua -gpu 0 -threads $1 -batch 128
#batch size 256
echo "**batch size 256**"
th mlp_l4.lua -gpu 0 -threads $1 -batch 256
#batch size 512
echo "**batch size 512**"
th mlp_l4.lua -gpu 0 -threads $1 -batch 512
#batch size 1024
echo "**batch size 1024**"
th mlp_l4.lua -gpu 0 -threads $1 -batch 1024
#batch size 2048
echo "**batch size 2048**"
th mlp_l4.lua -gpu 0 -threads $1 -batch 2048
#batch size 4096
echo "**batch size 4096**"
th mlp_l4.lua -gpu 0 -threads $1 -batch 4096
#batch size 8192
echo "**batch size 8192**"
th mlp_l4.lua -gpu 0 -threads $1 -batch 8192
#batch size 16384
echo "**batch size 16384**"
th mlp_l4.lua -gpu 0 -threads $1 -batch 16384
#echo "**mlp_l4 can run larger batch sizes, but for now not running those***"












