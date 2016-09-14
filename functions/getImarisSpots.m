%readout information of all spot objects in a Imaris surpass scene

%function [aSpots]=getImarisSpots(surpassScene)
%moehl DZNE bonn 2012
%[aSpots aSptsUnit]=getImarisSpots(vImarisApplication)
function [aSpots aSpotsUnit]=getImarisSpots(vImarisApplication)

surpassScene=vImarisApplication.GetSurpassScene;
fact=vImarisApplication.GetFactory;



num=surpassScene.GetNumberOfChildren;
 
 zahler=1;
 for i=1:num
 
     aData=surpassScene.GetChild(i-1);

     classInfo=whos('aData');

         if   fact.IsSpots(surpassScene.GetChild(i-1))
         %if strcmp(classInfo.class,'Interface.Bitplane_Imaris_7.4_Type_Library.ISpots')
            
            aSpotsUnit(zahler).name=char(aData.GetName); % name
            aSpots(zahler).name=char(aData.GetName); % name
         
         
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
                    varname=getridofshit(varname,'^ ,.:;!﻿');
                    
                    if ~isempty(idx{j})
                        
                        eval(['aSpots(zahler).',varname,'(k,1)=aValues(j);'])
                        
                        
                        eval(['aSpotsUnit(zahler).',varname,'=aUnits{j};'])
                        k=k+1;
                    end
                    
                end
         
            end
         
            
             aSpots(zahler).aPos=[aSpots(zahler).Position_X, aSpots(zahler).Position_Y, aSpots(zahler).Position_Z]
            %aSpots(zahler).name=aData.mName; %spots name
            %aSpots(zahler).aPos=aData.GetPositionsXYZ; % spots positions xyz
            %aSpots(zahler).radii=aData.GetRadii'; % spots radii
            %aSpots(zahler).timeframeMinMax=aData.GetTrackEdges; %
            aSpots(zahler).childIDX=i-1;
            zahler=zahler+1;
         end
 
 end