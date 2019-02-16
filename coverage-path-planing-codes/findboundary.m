function boundary = findboundary(pfigure)
%when we find the boundary, we use x,y, but when we output the point, we
%need line,colimn, they are opposite.
    count = size(pfigure);
    findone = find(pfigure == 1);
    pfigure(findone) = 0;
    status = zeros(count(1),count(2));
    countB = 0;
    for i = 2:count(2)-1
        for j = 2:count(1)-1
            if status(j,i) == 1
                continue
            end
            allzero = pfigure(j+1,i) + pfigure(j-1,i) + pfigure(j,i-1) + pfigure(j,i+1);
            if allzero == 0
                continue
            end
            if pfigure(j,i) == 0
               px = i; py =j;
               singleB = findSB(pfigure,px,py); %find single boundary %it is in line and column
               countB = countB + 1;
               boundary{countB} = singleB;
               countSB = size(singleB);
                for k = 1:countSB(1)
                    status(singleB(k,1),singleB(k,2))=1;
                end
            end
        end
    end
end