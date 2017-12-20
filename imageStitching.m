function [ panoImg ] = imageStitching( img1, img2, H2to1 )
%IMAGESTITCHING Summary of this function goes here
%   Detailed explanation goes here

img1=im2double(img1);
img2=im2double(img2);
out_size=[max(size(img1,1),size(img2,1)),max(size(img1,2),size(img2,2)),3];

new_im1=zeros(out_size);
new_im1(1:size(img1,1),1:size(img1,2),:)=img1;
mask1 = zeros(out_size(1),out_size(2));
mask1(1,:) = 1; mask1(size(img1,1):end,:) = 1; mask1(:,1) = 1; mask1(:,size(img1,2):end) = 1;
mask1 = bwdist(mask1, 'city');
mask1 = mask1/max(mask1(:));

new_im2=zeros(out_size);
img2 = warpH(img2, H2to1, size(img2));
%imwrite(img2,'results/q6_1.jpg','jpg');
new_im2(1:size(img2,1),1:size(img2,2),:)=img2;
mask2 = zeros(out_size(1),out_size(2));
mask2(1,:) = 1; mask2(size(img2,1):end,:) = 1; mask2(:,1) = 1; mask2(:,size(img2,2):end) = 1;
mask2 = bwdist(mask2, 'city');
mask2 = warpH(mask2,H2to1,size(mask2));
mask2 = mask2/max(mask2(:));

A1=(new_im1(:,:,1)>0 | new_im1(:,:,2)>0 | new_im1(:,:,3)>0); 
A2=(new_im2(:,:,1)>0 | new_im2(:,:,2)>0 | new_im2(:,:,3)>0);
I1=find(mask1==0);
I2=find(mask2==0);
I=intersect(intersect(find(A1==1),find(A2==0)),I1);
mask1(I)=1; mask2(I)=0;
I=intersect(intersect(find(A1==0),find(A2==1)),I2);
mask2(I)=1; mask1(I)=0;
I1=find(mask1==0);
I2=find(mask2==0);
I=intersect(I1,I2);
mask1(I)=0.5;
mask2(I)=0.5;

% blend each channel
mask2 = repmat(mask2,[1 1 3]);
mask1 = repmat(mask1,[1 1 3]);
panoImg = (new_im1.*mask1+new_im2.*mask2)./(mask1+mask2);
%imshow(panoImg);

end

