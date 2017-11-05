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
#### Yay! Setup's Done!!!


#### Running a benchmark on CPU/GPU
`th <.lua> -gpu <0/1> -threads <non-zero> -batch <non-zero>`

#### cmdline options: 
1. **gpu** > use 0 for CPU run, 1 for GPU run (default is CPU)
2. **threads** > useful for CPU runs, can increase to evaluate CPU performance (default is 1)
3. **batch** > can be varied to find the CPU, GPU numbers (inference time, power) variation

## Metrics of Interest which are printed
1. Number of parameters in the network
2. Inference time on (CPU/GPU) [NOTE: For, CPU inference time, run it twice (and use the 2nd value) to make sure the data movement cost from HDD isn't included]
3. The `<>pow.txt` file shows gpu power consumption



