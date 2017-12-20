function [ panoImg ] = imageStitching_noClip( img1, img2, H2to1 )
%IMAGESTITCHING_NOCLIP Summary of this function goes here
%   Detailed explanation goes here

img1 = im2double(img1);
img2 = im2double(img2);

%compute the coords translation in the extreme situation
old_heights = max(size(img1,1),size(img2,1));
old_width = max(size(img1,2),size(img2,2));
X = [1,old_width,1,old_width;1,1,old_heights,old_heights;1,1,1,1];
X = H2to1*X;
X = bsxfun(@rdivide,X,X(3,:));
bottomright = max([X(1:2,:) [old_width;old_heights]],[],2);
upperleft = min([X(1:2,:) [1;1]],[],2);
diff=bottomright-upperleft+1;

%compute the matrix M only fisrt do translation and then scaling.
scale = old_width/(diff(1)+1);
M = [scale.*[eye(2), 1-upperleft] ;0, 0, 1];

% compute the width and heights of panoImg
width=old_width;
heighs=ceil(scale*diff(2));
out_size=[heighs,width,3];
new_im1 = warpH(img1,M,out_size);
new_im2 = warpH(img2,M*H2to1,out_size);

% mask 
mask1 = zeros(size(img1,1),size(img1,2));
mask1(1,:) = 1; mask1(end,:) = 1; mask1(:,1) = 1; mask1(:,end) = 1;
mask1 = bwdist(mask1,'city');
mask1 = mask1/max(mask1(:));
mask1 = warpH(mask1,M,[out_size(1),out_size(2)]);

mask2 = zeros(size(img2,1),size(img2,2));
mask2(1,:) = 1; mask2(end,:) = 1; mask2(:,1) = 1; mask2(:,end) = 1;
mask2 = bwdist(mask2,'city');
mask2 = mask2/max(mask2(:));
mask2 = warpH(mask2,M*H2to1,[out_size(1),out_size(2)]);

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


% blending
mask1 = repmat(mask1,[1 1 3]);
mask2 = repmat(mask2,[1 1 3]);
panoImg = (new_im1.*mask1+new_im2.*mask2)./(mask1+mask2);

%imshow(panoImg);
%imwrite(panoImg,'results/q6_2_pan.jpg','jpg');

end

