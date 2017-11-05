torch.setdefaulttensortype('torch.FloatTensor')
require 'xlua'
require 'sys'
cmd = torch.CmdLine()
cmd:option('-gpu', 0, 'Run on CPU/GPU')
cmd:option('-threads', 2, 'Number of threads for CPU')
opt = cmd:parse(arg or {})
torch.setnumthreads(opt.threads)

-- DNN hyper-parameters
batchSize = 8
rho = 16 -- sequence length
hiddenSize = 1024
nIndex = 1024

-- build DNN
require 'rnn'
local r = nn.Recurrent(
   hiddenSize, nn.LookupTable(nIndex, hiddenSize),
   nn.Linear(hiddenSize, hiddenSize), nn.Sigmoid(),
   rho
)

local rnn = nn.Sequential()
   :add(r)
   :add(nn.Linear(hiddenSize, nIndex))

rnn = nn.Recursor(rnn, rho)
--print(rnn)

-- create input and output sequences
inputs = torch.ones(rho, batchSize, 1)
outputs = torch.zeros(rho, batchSize, nIndex, 1)

-- dnn inference model
local run_dnn = function()
  print('==> Type is '..inputs:type())
  -- forward sequence through rnn
  for step=1,rho do
    outputs[{{step},{},{},{}}] = rnn:forward(inputs[{{step},{},{}}]:view(batchSize))
  end
end

-- for running on GPU/CPU
if (opt.gpu == 1) then -- GPU run
  require 'cunn'
  rnn = rnn:cuda() -- move the model, i/o data to gpu memory
  inputs = inputs:cuda()
  outputs = outputs:cuda()
  -- measure gpu time
  gputime0 = sys.clock()
  run_dnn()
  gputime1 = sys.clock()
  -- run nvidia-smi for gpu power (Think about the placment of this later?)
  os.execute ('nvidia-smi -q -d POWER > ./rnnTest_gpuPow.txt')
  gputime = gputime1 - gputime0
  print('GPU Time: '.. (gputime*1000) .. 'ms')

else -- CPU run
  -- measure CPU latency
  cputime0 = sys.clock()
  run_dnn()
  cputime1 = sys.clock()
  cputime = cputime1 - cputime0
  print('CPU Time: '.. (cputime*1000) .. 'ms')
end






