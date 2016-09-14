%function cname=getImarisChannelNames(aDatset)
%moehl 2012 dzne bonn
function cname=getImarisChannelNames(aDatset)

cname=cell(aDatset.GetSizeC,1);
for i=0:aDatset.GetSizeC-1
   cname{i+1}=char(aDatset.GetChannelName(i)) ;
end