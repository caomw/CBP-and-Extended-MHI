function [ output ] = Co_occurrence_matrix(clusterNo,Sample,frameNumber,...
                          frameNumberIndividual, deltaT,alf,centers)
start=0;
frame=size(frameNumber,2);
output=zeros(frame,clusterNo*clusterNo);
for q=1:frame
    S=Sample(start+1:frameNumber(q),:);
    start=frameNumber(q);
    C=centers;
    frameNo=frameNumberIndividual(q);
    W=zeros(clusterNo,frameNo);
    for i=1:frameNo
        for j=1:clusterNo
            W(j,i)=exp(-(sum((S(i,:)-C(j,:)).^2)./(2*alf^2)));
        end
    end
    CO=zeros(clusterNo,clusterNo);
    for i=1:clusterNo
        for j=1:clusterNo
            for k=1:frameNo-deltaT
             CO(i,j)=CO(i,j)+W(i,k)*W(j,k+deltaT);
            end
        end 
    end
%figure; imshow(mat2gray(CO));
CO=CO';
CO=CO(:);
output(q,:)=CO';
end
end
