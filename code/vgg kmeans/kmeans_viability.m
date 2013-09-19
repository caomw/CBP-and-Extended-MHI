clear;clc; 
X = [randn(100,3)+ones(100,3);...
     randn(100,3)-ones(100,3)];

close all;
[idx,ctrs,sumd,d] = kmeans(X,2);
d=sum(d);
sumd=sum(sumd);
                   
[idx2,ssd]=vgg_kmeans(X',2); 
ctrs2=idx2';
% plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',12)
% hold on
% plot(X(idx==2,1),X(idx==2,2),'b.','MarkerSize',12)
% plot(ctrs(:,1),ctrs(:,2),'kx',...
%      'MarkerSize',12,'LineWidth',2)
% plot(ctrs(:,1),ctrs(:,2),'ko',...
%      'MarkerSize',12,'LineWidth',2)
% legend('Cluster 1','Cluster 2','Centroids',...
%        'Location','NW');
%    figure
%    plot(X(idx2==1,1),X(idx2==1,2),'r.','MarkerSize',12)
% hold on
% plot(X(idx2==2,1),X(idx2==2,2),'b.','MarkerSize',12)
% plot(ctrs(:,1),ctrs(:,2),'kx',...
%      'MarkerSize',12,'LineWidth',2)
% plot(ctrs(:,1),ctrs(:,2),'ko',...
%      'MarkerSize',12,'LineWidth',2)
% legend('Cluster 1','Cluster 2','Centroids',...
%        'Location','NW');