function [sequencePC, printPC] = quickprint(pfigure)
    count = size(pfigure);
    print = 1;
    sizea = 1;
    for i = 1:count(1)
        if mod(i,2) == 1
            sequencePC(:,:,sizea) = [i,1];
            printPC(sizea) = 1;
            sizea = sizea +1;
        for j = 1:count(2)-1
            if pfigure(i,j) ~= pfigure(i,j+1)
                sequencePC(:,:,sizea) = [i,j];
                if print == 1
                    printPC(sizea) = 1;
                    print = 0;
                else
                    printPC(sizea) = 0;
                    print = 1;
                end
                sizea = sizea+1;
            end
        end
        sequencePC(:,:,sizea) = [i,count(2)];
        printPC(sizea) = 1;
        sizea = sizea +1;
        else
            sequencePC(:,:,sizea) = [i,count(2)];
            printPC(sizea) = 1;
            sizea = sizea +1;
        for j = 1:count(2)-1
            if pfigure(i,count(2)-j+1) ~= pfigure(i,count(2)-j)
                sequencePC(:,:,sizea) = [i,count(2)-j];
                if print == 1
                    printPC(sizea) = 1;
                    print = 0;
                else
                    printPC(sizea) = 0;
                    print = 1;
                end
                sizea = sizea+1;
            end
        end
        sequencePC(:,:,sizea) = [i,1];
        printPC(sizea) = 1;
        sizea = sizea +1;
        end
    end
end