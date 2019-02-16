% wavefront path planning
clc
clear all
%  layerall = imread('test14.jpg');%only use black and white picture
%  layer = layerall(:,:,1);%pick one
 
%
[layer,nouse,useno] = xlsread('apple.xlsx') ;

%
pixelsize = 1;%decide how many pixels will form a minimum cell
pfigure = discretize(layer,pixelsize);
boundary = findboundary(pfigure);
sx = 1; sy = 1;%define the start point.
countp = size(pfigure);
gx = countp(1); gy = countp(2);%define the end point

additionaltime = additime(pfigure);

%[sequencePC, printPC] = quickprint(pfigure);

%PATH COST
[pcost, coststatus] = initialPClabel(pfigure); % pcost to store the PC, coststatus to store the coverage status.
[allsequencePC,sequencePC,coststatus,printPC] = pathcost(pcost,coststatus,sx,sy);
[sequencePC,printPC] = printboundary(sequencePC,printPC,boundary);
count = size(sequencePC);
for i = 1:count(3)
    yPC(i) = -sequencePC(1,1,i);
    xPC(i) = sequencePC(1,2,i);
end
figure(1)
imshow(layer)
figure(2)
plot(xPC,yPC)
axis equal

%form the loop



% % WAVEFRONT
% pwavefront = wavelabel(pfigure,gx,gy);
% [allsequence,sequence,status,print] = wavefront(pwavefront,sx,sy,gx,gy);
% count = size(sequence);
% for i = 1:count(3)
%     y(i) = -sequence(1,1,i);
%     x(i) = sequence(1,2,i);
% end
% figure(1)
% imshow(layer)
% figure(2)
% plot(x,y)


%for gcode

width = 0.3;%the distance between every two lines
E = 0.03;%the parameter for plastic supply and distance
F = 800;%velocity;
firstlayer = 0.4;
countS = size(sequencePC);
P = zeros(1,2,countS(3));
for i = 1:countS(3)
   P(:,:,i) = [countp(1)/2,countp(2)/2]; 
end
printingS = (sequencePC - P) * width;

% distance comparison
distance = fdistance(printingS);
alldis = 0;%the distance that is actually useful
quickdis = 0;%the distance that is wasted
plastictime =0;
normaldistance = countp(1)*countp(2)*width;%the overall distance by the normal one
advancedistance = 0;
for n = 1:countp(1)
    for m = 1:countp(2)
        if pfigure(n,m) == 2
            advancedistance = advancedistance +1;
        end
    end
end
usedis = advancedistance * width; % the actually useful distance
quickdistance = normaldistance - usedis;% the quick distance

blayer = 0.2;

% print the file %% y -60 max

fid = fopen('apple1B.txt','w');

ytrans = ceil(-75-printingS(1,2,1));

thickness = 10;% 1 means 0.1 mm
fprintf(fid,'%s\r\n','G90');
fprintf(fid,'%s\r\n','M83');
fprintf(fid,'%s\t','M73');
fprintf(fid,'%s\r\n','P0');
fprintf(fid,'%s\t%s\t%s\t%s\r\n','G162', 'X', 'Y', 'F3000');
fprintf(fid,'%s\t%s\t%s\r\n','G161', 'Z', 'F1200');
fprintf(fid,'%s\t%s\r\n','G92', 'Z-5');
fprintf(fid,'%s\t%s\r\n','G1', 'Z0');
fprintf(fid,'%s\t%s\t%s\r\n','G161', 'Z', 'F100');
fprintf(fid,'%s\t%s\t%s\t%s\t%s\t%s\r\n','M132', 'X', 'Y','Z','A', 'B');
fprintf(fid,'%s\t%s\r\n','M135', 'T0');
fprintf(fid,'%s\t%s\t%s\t%s\t%s\r\n','G1', 'X-130', 'Y-75','Z30','F9000');
fprintf(fid,'%s\t%s\t%s\t%s\t%s\t%s\r\n','G130', 'X20', 'Y20','Z20','A20', 'B20');
fprintf(fid,'%s\r\n','M127');
fprintf(fid,'%s\t%s\t%s\r\n','M140', 'S110', 'T0');
fprintf(fid,'%s\t%s\r\n','M134', 'T0');
fprintf(fid,'%s\t%s\t%s\r\n','M104','S240','T0');
fprintf(fid,'%s\t%s\r\n','M133', 'T0');
fprintf(fid,'%s\t%s\t%s\t%s\t%s\t%s\r\n','G130', 'X127', 'Y127','Z40','A127', 'B127');
fprintf(fid,'%s\t%s\t%s\r\n','G92','A0','B0 ');
fprintf(fid,'%s\t%s\t%s\t%s\r\n','G1','X100','Y-80','F9000');
fprintf(fid,'%s\t%s\t%s\r\n','G1','Z0.3','F6000 ');
fprintf(fid,'%s\t%s\t%s\t%s\t%s\r\n','G1','X-90','Y-80','E24','F2000');
fprintf(fid,'%s\t%s\t%s\t%s\r\n','G1','X-100','Y-80','F180');
fprintf(fid,'%s\t%s\t%s\t%s\r\n','G1','X-110','Y-80','F5000');
fprintf(fid,'%s\t%s\t%s\r\n','G1','Z0.5','F100');
fprintf(fid,'%s\t%s\t%s\r\n','G92','A0','B0 ');
fprintf(fid,'%s\t','M73');
fprintf(fid,'%s\r\n','P1');
fprintf(fid,'%s\t%s%g\t%s\r\n','G1','Z',firstlayer,'F1200 ');
for thick = 1: thickness

