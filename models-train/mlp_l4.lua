-- Network: Multi-layer perceptron w/ 5 layers
-- Application: Object Detection
-- Dataset: CIFAR10
-- Number of parameters:
-- Reference: None

-- How to interpret I/O data sizes?
-- batchsize * input_size
-- A batch - multiple inputs

torch.setdefaulttensortype('torch.FloatTensor')
require 'xlua'
require 'sys'
cmd = torch.CmdLine()
cmd:option('-gpu', 0, 'Run on CPU/GPU')
cmd:option('-threads', 2, 'Number of threads for CPU')
cmd:option('-batch', 1, 'Number of batches')
cmd:option('-gpusample', 500, 'Sampling rate in ms')
cmd:option('-gputype','nvidia','Type of Nvidia GPU')
opt = cmd:parse(arg or {})
torch.setnumthreads(opt.threads)

-- dnn hyper-parameters
batchsize = opt.batch
inputsize = 1024
hiddensize = {1024, 2048, 1024}
outputsize = 10
gpusample = opt.gpusample
gputype = opt.gputype
-- build dnn
require 'nn'

local num_params = 0
model = nn.Sequential()
model:add(nn.Linear(inputsize, hiddensize[1]))
model:add(nn.Sigmoid())
model:add(nn.Linear(hiddensize[1], hiddensize[2]))
model:add(nn.Sigmoid())
model:add(nn.Linear(hiddensize[2], hiddensize[3]))
model:add(nn.Sigmoid())
model:add(nn.Linear(hiddensize[3], outputsize))
num_params = num_params + (inputsize+1)*hiddensize[1] +
              (hiddensize[1]+1)*hiddensize[2] + (hiddensize[2]+1)*hiddensize[3] +
              (hiddensize[3]+1)*outputsize

print (model)
print (num_params)

-- create input, output and label tensors
input = torch.Tensor(batchsize, inputsize)
output = torch.zeros(batchsize, outputsize)
label = torch.zeros(batchsize, outputsize)
output = model:forward (input)

criterion = nn.MSECriterion()

-- dnn training model
local run_dnn = function()
  print('==> Type is '..input:type())
    -- forward pass
    output = model:forward(input)
    -- backward pass
    criterion:forward (output, label)
    model:backward(input, criterion:backward(mlp.output, output))
    -- weight update
    model:updateParameters(0.01)
end

-- for running on GPU/CPU
if (opt.gpu == 1) then -- GPU run
  require 'cunn'
  model = model:cuda() -- move the model, i/o data to gpu memory
  input = input:cuda()
  output = output:cuda()
  criterion = criterion:cuda()
  cmdstring1="nvidia-smi -i 0 --query-gpu=power.limit,power.draw,utilization.gpu,utilization.memory,memory.total,memory.used,memory.free --format=csv,nounits --loop-ms=%d >" %(gpusample)
  cmdstring2=" gpu_profile_data/mlp_l4_gpulog_batchsize_%d" %(batchsize)
  cmdstring3="_sample_ms_%d" %(gpusample)
  cmdstring4="_%s.txt &" %(gputype)
  cmdstring=cmdstring1 .. cmdstring2 .. cmdstring3 .. cmdstring4
  os.execute(cmdstring)
  -- measure gpu time
  gputime0 = sys.clock()
  run_dnn()
  gputime1 = sys.clock()
  -- run nvidia-smi for gpu power (Think about the placment of this later?)
  gputime = gputime1 - gputime0
  print('GPU Time: '.. (gputime*1000) .. 'ms')
  os.execute('kill -9 `pidof nvidia-smi`')
else -- CPU run
  -- measure CPU latency
  cputime0 = sys.clock()
  run_dnn()
  cputime1 = sys.clock()
  cputime = cputime1 - cputime0
  print('CPU Time: '.. (cputime*1000) .. 'ms')
end
