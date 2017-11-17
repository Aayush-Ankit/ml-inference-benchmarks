#!/bin/sh
echo "***vgg16 Benchmarking***"
echo "Usage ./run_cpu_vgg16.sh <numberofthreads> --> e.g: ./run_cpu_vgg16.sh 4"
#batch size 1
echo "**batch size 1**"
th vgg16.lua -gpu 0 -threads $1 -batch 1
#batch size 16
echo "**batch size 16**"
th vgg16.lua -gpu 0 -threads $1 -batch 16
#batch size 32
echo "**batch size 32**"
th vgg16.lua -gpu 0 -threads $1 -batch 32
#batch size 64
echo "**batch size 64**"
th vgg16.lua -gpu 0 -threads $1 -batch 64
#batch size 128
echo "**batch size 128**"
th vgg16.lua -gpu 0 -threads $1 -batch 128
#echo "**vgg16 large batch size between 128 to 150 is the maximum for 12GB GPU***"












