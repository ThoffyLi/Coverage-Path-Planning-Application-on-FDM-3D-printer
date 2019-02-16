layerall = imread('test17.jpg');%only use black and white picture
layer = layerall(:,:,1);%pick one
pixelsize = 2;%decide how many pixels will form a minimum cell
pfigure = discretize(layer,pixelsize);
a = find(pfigure<2);
b = find(pfigure==2);
pfigure(a)=0;
pfigure(b)=255;
la = pfigure;
imshow(la)
xlswrite('test17.xlsx',la)