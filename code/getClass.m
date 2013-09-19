function [ x1,x2 ] = getClass( g,trainNo,testNo,frameNumber )
for i=1:trainNo
    x1(i)=g(frameNumber(i));
end
for i=1:testNo
    x2(i)=g(frameNumber(i+trainNo));
end
end

