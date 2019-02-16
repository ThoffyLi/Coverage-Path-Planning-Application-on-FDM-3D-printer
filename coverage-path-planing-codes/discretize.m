function pfigure = discretize(layer,pixel)
    count1 = size(layer);
    if mod(count1(1),pixel)==0
        x = floor(count1(1)/pixel);
    else
        x = floor(count1(1)/pixel)+1;
        for i =1:pixel-mod(count1(1),pixel)
            for j = 1:count1(2)
            layer(count1(1)+i,j)=255;
            end
        end
    end
    count2 = size(layer);
    if mod(count2(2),pixel)==0
        y = floor(count2(2)/pixel);
    else
        y = floor(count2(2)/pixel)+1;
        for i =1:pixel-mod(count2(2),pixel)
            for j = 1:count2(1)
            layer(j,count2(2)+i)=255;
            end
        end
    end
    %x,y are the size of pfigure.
    %in the figure, black is obstacle, which is 0 in the matrix; white is
    %blank, which is 255 in the matrix.
    pfigure = zeros(x,y);
    for i = 1:x
        for j = 1:y
            bool255 = 0;
            bool0 = 0;
           for m = 1:pixel
               for n =1:pixel
                   if bool255 == 0
                      if  layer((i-1)*pixel+m,(j-1)*pixel+n) > 200
                          bool255 = 1;
                      end
                   end
                   if bool0 == 0
                      if  layer((i-1)*pixel+m,(j-1)*pixel+n)<100
                          bool0 = 1;
                      end
                   end
               end
           end
           if bool255 == 1 && bool0 == 0
               pfigure(i,j) = 2;
           end
           if bool255 == 1 && bool0 == 1
               pfigure(i,j) = 1;
           end
        end
    end
    %label pfigure, 2 is blank, 1 is boundary, 0 is obstacle.
end