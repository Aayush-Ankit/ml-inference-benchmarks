# Running the workloads

## Steps to set up dependancies
#### Rerun torch just to make sure your version's the latest one
1. `git clone git@github.com:Aayush-Ankit/isca_workloads.git`
2. `luarocks install torch`
3. `luarocks install nn`
4. `luarocks install dpnn`
5. `luarocks install torchx`
#### To use with CUDA
1. `luarocks install cutorch`
2. `luarocks install cunn`
3. `luarocks install cunnx`
#### Install RNN dependancy (allows using sequencers)
1. `cd rnn`
2. `luarocks make rocks/rnn-scm-1.rockspec`
Note: the above command may break due to proper rnn directory CMakeList cleanup. If that occurs please delete rnn and reclone the directory and run it again. 
2.a `rm rnn`
2.b `git clone git@github.com:Element-Research/rnn.git`
2.c Repeat steps 1 and 2 again
#### Yay! Setup's Done!!!


#### Running a benchmark on CPU/GPU
## Some info. about the benchmarks
1. **wlm_bigLSTM** - bigLSTM network for word-level language modelling (Google 1B dataset) 
2. **wlm_anotherLSTM** - another deep LSTM network for word-level language modelling (Google 1B dataset)
3. **nmt_l5** - Google Machine Tranalation for English-French (WMT15 dataset)
3. **nmt_l3** - Google Machine Tranalation for English-French (WMT15 dataset)

`th <.lua> -gpu <0/1> -threads <non-zero> -batch <non-zero>`

#### cmdline options: 
1. **gpu** > use 0 for CPU run, 1 for GPU run (default is CPU)
2. **threads** > useful for CPU runs, can increase to evaluate CPU performance (default is 1)
3. **batch** > can be varied to find the CPU, GPU numbers (inference time, power) variation. FOr GPU, can increase batchsize until torch throws THCudaCheck: out of memory error

## Metrics of Interest which are printed
1. Number of parameters in the network
2. Inference time on (CPU/GPU) `NOTE: For, CPU inference time, run it twice (and use the 2nd value) to make sure the data movement cost from HDD isn't included`
3. The `<>pow.txt` file shows gpu power consumption



