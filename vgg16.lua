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

model = nn.Sequential()
model:add(nn.SpatialConvolution(3, 64, 3, 3, 1, 1, 1, 1, 1))
model:add(nn.ReLU(true))
model:add(nn.SpatialConvolution(64, 64, 3, 3, 1, 1, 1, 1, 1))
model:add(nn.ReLU(true))
model:add(nn.SpatialMaxPooling(2, 2, 2, 2)
model:add(nn.SpatialConvolution(64, 128, 3, 3, 1, 1, 1, 1, 1))
model:add(nn.ReLU(true))
model:add(nn.SpatialConvolution(128, 128, 3, 3, 1, 1, 1, 1, 1))
model:add(nn.ReLU(true))
model:add(nn.SpatialMaxPooling(2, 2, 2, 2)
model:add(nn.SpatialConvolution(128, 256, 3, 3, 1, 1, 1, 1, 1))
model:add(nn.ReLU(true))
model:add(nn.SpatialConvolution(256, 256, 3, 3, 1, 1, 1, 1, 1))
model:add(nn.ReLU(true))
model:add(nn.SpatialConvolution(256, 256, 3, 3, 1, 1, 1, 1, 1))
model:add(nn.ReLU(true))
model:add(nn.SpatialMaxPooling(2, 2, 2, 2)
model:add(nn.SpatialConvolution(256, 512, 3, 3, 1, 1, 1, 1, 1))
model:add(nn.ReLU(true))
model:add(nn.SpatialConvolution(512, 512, 3, 3, 1, 1, 1, 1, 1))
model:add(nn.ReLU(true))
model:add(nn.SpatialConvolution(512, 512, 3, 3, 1, 1, 1, 1, 1))
model:add(nn.ReLU(true))
model:add(nn.SpatialMaxPooling(2, 2, 2, 2)
model:add(nn.SpatialConvolution(512, 512, 3, 3, 1, 1, 1, 1, 1))
model:add(nn.ReLU(true))
model:add(nn.SpatialConvolution(512, 512, 3, 3, 1, 1, 1, 1, 1))
model:add(nn.ReLU(true))
model:add(nn.SpatialConvolution(512, 512, 3, 3, 1, 1, 1, 1, 1))
model:add(nn.ReLU(true))
model:add(nn.SpatialMaxPooling(2, 2, 2, 2)
model:add(nn.View(-1):setNumInputDims(3))
model:add(nn.Linear(25088, 4096))
model:add(nn.ReLU(true))
model:add(nn.Linear(4096, 4096))
model:add(nn.ReLU(true))
model:add(nn.Linear(4096, outputsize))

num_params_fb1 = 3*48*(11^2) + 48*128*(5*5) + 128*192*(3^2) + 192*192*(3^3) +
                  192*128*(3^2)
num_params_classifier =  256*6*6*4096 + 4096*4096 + 4096*1000
num_params = 2*num_params_fb1 + num_params_classifier

print (model)
print (num_params)

