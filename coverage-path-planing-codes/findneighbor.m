function next = findneighbor(pwavefront,status,current)
    coordinate = [];
    count = size(pwavefront);
    i = 1;
     if current(1) > 1
        if status(current(1)-1,current(2)) == 0
           coordinate(:,:,i) = [current(1)-1,current(2)];
           DT(i) = pwavefront(current(1)-1,current(2));
           i = i+1;
        end
        
        if current(2)>1
           if status(current(1)-1,current(2)-1) == 0
           coordinate(:,:,i) = [current(1)-1,current(2)-1];
           DT(i) = pwavefront(current(1)-1,current(2)-1);
           i = i+1;
           end
        end
       if current(2)<count(2)
           if status(current(1)-1,current(2)+1) == 0
           coordinate(:,:,i) = [current(1)-1,current(2)+1];
           DT(i) = pwavefront(current(1)-1,current(2)+1);
           i = i+1;
           end
       end            %we only want horizontal or vertical motion.
        
     end %do the judgement for the top three points of current point
     if current(1) < count(1)
        if status(current(1)+1,current(2)) == 0
           coordinate(:,:,i) = [current(1)+1,current(2)];
           DT(i) = pwavefront(current(1)+1,current(2));
           i = i+1;
        end
        if current(2)>1
           if status(current(1)+1,current(2)-1) == 0
           coordinate(:,:,i) = [current(1)+1,current(2)-1];
           DT(i) = pwavefront(current(1)+1,current(2)-1);
           i = i+1;
           end
        end
       if current(2)<count(2)
           if status(current(1)+1,current(2)+1) == 0
           coordinate(:,:,i) = [current(1)+1,current(2)+1];
           DT(i) = pwavefront(current(1)+1,current(2)+1);
           i = i+1;
           end
        end
     end % do the judgement for the bottom three points
     if current(2) > 1
        if status(current(1),current(2)-1) == 0
           coordinate(:,:,i) = [current(1),current(2)-1];
           DT(i) = pwavefront(current(1),current(2)-1);
           i = i+1;
        end
    end % do the judgement for the left point
    if current(2) < count(2)
        if status(current(1),current(2)+1) == 0
           coordinate(:,:,i) = [current(1),current(2)+1];
           DT(i) = pwavefront(current(1),current(2)+1);
           i = i+1;
        end
    end % do the judgement for the right point
    countc = size(coordinate);
    countcc = size(countc);
    if countcc(2) == 3
            n = 1;
            for j = 1:countc(3)-1
                if DT(n)<DT(j+1)
                    n = j+1;
                end
            end
            next = coordinate(:,:,n);
    elseif countc(2)==2
        next = coordinate;
    else
        next = 0;
    end
end