function additionaltime = additime(pfigure)
    count = size(pfigure);
    for i = 1: count(1)
        for j = 1:count(2)
            if pfigure(i,j)==1
                pfigure(i,j) = 0;
            end
        end
    end
    additionaltime = 0;
    for i = 1: count(1)
        for j = 1:count(2)
            if i ==1 && j==1
               past = pfigure(i,j);
               continue
            end
            if pfigure(i,j) == past
                continue
            end
            past = pfigure(i,j);
            additionaltime = additionaltime + 1/360+0.1/1200;
        end
    end
    
end