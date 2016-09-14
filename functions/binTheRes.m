function resBinned = binTheRes(rres2,nbins,reldistmax)

resBinned = cell(numel(rres2),1);

for num = 1:numel(rres2);

    
    names = fieldnames(rres2{num});
    for i=1:numel(names)
        eval(['vals =rres2{num}.',names{i},';']);

        if (isnumeric(vals) && numel(vals) == numel(rres2{num}.reldist))
           
            [stat egal bpos egal]=poolMyDataStat(rres2{num}.reldist...
                ,vals,nbins,[0 reldistmax]);

            resBinned{num}.bpos = bpos;%bin positions
            resBinned{num}.nSpots = stat.n;
            eval(['resBinned{num}.',names{i},'_mean = stat.m;']);

        end


    end

end