function [allsequence,sequence,status,print] = wavefront(pwavefront, sx, sy,gx,gy)%print is the variable to tell whether we should print. 1 is print, 0 is not.
    allsequence = [sx,sy];%0 to 1 print, 1 to 1 print, 1 to 0 do not print
    sequence = [sx,sy];
    print = 0;
    countp = size(pwavefront);
    status = zeros(countp);%0 is unvisited, 1 is visited
    for n=1:countp(1)
        for m = 1: countp(2)
           if pwavefront(n,m)==0||pwavefront(n,m)==1
               status(n,m)=1;
           end
        end
    end %make the obstacle "visited"
    current = [sx,sy];
    goal = [gx,gy];
    direction = 0;
    i = 0;
    j = 1;
    while 1
%        next = findneighbor(pwavefront,status,current); %8 choices
        next = findneighborVH(pwavefront,status,current); %only 4 choices
        if next == 0
            if direction~=0
                i =i+1;
                print(i)=1;
                status(current(1),current(2))=1;
                sequence(:,:,i)=current;
            end
            if current(1) == goal(1) && current(2)==goal(2)
                fprintf('program succeed');
                break
            end
            direction = 0;
            j = j-1;
            current = allsequence(:,:,j);
            continue
%             fprintf('program error please check');
%             i = i+1;
%             sequence(:,:,i) = current;
%           break
        end
        
        allsize = size(allsequence);
        a = size(allsize);
        if a(2) == 3
            j = allsize(3);
        end % recover j
        
        status(current(1),current(2)) = 1;
        newdirection = direct(current,next);
        if direction == 0
            i=i+1;
            print(i)=0;
            sequence(:,:,i)=current;
            direction = newdirection;
        elseif direction ~= newdirection
                i = i+1;
                sequence(:,:,i) = current;
                print(i)=1;
                direction = newdirection;
        end
        j= j+1;
        allsequence(:,:,j) = next;
        current = next;
    end
end