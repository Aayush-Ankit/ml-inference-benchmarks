-- Network: Google MAchine Translation
-- Application: Language-Language modelling (english-french)
-- Dataset: WMT15
-- Number of parameters: 130 Million (for 5 layers)
-- Reference: Google's machine translation

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

-- dnn hyper-parameters
batchsize = opt.batch
seqlen = 50 -- sequence length
hiddensize = 1024
inputsize = 1024 -- inputsize is the length of vector produced after embedding (here would be for english language)
numlayers = 3
vocabsize = 40000 -- for decoder language (here french)

-- build dnn
require 'rnn'

--Forward coupling: Copy encoder cell and output to decoder LSTM
function forwardConnect(enc, dec)
   for i=1,#enc.lstmLayers do
      dec.lstmLayers[i].userPrevOutput = enc.lstmLayers[i].output[seqlen]
      dec.lstmLayers[i].userPrevCell = enc.lstmLayers[i].cell[seqen]
   end
end

-- Encoder
local enc_num_params = 0
local enc = nn.Sequential()
enc.lstmLayers = {}
for i=1,numlayers do
    enc.lstmLayers[i] = nn.SeqLSTM(hiddensize, hiddensize)
    enc:add(enc.lstmLayers[i])
    enc_num_params = enc_num_params + 4*((hiddensize+1)*hiddensize + hiddensize^2)
end

-- Decoder
local dec_num_params = 0
local dec = nn.Sequential()
dec.lstmLayers = {}
for i=1,numlayers do
    dec.lstmLayers[i] = nn.SeqLSTM(hiddensize, hiddensize)
    dec:add(dec.lstmLayers[i])
    dec_num_params = dec_num_params + 4*((hiddensize+1)*hiddensize + hiddensize^2)
end
dec:add(nn.Sequencer(nn.Linear(hiddensize, vocabsize), 1))
dec_num_params = dec_num_params + (hiddensize+1)*vocabsize

print ('Number of parameters', enc_num_params+dec_num_params)
print(enc)
print(dec)

-- create input and output sequences
enc_input = torch.Tensor(seqlen, batchsize, inputsize)
dec_input = torch.Tensor(seqlen, batchsize, inputsize)
output = torch.zeros(seqlen, batchsize, vocabsize)

-- dnn inference model
local run_dnn = function()
  print('==> Type is '..enc_input:type())
  -- forward sequence through machine-translation model
  for step=1,seqlen do
    enc:forward(enc_input)
    forwardConnect (enc, dec)
    output[{{step}, {}, {}}] = dec:forward(dec_input[{{step},{},{}}])
  end
end

-- for running on GPU/CPU
if (opt.gpu == 1) then -- GPU run
  require 'cunn'
  enc = enc:cuda() -- move the model, i/o data to gpu memory
  dec = dec:cuda()
  enc_input = enc_input:cuda()
  dec_input = dec_input:cuda()
  output = output:cuda()
  cmdstring="nvidia-smi -i 0 --query-gpu=power.limit,power.draw,utilization.gpu,utilization.memory,memory.total,memory.used,memory.free --format=csv,nounits --loop-ms=500> ./nmt_l3_gpulog_batchsize_%d.txt &"% (batchsize)
  os.execute(cmdstring)
  -- measure gpu time
  gputime0 = sys.clock()
  run_dnn()
  gputime1 = sys.clock()
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

