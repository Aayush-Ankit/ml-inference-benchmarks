require 'nn'
require 'rnn'


model = nn.Sequential()
model:add(nn.SpatialConvolution(1, 32, 11, 41, 2, 2))
model:add(nn.Clamp(0, 20))
model:add(nn.SpatialConvolution(32, 32, 11, 21, 2, 1))
model:add(nn.Clamp(0, 20))

inputsize_rnn = 32 * 41 -- based on the above convolutions and 16khz audio.
hiddenlayers_rnn = 7
hiddensize_rnn = 1760

model:add(nn.View(rnnInputsize, -1):setNumInputDims(3)) -- batch x features x seqLength
model:add(nn.Transpose({ 2, 3 }, { 1, 2 })) -- seqLength x batch x features

model:add(nn.SeqLSTM(inputsize_rnn, hiddensize_rnn))
for i = 1, nbOfHiddenLayers - 1 do
  model:add(nn.SeqLSTM(hiddensize_rnn, hiddensize_rnn))
end

model:add(nn.Linear(rnnHiddenSize, 29))

model:add(nn.Bottle(fullyConnected, 2))
model:add(nn.Transpose({1, 2})) -- batch x seqLength x features
