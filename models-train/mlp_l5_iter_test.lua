-- Network: Multi-layer perceptron w/ 5 layers
-- Application: Object Detection
-- Dataset: CIFAR10
-- Number of parameters: 20 million
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
cmd:option('-iter','100','Number of Iterations to run the test')
opt = cmd:parse(arg or {})
torch.setnumthreads(opt.threads)

-- dnn hyper-parameters
batchsize = opt.batch
inputsize = 1024
hiddensize = {2048, 3072, 3072, 1024}
outputsize = 10
gpusample = opt.gpusample
gputype = opt.gputype
iter = opt.iter
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
model:add(nn.Linear(hiddensize[3], hiddensize[4]))
model:add(nn.Sigmoid())
model:add(nn.Linear(hiddensize[4], outputsize))
num_params = num_params + (inputsize+1)*hiddensize[1] +
              (hiddensize[1]+1)*hiddensize[2] + (hiddensize[2]+1)*hiddensize[3] +
              (hiddensize[4]+1)*outputsize + (hiddensize[3]+1)*hiddensize[4]

--print (model)
--print (num_params)

-- create input and output tensors
input = torch.Tensor(batchsize, inputsize)
output = torch.zeros(batchsize, outputsize)

-- dnn inference model
local run_dnn = function()
--  print('==> Type is '..input:type())
    output = model:forward(input)
end

-- for running on GPU/CPU
if (opt.gpu == 1) then -- GPU run
  require 'cunn'
  model = model:cuda() -- move the model, i/o data to gpu memory
  input = input:cuda()
  output = output:cuda()
  print '****GPU Data (iter,time)****'
  cmdstring1="nvidia-smi -i 0 --query-gpu=power.limit,power.draw,utilization.gpu,utilization.memory,memory.total,memory.used,memory.free --format=csv,nounits --loop-ms=%d >" %(gpusample)
  cmdstring2=" gpu_profile_data/mlp_l5_gpulog_batchsize_%d" %(batchsize)
  cmdstring3="_sample_ms_%d" %(gpusample)
  cmdstring4="_%s.txt &" %(gputype)
  cmdstring=cmdstring1 .. cmdstring2 .. cmdstring3 .. cmdstring4
  os.execute(cmdstring)
  -- measure gpu time
  for i =1,iter do
	  gputime0 = sys.clock()
	  run_dnn()
	  gputime1 = sys.clock()
	  gputime = gputime1 - gputime0
	  print(i .. ' ' .. (gputime*1000) .. ' ms')
  end
  os.execute('kill -9 `pidof nvidia-smi`')
else -- CPU run
  -- measure CPU latency
  print '****CPU Data****'
  for i=1,iter do
	  cputime0 = sys.clock()
	  run_dnn()
	  cputime1 = sys.clock()
	  cputime = cputime1 - cputime0
	  print((cputime*1000) .. ' ms')
  end
end
