%function surfmask=getImarisSurfaceMasks(vImarisApplication,aSurface)
%
%returns a mask with dimesnions of the dataset volume. -1:outside surfaces,
%surfaces are marked by their indices 0:nSurfaces
%
%moehl 2012 dzne bonn
function surfmask=getImarisSurfaceMasks(vImarisApplication,aSurface)

datset=vImarisApplication.GetDataSet;
xmax=datset.GetExtendMaxX;
ymax=datset.GetExtendMaxY;
zmax=datset.GetExtendMaxZ;
xmin=datset.GetExtendMinX;
ymin=datset.GetExtendMinY;
zmin=datset.GetExtendMinZ;
xn=datset.GetSizeX;
yn=datset.GetSizeY;
zn=datset.GetSizeZ;


surfmask=zeros(xn,yn,zn)-1;





nsurf=aSurface.GetNumberOfSurfaces;




for surfInd=0:nsurf-1;

aMask = aSurface.GetSingleMask(surfInd,xmin,ymin,zmin,xmax,ymax,zmax,xn,yn,zn);  
msk=aMask.GetDataVolumeBytes(0,0);

surfmask(msk==1)=surfInd;
end
