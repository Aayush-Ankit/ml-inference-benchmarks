#!/bin/sh
echo "***wlm_bigLSTM_iter_test Benchmarking***"
echo "Usage ./run_gpu_wlm_bigLSTM_iter_test.sh <typeofgpu> --> e.g: ./run_gpu_wlm_bigLSTM_iter_test.sh geforce_gtx_maxwell"
#batch size 1
echo "**batch size 1**"
th wlm_bigLSTM_iter_test.lua -gpu 1 -batch 1 -gpusample 10 -gputype $1
#batch size 16
echo "**batch size 16**"
th wlm_bigLSTM_iter_test.lua -gpu 1 -batch 16 -gpusample 10 -gputype $1
#batch size 32
echo "**batch size 32**"
th wlm_bigLSTM_iter_test.lua -gpu 1 -batch 32 -gpusample 10 -gputype $1
#batch size 64
echo "**batch size 64**"
th wlm_bigLSTM_iter_test.lua -gpu 1 -batch 64 -gpusample 10 -gputype $1
#batch size 128
echo "**batch size 128**"
th wlm_bigLSTM_iter_test.lua -gpu 1 -batch 128 -gpusample 10 -gputype $1
#batch size 256
echo "**batch size 256**"
th wlm_bigLSTM_iter_test.lua -gpu 1 -batch 256 -gpusample 10 -gputype $1
#batch size 512
echo "**batch size 512**"
th wlm_bigLSTM_iter_test.lua -gpu 1 -batch 512 -gpusample 10 -gputype $1
#batch size 1024
echo "**batch size 1024**"
th wlm_bigLSTM_iter_test.lua -gpu 1 -batch 1024 -gpusample 10 -gputype $1
#batch size 2048
echo "**batch size 2048**"
th wlm_bigLSTM_iter_test.lua -gpu 1 -batch 2048 -gpusample 10 -gputype $1
#batch size 4096
echo "**batch size 3800**"
th wlm_bigLSTM_iter_test.lua -gpu 1 -batch 3800 -gpusample 10 -gputype $1
echo "**wlm_bigLSTM_iter_test can run upto 3800 for a 12GB GPU***"












