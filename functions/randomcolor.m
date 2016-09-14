%function color=randomcolor(colormap
function color=randomcolor(colormapname)

cmap=colormap(colormapname);
 ind=floor(rand*(length(cmap)-1))+1;
color=cmap(ind,:);
