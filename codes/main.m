imNum=3;  %Suppose the images are named squentailly from left to right
imgNameBase='inputs/ec8_';
imgName=cell(imNum,1);

for i =1 :imNum
    imgName{i}= [imgNameBase num2str(i) '.jpg'];
end
center=ceil(imNum/2);

im1=imread(imgName{center});

for i=1:floor(imNum/2)
    if ((center+i)>imNum)
        panoImg=im1;
        break;
    end
    im2 = imread(imgName{center+i});
    im2 = generatePanorama( im1, im2 );
    panoImg = im2;
    
    if ((center-i)<1)
        panoImg=im2;
        break;
    end
    im1 = imread(imgName{center-i});
    im1 = generatePanorama( im1, im2 );
    panoImg= im1;
end


figure();
imshow(panoImg);
imwrite(panoImg, 'outputs/ec8_pan.jpg','jpg');

    