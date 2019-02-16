function [pcost, coststatus] = PClabel(pcost, coststatus,current)
    coststatus(current(1),current(2)) = 1;
    count = size(coststatus);
     if current(1) > 1 
        if pcost(current(1)-1,current(2)) < 8 
            pcost(current(1)-1,current(2)) = pcost(current(1)-1,current(2))+1;
        end
        if current(2) > 1 && pcost(current(1)-1,current(2)-1) < 8
           pcost(current(1)-1,current(2)-1) = pcost(current(1)-1,current(2)-1)+1;
        end
        if current(2) < count(2) && pcost(current(1)-1,current(2)+1) < 8
           pcost(current(1)-1,current(2)+1) = pcost(current(1)-1,current(2)+1)+1;
        end
     end
     if current(1) < count(1)
        if pcost(current(1)+1,current(2)) < 8
            pcost(current(1)+1,current(2)) = pcost(current(1)+1,current(2))+1;
        end
        if current(2) > 1 && pcost(current(1)+1,current(2)-1) < 8
           pcost(current(1)+1,current(2)-1) = pcost(current(1)+1,current(2)-1)+1;
        end
        if current(2) < count(2) && pcost(current(1)+1,current(2)+1) < 8
           pcost(current(1)+1,current(2)+1) = pcost(current(1)+1,current(2)+1)+1;
        end
     end
     if current(2) > 1 && pcost(current(1),current(2)-1) < 8
        pcost(current(1),current(2)-1) = pcost(current(1),current(2)-1)+1;
     end
     if current(2) < count(2) && pcost(current(1),current(2)+1) < 8
        pcost(current(1),current(2)+1) = pcost(current(1),current(2)+1)+1;
     end
                %check the 8 neighbors
end