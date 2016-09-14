%readout information of all measurement point objects in a Imaris surpass scene

%function [mpoint mpointUnit]=getImarisMeasurementPoints(vImarisApplication)

function [mpoint mpointUnit]=getImarisMeasurementPoints(vImarisApplication)

surpassScene=vImarisApplication.GetSurpassScene;
fact=vImarisApplication.GetFactory;

num=surpassScene.GetNumberOfChildren;

 zahler=1;
 
 clear mpoint
 clear mpointUnit
  %mpoint=struct('mName','name','aPos',0,'IndicesT',0);
 for i=1:num


     aData=surpassScene.GetChild(i-1);

     
   
         if   fact.IsMeasurementPoints(surpassScene.GetChild(i-1))
         %if strcmp(classInfo.class, 'Interface.Bitplane_Imaris_7.4_Type_Library.IMeasurementPoints')
           
            mpoint(zahler).name=char(aData.GetName); % name
            mpoint(zahler).name=char(aData.GetName); % name
            
            statistics=aData.GetStatistics;
            aValues=statistics.mValues;
            aUnits=cellstr(char(statistics.mUnits));
            aNames=cellstr(char(statistics.mNames));
            names=cellstr(char(unique(aNames)));
           
            
            for ii=1:length(names)
                idx=strfind(aNames,names{ii});

                k=1;
                for j=1:length(idx)
                    tmp=[cell2mat(strfind(names(ii),'(')), cell2mat(strfind(names(ii),')'))];
                    varname=names{ii};varname(tmp)='_';varname=space2underscore(varname);
                    
                    
                    if ~isempty(idx{j})
                     eval(['mpoint(zahler).',varname,'(k,1)=aValues(j);'])
                     eval(['mpointUnit(zahler).',varname,'=aUnits{j};'])
                     k=k+1;
                    end
                    
                end
                

            end
            
            mpoint(zahler).aPos=[mpoint(zahler).Position_X, mpoint(zahler).Position_Y, mpoint(zahler).Position_Z]
            mpoints(zahler).childIDX=i-1;
%             mpoint(zahler).name=aData.GetName; % name
%             mpoint(zahler).aPos=aData.GetPositionsXYZ; % positions xyz
%             mpoint(zahler).IndicesT=aData.GetIndicesT; % time indices
%             zahler=zahler+1;
%             mpoint
         
         zahler=zahler+1    
         end
     
 end
 
 mpoint
 