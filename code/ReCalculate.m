function [ Data, g,trainNo,testNo] = ReCalculate( trials,frameNumber,PersonframeNo,PersonframeNoTotal,...
                       Data,g)
     
if trials==1
    serial=1:frameNumber(PersonframeNoTotal(1));
else
    serial=frameNumber(PersonframeNoTotal(trials-1))+1:frameNumber(PersonframeNoTotal(trials));
end
    trainNo=sum(PersonframeNo)-PersonframeNo(trials);
    testNo=PersonframeNo(trials);
    
    tempData=Data(serial,:);
    Data(serial,:)=[];
    Data=cat(1,Data,tempData);
     
    tempg=g(serial);
    g(serial)=[];
    g=cat(2,g,tempg);
end
