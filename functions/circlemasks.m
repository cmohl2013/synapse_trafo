function cmask=circlemasks(aSpotPos,radius,masksize)

cmask=zeros(masksize(1),masksize(2));
       for j=1:size(aSpotPos,1)
            cmask=cmask+circlemask(aSpotPos(j,1),aSpotPos(j,2),radius,masksize);
       end
       
       cmask(cmask>1)=1;