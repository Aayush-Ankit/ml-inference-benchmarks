#!/bin/sh
echo "***wlm_anotherLSTM Benchmarking***"
echo "Usage ./run_cpu_wlm_anotherLSTM.sh <numberofthreads> --> e.g: ./run_cpu_wlm_anotherLSTM.sh 4"
#batch size 1
echo "**batch size 1**"
th wlm_anotherLSTM.lua -gpu 0 -threads $1 -batch 1
#batch size 16
echo "**batch size 16**"
th wlm_anotherLSTM.lua -gpu 0 -threads $1 -batch 16
#batch size 32
echo "**batch size 32**"
th wlm_anotherLSTM.lua -gpu 0 -threads $1 -batch 32
#batch size 64
echo "**batch size 64**"
th wlm_anotherLSTM.lua -gpu 0 -threads $1 -batch 64
#batch size 128
echo "**batch size 128**"
th wlm_anotherLSTM.lua -gpu 0 -threads $1 -batch 128
#batch size 256
echo "**batch size 256**"
th wlm_anotherLSTM.lua -gpu 0 -threads $1 -batch 256
#batch size 512
echo "**batch size 512**"
th wlm_anotherLSTM.lua -gpu 0 -threads $1 -batch 512
#batch size 1024
echo "**batch size 1024**"
th wlm_anotherLSTM.lua -gpu 0 -threads $1 -batch 1024
#batch size 2048
echo "**batch size 2048**"
th wlm_anotherLSTM.lua -gpu 0 -threads $1 -batch 2048
#batch size 4096
echo "**batch size 4096**"
th wlm_anotherLSTM.lua -gpu 0 -threads $1 -batch 4096
#echo "**wlm_anotherLSTM can run upto 4096 for a 12GB GPU***"












