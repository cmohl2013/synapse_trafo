function exportSynTrafoData(plainim,rres2,resBinned,savename,channelname)
% [filename,path] = uiputfile('*.csv','Save Result As');
% savename=[path,filename];
% savename=savename(1:end-4);

%plainim = normalizeAndClipData((mean(vol,3)),0.03);


h =figure(1);
imshow(plainim,[]);
hold on
for num = 1:numel(rres2)
    for i=1:numel(rres2{num}.bnd)
    %plot(rres{i}.bnd(:,1),rres{i}.bnd(:,2),'Color',randomcolor('jet'))
    plotkoordinatensammlung(rres2{num}.bnd{i},randomcolor('jet'))
    
    end
end
colormap gray
export_fig(h,[savename,'_cytoRegions.pdf'])

h = figure(2);
imshow(plainim,[]);
hold on
for num = 1:numel(rres2)
    
    plot(rres2{num}.neuronpos(:,2),rres2{num}.neuronpos(:,1))    
    plot(rres2{num}.spotpos(:,2),rres2{num}.spotpos(:,1),'.r')
    plot(rres2{num}.spotposCorr(:,2),rres2{num}.spotposCorr(:,1),'.g')
    
end
export_fig(h,[savename,'_projections.pdf'])



for num = 1:numel(rres2)
    clear dat
    dat=struct2cell_chris(resBinned{num});
    dat = [cell(4,size(dat,2)); dat]; %add 2 rows
    dat{1,1} = 'channelname:';dat{1,2} = channelname;
    dat{2,1} = 'spotsname:';dat{2,2} = rres2{num}.spotname;
    dat{3,1} = 'surface name:'; dat{3,2} = rres2{num}.surfname;
    
    cell2csv([savename,'_',getridofCharacters(rres2{num}.spotname,' '),'.csv'],dat);
end