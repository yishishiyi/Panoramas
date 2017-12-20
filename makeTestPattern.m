function [ compareX, compareY ] = makeTestPattern( patchWidth, nbits )
%MAKETESTPATTERN Summary of this function goes here
%   generate a static set of test pairs and save that data to a file (using
%   solution 2) in paper BRIEF : Binary Robust Independent Elementary
%   Features.
%   patchWidth is the width of the image patch (usually 9) and nbits
%    (usually 256) is the number of tests in the BRIEF descriptor.
%   

MU=[0,0];
SIGMA=(patchWidth)^2/25*eye(2);

compareX=fix(mvnrnd(MU, SIGMA, nbits));
compareY=fix(mvnrnd(MU, SIGMA, nbits));

compareX(find(compareX(:,1)<-4),1)=-4;
compareX(find(compareX(:,2)<-4),2)=-4;
compareX(find(compareX(:,1)>4),1)=4;
compareX(find(compareX(:,2)>4),2)=4;

compareY(find(compareY(:,1)<-4),1)=-4;
compareY(find(compareY(:,2)<-4),2)=-4;
compareY(find(compareY(:,1)>4),1)=4;
compareY(find(compareY(:,2)>4),2)=4;

save('testPattern.mat','compareX','compareY');
end

