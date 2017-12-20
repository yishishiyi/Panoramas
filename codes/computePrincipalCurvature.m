function [ PrincipalCurvature ] = computePrincipalCurvature( DoGPyramid )
%COMPUTEPRINCIPALCURVATURE Summary of this function goes here
% The function takes in DoGPyramid generated in the previous section and 
% returns PrincipalCurvature, a matrix of the same size where each point 
% contains the curvature ratio R for the corresponding point in the DoG 
% pyramid. R= Tr(H)^2/Det(H). H is the Hessian of DoG Function.

PrincipalCurvature = zeros(size(DoGPyramid));

for i = 1: size(DoGPyramid,3)
    [Fx, Fy]=gradient(DoGPyramid(:,:,i));
    [Dxx, Dxy]=gradient(Fx);
    [Dyx, Dyy]=gradient(Fy);
    PrincipalCurvature(:,:,i) = ((Dxx+Dyy).^2) ./ ((Dxx.*Dyy)-(Dxy.*Dyx));
end

end