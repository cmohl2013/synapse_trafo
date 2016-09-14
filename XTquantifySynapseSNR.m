%
%
%  Atsushis Synapse trafo and SNR measurement  7.6.3
%
%  Copyrigh IDAF DZNE Bonn Christoph Moehl 2013
%
%
%  Installation:
%
%  - Copy this file into the XTensions folder in the Imaris installation directory.
%  - You will find this function in the Image Processing menu
%
%    <CustomTools>
%      <Menu>
%        <Submenu name="CUSTOM">   
%        <Item name="Atsushis Synapse Trafo Vs 6" icon="Matlab" tooltip="transforms synapses to 1d and measures cytoplasm intensity">
%          <Command>MatlabXT::XTquantifySynapseSNR(%i)</Command>
%        </Item>
%      </Menu>
%    </CustomTools>
%  
%
%  
%
%

function XTquantifySynapseSNR(aImarisApplicationID, ~)

% connect to Imaris interface
if ~isa(aImarisApplicationID, 'Imaris.IApplicationPrxHelper')
    javaaddpath ImarisLib.jar
    vImarisLib = ImarisLib;
    if ischar(aImarisApplicationID)
        aImarisApplicationID = round(str2double(aImarisApplicationID));
    end
    vImarisApplication = vImarisLib.GetApplication(aImarisApplicationID);
else
    vImarisApplication = aImarisApplicationID;
end


 %include functions path
info=what;
addpath([info.path,'/functions'])    


%% load and image dimensions
aDataSet = vImarisApplication.GetDataSet;
aSizeX = aDataSet.GetSizeX;
aSizeY = aDataSet.GetSizeY;
aSizeZ = aDataSet.GetSizeZ;


%% parameters

%check metadata
if imarisMetadataCheck(vImarisApplication)==0
    return
end


%define channel
[channel channelname] = ImarisChannelSelectorGui(aDataSet);


% save name
[filename,path] = uiputfile('*.csv','Save Result As');
savename=[path,filename];
savename=savename(1:end-4);



% binning
prompt = {'Enter number of bins:'};
 dlg_title = 'Input for binning';
 num_lines = 1;
 def = {'10'};
 nbins = str2double(inputdlg(prompt,dlg_title,num_lines,def));
%nbins=12



% spot and cyto disk sizes
 prompt = {'Enter range of bins (max relative spot distance [%]):'};
 dlg_title = 'Input for bin range';
 num_lines = 1;
 def = {'100'};
 reldistmax = str2double(inputdlg(prompt,dlg_title,num_lines,def))/100;
%reldistmax=120/100;

 prompt = {'Enter spots radius [µm]:','Enter width of surrounding area [µm]:' };
 dlg_title = 'Input calculation of diluted fraction';
 num_lines = 1;
 def = {'0.3','0.8'};
 params = str2double(inputdlg(prompt,dlg_title,num_lines,def));
 radiusabs=params(1);%radius of spots in µm
 cytowidthabs=params(2);%width of cytoplasmic area in µm


%defaults
%radiusabs = 0.3;
%cytowidthabs = 1.3;

%nbins=12;
%reldistmax = 1.2;



%% load spot and surface objects and assign them to rach other

spots = getImarisDataItems(vImarisApplication,'spots');
surfs=getImarisDataItems(vImarisApplication,'surfaces');
mpoints = getImarisDataItems(vImarisApplication,'measurementpoints');




if numel(spots) ~= numel(surfs)
    error('number of spot and surface objects must be equal')
end

combi = assignSurfToSpots(surfs,spots);%column1: surfaces, column2: spots


psize = getImarisVoxelSize(aDataSet);
radius = radiusabs/psize(1);
cytowidth = cytowidthabs/psize(1);

%% load volume
disp(['loading pixeldata from channel ',channelname])
vol = aDataSet.GetDataVolumeShorts(channel,0);



%% remove spots outside neuron and create masks
rres = cell(numel(spots),1);


for num =1:numel(spots)

    neuronIndex = combi(num,1);
    spotsIndex = combi(num,2);
    surf = surfs{neuronIndex};
    spot = spots{spotsIndex};



    disp(['loading neuronmask ',num2str(num),' of ',num2str(numel(surfs)),'...'])
    msk = max(getImarisSurfaceMasks(vImarisApplication,surf),[],3); %load 2D neuron mask
    msk = imopen(msk,strel('disk',3));
    spotpos = round(ImarisTransformToPixelPos(spot.GetPositionsXYZ(),aDataSet));%spot positions
    ttt=ones(size(spotpos,1),1);
    for i = 1:size(spotpos,1)
        if msk(spotpos(i,1),spotpos(i,2)) == -1
            ttt(i)=0;
        end
    end
    spotpos = spotpos(ttt==1,:);

    %% measure spotregions

    spotmasks =circlemasks(spotpos,radius,[aSizeX aSizeY]);


    disp(['measuring pixeldata from ',char(spot.GetName())])

    % all relevant sots info is stored in the res struct
    clear res
    res.spotname = char(spot.GetName());
    res.surfname = char(surf.GetName());
    res.spotpos = spotpos;


    for i = 1:size(spotpos,1)
        spotmask = circlemasks(spotpos(i,:),radius,[aSizeX aSizeY]);% spotregion of spot i 
        pmask=circlemasks(spotpos(i,:),radius+cytowidth,[aSizeX aSizeY]); 
        pmask(msk==-1 | spotmasks ==1)=0;%cytoplasm region of spot i;

        %make a 3d cytomask
        pmask3d = zeros(aSizeX,aSizeY,aSizeZ);
        spotmask3d = zeros(aSizeX,aSizeY,aSizeZ);
        for j = 1: aSizeZ
            pmask3d(:,:,j)=pmask;
            spotmask3d(:,:,j)=spotmask;
        end
        cytopix = double(vol(pmask3d==1));
        spotpix = double(vol(spotmask3d==1));
        
        bnd = bwboundaries(pmask);
        res.bnd{i} = bnd; 
        res.meancyto(i,1) = mean(cytopix);
        res.medcyto(i,1) = median(cytopix);
        res.meanspot(i,1) = mean(spotpix);
        res.medspot(i,1) = median(spotpix);
        res.maxspot(i,1) =quantile(spotpix,0.95);
        
        res.RatioMeanCytoMeanSpot(i,1) = mean(cytopix)./mean(spotpix);
        res.RatioMedianCytoMedianSpot(i,1) = median(cytopix)./median(spotpix);
        res.RatioMeanCytoMaxSpot(i,1) = mean(cytopix)./quantile(spotpix,0.95);
    end
    rres{num} = res;

end

%% projection and binning
[rres2] = projectSpotsByMpoints(mpoints,surfs,spots,aDataSet,rres);
resBinned = binTheRes(rres2,nbins,reldistmax);




%% vis and export
plainim = normalizeAndClipData((mean(vol,3)),0.03);
exportSynTrafoData(plainim,rres2,resBinned,savename,channelname);
