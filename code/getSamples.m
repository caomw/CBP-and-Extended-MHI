function [ trainSample,testSample,g_train ] = getSamples(Data,frameNumber,trainNo,g)
trainSample=Data(1:frameNumber(trainNo),:);
testSample=Data(frameNumber(trainNo)+1:frameNumber(end),:);
g_train=g(1:frameNumber(trainNo));  % Only know the training data ground truth;
end

