function singleB = findSB(pfigure,px,py)
    singleB = [py,px];%*************
    cp = [px,py]; %current point
    fp = [px,py-1]; %former point
    while 1
        next = findnextboundary(pfigure, cp,fp);
        if next(1) == 0 && next(2) == 0
            break
        end
        
        if next(1) == px && next(2) == py
            break
        end
        count = size(singleB);
        singleB(count(1)+1,1)=next(2);
        singleB(count(1)+1,2)=next(1);
        fp = cp;
        cp = next;
    end
end