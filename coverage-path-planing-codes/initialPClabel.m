function [pcost, coststatus] = initialPClabel(pfigure)
    count = size(pfigure);
    pcost = zeros(count(1),count(2));
    coststatus = zeros(count(1),count(2));
    for i = 1:count(1)
        for j =1:count(2)
            if pfigure(i,j) == 2
                coststatus(i,j) = 0;
                cost = 8;
                if i > 1
                    if pfigure(i-1,j) == 2
                        cost = cost -1;
                    end
                    if j > 1
                        if pfigure(i-1,j-1) == 2
                            cost = cost -1;
                        end
                    end
                    if j < count(2)
                        if pfigure(i-1,j+1) == 2
                            cost = cost -1;
                        end
                    end
                end
                if i < count(1)
                    if pfigure(i+1,j) == 2
                        cost = cost -1;
                    end
                    if j > 1
                        if pfigure(i+1,j-1) == 2
                            cost = cost -1;
                        end
                    end
                    if j < count(2)
                        if pfigure(i+1,j+1) == 2
                            cost = cost -1;
                        end
                    end
                end
                if j > 1
                   if pfigure(i,j-1) == 2
                       cost = cost -1;
                   end
                end
                if j < count(2)
                   if pfigure(i,j+1) == 2
                       cost = cost -1;
                   end
                end
                pcost(i,j) = cost;
                %check the 8 neighbors
            end
            if pfigure(i,j) < 2
                coststatus(i,j) = 1;
                pcost(i,j) = 8;
            end
        end
    end
    
end