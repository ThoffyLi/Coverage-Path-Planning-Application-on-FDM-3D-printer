function next = findnextboundary(pfigure, cp,fp)
    next = [0,0];
    cpx = cp(1);
    cpy = cp(2);
    neighbor = [cpx,cpy-1;cpx-1,cpy-1;cpx-1,cpy;cpx-1,cpy+1;cpx,cpy+1;cpx+1,cpy+1;cpx+1,cpy;cpx+1,cpy-1;];
    for i = 1:8
        if neighbor(i,1) == fp(1) && neighbor(i,2)== fp(2)
            start = i;
            break
        end
    end
    for i = 1:8
        nextC = mod(start+i,8);
        if nextC == 0
            nextC = 8;
        end
        point = [neighbor(nextC,1),neighbor(nextC,2)];
        if pfigure(point(2),point(1))<2
            next = point;
            break
        end
    end
end