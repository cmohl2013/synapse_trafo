
%function idx=pntsOnStrecke(pnt,strecke)
%liegt der punkt pnt auf der strecke?
%moehl 2012
function idx=pntsOnStrecke_orOver(pnt,strecke)

neuron=strecke;
corrpos=pnt;

idx=zeros(size(corrpos,1),1);
for ii=1:size(corrpos,1)
      p=corrpos(ii,:);
      a=neuron(1,1:2);
      b=neuron(2,1:2);
      t=(p-a)/(b-a);
      
      if (t>=0)
          idx(ii)=1;
      end
end
   
idx=find(idx==1);