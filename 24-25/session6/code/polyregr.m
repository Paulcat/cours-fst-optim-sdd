function c = polyregr(d,x,fx)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

A = x(:).^(0:d);
c = A\fx(:);

end