clear;clc
load wholedes_plus;
% addpath(genpath('F:\softwares\dolloar_toolbox_V2.53'));
% [CX, sse] = kmeans2(wholedes, 4000);

 
%mex vgg_kmiter.c
[CX2, sse2] = vgg_kmeans(wholedes', 4000);
%save('CX2','CX2');save('sse2','sse2');
% iter 0: sse = 51623.3 (694.031 secs)
% iter 1: sse = 40166.4 (697.15 secs)
% iter 2: sse = 38851.5 (697.446 secs)
% iter 3: sse = 38318.7 (748.94 secs)
% iter 4: sse = 38015.8 (738.554 secs)