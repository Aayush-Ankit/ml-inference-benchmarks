#!/bin/sh
echo "***Alexnet Benchmarking***"
echo "Usage ./run_cpu_alexnet.sh <numberofthreads>  --> e.g: ./run_cpu_alexnet.sh 4"
#batch size 1
echo "**batch size 1**"
th alexnet.lua -gpu 0 -threads $1 -batch 1
#batch size 16
echo "**batch size 16**"
th alexnet.lua -gpu 0 -threads $1 -batch 16
#batch size 32
echo "**batch size 32**"
th alexnet.lua -gpu 0 -threads $1 -batch 32
#batch size 64
echo "**batch size 64**"
th alexnet.lua -gpu 0 -threads $1 -batch 64
#batch size 128
echo "**batch size 128**"
th alexnet.lua -gpu 0 -threads $1 -batch 128
#batch size 256
echo "**batch size 256**"
th alexnet.lua -gpu 0 -threads $1 -batch 256
#batch size 512
echo "**batch size 512**"
th alexnet.lua -gpu 0 -threads $1 -batch 512
#batch size 1024
echo "**batch size 1024**"
th alexnet.lua -gpu 0 -threads $1 -batch 1024
#batch size 2048
echo "**batch size 2048**"
th alexnet.lua -gpu 0 -threads $1 -batch 2048










