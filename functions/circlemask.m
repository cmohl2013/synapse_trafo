%function M=circlemask(xc,yc,r,masksize)
%draws a circular mask, moehl 2012

function M=circlemask(xc,yc,r,masksize)
nx=masksize(1);
ny=masksize(2);

M = zeros(nx,ny);

Ix = 1:nx;Iy=1:ny;

%x = Ix-nx+xc;
%y = Iy-ny+yc;


x = Ix-xc;
y = Iy-yc;


[X,Y] = meshgrid(y,x);
R = r;
A = (X.^2 + Y.^2 <= R^2);
M(A) = 1;

