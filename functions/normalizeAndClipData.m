%function outdata=normalizeAndClipData(indata,alpha)
%alpha: upper and lower quantile
function outdata=normalizeAndClipData(indata,alpha)

upperthresh=quantile(indata(:),1-alpha);
lowerthresh=quantile(indata(:),alpha);

indata(indata>upperthresh)=upperthresh;%upper clipping
indata=indata-lowerthresh;
indata(indata<0)=0;
outdata=indata/max(indata(:));