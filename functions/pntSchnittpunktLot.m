%finde schnittpunkt zwischen gerade und punkt p
%gerade ist definiert durch zwei punkte g1 und g2
%moehl 2012
%function s = pntSchnittpunktLot(p,g1,g2)

function s = pntSchnittpunktLot(p,g1,g2)


% Punkt A=(x1, y1)
% 
% Gerade mit B=(x2, y2) und C=(x3, y3):
% x=x2+u*(x3-x2)
% y=y2+u*(y3-y2)
% 
% u=[(y1-y2)*(y3-y2)+(x2-x1)*(x2-x3)]/[(y3-y2)*(y3-y2)-(x3-x2)*(x2-x3)]
% 
% 
% Schnittpunkt D = (x2+u*(x3-x2), y2+u*(y3-y2)) = (x4, y4) 


% g1=[1 4];
% g2=[3 7]
% p=[2 6]

y2=g1(2);y3=g2(2);y1=p(2);
x2=g1(1);x3=g2(1);x1=p(1);

u=((y1-y2)*(y3-y2)+(x2-x1)*(x2-x3))/((y3-y2)*(y3-y2)-(x3-x2)*(x2-x3));

s=[x2+u*(x3-x2), y2+u*(y3-y2)];

% close all
% plot([g1(1) g2(1)],[g1(2) g2(2)])
% hold on
% plot(p(1),p(2),'+r')
% plot(s(1),s(2),'+g')
% axis equal

end