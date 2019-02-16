function newdirection = direct(current, next)
        if  next(1) > current(1) &&  next(2)== current(2)
            newdirection = 1;
        end
        if  next(1) > current(1) &&  next(2) > current(2)
            newdirection = 5;
        end
        if  next(1) > current(1) &&  next(2) < current(2)
            newdirection = 6;
        end
        if  next(1) < current(1) &&  next(2) > current(2)
            newdirection = 7;
        end
        if  next(1) < current(1) &&  next(2) < current(2)
            newdirection = 8;
        end
        if  next(1) < current(1) &&  next(2)== current(2)
            newdirection = 2;
        end
        if  next(2) > current(2) &&  next(1)== current(1)
            newdirection = 3;
        end
        if  next(2) < current(2) &&  next(1)== current(1)
            newdirection = 4;
        end
end