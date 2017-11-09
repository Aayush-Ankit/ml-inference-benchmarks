-- Network: COnvolutional Neural Network
-- Application: Object Detection
-- Dataset: Imagenet
-- Number of parameters:
-- Reference: Google search

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
opt = cmd:parse(arg or {})
torch.setnumthreads(opt.threads)

-- dnn hyper-parameters
batchsize = opt.batch
num_inDim = 3
inputsize = 224
outputsize = 1000

-- build dnn
require 'nn'
local num_params = 0

-- create feature layers (2 || branches)
features = nn.Concat(2)
fb1 = nn.Sequential() -- branch 1
fb1:add(nn.SpatialConvolution(3,48,11,11,4,4,2,2))       -- 224 -> 55
fb1:add(nn.ReLU(true))
fb1:add(nn.SpatialMaxPooling(3,3,2,2))                   -- 55 ->  27
fb1:add(nn.SpatialConvolution(48,128,5,5,1,1,2,2))       --  27 -> 27
fb1:add(nn.ReLU(true))
fb1:add(nn.SpatialMaxPooling(3,3,2,2))                   --  27 ->  13
fb1:add(nn.SpatialConvolution(128,192,3,3,1,1,1,1))      --  13 ->  13
fb1:add(nn.ReLU(true))
fb1:add(nn.SpatialConvolution(192,192,3,3,1,1,1,1))      --  13 ->  13
fb1:add(nn.ReLU(true))
fb1:add(nn.SpatialConvolution(192,128,3,3,1,1,1,1))      --  13 ->  13
fb1:add(nn.ReLU(true))
fb1:add(nn.SpatialMaxPooling(3,3,2,2))                   -- 13 -> 6

fb2 = fb1:clone() -- branch 2

features:add(fb1)
features:add(fb2)

-- create Classifier (fully connected layers)
classifier = nn.Sequential()
classifier:add(nn.View(256*6*6))
classifier:add(nn.Linear(256*6*6, 4096))
classifier:add(nn.ReLU())
classifier:add(nn.Linear(4096, 4096))
classifier:add(nn.ReLU())
classifier:add(nn.Linear(4096, outputsize))
classifier:add(nn.LogSoftMax())

-- augment classifier to feature
model = nn.Sequential():add(features):add(classifier)

num_params_fb1 = 3*48*(11^2) + 48*128*(5^2) + 128*192*(3^2) + 192*192*(3^2) +
                  192*128*(3^2)
num_params_classifier =  256*6*6*4096 + 4096*4096 + 4096*1000
num_params = 2*num_params_fb1 + num_params_classifier

print (model)
print (num_params)

-- create input and output tensors
input = torch.Tensor(batchsize, num_inDim, inputsize, inputsize)
output = torch.Tensor(batchsize, outputsize)

-- dnn inference model
local run_dnn = function()
    print('==> Type is '..input:type())
    output = model:forward(input)
end

-- for running on GPU/CPU
if (opt.gpu == 1) then -- GPU run
  require 'cunn'
  model = model:cuda() -- move the model, i/o data to gpu memory
  input = input:cuda()
  output = output:cuda()
  cmdstring="nvidia-smi -i 0 --query-gpu=power.limit,power.draw,utilization.gpu,utilization.memory,memory.total,memory.used,memory.free --format=csv,nounits --loop-ms=500> ./nmt_l3_gpulog_batchsize_%d.txt &"% (batchsize)
  os.execute(cmdstring)
  -- measure gpu time
  gputime0 = sys.clock()
  run_dnn()
  gputime1 = sys.clock()
  -- run nvidia-smi for gpu power (Think about the placment of this later?)
  os.execute ('nvidia-smi -q -d POWER > ./rnnTest_gpuPow.txt')
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
