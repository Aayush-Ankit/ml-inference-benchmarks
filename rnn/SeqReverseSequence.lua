------------------------------------------------------------------------
--[[ SeqReverseSequence ]] --
-- Reverses a sequence on a given dimension.
-- Example: Given a tensor of torch.Tensor({{1,2,3,4,5}, {6,7,8,9,10}})
-- nn.SeqReverseSequence(1):forward(tensor) would give: torch.Tensor({{6,7,8,9,10},{1,2,3,4,5}})
------------------------------------------------------------------------
local SeqReverseSequence, parent = torch.class("nn.SeqReverseSequence", "nn.Module")

function SeqReverseSequence:__init(dim)
    parent.__init(self)
    self.output = torch.Tensor()
    self.gradInput = torch.Tensor()
    assert(dim, "Must specify dimension to reverse sequence over")
    assert(dim <= 3, "Dimension has to be no greater than 3 (Only supports up to a 3D Tensor).")
    self.dim = dim
end

function SeqReverseSequence:reverseOutput(input)
    self.output:resizeAs(input)
    self.outputIndices = self.outputIndices or ((torch.type(input) == 'torch.CudaTensor') and torch.CudaTensor() or (torch.type(input) == 'torch.ClTensor') and torch.ClTensor() or torch.LongTensor())
    self.outputIndices:resize(input:size())
    local T = input:size(1)
    for x = 1, T do
        self.outputIndices:narrow(1, x, 1):fill(T - x + 1)
    end
    self.output:gather(input, 1, self.outputIndices)
end

function SeqReverseSequence:updateOutput(input)
    if (self.dim == 1) then
        self:reverseOutput(input)
    end
    if (self.dim == 2) then
        input = input:transpose(1, 2)
        self:reverseOutput(input)
        self.output = self.output:transpose(1, 2)
    end
    if (self.dim == 3) then
        input = input:transpose(1, 3)
        self:reverseOutput(input)
        self.output = self.output:transpose(1, 3)
    end
    return self.output
end

function SeqReverseSequence:reverseGradOutput(gradOutput)
    self.gradInput:resizeAs(gradOutput)
    self.gradIndices = self.gradIndices or ((torch.type(gradOutput) == 'torch.CudaTensor') and torch.CudaTensor() or (torch.type(gradOutput) == 'torch.ClTensor') and torch.ClTensor() or torch.LongTensor())
    self.gradIndices:resize(gradOutput:size())
    local T = gradOutput:size(1)
    for x = 1, T do
        self.gradIndices:narrow(1, x, 1):fill(T - x + 1)
    end
    self.gradInput:gather(gradOutput, 1, self.gradIndices)
end

function SeqReverseSequence:updateGradInput(inputTable, gradOutput)
    if (self.dim == 1) then
        self:reverseGradOutput(gradOutput)
    end
    if (self.dim == 2) then
        gradOutput = gradOutput:transpose(1, 2)
        self:reverseGradOutput(gradOutput)
        self.gradInput = self.gradInput:transpose(1, 2)
    end
    if (self.dim == 3) then
        gradOutput = gradOutput:transpose(1, 3)
        self:reverseGradOutput(gradOutput)
        self.gradInput = self.gradInput:transpose(1, 3)
    end
    return self.gradInput
end

function SeqReverseSequence:type(type, typecache)
   if type then
      self.outputIndices = nil
      self.gradIndices = nil
   end
   return parent.type(self, type, typecache)
end

function SeqReverseSequence:clearState()
   self.output:set()
   self.gradInput:set()
   self.outputIndices = nil
   self.gradIndices = nil
end
