function [ locs, desc ] = computeBrief( im, locs, levels, compareX, compareY )
%COMPUTEBRIEF Summary of this function goes here
%   Detailed explanation goes here
load('params.mat');
GaussianPyramid = createGaussianPyramid(im, sigma0, k, levels);

old_locs=locs;
[R,C]=size(im);
n=length(compareX);
desc=[];
locs=[];
for i=1:length(old_locs)
    y=old_locs(i,1);
    x=old_locs(i,2);
    l=old_locs(i,3);
    %Gim=GaussianPyramid(:,:,l);
    if ((x-4>=1) && (x+4<=R) && (y-4>=1) && (y+4<=C))
        %{
        p1=(y+compareX(:,2)-1)*R+compareX(:,1)+x;
        p2=(y+compareY(:,2)-1)*R+compareY(:,1)+x;
        A=zeros(1,n);
        I=find((Gim(p1)-Gim(p2))<0);
        A(1,I)=1;
        desc=[desc;A];
        locs=[locs;old_locs(i,:)];
        %}
        
        pathes = GaussianPyramid(x-4:x+4,y-4:y+4,l);
        p1=(compareX(:,2)+4)*9+compareX(:,1)+5;
        p2=(compareY(:,2)+4)*9+compareY(:,1)+5;
        A=zeros(1,n);
        I=find((pathes(p1)-pathes(p2))<0);
        A(1,I)=1;
        desc=[desc;A];
        locs=[locs;old_locs(i,:)];
       
    end
end


end

