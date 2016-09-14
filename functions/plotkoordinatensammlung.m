%plotkoordinatensammlung(cellarray,farbe)
function plotkoordinatensammlung(cellarray,farbe)

if ischar(farbe)
    for i=1:length(cellarray)
        p=cellarray{i};
        plot(p(:,2),p(:,1),farbe)  
    end
    
else
    if numel(farbe) == 3
    
        for i=1:length(cellarray)
            p=cellarray{i};
            plot(p(:,2),p(:,1),'Color',farbe)  
        end
    end           
 end