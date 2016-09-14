%function dat=struct2cell_chris(s)
%converts a structure in a cell array with fieldnames in 1st row
function dat=struct2cell_chris(s)

n=fieldnames(s);


%find cellarray size

siz=0;
for i=1:numel(n)
  eval(['tmp=s.',n{i},';'])  
  sz=length(tmp);
  if sz>siz
      siz=sz;
  end
  
end

dat=cell(siz+1,numel(n));

%fill cell array
for i=1:numel(n)
    
    dat{1,i}=n{i};
    
    eval(['tmp=s.',n{i},';'])
    if size(tmp,1)<=siz-1
        
        if isstr(tmp)
        dat{2,i}=tmp;
        else
        
            if numel(tmp)>0
                if iscell(tmp)
                   dat(2:numel(tmp)+1,i)=tmp; 
                else
                   dat(2:numel(tmp)+1,i)=num2cell(tmp);
                end
            end
          
            
        
        end
    else
        if iscell(tmp)
        dat(2:numel(tmp)+1,i)=tmp';
        else
        dat(2:numel(tmp)+1,i)=num2cell(tmp');
        end
    
    end
end
