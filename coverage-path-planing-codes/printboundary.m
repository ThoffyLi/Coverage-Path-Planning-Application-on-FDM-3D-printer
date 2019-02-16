function [sequencePC,printPC] = printboundary(sequencePC,printPC,boundary)
    %go through the boundary when we first touch the nieghbor of the first
    %point of the bondary
    countBGN = size(boundary); %count boundary group number
    for i = 1: countBGN(2)
        countS = size(sequencePC);
        current = boundary(1,i);
        pcurrent = cell2mat(current);%change cell to nomarl group
        countpc = size(pcurrent);
        pl = pcurrent(1,1);% the point line number
        pc = pcurrent(1,2);
        for j = 1:countS(3)
            if sequencePC(1,1,j)> pl+1 ||sequencePC(1,1,j)< pl-1|| sequencePC(1,2,j)< pc-1||sequencePC(1,2,j)> pc+1
                continue
            end
            temsequence = sequencePC;%to store the numbertemperatly;
            temprint = printPC;
            for n = 1: countpc(1)
                sequencePC(1,1,j+n) = pcurrent(n,1); 
                sequencePC(1,2,j+n) = pcurrent(n,2);
                printPC(1,j+n) = 1;
            end
            sequencePC(1,1,j+countpc(1)+1) = temsequence(1,1,j); 
            sequencePC(1,2,j+countpc(1)+1) = temsequence(1,2,j);
            printPC(1,j+countpc(1)+1) = 0;
            for m = 1: countS(3)-j
                sequencePC(1,1,j+countpc(1)+1+m) = temsequence(1,1,j+m); 
                sequencePC(1,2,j+countpc(1)+1+m) = temsequence(1,2,j+m);
                printPC(1,j+countpc(1)+1+m) = temprint(1,j+m);
            end
            break
        end
    end
end