function pwavefront = wavelabel(pfigure,gx,gy)
%label every cell by the wavefront way
count = size(pfigure);
currentpoints(:,:,1) = [gx,gy];
currentpoints(:,:,2) = [0,0];
while 1
    countc = size(currentpoints);
    neighborN = 0;
    nextpoints = [];
    nextpoints(:,:,1) = [0,0];
    nextpoints(:,:,2) = [0,0];%to solve the problem of matrix size.
    for i = 1:countc(3)-1
        cpoint = currentpoints(:,:,i);
       if cpoint(1) > 1
           if pfigure(cpoint(1)-1,cpoint(2)) == 2
               neighborN = neighborN + 1;
               pfigure(cpoint(1)-1,cpoint(2)) = pfigure(cpoint(1),cpoint(2))+1;
               countn = size(nextpoints);
               nextpoints(:,:,countn(3)-1) = [cpoint(1)-1,cpoint(2)];
               nextpoints(:,:,countn(3)+1) = [0,0];
           end
           if cpoint(2) > 1
              if pfigure(cpoint(1)-1,cpoint(2)-1) == 2
                  neighborN = neighborN + 1;
                  pfigure(cpoint(1)-1,cpoint(2)-1) = pfigure(cpoint(1),cpoint(2))+1;
                  countn = size(nextpoints);
                  nextpoints(:,:,countn(3)-1) = [cpoint(1)-1,cpoint(2)-1];
                  nextpoints(:,:,countn(3)+1) = [0,0];
               end
           end
           if cpoint(2) < count(2)
              if pfigure(cpoint(1)-1,cpoint(2)+1) == 2
                  neighborN = neighborN + 1;
                  pfigure(cpoint(1)-1,cpoint(2)+1) = pfigure(cpoint(1),cpoint(2))+1;
                  countn = size(nextpoints);
                  nextpoints(:,:,countn(3)-1)= [cpoint(1)-1,cpoint(2)+1];
                  nextpoints(:,:,countn(3)+1) = [0,0];
               end
           end
       end %do the judgement for the top three points of current point
        if cpoint(1) < count(1)
           if pfigure(cpoint(1)+1,cpoint(2)) == 2
               neighborN = neighborN + 1;
               pfigure(cpoint(1)+1,cpoint(2)) = pfigure(cpoint(1),cpoint(2))+1;
               countn = size(nextpoints);
               nextpoints(:,:,countn(3)-1) = [cpoint(1)+1,cpoint(2)];
               nextpoints(:,:,countn(3)+1) = [0,0];
           end
           if cpoint(2) > 1
              if pfigure(cpoint(1)+1,cpoint(2)-1) == 2
                  neighborN = neighborN + 1;
                  pfigure(cpoint(1)+1,cpoint(2)-1) = pfigure(cpoint(1),cpoint(2))+1;
                  countn = size(nextpoints);
                  nextpoints(:,:,countn(3)-1) = [cpoint(1)+1,cpoint(2)-1];
                  nextpoints(:,:,countn(3)+1) = [0,0];
               end
           end
           if cpoint(2) < count(2)
              if pfigure(cpoint(1)+1,cpoint(2)+1) == 2
                  neighborN = neighborN + 1;
                  pfigure(cpoint(1)+1,cpoint(2)+1) = pfigure(cpoint(1),cpoint(2))+1;
                  countn = size(nextpoints);
                  nextpoints(:,:,countn(3)-1) = [cpoint(1)+1,cpoint(2)+1];
                  nextpoints(:,:,countn(3)+1) = [0,0];
               end
           end
        end % do the judgement for the bottom three points
        if cpoint(2) > 1
           if pfigure(cpoint(1),cpoint(2)-1) == 2
               neighborN = neighborN + 1;
               pfigure(cpoint(1),cpoint(2)-1) = pfigure(cpoint(1),cpoint(2))+1;
               countn = size(nextpoints);
               nextpoints(:,:,countn(3)-1) = [cpoint(1),cpoint(2)-1];
               nextpoints(:,:,countn(3)+1) = [0,0];
           end
        end % do the judgement for the left point
        if cpoint(2) < count(2)
           if pfigure(cpoint(1),cpoint(2)+1) == 2
               neighborN = neighborN + 1;
               pfigure(cpoint(1),cpoint(2)+1) = pfigure(cpoint(1),cpoint(2))+1;
               countn = size(nextpoints);
               nextpoints(:,:,countn(3)-1) = [cpoint(1),cpoint(2)+1];
               nextpoints(:,:,countn(3)+1) = [0,0];
           end
        end % do the judgement for the right point
    end
    if neighborN == 0
            break;
    end
    countn = size(nextpoints);
    nextpoints(:,:,countn(3))=[];
    currentpoints = nextpoints;
    pfigure(gx,gy)=1;
end
pfigure(gx,gy)=2;
pwavefront = pfigure;
end