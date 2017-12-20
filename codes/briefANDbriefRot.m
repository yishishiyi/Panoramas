%{
function [desc1, desc2] = briefANDbriefRot(GaussianPyramid, locs, levels, compareX, compareY, degree)
old_locs=locs;
[R,C,~]=size(GaussianPyramid);
n=length(compareX);
desc1=[];
locs1=[];
desc2=[];
p1=(compareX(:,2)+4)*9+compareX(:,1)+5;
p2=(compareY(:,2)+4)*9+compareY(:,1)+5;
for i=1:length(old_locs)
    y=old_locs(i,1);
    x=old_locs(i,2);
    l=old_locs(i,3);
    if ((x-4>=1) && (x+4<=R) && (y-4>=1) && (y+4<=C))
        pathes = GaussianPyramid(x-4:x+4,y-4:y+4,l);
        A=zeros(1,n);
        I=find((pathes(p1)-pathes(p2))<0);
        A(1,I)=1;
        desc1=[desc1;A];
        locs=[locs;old_locs(i,:)];
        
        pathes=imrotate(pathes,degree);
        A=zeros(1,n);
        I=find((pathes(p1)-pathes(p2))<0);
        A(1,I)=1;
        desc2=[desc2;A];
    end
end
%}

end

