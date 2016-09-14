function [neuron corrpos]=correctSpotPositions(aPos1,aPos2,aSpotPos,num) 
   
   neuron=[aPos1(num,:); aPos2(num,:)]; 
   corrpos=[];
   for ii=1:size(aSpotPos,1)
       
    corrpos(ii,:)=pntSchnittpunktLot(aSpotPos(ii,1:2),neuron(1,1:2),neuron(2,1:2));
       
   end 
   
end