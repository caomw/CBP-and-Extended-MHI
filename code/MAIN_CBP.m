clc; clear;
trials=1; save('trials'); %5 trials is cross-validation set
Percent_CBP_SVM=zeros(10,1);save('Percent_CBP_SVM'); % This save the cross validation result
Class=[];save('Class');
tag=[];save('tag'); 
CBP=[];save('CBP','CBP');
for trials=1:10  %*person vs 1personn This loop runs till the very end
            clear;            
            load trials.mat
            fprintf('loading data,trials %d\n',trials);
            load Sample_3.mat ; % This is the cam3 all frame information
            load frameNumber.mat  ;  % accumulated frame number
            load frameNumberIn.mat ;  %individual frame number 
            load g.mat;  %ground truth
PersonframeNo=[34 29 33 26 30 33 32 33 34 33];
PersonframeNoTotal=[34 63 96 122 152 185 217 250 284 317];
totalframe=frameNumber(sum(PersonframeNo));
%% Choose data
%Data=cat(2,a2,a3,a4);
 Data=ALL;
%x=Data(1,:);y=reshape(x,30,20);imagesc(y);
%% Recalculate groundtruth g
fprintf('Recalculate groundtruth\n');
[ Data, g,trainNo,testNo]...
    = ReCalculate( trials,frameNumber,PersonframeNo,PersonframeNoTotal,Data,g); 
[frameNumber,frameNumberIn ] =...
    Getframe( frameNumber,frameNumberIn,trials,PersonframeNoTotal);
[trainSample,testSample,g_train ] = getSamples(Data,frameNumber,trainNo,g);
%% dimsionality deduction methods 
fprintf('Dimsionality deduction methods\n');
%choose a dimensionality deduction scheme %refer to file DeDim.m
options.ReducedDim=100;
% options.PCARatio=0.98;
[eigvector] = PCA(trainSample,options);  
Sample=Data*eigvector;
%% kmeans clustering
fprintf('Kmeans clustering\n'); % A much fast version of kmeans
addpath(genpath('vgg kmeans'));
frameNumberIndividual=frameNumberIn; 
trainSample=Sample(1:frameNumber(trainNo),:);
clusterNo=30;
opts.maxiters=20;opts.mindelta=1e-4;
[centers,dummy]= vgg_kmeans(trainSample',clusterNo,opts);
%% co-occurrence matrix
fprintf('Co-occurrence matrix\n');
 % we have two versions of computing co-occurrence matrix, one in Matlab,
% one in mex (written in C), C is almost 10 times faster.
% but if you want to read inside, you can refer to the Matlab version as
% follows ( they give idential result):
% [ output ] = Co_occurrenc_matrix_in_c(clusterNo,Sample,frameNumber,...
%                           frameNumberIndividual, deltaT,alf,centers);
centers=centers';
deltaT=2;  %23 fps --this is the time difference
alf=8;  %heat kernel parameter, need carefully tuning
                   
[output ]=  Co_occurrenc_matrix_in_c(clusterNo,Sample,frameNumber,...
                          frameNumberIndividual, deltaT,alf,centers);             
deltaT=4;  %23 fps
[ output2 ] = Co_occurrenc_matrix_in_c(clusterNo,Sample,frameNumber,...
                          frameNumberIndividual, deltaT,alf,centers);
deltaT=6;  %23 fps
[ output3 ] = Co_occurrenc_matrix_in_c(clusterNo,Sample,frameNumber,...
                          frameNumberIndividual, deltaT,alf,centers);
deltaT=8;  %23 fps
[ output4 ] = Co_occurrenc_matrix_in_c(clusterNo,Sample,frameNumber,...
                          frameNumberIndividual, deltaT,alf,centers);
output=cat(2,output,output2,output3,output4);
trainSample_co=output(1:trainNo,:);
%  load  CBP__long_cluster_200.mat;
%  CBP__long_cluster_200(:,:,trials)=output(:,:);
%save('CBP__long_cluster_200','CBP__long_cluster_200');
testSample_co=output(trainNo+1:trainNo+testNo,:);
%% Further dimension reduce
% DDM='PCA+LDA';%choose a dimensionality deduction scheme %refer to file
options.ReducedDim=100;
% options.PCARatio=0.99;
[eigvector,eigvalue] = PCA(trainSample_co,options);
% trainVector=trainSample_co*eigvector;
% testVector=testSample_co*eigvector;
% output=[trainVector;testVector];
% load CBP_PCA.mat;
% CBP_PCA(:,:,trials)=output(:,:);
% save('CBP_PCA','CBP_PCA');
temp_train=trainSample_co*eigvector;
temp_test=testSample_co*eigvector;
g_co_train=zeros(trainNo,1);
for i=1:trainNo
    g_co_train(i)=g(frameNumber(i));
end
options.Fisherface = 1; %%??
[eigvector2, eigvalue2] = LDA(g_co_train, options, temp_train);
temp=[temp_train;temp_test];
output=temp*eigvector2;
trainVector=output(1:trainNo,:);
testVector=output(trainNo+1:trainNo+testNo,:); 
load('CBP','CBP');
CBP(:,:,trials)=output(:,:);
save('CBP','CBP');
%  load  CBP_cluster_200.mat;
%  CBP_cluster_200(:,:,trials)=output(:,:);
% save(' CBP_cluster_200',' CBP_cluster_200');
% [trainVector]=normalization(trainVector,'L2-norm');
% [testVector]=normalization(testVector,'L2-norm');
%% SVM
fprintf('Classifying\n');
[ x1,x2 ] = getClass( g,trainNo,testNo,frameNumber );
addpath(genpath('libsvm-mat-3.0-1'));
model = svmtrain(x1',trainVector, '-t 2 -g 0.01 -b 1');
[predicted_label, accuracy, decision_values]...
= svmpredict(x2',testVector,model,'-b 1' ); 
%% Result reading and loading
load('Percent_CBP_SVM.mat');
Result_SVM = ~abs(predicted_label'-x2); 
Percent_CBP_SVM(trials) = accuracy(1);
save('Percent_CBP_SVM','Percent_CBP_SVM');
load('tag.mat');
tag(end+1:end+length(x2))=x2;
save('tag','tag');
trials=trials+1; %#ok<FXSET>
save('trials','trials');
end
fprintf('\n Mean(Percent_CBP_SVM) is %f\n',mean(Percent_CBP_SVM));
 
%3D 
%PCA1:30 83.7;PCA1:100 85.68;PCA1:200 84.38
%cluerNo:50--84.9;100-72.78


% Using only one deltaT in CBP and brute-concatenating
% CAM1 82.02(LOOP2--44.83) Because amel shadows!!!
%CAM2 85.74 CAM 3 85.54 
%CAM4  89.10  CAM5 69.50
%Direct concatenation 90.6347 (loop2 69)
%Using 2,3,4 cameras 90.87

% cam2,cam3  92.6

% CBP_long  0.7663
%  0.6765    0.7241    0.7879    0.7692    0.7000    0.8485    0.8438
%  0.7576    0.6765    0.8788
%  CBP 0.862
% 0.9118    0.7931    0.8788    0.8846    0.9000    0.8485    0.9688  
% 0.7576   0.8824    0.8182
% CBP PCA 200    0.8400
%0.8235    0.7931    0.8485    0.9231    0.7333    0.8485    1.0000   
%0.6970    0.8235    0.9091


 

    
    