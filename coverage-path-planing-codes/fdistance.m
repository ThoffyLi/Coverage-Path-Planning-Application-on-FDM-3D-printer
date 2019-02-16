function distance = fdistance(printingS)
    count = size(printingS);
    distance = zeros(count(3)-1,1);
    for i =1:count(3)-1
       distance(i) = sqrt((printingS(1,1,i) - printingS(1,1,i+1))^2+(printingS(1,2,i) - printingS(1,2,i+1))^2);
    end
end