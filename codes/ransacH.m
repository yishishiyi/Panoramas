function [ bestH ] = ransacH( matches, locs1, locs2, nIter, tol )
%RANSACH Summary of this function goes here
%   Detailed explanation goes here


n=length(matches);
ninlier=0;
npair=4;
P1=locs1(matches(:,1),1:2)';
P2=locs2(matches(:,2),1:2)';
for i=1:nIter
    rd = randi([1 n],1,npair);
    p1=locs1(matches(rd,1),1:2)';
    p2=locs2(matches(rd,2),1:2)';
    H2to1  = computeH(p1,p2);
    PP1=H2to1*[P2;ones(1,n)];
    PP1=[PP1(1,:)./PP1(3,:); PP1(2,:)./PP1(3,:)];
    error = (P1(1,:) - PP1(1,:)).^2 + (P1(2,:) - PP1(2,:)).^2; 
    I=find(error<tol);
    num=length(I);
    if num > ninlier
        ninlier=num;
        inI=I;
    end
end

p1=locs1(matches(inI,1),1:2)';
p2=locs2(matches(inI,2),1:2)';
bestH = computeH(p1,p2);
end
