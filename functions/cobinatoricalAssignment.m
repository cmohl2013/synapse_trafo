
% assign = cobinatoricalAssignment(costmat)
% compute combination with lowest cost by global optimization
% the cost matrix has to be cubic
%moehl 2013 dzne, IDAF
function assign = cobinatoricalAssignment(costmat)


numdat = size(costmat,1);


combis = perms(1:numdat);%list of possible permutations



%% compute total cost for each combination
costp=zeros(size(combis,1),1); % total costs per combination
for i = 1:size(combis,1) 
    for j =1:size(combis,2)
        costp(i) = costp(i) + costmat(j,combis(i,j));
    end
end

bestcombi = combis(costp == min(costp),:);
 
bestcombi = bestcombi(1,:);
 
 
%% populate assignment matrix 
 assign = zeros(numdat,2);
 for i =1: numel(bestcombi)
    assign(i,:) = [i bestcombi(i)]; 
 end
 
 
 
 