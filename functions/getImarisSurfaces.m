%readout information of all measurement point objects in a Imaris surpass scene

%function [aSurface aSurfaceUnit]=getImarisSurfaces(vImarisApplication)
function [aSurface aSurfaceUnit]=getImarisSurfaces(vImarisApplication)

surpassScene=vImarisApplication.GetSurpassScene;
fact=vImarisApplication.GetFactory;

num=surpassScene.GetNumberOfChildren;%anzahl surpass items
 
 zahler=1;
 for i=1:num
 
     aData=surpassScene.GetChild(i-1);%dataItem Object

     classInfo=whos('aData');

            %find surface objects
         %if strcmp(classInfo.class, 'Interface.Bitplane_Imaris_7.4_Type_Library.ISurfaces')
         if   fact.IsSurfaces(surpassScene.GetChild(i-1))
             
            aSurface(zahler).name=char(aData.GetName); %surface name
            aSurfaceUnit(zahler).name=char(aData.GetName); %surface name
            
            %extract statistical values from surface objects
            %[aNames,aValues,aUnits,aFactors,aFactorNames,aIds]=aData.GetStatistics;
            %names=unique(aNames);
            %names=names([1:4  35:37 45]);
           
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
                     eval(['aSurface(zahler).',varname,'(k,1)=aValues(j);'])
                     eval(['aSurfaceUnit(zahler).',varname,'=aUnits{j};'])
                     k=k+1;
                    end

                end

            end
            
            zahler=zahler+1;
         end
 
 end