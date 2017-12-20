function [ im3 ] = generatePanorama( im1, im2 )
%GENERATEPANORAMA Summary of this function goes here
%   Detailed explanation goes here
img1=im1;
img2=im2;

im1 = im2double(im1);
if size(im1,3)==3
    im1= rgb2gray(im1);
end
im2 = im2double(im2);
if size(im2,3)==3
    im2= rgb2gray(im2);
end

fprintf('Computing BRIEF Descriptor...\n');
[ locs1,  desc1] = briefLite( im1 );
[ locs2,  desc2] = briefLite( im2 );
fprintf('Computing matches...\n');
matches = briefMatch(desc1, desc2);

fprintf('Computing H with RANSEC...\n');
nIter=5000;
tol=2;
bestH = ransacH( matches, locs1, locs2, nIter, tol );

fprintf('Computing paranomas...\n');
im3 = imageStitching_noClip( img1, img2, bestH );

figure();
imshow(im3);

end

