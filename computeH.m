function [ H2to1 ] = computeH( p1, p2 )
%COMPUTEH Summary of this function goes here
%   Detailed explanation goes here

N=size(p1,2);
A=zeros(2*N,9);

p2=[p2;ones(1,N)];
index=1:2:2*N;
A(index,1:3)=p2';
A(index,7:9)=-(repmat(p1(1,:),3,1).*p2)';
index=2:2:2*N;
A(index,4:6)=p2';
A(index,7:9)=-(repmat(p1(2,:),3,1).*p2)';

[V,D] = eig(A'*A);
h=V(:,1);
H2to1 = [h(1:3)';h(4:6)';h(7:9)'];


end

