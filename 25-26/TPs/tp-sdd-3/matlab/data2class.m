function [X,y] = data2class(n0)
%DATA2CLASS Bi-class banana-shaped data (labelled)
%   n0 : number of samples per class

d = 2;   % dimensionality
k = 2;   % number of classes
n = n0*k; % Total number of points
X = zeros(d,n);
y = zeros(1,n);
r0 = 0.3;
t0 = pi/4;
c  = [0.02 -0.15; -0.02 0.15]';
for j=1:k
    I = n0*(j-1)+1:n0*j;
    r = r0 + randn(1,n0).*linspace(0.04,0.05,n0); % radius
    t = t0 * linspace(j*4,(j+1)*4.2,n0) + randn(1,n0)*0.1; % angle
    X(:,I) = c(:,j) + [r.*sin(t); r.*cos(t)];
    y(1,I) = j;
end


end