#!/bin/sh
echo "***nmt_l5 Benchmarking***"
echo "Usage ./run_cpu_nmt_l5.sh <numberofthreads> --> e.g: ./run_cpu_nmt_l5.sh 4"
#batch size 1
echo "**batch size 1**"
th nmt_l5.lua -gpu 0 -threads $1 -batch 1
#batch size 16
echo "**batch size 16**"
th nmt_l5.lua -gpu 0 -threads $1 -batch 16
#batch size 32
echo "**batch size 32**"
th nmt_l5.lua -gpu 0 -threads $1 -batch 32
#batch size 64
echo "**batch size 64**"
th nmt_l5.lua -gpu 0 -threads $1 -batch 64
#batch size 128
echo "**batch size 128**"
th nmt_l5.lua -gpu 0 -threads $1 -batch 128
#batch size 256
echo "**batch size 256**"
th nmt_l5.lua -gpu 0 -threads $1 -batch 256
#batch size 512
echo "**batch size 512**"
th nmt_l5.lua -gpu 0 -threads $1 -batch 512
#batch size 50024
echo "**batch size 750**"
th nmt_l5.lua -gpu 0 -threads $1 -batch 750
#echo "Batch size of 750 is the largest that ran on the 12GB GPU"











