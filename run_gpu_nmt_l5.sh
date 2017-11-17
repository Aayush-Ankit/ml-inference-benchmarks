#!/bin/sh
echo "***nmt_l5_iter_test Benchmarking***"
echo "Usage ./run_gpu_nmt_l5_iter_test.sh <typeofgpu> --> e.g: ./run_gpu_nmt_l5_iter_test.sh geforce_gtx_maxwell"
#batch size 1
echo "**batch size 1**"
th nmt_l5_iter_test.lua -gpu 1 -batch 1 -gpusample 500 -gputype $1 -iter $2
#batch size 16
echo "**batch size 16**"
th nmt_l5_iter_test.lua -gpu 1 -batch 16 -gpusample 500 -gputype $1 -iter $2
#batch size 32
echo "**batch size 32**"
th nmt_l5_iter_test.lua -gpu 1 -batch 32 -gpusample 500 -gputype $1 -iter $2
#batch size 64
echo "**batch size 64**"
th nmt_l5_iter_test.lua -gpu 1 -batch 64 -gpusample 500 -gputype $1 -iter $2
#batch size 128
echo "**batch size 128**"
th nmt_l5_iter_test.lua -gpu 1 -batch 128 -gpusample 500 -gputype $1 -iter $2
#batch size 256
echo "**batch size 256**"
th nmt_l5_iter_test.lua -gpu 1 -batch 256 -gpusample 500 -gputype $1 -iter $2
#batch size 512
echo "**batch size 512**"
th nmt_l5_iter_test.lua -gpu 1 -batch 512 -gpusample 500 -gputype $1 -iter $2
#batch size 50024
echo "**batch size 750**"
th nmt_l5_iter_test.lua -gpu 1 -batch 750 -gpusample 500 -gputype $1 -iter $2
echo "Batch size of 750 is the largest that ran on the 12GB GPU"











