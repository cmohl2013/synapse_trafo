function combi = assignSurfToPos(surfObjects,pos)

surf = surfObjects;





%% compute surface centroids

surfCenters = zeros(numel(surf),3);
for i=1:numel(surf)
    s =surf{i}; 
    numSurf = s.GetNumberOfSurfaces();
    c = zeros(1,3);
    for j =1:numSurf
        c =c + s.GetCenterOfMass(j-1);
    end    
    surfCenters(i,:) = c/numSurf; % center of mass of all elements
end






%% compute centroid distances and assign by global distance opimization 
costmat = pdist2(surfCenters,double(pos),'euclidean');
combi = cobinatoricalAssignment(costmat);








