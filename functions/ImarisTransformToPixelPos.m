%function spotpos = ImarisTransformTpPixelPos(spotpos,aDataSet)
% transforms absolute xyz positions to pixel positions
%moehl idaf,dzne bonn, 2013
function spotpos = ImarisTransformToPixelPos(spotpos,aDataSet)

[psize ~] = getImarisVoxelSize(aDataSet);

spotpos(:,1) = (spotpos(:,1) - aDataSet.GetExtendMinX())/psize(1); 
spotpos(:,2) = (spotpos(:,2) - aDataSet.GetExtendMinY())/psize(2); 
spotpos(:,3) = (spotpos(:,3) - aDataSet.GetExtendMinZ())/psize(3);
