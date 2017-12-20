function [ locs ] = getLocalExtrema( DoGPyramid, DoGLevels, PrincipalCurvature, th_contrast, th_r )
%GETLOCALEXTREMA Summary of this function goes here
% Input:
%   DoGPyramid: Difference of Guassian Pyramid,  R*C*(L-1)
%   DoGLevels: (L-1)vectors corresponding to DoGPyramid.
%   PrincipalCurvature: R*C*(L-1)matrix where each point contains the 
%    curvature ratio R
%   threshold ?c should remove any point that is a local extremum 
%     but does not have a Difference of Gaussian (DoG) response magnitude 
%     above this threshold (i.e. |D(x,y,?)| > ?c). 
%   threshold ?r should remove any edge-like points 
%    that have too large a principal curvature ratio R.
% Output:
%   locs: N*3 matrix, each entry(x,y,DoGLevels(l)) specipied a point where the DoG 
%    pyramid achieves a local extrema and and also satisfies the two 
%    thresholds.

Ic=find(abs(DoGPyramid)>th_contrast);
Ir=find(abs(PrincipalCurvature)<th_r);
[I,~,~]=intersect(Ic,Ir);
[R,C,L]=size(DoGPyramid);
isLocalMax=ones(R,C,L);
isLocalMin=isLocalMax;

index=1;
for i=1:length(I)
    l=fix((I(i)-1)/(R*C))+1;
    r=mod(I(i)-1,R*C);
    y=fix(r/R)+1;
    x=mod(r,R)+1;
    if (isLocalMax(x,y,l) || isLocalMin(x,y,l))
    %if ((x>1) && (x<R) && (y>1) && (y<C) && (l>1) && (l<L))
        [flag,isLocalMax,isLocalMin] = isLocalExtrema(x,y,l,DoGPyramid, isLocalMax, isLocalMin);
        if (flag)
            locs(index,:)=[y,x,DoGLevels(l)] ;
            index=index+1;
        end
    %end
    end
end

end



function [flag,isLocalMax,isLocalMin] = isLocalExtrema(x,y,l,DoGPyramid, isLocalMax, isLocalMin)
    flagMax=1;
    flagMin=1;
    istart=max(x-1,1);
    jstart=max(y-1,1);
    iend=min(x+1,size(DoGPyramid,1));
    jend=min(y+1,size(DoGPyramid,2));
    num=DoGPyramid(x,y,l);
    for i=istart:iend
        for j=jstart:jend
            if ((i==x) && (j==y))
                continue;
            end
            if (flagMax) && (DoGPyramid(i,j,l)>=num)
                flagMax=0;
            end
            if (flagMin) && (DoGPyramid(i,j,l)<=num)
                flagMin=0;
            end
            if (flagMax==0) && (flagMin==0)
                break;
            end
        end
        if (flagMax==0) && (flagMin==0)
            break;
        end
    end
    
    if (l>1) 
        if (flagMax) && (DoGPyramid(x,y,l-1)>=num)
            flagMax=0;
        end
        if (flagMin) && (DoGPyramid(x,y,l-1)<=num)
            flagMin=0;
        end
    end
    
    if (l<size(DoGPyramid,3)) 
        if (flagMax) && (DoGPyramid(x,y,l+1)>=num)
            flagMax=0;
        end
        if (flagMin) && (DoGPyramid(x,y,l+1)<=num)
            flagMin=0;
        end
    end
    
    
    if (flagMax)
    for i=istart:iend
        for j=jstart:jend
            if ((i==x) && (j==y))
                continue;
            end
            isLocalMax(i,j,l)=0;
        end
    end 
    if (l>1)
        isLocalMax(x,y,l-1)=0;
    end
    if (l<size(DoGPyramid,3))
        isLocalMax(x,y,l+1)=0;
    end
    end
    
    if (flagMin)
    for i=istart:iend
        for j=jstart:jend
            if ((i==x) && (j==y))
                continue;
            end
            isLocalMin(i,j,l)=0;
        end
    end    
    if (l>1)
        isLocalMin(x,y,l-1)=0;
    end
    if (l<size(DoGPyramid,3))
        isLocalMin(x,y,l+1)=0;
    end
    end
    
    flag=flagMax || flagMin;
end
