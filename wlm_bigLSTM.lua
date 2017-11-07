-- Network: bigLSTM
-- Application: Word Language Modelling
-- Dataset: Google Billion Words
-- Number of parameters: 1.8 Billion
-- Reference: Exploring the limits of language modelling

-- How to interpret I/O data sizes?
-- batchsize * sequence_length * word/char_lnegth
-- A batch - sequence of words
-- A sequence consists of multiple words
-- A word, with nn.Lookup, forms an embeddeding (vector) taht is fed as input to network

torch.setdefaulttensortype('torch.FloatTensor')
require 'xlua'
require 'sys'
cmd = torch.CmdLine()
cmd:option('-gpu', 0, 'Run on CPU/GPU')
cmd:option('-threads', 2, 'Number of threads for CPU')
cmd:option('-batch', 1, 'Number of batches')
opt = cmd:parse(arg or {})
torch.setnumthreads(opt.threads)

-- Hyper-parameters
batchsize = opt.batch
seqlen = 50
hiddensize = 8192
inputsize = 8192
projsize = 1024 -- Keeping this more than hidden size gives error

-- build DNN
--[[ 1. Removed the input embedding layer and decoder layer (don't have parameters and not shown in paper as part of network)
     2. Input to bigLSTM is produced by nn.Lookup (vocabsize, hiddensize) [vocabsize = 793K words]
     3. Output layer is a unigram --]]

--[[ LSTMP cell in math
i[t] = σ(W[x->i]x[t] + W[r->i]r[t−1] + b[1->i])                      (1)
f[t] = σ(W[x->f]x[t] + W[r->f]r[t−1] + b[1->f])                      (2)
z[t] = tanh(W[x->c]x[t] + W[h->c]r[t−1] + b[1->c])                   (3)
c[t] = f[t]c[t−1] + i[t]z[t]                                         (4)
o[t] = σ(W[x->o]x[t] + W[r->o]r[t−1] + b[1->o])                      (5)
h[t] = o[t]tanh(c[t])                                                (6)
r[t] = W[h->r]h[t]                                                   (7) --]]

require 'rnn'
model = nn.Sequential()
model:add(nn.SeqLSTMP(inputsize, hiddensize, projsize)) -- LSTM with a projection layer
model:add(nn.SeqLSTMP(projsize, hiddensize, projsize)) -- LSTM with a projection layer

-- Note ML papers will count parameters as num_params*2 (weight + gradweight, gradweight is null for inference)
num_param = 4 * ((inputsize+1)*hiddensize + hiddensize^2) + hiddensize*projsize +
            4 * ((projsize+1)*hiddensize + hiddensize^2) + hiddensize*projsize
print ('Number of parameters', num_param)
print (model)

-- create input and output sequences
input = torch.Tensor(seqlen, batchsize, inputsize)
output = torch.zeros(seqlen, batchsize, projsize)

-- dnn inference model
local run_dnn = function()
  print('==> Type is '..input:type())
  -- forward sequence through language-model
  for step=1,seqlen do
    output[{{step}, {}, {}}] = model:forward(input[{{step},{},{}}])
  end
end

-- for running on GPU/CPU
if (opt.gpu == 1) then -- GPU run
  require 'cunn'
  model = model:cuda() -- move the model, i/o data to gpu memory
  input = input:cuda()
  output = output:cuda()
  cmdstring="nvidia-smi -i 0 --query-gpu=power.limit,power.draw,utilization.gpu,utilization.memory,memory.total,memory.used,memory.free --format=csv,nounits --loop-ms=500> ./wlm_bigLSTM_gpulog_batchsize_%d.txt &"% (batchsize)
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
