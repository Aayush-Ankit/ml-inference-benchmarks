#!/bin/sh
echo "***vgg19_iter_test Benchmarking***"
echo "Usage ./run_gpu_vgg19_iter_test.sh <typeofgpu> <number of iterations>--> e.g: ./run_gpu_vgg19_iter_test.sh geforce_gtx_maxwell 100"
#batch size 1
echo "**batch size 1**"
th vgg19_iter_test.lua -gpu 1 -batch 1 -gpusample 10 -gputype $1 -iter $2
#batch size 16
echo "**batch size 16**"
th vgg19_iter_test.lua -gpu 1 -batch 16 -gpusample 10 -gputype $1 -iter $2
#batch size 32
echo "**batch size 32**"
th vgg19_iter_test.lua -gpu 1 -batch 32 -gpusample 10 -gputype $1 -iter $2
#batch size 64
echo "**batch size 64**"
th vgg19_iter_test.lua -gpu 1 -batch 64 -gpusample 10 -gputype $1 -iter $2
#batch size 128
echo "**batch size 128**"
th vgg19_iter_test.lua -gpu 1 -batch 128 -gpusample 10 -gputype $1 -iter $2
echo "**vgg19_iter_test large batch size between 128 to 150 is the maximum for 12GB GPU***"












