#!/bin/sh
echo "***Alexnet Benchmarking***"
echo "Usage ./run_gpu_alexnet_iter_test.sh <typeofgpu> --> e.g: ./run_gpu_alexnet_iter_test.sh geforce_gtx_maxwell"
#batch size 1
echo "**batch size 1**"
th alexnet_iter_test.lua -gpu 1 -batch 1 -gpusample 10 -gputype $1 -iter $2
#batch size 16
echo "**batch size 16**"
th alexnet_iter_test.lua -gpu 1 -batch 16 -gpusample 10 -gputype $1 -iter $2
#batch size 32
echo "**batch size 32**"
th alexnet_iter_test.lua -gpu 1 -batch 32 -gpusample 10 -gputype $1 -iter $2
#batch size 64
echo "**batch size 64**"
th alexnet_iter_test.lua -gpu 1 -batch 64 -gpusample 10 -gputype $1 -iter $2
#batch size 128
echo "**batch size 128**"
th alexnet_iter_test.lua -gpu 1 -batch 128 -gpusample 10 -gputype $1 -iter $2
#batch size 256
echo "**batch size 256**"
th alexnet_iter_test.lua -gpu 1 -batch 256 -gpusample 10 -gputype $1 -iter $2
#batch size 512
echo "**batch size 512**"
th alexnet_iter_test.lua -gpu 1 -batch 512 -gpusample 10 -gputype $1 -iter $2
#batch size 1024
echo "**batch size 1024**"
th alexnet_iter_test.lua -gpu 1 -batch 1024 -gpusample 10 -gputype $1 -iter $2
#batch size 2048
echo "**batch size 2048**"
th alexnet_iter_test.lua -gpu 1 -batch 2048 -gpusample 10 -gputype $1 -iter $2










