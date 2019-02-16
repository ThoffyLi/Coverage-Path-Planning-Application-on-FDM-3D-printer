function [allsequencePC,sequencePC,coststatus,printPC] = pathcost(pcost,coststatus,sx,sy)
    allsequencePC = [sx,sy];%0 to 1 print, 1 to 1 print, 1 to 0 do not print
    sequencePC = [sx,sy];
    printPC = 0;
    current = [sx,sy];
    direction = 0;
    count = size(coststatus);
    i = 0;
    j = 1;
    while 1
%        next = findneighbor(pwavefront,status,current); %8 choices
        next = findneighborVH(pcost,coststatus,current); %only 4 choices
        if next == 0
            if direction~=0
                i =i+1;
                printPC(i)=1;
                [pcost, coststatus] = PClabel(pcost,coststatus,current); %update the PC
                sequencePC(:,:,i)=current;
            end
            if sum(sum(coststatus)) == count(1)*count(2)
                fprintf('program succeed')
                break
            end
            direction = 0;
            j = j-1;
            if j == 0
                fprintf('a through whole in side the obstacle.')
                break
            end
            current = allsequencePC(:,:,j);
            continue
        end

        allsize = size(allsequencePC);
        as = size(allsize);
        if as(2) == 3
            j = allsize(3);
        end % recover j
        
        [pcost, coststatus] = PClabel(pcost,coststatus,current); %update the PC
        newdirection = direct(current,next);
        if direction == 0
            i=i+1;
            printPC(i)=0;
            sequencePC(:,:,i)=current;
            direction = newdirection;
        elseif direction ~= newdirection
                i = i+1;
                sequencePC(:,:,i) = current;
                printPC(i)=1;
                direction = newdirection;
        end
        j= j+1;
        allsequencePC(:,:,j) = next;
        current = next;
    end
end