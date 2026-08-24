function [X,y] = data3class(n0)
%DATA3CLASS Tri-class spiral-shaped data (labelled)
%   n : number of samples per class

d = 2;   % dimensionality
k = 3;   % number of classes
n = n0*k; % Total number of points
X = zeros(d,n);
y = zeros(1,n);
for j=1:k
    I = n0*(j-1)+1:n0*j;
    r = linspace(0.0,0.9,n0); % radius
    t = linspace(j*4,(j+1)*4.2,n0) + randn(1,n0)*0.2; % angle
    X(:,I) = [r.*sin(t); r.*cos(t)];
    y(1,I) = j;
end



end