addpath("matlab")
load("td_tenseurs.mat");

X = double ( imread ('cameraman.tif'));
X = X(: ,1:220);

[U,S,V] = svd(X);

r = 80;
Xr = U(:,1:r)*S(1:r,1:r)*V(:,1:r)';

err = norm(X-Xr,'fro');