fprintf(fid,'%s\t','G1');
fprintf(fid,'%s','X');
fprintf(fid,'%g\t',printingS(1,1,1));
fprintf(fid,'%s','Y');  
fprintf(fid,'%g\t',printingS(1,2,1)+ytrans);
fprintf(fid,'%s','F');
fprintf(fid,'%g\r\n',9000);
fprintf(fid,'%s\t','G1');
fprintf(fid,'%s','E');
fprintf(fid,'%g\t',1);
fprintf(fid,'%s','F');
fprintf(fid,'%g\r\n',360);
for i = 1:countS(3)-1
    if printPC(i)==1 && printPC(i+1) == 0%do not need to print
        fprintf(fid,'%s\t','G1');
        fprintf(fid,'%s','E');
        fprintf(fid,'%g\t',-1);
        fprintf(fid,'%s','F');
        fprintf(fid,'%g\r\n',360);
        fprintf(fid,'%s\t','G1');
        fprintf(fid,'%s','Z');
        fprintf(fid,'%g\t',firstlayer+blayer*thick);
        fprintf(fid,'%s','F');
        fprintf(fid,'%g\r\n',1200);
        fprintf(fid,'%s\t','G1');
        fprintf(fid,'%s','X');
        fprintf(fid,'%g\t',printingS(1,1,i+1));
        fprintf(fid,'%s','Y');
        fprintf(fid,'%g\t',printingS(1,2,i+1)+ytrans);
        fprintf(fid,'%s','F');
        fprintf(fid,'%g\r\n',9000);
        fprintf(fid,'%s\t','G1');
        fprintf(fid,'%s','Z');
        fprintf(fid,'%g\t',firstlayer+blayer*(thick-1));
        fprintf(fid,'%s','F');
        fprintf(fid,'%g\r\n',1200);
        fprintf(fid,'%s\t','G1');
        fprintf(fid,'%s','E');
        fprintf(fid,'%g\t',1);
        fprintf(fid,'%s','F');
        fprintf(fid,'%g\r\n',360);
        if thick == 1
            quickdis = quickdis + distance(i);
            plastictime = plastictime + 2/360+0.2/1200;
        end
    else
        fprintf(fid,'%s\t','G1');
        fprintf(fid,'%s','X');
        fprintf(fid,'%g\t',printingS(1,1,i+1));
        fprintf(fid,'%s','Y');
        fprintf(fid,'%g\t',printingS(1,2,i+1)+ytrans);
        fprintf(fid,'%s','E');
        fprintf(fid,'%g\t',distance(i)*E);
        fprintf(fid,'%s','F');
        fprintf(fid,'%g\r\n',F);
        if thick == 1
            alldis = alldis + distance(i);
        end
    end
end
        fprintf(fid,'%s\t','G1');
        fprintf(fid,'%s','E');
        fprintf(fid,'%g\t',-1);
        fprintf(fid,'%s','F');
        fprintf(fid,'%g\r\n',360);
        fprintf(fid,'%s\t','G1');
        fprintf(fid,'%s','Z');
        fprintf(fid,'%g\t',firstlayer+blayer*thick);
        fprintf(fid,'%s','F');
        fprintf(fid,'%g\r\n',1200);
        fprintf(fid,'%s\t','G1');
        fprintf(fid,'%s','X');
        fprintf(fid,'%g\t',printingS(1,1,1));
        fprintf(fid,'%s','Y');
        fprintf(fid,'%g\t',printingS(1,2,1)+ytrans);
        fprintf(fid,'%s','F');
        fprintf(fid,'%g\r\n',9000);
        fprintf(fid,'%s\t','G1');
        fprintf(fid,'%s','E');
        fprintf(fid,'%g\t',1);
        fprintf(fid,'%s','F');
        fprintf(fid,'%g\r\n',360);
end
fprintf(fid,'%s\t','M73');
fprintf(fid,'%s\r\n','P100');
fprintf(fid,'%s\t%s\t%s\r\n','G1','Z155','F1000 ');
fprintf(fid,'%s\t%s\t%s\r\n','M140','S0','T0 ');
fprintf(fid,'%s\t%s\t%s\r\n','M104','S0','T0 ');
fprintf(fid,'%s\r\n','M127');
fprintf(fid,'%s\t%s\t%s\t%s\r\n','G162','X','Y','F3000');
fprintf(fid,'%s\r\n','M18');
fprintf(fid,'%s\t','M72');
fprintf(fid,'%s\r\n','P1');
fclose(fid);

AAtheotime = (usedis+countp(2)/pixelsize*width)/1200;
AAcosttime = alldis/1200+quickdis/9000+plastictime;
AAnormaltime = normaldistance/1200+additionaltime;
AAquicktime = usedis/1200+quickdistance/9000+additionaltime;



