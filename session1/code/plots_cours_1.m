% plots cours 1

%% plot optim cylindre

V0 = 1000;

r = linspace(1.5,16.5,100);

A1 = 2*pi*V0./r;
A2 = 2*pi*r.^2;
A  = A1 + A2;

clf;
p2 = plot(r,A2,'-d','MarkerFaceColor',[0 0.4470 0.7410],'linewidth',2);
p2.MarkerIndices = 1:3:length(r);
hold on;
%
p1 = plot(r,A1,'-o','MarkerFaceColor',[0.8500 0.3250 0.0980],'linewidth',2);
p1.MarkerIndices = 1:3:length(r);
%
p3 = plot(r,A,'-','linewidth',2);
hold off

grid on
xlim([1,17]);
ylim([-100,4500]);
yticks(0:1000:4500);
box off

xlabel('rayon (cm)','interpreter','latex');
ylabel('valeur objectif (cm$^2$)','interpreter','latex');

legend('aire des couvercles','aire du cylindre','aire totale');
set(gca,'fontsize',17);


%% plot transport optimal (from Gabriel's Numerical Tours)

addpath('~/Workspace/build/toolbox_signal/');
addpath('~/Workspace/build/toolbox_general/');

flat = @(x)x(:);
Cols = @(n0,n1)sparse( flat(repmat(1:n1, [n0 1])), ...
             flat(reshape(1:n0*n1,n0,n1) ), ...
             ones(n0*n1,1) );
Rows = @(n0,n1)sparse( flat(repmat(1:n0, [n1 1])), ...
             flat(reshape(1:n0*n1,n0,n1)' ), ...
             ones(n0*n1,1) );
Sigma = @(n0,n1)[Rows(n0,n1);Cols(n0,n1)];


maxit = 1e4; tol = 1e-9;
otransp = @(C,p0,p1)reshape( perform_linprog( ...
        Sigma(length(p0),length(p1)), ...
        [p0(:);p1(:)], C(:), 0, maxit, tol), [length(p0) length(p1)] );


n0 = 4;
n1 = 5;

gauss = @(q,a,c)a*randn(2,q)+repmat(c(:), [1 q]);
X0 = randn(2,n0)*.3;
X1 = .5 * [gauss(1,.5, [0 .5]) gauss(2,.3, [-.5 -.5]) gauss(2,.3, [-.2 .1])];

normalize = @(a)a/sum(a(:));
mass = 100;
%p0 = normalize(rand(n0,1));
%p1 = normalize(rand(n1,1));
p0_ = sort(randi(mass,n0-1,1));
p0 = normalize([p0_(1);diff(p0_);mass-p0_(end)]);

p1_ = sort(randi(mass,n1-1,1));
p1 = normalize([p1_(1);diff(p1_);100-p1_(end)]);

myplot = @(x,y,style,ms,col)plot(x,y, style, 'MarkerSize', 4*ms, 'MarkerEdgeColor', col, 'MarkerFaceColor', col, 'LineWidth', 2);



clf; hold on;
for i=1:length(p0)
    myplot(X0(1,i), X0(2,i), '.', p0(i)*length(p0)*10, [0 0.4470 0.7410]);
end
for i=1:length(p1)
    myplot(X1(1,i), X1(2,i), 's', p1(i)*length(p1)*3, [0.8500 0.3250 0.0980]);
end
%axis([min(X1(1,:)) max(X1(1,:)) min(X1(2,:)) max(X1(2,:))]); %axis off;

pause(1);


C = repmat( sum(X0.^2)', [1 n1] ) + ...
    repmat( sum(X1.^2), [n0 1] ) - 2*X0'*X1;

%C = sum(abs(reshape(X0',[n0,1,2]) - reshape(X1',[1,n1,2])),3);


gamma = otransp(C,p0,p1);



clf; hold on;
[I,J,~] = find(gamma);
for k=1:length(I)
    %h = plot( [X0(1,I(k)) X1(1,J(k))], [X0(2,I(k)) X1(2,J(k))], 'k' );
    q = quiver( ...
         X0(1,I(k)) + .05*(X1(1,J(k))-X0(1,I(k))),...
         X0(2,I(k)) + .05*(X1(2,J(k))-X0(2,I(k))),...
         1.05*(X1(1,J(k))-X0(1,I(k))),...
         1.05*(X1(2,J(k))-X0(2,I(k)))...
    );
    %set(q, 'color','k','markersize',20);
    q.ShowArrowHead = 0;
    q.Marker = '.';
    set(q,'markersize',10,'color','k','linewidth',15*gamma(I(k),J(k)));
end
for i=1:length(p0)
   myplot(X0(1,i), X0(2,i), '.', p0(i)*length(p0)*10, [0 0.4470 0.7410]);
end
for i=1:length(p1)
   myplot(X1(1,i), X1(2,i), 's', p1(i)*length(p1)*3, [0.8500 0.3250 0.0980]);
end
%axis([min(X1(1,:)) max(X1(1,:)) min(X1(2,:)) max(X1(2,:))]); %axis off;



