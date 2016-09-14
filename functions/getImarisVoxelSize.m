%function [voxelsize unit]=getImarisVoxelSize(datset)
%gets voxelsize from a imaris dataset, e.g. vImarisApplication.mDataset
%moehl DZNE Bonn 2012
function [voxelsize unit]=getImarisVoxelSize(datset)



    voxelsize=zeros(1,3);
    voxelsize(1)=(datset.GetExtendMaxX-datset.GetExtendMinX)/datset.GetSizeX;
    voxelsize(2)=(datset.GetExtendMaxY-datset.GetExtendMinY)/datset.GetSizeY;
    voxelsize(3)=(datset.GetExtendMaxZ-datset.GetExtendMinZ)/datset.GetSizeZ;


    unit=datset.GetUnit;

end