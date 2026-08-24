% covariance of gaussian vector


Sigma1 = eye(2);
Sigma2 = 1/10*diag([1,10]);
Sigma3 = rand(2,2); Sigma3 = Sigma3*Sigma3';
mu = [0;0];

X = mvnrnd(mu,Sigma1,2000);
%
scatter(X(:,1),X(:,2),50,'.')
xlim([-4,4]);
ylim([-4,4]);
axis off

%%

X = mvnrnd(mu,Sigma2,2000);
%
scatter(X(:,1),X(:,2),50,'.')
xlim([-4,4]);
ylim([-4,4]);
axis off

%%
% 
% X = mvnrnd(mu,Sigma4,2000);
% %
% scatter(X(:,1),X(:,2),50,'.')
% xlim([-4,4]);
% ylim([-4,4]);
% axis off