function [ locs, GaussianPyramid ] = DoGdetector( im, sigma0, k, levels, th_contrast, th_r )
%DOGDETECTOR Summary of this function goes here
%   Detailed explanation goes here

im = im2double(im);
if size(im,3)==3
    im= rgb2gray(im);
end

GaussianPyramid = createGaussianPyramid(im, sigma0, k, levels);
[DoGPyramid, DoGLevels] = createDoGPyramid( GaussianPyramid, levels );
PrincipalCurvature = computePrincipalCurvature( DoGPyramid );
locs = getLocalExtrema( DoGPyramid, DoGLevels, PrincipalCurvature, th_contrast, th_r );


%{
figure
imshow(im);
hold on;
plot(locs(:,1),locs(:,2),'g.');
%}
end

