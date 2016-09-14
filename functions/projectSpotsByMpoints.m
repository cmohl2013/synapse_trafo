function [rres] = projectSpotsByMpoints(mpoints,surfs,spots,aDataSet,rres) 





%% check if we have correct number of measurement points, spots and surfaces

if numel(mpoints) ~=2
    error('only two measurement point objects are allowed')
end
if (size(mpoints{1}.GetPositionsXYZ(),1) ~=numel(surfs) ...
   || size(mpoints{1}.GetPositionsXYZ(),1) ~=numel(spots)...
   ||size(mpoints{2}.GetPositionsXYZ(),1) ~=numel(surfs) ...
   || size(mpoints{2}.GetPositionsXYZ(),1) ~=numel(spots))
    error('number of measurement point items have to be equivalent with number of surfaces and number of spots')
end

if numel(rres) ~= numel(spots) || numel(rres)~= numel(surfs)
    error('results cell array has to have the same nr of elements as surfaces and spots')
end

%% assign surfs to spots and spots to mpoint positions
pos1 = round(ImarisTransformToPixelPos(mpoints{1}.GetPositionsXYZ(),aDataSet));%mpoint positions
pos2 = round(ImarisTransformToPixelPos(mpoints{2}.GetPositionsXYZ(),aDataSet));%mpoint positions

cpos =(pos1+pos2)/2;%mpoint centroid

combi = assignSurfToSpots(surfs,spots);%column1: surfaces, column2: spots
combiSurfMp = assignSurfToPos(surfs,cpos); %assignemnt of mpoints to surfaces
combiMpSpot = [combiSurfMp(:,2) combi(:,2)];%assignment mpoints to spots


%% correct spot positions
for num = 1:numel(spots)

    
    aSpotPos = rres{num}.spotpos;%round(ImarisTransformToPixelPos(spot.GetPositionsXYZ(),aDataSet));


    [neuron corrpos]=correctSpotPositions(pos1,pos2,aSpotPos,num); 
    %idx=pntsOnStreckeorOver(corrpos,neuron);%finde synapsen auf der strecke (von 0% bis unendlich)
    corrpos(:,3)=aSpotPos(:,3);
    
    %distance calculations
   relspots=corrpos(:,1:2);
   relspots(:,1)=corrpos(:,1)-neuron(1,1);
   relspots(:,2)=corrpos(:,2)-neuron(1,2);
   distance=sqrt(relspots(:,1).^2+relspots(:,2).^2);
   
   relneu=neuron(2,:)-neuron(1,:);
   neuronlength=sqrt(relneu(:,1).^2+relneu(:,2).^2);%length of neuron
   reldist=distance/neuronlength;
    
    
    rres{num}.reldist = reldist;
    rres{num}.spotposCorr = corrpos;
    rres{num}.neuronpos = neuron;
end




