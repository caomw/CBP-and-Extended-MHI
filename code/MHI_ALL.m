%This file is used to exam whether the temporal segmentation is reasonable
% and collect all the data
clear;
clc;
actor_names = {'alba', 'amel', 'andreas',...
    'chiara', 'clare', 'daniel', 'florian', 'hedlena', 'julien', 'nicolas','pao','srikumar'};

actions={'---0-nothing---','1-check watch', '2 - cross arms', '3 - scratch head', ...
    '4 - sit down', '5 - get up', '6 - turn around', '7 - walk', '8 - wave', '9 - punch',...
    '10 -kick', '11 - point', '12 - pick up', '13 - throw (over head)',' 14 - throw (from bottom up)'};
%% 1
s=load('original_1');  %%%%%%%%manually change!!!!!!!!!!!!
truth1=load('alba1_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth2=load('alba2_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth3=load('alba3_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth_new1=truth1;
truth_new2=truth2;
truth_new3=truth3;
truth=[truth_new1;truth_new2;truth_new3];
num=length(s.final);
mhi=struct('action',{},'cuboid',{});
frame=0;
counter=1;
se_dilate_disk=strel('disk',8,8);
for n=1:num
      if s.final(n).camnum==3%%%%%%manually change!!!!!!!!!!!!
          frame=frame+1;
           if frame<=length(truth)
               if truth(frame)>0 && truth(frame)<13 && truth(frame)~=11
                    image=s.final(n).im;
                     bw_dilate=imdilate(image,se_dilate_disk);
                     bw_open=bwareaopen(bw_dilate,500);
                     STATS = regionprops(bw_open,'BoundingBox');
                     BoundingBox = cat(1, STATS.BoundingBox);
                         if(~isempty (BoundingBox))
                            xmin=round(BoundingBox(:,1));
                            xmax=floor(BoundingBox(:,1)+BoundingBox(:,3));
                            ymin=round(BoundingBox(:,2));
                            ymax=floor(BoundingBox(:,2)+BoundingBox(:,4));
                         end
                        postdata=image(ymin:ymax,xmin:xmax);
                        image= imresize(postdata, [30 20]);
                   if counter==1;
                     mhi(end+1).action=truth(frame);
                     mhi(end).cuboid(:,:,counter)=image;
                     counter=counter+1;
                   else 
                        if truth(frame)==truth(frame-1)
                             mhi(end).cuboid(:,:,counter)=image;
                             counter=counter+1;
                        else
                            mhi(end+1).action=truth(frame);
                            counter=1;
                            mhi(end).cuboid(:,:,counter)=image;
                            counter=counter+1;
                        end
                    end
               end
           end
      end
end
save('mhi_1','mhi');  %%%%%%%%manually change!!!!!!!!!!!!%% 
%% 2
clear
s=load('original_2');  %%%%%%%%manually change!!!!!!!!!!!!
truth1=load('amel1_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth2=load('amel2_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth3=load('amel3_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth_new1=truth1;
truth_new2=truth2;
truth_new2(find(truth_new2==3))=0;
truth_new2(find(truth_new2==8))=0;
truth_new3=truth3;
truth_new3(find(truth_new3==3))=0;
truth_new3(find(truth_new3==8))=0;
truth=[truth_new1;truth_new2;truth_new3];
num=length(s.final);
mhi=struct('action',{},'cuboid',{});
frame=0;
counter=1;se_dilate_disk=strel('disk',8,8);
for n=1:num
      if s.final(n).camnum==3%%%%%%manually change!!!!!!!!!!!!
          frame=frame+1;
           if frame<=length(truth)
               if truth(frame)>0 && truth(frame)<13 && truth(frame)~=11
                image=s.final(n).im;
                 bw_dilate=imdilate(image,se_dilate_disk);
                     bw_open=bwareaopen(bw_dilate,500);
                     STATS = regionprops(bw_open,'BoundingBox');
                     BoundingBox = cat(1, STATS.BoundingBox);
                         if(~isempty (BoundingBox))
                            xmin=round(BoundingBox(:,1));
                            xmax=floor(BoundingBox(:,1)+BoundingBox(:,3));
                            ymin=round(BoundingBox(:,2));
                            ymax=floor(BoundingBox(:,2)+BoundingBox(:,4));
                         end
                        postdata=image(ymin:ymax,xmin:xmax);
                        image= imresize(postdata, [30 20]);
                   if counter==1;
                     mhi(end+1).action=truth(frame);
                     mhi(end).cuboid(:,:,counter)=image;
                     counter=counter+1;
                   else 
                        if truth(frame)==truth(frame-1)
                             mhi(end).cuboid(:,:,counter)=image;
                             counter=counter+1;
                        else
                            mhi(end+1).action=truth(frame);
                            counter=1;
                            mhi(end).cuboid(:,:,counter)=image;
                            counter=counter+1;
                        end
                    end
               end
           end
      end
end
save('mhi_2','mhi');  %%%%%%%%manually change!!!!!!!!!!!!
%% 3
clear
s=load('original_3');  %%%%%%%%manually change!!!!!!!!!!!!
truth1=load('andreas1_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth2=load('andreas2_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth3=load('andreas3_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth_new1=truth1;
truth_new2=truth2;
truth_new3=truth3;
truth=[truth_new1;truth_new2;truth_new3];
num=length(s.final);
mhi=struct('action',{},'cuboid',{});
frame=0;
counter=1;se_dilate_disk=strel('disk',8,8);
for n=1:num
      if s.final(n).camnum==3%%%%%%manually change!!!!!!!!!!!!
          frame=frame+1;
           if frame<=length(truth)
               if truth(frame)>0 && truth(frame)<13 && truth(frame)~=11
                image=s.final(n).im;
                 bw_dilate=imdilate(image,se_dilate_disk);
                     bw_open=bwareaopen(bw_dilate,500);
                     STATS = regionprops(bw_open,'BoundingBox');
                     BoundingBox = cat(1, STATS.BoundingBox);
                         if(~isempty (BoundingBox))
                            xmin=round(BoundingBox(:,1));
                            xmax=floor(BoundingBox(:,1)+BoundingBox(:,3));
                            ymin=round(BoundingBox(:,2));
                            ymax=floor(BoundingBox(:,2)+BoundingBox(:,4));
                         end
                        postdata=image(ymin:ymax,xmin:xmax);
                        image= imresize(postdata, [30 20]);
                   if counter==1;
                     mhi(end+1).action=truth(frame);
                     mhi(end).cuboid(:,:,counter)=image;
                     counter=counter+1;
                   else 
                        if truth(frame)==truth(frame-1)
                             mhi(end).cuboid(:,:,counter)=image;
                             counter=counter+1;
                        else
                            mhi(end+1).action=truth(frame);
                            counter=1;
                            mhi(end).cuboid(:,:,counter)=image;
                            counter=counter+1;
                        end
                    end
               end
           end
      end
end
save('mhi_3','mhi');  %%%%%%%%manually change!!!!!!!!!!!!
%% 4
clear
s=load('original_4');  %%%%%%%%manually change!!!!!!!!!!!!
truth1=load('chiara1_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth2=load('chiara2_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth3=load('chiara3_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth_new1=truth1;
truth_new1(find(truth_new1==3))=0;
truth_new2=truth2;
truth_new2(find(truth_new2==3))=0;
truth_new2(find(truth_new2==8))=0;
truth_new2(find(truth_new2==9))=0;
truth_new3=truth3;
truth_new3(find(truth_new3==3))=0;
truth_new3(find(truth_new3==8))=0;
truth_new3(find(truth_new3==9))=0;
truth=[truth_new1;truth_new2;truth_new3];
num=length(s.final);
mhi=struct('action',{},'cuboid',{});
frame=0;
counter=1;se_dilate_disk=strel('disk',8,8);
for n=1:num
      if s.final(n).camnum==3%%%%%%manually change!!!!!!!!!!!!
          frame=frame+1;
           if frame<=length(truth)
               if truth(frame)>0 && truth(frame)<13 && truth(frame)~=11
                image=s.final(n).im;
                 bw_dilate=imdilate(image,se_dilate_disk);
                     bw_open=bwareaopen(bw_dilate,500);
                     STATS = regionprops(bw_open,'BoundingBox');
                     BoundingBox = cat(1, STATS.BoundingBox);
                         if(~isempty (BoundingBox))
                            xmin=round(BoundingBox(:,1));
                            xmax=floor(BoundingBox(:,1)+BoundingBox(:,3));
                            ymin=round(BoundingBox(:,2));
                            ymax=floor(BoundingBox(:,2)+BoundingBox(:,4));
                         end
                        postdata=image(ymin:ymax,xmin:xmax);
                        image= imresize(postdata, [30 20]);
                   if counter==1;
                     mhi(end+1).action=truth(frame);
                     mhi(end).cuboid(:,:,counter)=image;
                     counter=counter+1;
                   else 
                        if truth(frame)==truth(frame-1)
                             mhi(end).cuboid(:,:,counter)=image;
                             counter=counter+1;
                        else
                            mhi(end+1).action=truth(frame);
                            counter=1;
                            mhi(end).cuboid(:,:,counter)=image;
                            counter=counter+1;
                        end
                    end
               end
           end 
      end
end
c7=mhi(7).cuboid;
c8=mhi(8).cuboid;
cc8=cat(3,c7,c7);
c9=mhi(9).cuboid;
c10=mhi(10).cuboid;
c11=mhi(11).cuboid;
c12=mhi(12).cuboid;
cc9=cat(3,c9,c10);cc10=cat(3,c11,c12);
mhi(7).cuboid=cc8;
mhi(8)=[];
mhi(8).cuboid=cc9;
mhi(9)=[];
mhi(9).cuboid=cc10;
mhi(10)=[];
save('mhi_4','mhi');  %%%%%%%%manually change!!!!!!!!!!!!
%% 5
clear;
s=load('original_5_1-4');  %%%%%%%%manually change!!!!!!!!!!!!
s2=load('original_5_5');  %%%%%%%%manually change!!!!!!!!!!!!
truth1=load('clare1_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth2=load('clare2_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth3=load('clare3_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth_new1=truth1;
truth_new1(find(truth_new1==3))=0;
truth_new2=truth2;
truth_new2(find(truth_new2==3))=0;
truth_new3=truth3;
truth_new3(find(truth_new3==3))=0;
truth=[truth_new1;truth_new2;truth_new3];
num=length(s.final);
num2=length(s2.final);
mhi=struct('action',{},'cuboid',{});
frame=0;
counter=1;se_dilate_disk=strel('disk',8,8);
for n=1:num
      if s.final(n).camnum==3%%%%%%manually change!!!!!!!!!!!!
          frame=frame+1;
           if frame<=length(truth)
               if truth(frame)>0 && truth(frame)<13 && truth(frame)~=11
                image=s.final(n).im;
                 bw_dilate=imdilate(image,se_dilate_disk);
                     bw_open=bwareaopen(bw_dilate,500);
                     STATS = regionprops(bw_open,'BoundingBox');
                     BoundingBox = cat(1, STATS.BoundingBox);
                         if(~isempty (BoundingBox))
                            xmin=round(BoundingBox(:,1));
                            xmax=floor(BoundingBox(:,1)+BoundingBox(:,3));
                            ymin=round(BoundingBox(:,2));
                            ymax=floor(BoundingBox(:,2)+BoundingBox(:,4));
                         end
                        postdata=image(ymin:ymax,xmin:xmax);
                        image= imresize(postdata, [30 20]);
                   if counter==1;
                     mhi(end+1).action=truth(frame);
                     mhi(end).cuboid(:,:,counter)=image;
                     counter=counter+1;
                   else 
                        if truth(frame)==truth(frame-1)
                             mhi(end).cuboid(:,:,counter)=image;
                             counter=counter+1;
                        else
                            mhi(end+1).action=truth(frame);
                            counter=1;
                            mhi(end).cuboid(:,:,counter)=image;
                            counter=counter+1;
                        end
                    end
               end
           end
      end
end 
counter=1;
 for n=1:num2
      if s2.final(n).camnum==3%%%%%%manually change!!!!!!!!!!!!
          frame=frame+1;
           if frame<=length(truth)
              if truth(frame)>0 && truth(frame)<13 && truth(frame)~=11
                  image=s2.final(n).im;
                   bw_dilate=imdilate(image,se_dilate_disk);
                     bw_open=bwareaopen(bw_dilate,500);
                     STATS = regionprops(bw_open,'BoundingBox');
                     BoundingBox = cat(1, STATS.BoundingBox);
                         if(~isempty (BoundingBox))
                            xmin=round(BoundingBox(:,1));
                            xmax=floor(BoundingBox(:,1)+BoundingBox(:,3));
                            ymin=round(BoundingBox(:,2));
                            ymax=floor(BoundingBox(:,2)+BoundingBox(:,4));
                         end
                        postdata=image(ymin:ymax,xmin:xmax);
                        image= imresize(postdata, [30 20]);
                   if counter==1;
                     mhi(end+1).action=truth(frame);
                     mhi(end).cuboid(:,:,counter)=image;
                     counter=counter+1;
                   else 
                        if truth(frame)==truth(frame-1)
                             mhi(end).cuboid(:,:,counter)=image;
                             counter=counter+1;
                        else
                            mhi(end+1).action=truth(frame);
                            counter=1;
                            mhi(end).cuboid(:,:,counter)=image;
                            counter=counter+1;
                        end
                   end
            end
       end
   end
 end
c2=mhi(2).cuboid;
c3=mhi(3).cuboid;
c10=mhi(10).cuboid;
c11=mhi(11).cuboid;
c12=mhi(12).cuboid;
c13=mhi(13).cuboid;
cc2=cat(3,c2,c3);cc10=cat(3,c10,c11);cc11=cat(3,c12,c13);
mhi(2).cuboid=cc2;
mhi(3)=[];
mhi(9).cuboid=cc10;
mhi(10)=[];
mhi(10).cuboid=cc11;
mhi(11)=[];
save('mhi_5','mhi');  %%%%%%%%manually change!!!!!!!!!!!!
%% 6
clear
s=load('original_6');  %%%%%%%%manually change!!!!!!!!!!!!
truth1=load('daniel1_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth2=load('daniel2_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth3=load('daniel3_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth_new1=truth1;
truth_new2=truth2;
truth_new3=truth3;
truth=[truth_new1;truth_new2;truth_new3];
num=length(s.final);
mhi=struct('action',{},'cuboid',{});
frame=0;
counter=1;se_dilate_disk=strel('disk',8,8);
for n=1:num
      if s.final(n).camnum==3%%%%%%manually change!!!!!!!!!!!!
          frame=frame+1;
           if frame<=length(truth)
               if truth(frame)>0 && truth(frame)<13 && truth(frame)~=11
                image=s.final(n).im;
                 bw_dilate=imdilate(image,se_dilate_disk);
                     bw_open=bwareaopen(bw_dilate,500);
                     STATS = regionprops(bw_open,'BoundingBox');
                     BoundingBox = cat(1, STATS.BoundingBox);
                         if(~isempty (BoundingBox))
                            xmin=round(BoundingBox(:,1));
                            xmax=floor(BoundingBox(:,1)+BoundingBox(:,3));
                            ymin=round(BoundingBox(:,2));
                            ymax=floor(BoundingBox(:,2)+BoundingBox(:,4));
                         end
                        postdata=image(ymin:ymax,xmin:xmax);
                        image= imresize(postdata, [30 20]);
                   if counter==1;
                     mhi(end+1).action=truth(frame);
                     mhi(end).cuboid(:,:,counter)=image;
                     counter=counter+1;
                   else 
                        if truth(frame)==truth(frame-1)
                             mhi(end).cuboid(:,:,counter)=image;
                             counter=counter+1;
                        else
                            mhi(end+1).action=truth(frame);
                            counter=1;
                            mhi(end).cuboid(:,:,counter)=image;
                            counter=counter+1;
                        end
                    end
               end
           end
      end
end
save('mhi_6','mhi');  %%%%%%%%manually change!!!!!!!!!!!!
%% 7
clear
s=load('original_7');  %%%%%%%%manually change!!!!!!!!!!!!
truth1=load('florian1_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth2=load('florian2_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth3=load('florian3_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth_new1=truth1;
truth_new1(find(truth_new1==1))=0;
truth_new2=truth2;
truth_new3=truth3;
truth=[truth_new1;truth_new2;truth_new3];
num=length(s.final);
mhi=struct('action',{},'cuboid',{});
frame=0;
counter=1;se_dilate_disk=strel('disk',8,8);
for n=1:num
      if s.final(n).camnum==3%%%%%%manually change!!!!!!!!!!!!
          frame=frame+1;
           if frame<=length(truth)
               if truth(frame)>0 && truth(frame)<13 && truth(frame)~=11
                image=s.final(n).im;
                 bw_dilate=imdilate(image,se_dilate_disk);
                     bw_open=bwareaopen(bw_dilate,500);
                     STATS = regionprops(bw_open,'BoundingBox');
                     BoundingBox = cat(1, STATS.BoundingBox);
                         if(~isempty (BoundingBox))
                            xmin=round(BoundingBox(:,1));
                            xmax=floor(BoundingBox(:,1)+BoundingBox(:,3));
                            ymin=round(BoundingBox(:,2));
                            ymax=floor(BoundingBox(:,2)+BoundingBox(:,4));
                         end
                        postdata=image(ymin:ymax,xmin:xmax);
                        image= imresize(postdata, [30 20]);
                   if counter==1;
                     mhi(end+1).action=truth(frame);
                     mhi(end).cuboid(:,:,counter)=image;
                     counter=counter+1;
                   else 
                        if truth(frame)==truth(frame-1)
                             mhi(end).cuboid(:,:,counter)=image;
                             counter=counter+1;
                        else
                            mhi(end+1).action=truth(frame);
                            counter=1;
                            mhi(end).cuboid(:,:,counter)=image;
                            counter=counter+1;
                        end
                    end
               end
           end
      end
end
save('mhi_7','mhi');  %%%%%%%%manually change!!!!!!!!!!!!
%% 8
clear
s=load('original_8');  %%%%%%%%manually change!!!!!!!!!!!!
truth1=load('hedlena1_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth2=load('hedlena2_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth3=load('hedlena3_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth_new1=truth1;
truth_new2=truth2;
truth_new3=truth3;
truth=[truth_new1;truth_new2;truth_new3];
num=length(s.final);
mhi=struct('action',{},'cuboid',{});
frame=0;
counter=1;se_dilate_disk=strel('disk',8,8);
for n=1:num
      if s.final(n).camnum==3%%%%%%manually change!!!!!!!!!!!!
          frame=frame+1;
           if frame<=length(truth)
               if truth(frame)>0 && truth(frame)<13 && truth(frame)~=11
                image=s.final(n).im;
                 bw_dilate=imdilate(image,se_dilate_disk);
                     bw_open=bwareaopen(bw_dilate,500);
                     STATS = regionprops(bw_open,'BoundingBox');
                     BoundingBox = cat(1, STATS.BoundingBox);
                         if(~isempty (BoundingBox))
                            xmin=round(BoundingBox(:,1));
                            xmax=floor(BoundingBox(:,1)+BoundingBox(:,3));
                            ymin=round(BoundingBox(:,2));
                            ymax=floor(BoundingBox(:,2)+BoundingBox(:,4));
                         end
                        postdata=image(ymin:ymax,xmin:xmax);
                        image= imresize(postdata, [30 20]);
                   if counter==1;
                     mhi(end+1).action=truth(frame);
                     mhi(end).cuboid(:,:,counter)=image;
                     counter=counter+1;
                   else 
                        if truth(frame)==truth(frame-1)
                             mhi(end).cuboid(:,:,counter)=image;
                             counter=counter+1;
                        else
                            mhi(end+1).action=truth(frame);
                            counter=1;
                            mhi(end).cuboid(:,:,counter)=image;
                            counter=counter+1;
                        end
                    end
               end
           end
      end
end
save('mhi_8','mhi');  %%%%%%%%manually change!!!!!!!!!!!!
%% 9
clear
s=load('original_9');  %%%%%%%%manually change!!!!!!!!!!!!
truth1=load('julien1_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth2=load('julien2_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth3=load('julien3_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth_new1=truth1;
truth_new2=truth2;
truth_new3=truth3;
truth=[truth_new1;truth_new2;truth_new3];
num=length(s.final);
mhi=struct('action',{},'cuboid',{});
frame=0;
counter=1;se_dilate_disk=strel('disk',8,8);
for n=1:num
      if s.final(n).camnum==3%%%%%%manually change!!!!!!!!!!!!
          frame=frame+1;
           if frame<=length(truth)
               if truth(frame)>0 && truth(frame)<13 && truth(frame)~=11
                image=s.final(n).im;
                 bw_dilate=imdilate(image,se_dilate_disk);
                     bw_open=bwareaopen(bw_dilate,500);
                     STATS = regionprops(bw_open,'BoundingBox');
                     BoundingBox = cat(1, STATS.BoundingBox);
                         if(~isempty (BoundingBox))
                            xmin=round(BoundingBox(:,1));
                            xmax=floor(BoundingBox(:,1)+BoundingBox(:,3));
                            ymin=round(BoundingBox(:,2));
                            ymax=floor(BoundingBox(:,2)+BoundingBox(:,4));
                         end
                        postdata=image(ymin:ymax,xmin:xmax);
                        image= imresize(postdata, [30 20]);
                   if counter==1;
                     mhi(end+1).action=truth(frame);
                     mhi(end).cuboid(:,:,counter)=image;
                     counter=counter+1;
                   else 
                        if truth(frame)==truth(frame-1)
                             mhi(end).cuboid(:,:,counter)=image;
                             counter=counter+1;
                        else
                            mhi(end+1).action=truth(frame);
                            counter=1;
                            mhi(end).cuboid(:,:,counter)=image;
                            counter=counter+1;
                        end
                    end
               end
           end
      end
end
save('mhi_9','mhi');  %%%%%%%%manually change!!!!!!!!!!!!
%% 10
clear
s=load('original_10');  %%%%%%%%manually change!!!!!!!!!!!!
truth1=load('nicolas1_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth2=load('nicolas2_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth3=load('nicolas3_truth.txt');%%%%%%%%manually change!!!!!!!!!!!!
truth_new1=truth1;
truth_new2=truth2;
truth_new3=truth3;
truth=[truth_new1;truth_new2;truth_new3];
num=length(s.final);
mhi=struct('action',{},'cuboid',{});
frame=0;
counter=1;se_dilate_disk=strel('disk',8,8);
for n=1:num
      if s.final(n).camnum==3%%%%%%manually change!!!!!!!!!!!!
          frame=frame+1;
           if frame<=length(truth)
               if truth(frame)>0 && truth(frame)<13 && truth(frame)~=11
                image=s.final(n).im;
                 bw_dilate=imdilate(image,se_dilate_disk);
                     bw_open=bwareaopen(bw_dilate,500);
                     STATS = regionprops(bw_open,'BoundingBox');
                     BoundingBox = cat(1, STATS.BoundingBox);
                         if(~isempty (BoundingBox))
                            xmin=round(BoundingBox(:,1));
                            xmax=floor(BoundingBox(:,1)+BoundingBox(:,3));
                            ymin=round(BoundingBox(:,2));
                            ymax=floor(BoundingBox(:,2)+BoundingBox(:,4));
                         end
                        postdata=image(ymin:ymax,xmin:xmax);
                        image= imresize(postdata, [30 20]);
                   if counter==1;
                     mhi(end+1).action=truth(frame);
                     mhi(end).cuboid(:,:,counter)=image;
                     counter=counter+1;
                   else 
                        if truth(frame)==truth(frame-1)
                             mhi(end).cuboid(:,:,counter)=image;
                             counter=counter+1;
                        else
                            mhi(end+1).action=truth(frame);
                            counter=1;
                            mhi(end).cuboid(:,:,counter)=image;
                            counter=counter+1;
                        end
                    end
               end
           end
      end
end
save('mhi_10','mhi');  %%%%%%%%manually change!!!!!!!!!!!!
clc;
clear all;
tic;j=1;
H=[];H_inv=[];H_half=[];H_inv_half=[];AGI=[];
for trials=1:10
    start=1;
    l = 1 : 10;
        l(trials)=[];
        l(end+1)=trials;
    for m=1:length(l)
          actor=l(m);
           name=['mhi_',num2str(actor)];
             mhi=load(name);
      for i=1:length(mhi.mhi) 
        [data,data2,data3,data4,data5] = mhi_silhouet(mhi.mhi(i).cuboid);
        H(start,:,trials) = reshape(data/max(max(data)),600,1);
        H_inv(start,:,trials)=reshape(data2/max(max(data2)),600,1);
        H_half(start,:,trials)=reshape(data3/max(max(data3)),600,1);
        H_inv_half(start,:,trials)=reshape(data4/max(max(data4)),600,1);
        H_5(start,:,trials)=reshape(data5/max(max(data5)),600,1);
%       imshow(H(:,:,i));pause(0.1);
        im= sum(mhi.mhi(i).cuboid,3)/size(mhi.mhi(i).cuboid,3);
        AGI(start,:,trials)=reshape(im,size(im,1)*size(im,2),1);
       % imshow(G(:,:,i));pause(0.1);
       start=start+1;
%        colormap(gray);
%        if (i==1 || i==7 || i==20)
% subplot(3,3,3*(j-1)+1);imagesc(data);title('forward');axis off
% subplot(3,3,3*(j-1)+2);imagesc(im);title('Gait Energy information');axis off
% subplot(3,3,3*(j-1)+3); imagesc(data2);title('Inverse recording');axis off
% j=j+1;
%        end

% subplot(2,2,4);imagesc(Img_5(:,:,nFrames-1));
% colormap(gray);
% pause(1);
      end
    end
end
toc
% Elapsed time is 79.465743 seconds.
save('H_3','H');
save('H_inv_3','H_inv');
save('H_half_3','H_half');
save('H_inv_half_3','H_inv_half');
save('H_5_3','H_5');
save('AGI_3','AGI');