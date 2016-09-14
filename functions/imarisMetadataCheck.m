function correct = imarisMetadataCheck(vImarisApplication)
%function correct = imarisMetadataCheck(vImarisApplication)
%displays a question dialog with voxelsize and dt settings
%correct=1: user accepts meatadata

psizesMeta=getImarisVoxelSize(vImarisApplication.GetDataSet);
dtMeta=vImarisApplication.GetDataSet.GetTimePointsDelta;

button = questdlg(sprintf(['is metadata correct? \n\n x=',...
    num2str(psizesMeta(1)),'�m\n y=',num2str(psizesMeta(2))...
    ,'�m\n z=',num2str(psizesMeta(3)),'�m\n dt=',num2str(dtMeta)...
    ,'s \n\n [if not, change image settings: EDIT>>IMAGE PROPERTIES...]']),...
    'metadata check','yes','no','yes') 
correct=0;
if strcmp('yes',button)
    correct=1;
end