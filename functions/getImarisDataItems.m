%function [surf]=getImarisDataItems(vImarisApplication,datatype)
%datatypes: surfaces,spots,cells,filaments, measurementpoints
function [surf]=getImarisDataItems(vImarisApplication,datatype)

nobj = vImarisApplication.GetSurpassScene.GetNumberOfChildren();

surf = {};
for i = 0:nobj-1
    tst = vImarisApplication.GetSurpassScene.GetChild(i);
    
    switch datatype
        case 'surfaces'
            datitem = vImarisApplication.GetFactory.ToSurfaces(tst);
        case 'spots'
            datitem = vImarisApplication.GetFactory.ToSpots(tst);
        case 'filaments'
            datitem = vImarisApplication.GetFactory.ToFilaments(tst); 
        case 'cells'
            datitem = vImarisApplication.GetFactory.ToCells(tst); 
        case 'measurementpoints'
            datitem = vImarisApplication.GetFactory.ToMeasurementPoints(tst);    
        
    end
    if isjava(datitem)
        surf{end+1}=datitem;
    end
end



