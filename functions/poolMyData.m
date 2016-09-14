%function [pooldata binpos binbreite]=poolMyData(xdata,ydata,n)
%poolen der y-daten in n gleichgroße x-bins 
%optionale variable range zur angabe der oberen und unteren grenze
function [pooldata binpos binbreite]=poolMyData(xdata,ydata,n,range)

 
 
 
 
 if ~exist('range','var')
    range(1)=min(xdata);
    range(2)=max(xdata);
 end
 
 binbreite=(range(2)-range(1))/n;
 binpos=[range(1)+binbreite*0.5 :binbreite: range(2)-binbreite*0.5]'; %mittelpositionen der bins
 
 binunten=binpos-binbreite*0.5;
 binoben=binpos+binbreite*0.5;binoben(end)=binoben(end)+1;
 pooldata=cell(1,n);
 
 for i=1:n
     
    pooldata{1,i}=ydata(xdata>=binunten(i) & xdata<binoben(i));
     
 end