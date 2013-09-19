function [frameNumber,frameNumberIn ] = Getframe( frameNumber,frameNumberIn,trials,PersonframeNoTotal )
if trials==1
temp_frameNumberIn=frameNumberIn(1:PersonframeNoTotal(trials));
frameNumberIn(1:PersonframeNoTotal(trials))=[];
frameNumberIn=cat(2,frameNumberIn,temp_frameNumberIn);
else
temp_frameNumberIn=frameNumberIn(PersonframeNoTotal(trials-1)+1:PersonframeNoTotal(trials)); 
frameNumberIn(PersonframeNoTotal(trials-1)+1:PersonframeNoTotal(trials))=[];
frameNumberIn=cat(2,frameNumberIn,temp_frameNumberIn);
end

for m=1:length(frameNumberIn)
    if m==1
        frameNumber(m)=frameNumberIn(m);
    else
        frameNumber(m)=frameNumberIn(m)+frameNumber(m-1);
    end
end