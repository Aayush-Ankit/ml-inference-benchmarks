#!/bin/sh
echo "***Alexnext Benchmarking***"
echo "Usage ./run_gpu_vgg16.sh <typeofgpu> --> e.g: ./run_gpu_vgg16.sh geforce_gtx_maxwell"
#batch size 1
echo "**batch size 1**"
th vgg16.lua -gpu 1 -batch 1 -gpusample 10 -gputype $1
#batch size 16
echo "**batch size 16**"
th vgg16.lua -gpu 1 -batch 16 -gpusample 10 -gputype $1
#batch size 32
echo "**batch size 32**"
th vgg16.lua -gpu 1 -batch 32 -gpusample 10 -gputype $1
#batch size 64
echo "**batch size 64**"
th vgg16.lua -gpu 1 -batch 64 -gpusample 10 -gputype $1
#batch size 128
echo "**batch size 128**"
th vgg16.lua -gpu 1 -batch 128 -gpusample 10 -gputype $1
echo "**vgg16 large batch size between 128 to 150 is the maximum for 12GB GPU***"












