%[stat pooldata binpos binbreite]=poolMyDataStat(xdata,ydata,n,{range})
%stat enthaelt statistische groessen von pooldata, moehl2011
function [stat pooldata binpos binbreite]=poolMyDataStat(xdata,ydata,n,range)


if ~exist('range','var')
    [pooldata binpos binbreite]=poolMyData(xdata,ydata,n);
 
else
    [pooldata binpos binbreite]=poolMyData(xdata,ydata,n,range);
end



quart=zeros(n,2);
m=zeros(n,1);
stm=m;
md=m;
minmax=quart;
for j=1:n
    pdat=double(pooldata{j});
    
    
    if isempty(pdat)
        m(j)=NaN;%mean
        stm(j)=NaN;%standard deviation of mean
        md(j)=NaN;
        quart(j,:)=NaN;%0.25 and 0.75 quartiles
        stdw(j)=NaN;
        n(j)=NaN;
        minmax(j,1)=NaN;
        minmax(j,2)=NaN;
        
        
    else    
        m(j)=mean(pdat);%mean
        stm(j)=std(pdat)/sqrt(length(pdat));%standard deviation of mean
        md(j)=median(pdat);
        quart(j,:)=quantile(pdat,[0.25 0.75]);%0.25 and 0.75 quartiles
        stdw(j)=std(pdat);
        n(j)=length(pdat);
        minmax(j,1)=min(pdat);
        minmax(j,2)=max(pdat);
    end
end





stat.m=m;
stat.stm=stm;
stat.md=md;
stat.quart=quart;
stat.minmax=minmax;
stat.stdw=stdw';
stat.n=n';