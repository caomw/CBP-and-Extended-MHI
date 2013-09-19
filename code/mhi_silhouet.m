function [H,H_inv,H_half,H_inv_half] = mhi_silhouet(cuboids)

Height = size(cuboids,1);
Width = size(cuboids,2);
nFrames = size(cuboids,3);

% I = zeros(Height,Width,nFrames-1);
Diff = zeros(Height,Width,nFrames-1);
Diff_inv = zeros(Height,Width,nFrames-1);
Img = zeros(Height,Width,nFrames-1);
Img_inv = zeros(Height,Width,nFrames-1);
Img_half = zeros(Height,Width,nFrames-1);
Img_inv_half = zeros(Height,Width,nFrames-1);


    cub = cuboids(:,:,:);
    for index = 1 : nFrames - 1
        Diff(:,:,index) = (cub(:,:,index+1) - cub(:,:,index) == 1);
        Diff_inv(:,:,index) = (cub(:,:,nFrames-index) - cub(:,:,nFrames-index+1)== 1);         
    end
   
    clear cub;
for index = 1 : nFrames - 1
       for h = 1 : Height
            for w = 1 : Width
                if Diff(h,w,index) == 1
                    Img(h,w,index) = nFrames - 1;
                    Img_half(h,w,index) =ceil( (nFrames - 1)/2);
                end
                if Diff(h,w,index) == 0
                    if index == 1
                        Img(h,w,index) = 0;
                        Img_half(h,w,index) = 0;
                    elseif index > 1
                        Img(h,w,index) = max(0, Img(h,w,index-1) - 1);
                        Img_half(h,w,index) = max(0, Img_half(h,w,index-1) - 1);
                    end
                end
                 if Diff_inv(h,w,index) == 1
                    Img_inv(h,w,index) = nFrames - 1;
                     Img_inv_half(h,w,index) = ceil( (nFrames - 1)/2);
                end
                if Diff_inv(h,w,index) == 0
                    if index == 1
                        Img_inv(h,w,index) = 0;
                        Img_inv_half(h,w,index) = 0;
                    elseif index > 1
                        Img_inv(h,w,index) = max(0, Img_inv(h,w,index-1) - 1);
                        Img_inv_half(h,w,index) = max(0, Img_inv_half(h,w,index-1) - 1);
                    end
                end
            end
      end        
end

% subplot(2,2,1);
% imagesc(Img(:,:,nFrames-1));
% subplot(2,2,2);imagesc(Img_inv(:,:,nFrames-1));
% subplot(2,2,3);
% imagesc(Img_half(:,:,nFrames-1));
% subplot(2,2,4);imagesc(Img_inv_half(:,:,nFrames-1));
% colormap(gray);
% % pause(1);
H = reshape(Img(:,:,nFrames-1),size(Img(:,:,nFrames-1),1)*size(Img(:,:,nFrames-1),2),1);
H_inv = reshape(Img_inv(:,:,nFrames-1),size(Img_inv(:,:,nFrames-1),1)*size(Img_inv(:,:,nFrames-1),2),1);
H_half= reshape(Img_half(:,:,nFrames-1),size(Img_half(:,:,nFrames-1),1)*size(Img_half(:,:,nFrames-1),2),1);
H_inv_half= reshape(Img_inv_half(:,:,nFrames-1),size(Img_inv_half(:,:,nFrames-1),1)*size(Img_inv_half(:,:,nFrames-1),2),1);

    Diff = zeros(Height,Width,nFrames-1);
    Img = zeros(Height,Width,nFrames-1);
end
% save('E:\Representation\Codes\MatFiles\Hh.mat','H');
% if size(H,3) == 1
%     imshow(H);
% end
% if size(H,3) >1
%     imshow(H(:,:,2));
% end

