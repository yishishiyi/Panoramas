function [ locs,  desc] = briefLite( im )
%BRIEFLITE Summary of this function goes here
%   Detailed explanation goes here
load('testPattern.mat');
load('params.mat');

im = im2double(im);
if size(im,3)==3
    im= rgb2gray(im);
end
[ locs, GaussianPyramid ] = DoGdetector( im, sigma0, k, levels, th_contrast, th_r );
[ locs, desc ] = computeBrief( im, locs, levels, compareX, compareY );

end

