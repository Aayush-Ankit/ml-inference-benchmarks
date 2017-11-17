#!/bin/sh
echo "***mlp_l5_iter_test Benchmarking***"
echo "Usage ./run_gpu_mlp_l5_iter_test.sh <typeofgpu> --> e.g: ./run_gpu_mlp_l5_iter_test.sh geforce_gtx_maxwell"
#batch size 1
echo "**batch size 1**"
th mlp_l5_iter_test.lua -gpu 1 -batch 1 -gpusample 10 -gputype $1 -iter $2
#batch size 16
echo "**batch size 16**"
th mlp_l5_iter_test.lua -gpu 1 -batch 16 -gpusample 10 -gputype $1 -iter $2
#batch size 32
echo "**batch size 32**"
th mlp_l5_iter_test.lua -gpu 1 -batch 32 -gpusample 10 -gputype $1 -iter $2
#batch size 64
echo "**batch size 64**"
th mlp_l5_iter_test.lua -gpu 1 -batch 64 -gpusample 10 -gputype $1 -iter $2
#batch size 128
echo "**batch size 128**"
th mlp_l5_iter_test.lua -gpu 1 -batch 128 -gpusample 10 -gputype $1 -iter $2
#batch size 256
echo "**batch size 256**"
th mlp_l5_iter_test.lua -gpu 1 -batch 256 -gpusample 10 -gputype $1 -iter $2
#batch size 512
echo "**batch size 512**"
th mlp_l5_iter_test.lua -gpu 1 -batch 512 -gpusample 10 -gputype $1 -iter $2
#batch size 1024
echo "**batch size 1024**"
th mlp_l5_iter_test.lua -gpu 1 -batch 1024 -gpusample 10 -gputype $1 -iter $2
#batch size 2048
echo "**batch size 2048**"
th mlp_l5_iter_test.lua -gpu 1 -batch 2048 -gpusample 10 -gputype $1 -iter $2
#batch size 4096
echo "**batch size 4096**"
th mlp_l5_iter_test.lua -gpu 1 -batch 4096 -gpusample 10 -gputype $1 -iter $2
#batch size 8192
echo "**batch size 8192**"
th mlp_l5_iter_test.lua -gpu 1 -batch 8192 -gpusample 10 -gputype $1 -iter $2
#batch size 16384
echo "**batch size 16384**"
th mlp_l5_iter_test.lua -gpu 1 -batch 16384 -gpusample 10 -gputype $1 -iter $2
echo "**mlp_l5_iter_test can run larger batch sizes, but for now not running those***"












