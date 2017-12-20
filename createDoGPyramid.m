function [ DoGPyramid, DoGLevels ] = createDoGPyramid( GaussianPyramid, levels )
%CREATEDOGPYRAMID Summary of this function goes here
%   The function should return DoGPyramid an R ? C ? (L ? 1) matrix of the 
%   DoG pyramid created by differencing the GaussianPyramid input. 

DoGLevels=2:length(levels);
DoGPyramid = zeros([size(GaussianPyramid,1),size(GaussianPyramid,2),length(DoGLevels)]);

for i = 1:length(DoGLevels)
    DoGPyramid(:,:,i) = GaussianPyramid(:,:,i+1)-GaussianPyramid(:,:,i);
end


end

