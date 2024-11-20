% figures

cl1 = [0 0.4470 0.7410]; % blue;
cl4 = [0.8500 0.3250 0.0980]; % orange
cl2 = [0.4940 0.1840 0.5560]; % purple
cl3 = [0.9290 0.6940 0.1250]; % yellow

%% relu
a = -3; b = 1.5;
x = linspace(a,b,1000);

txt = {'\sigma(t)'};

clf, plot([a,b],[0,0],'k--','linewidth',2);
hold on
pl = plot(x,max(x,0),'linewidth',4,'color',cl1);
text(-0.8,-0.2,"ReLU",'color','k','fontsize',40);
text(-0.5,1,txt,'color',[0 0.4470 0.7410],'fontsize',40);
%axis off
axis tight
ylim([-0.5,1.5]);
set(gca,'fontsize',20);
exportgraphics(gcf,'../figs/relu.eps','BackgroundColor','none');

%% sigmoid

a = -10; b= 10;
x = linspace(a,b,1000);

txt = {'\sigma(t)'};

clf, plot([a,b],[0,0],'k--','linewidth',2);
hold on
pl = plot(x,1./(1+exp(-x)),'linewidth',4,'color',cl1);
text(-3,-0.2,"Sigmoid",'color','k','fontsize',40);
text(-5,0.5,txt,'color',[0 0.4470 0.7410],'fontsize',40);
%axis off
ylim([-0.5,1.5]);
set(gca,'fontsize',20);
exportgraphics(gcf,'../figs/sigmoid.eps','BackgroundColor','none');

%% swish

a = -4; b= 1.5;
x = linspace(a,b,1000);

txt = {'\sigma(t)'};

beta = 2;

clf, plot([a,b],[0,0],'k--','linewidth',2);
hold on
pl = plot(x,x./(1+exp(-beta*x)),'linewidth',4,'color',cl1);
text(-1.7,-0.3,"SiLU",'color','k','fontsize',40);
text(-1,0.5,txt,'color',[0 0.4470 0.7410],'fontsize',40);
%axis off
axis tight
ylim([-0.5,1.5]);
set(gca,'fontsize',20);
exportgraphics(gcf,'../figs/swish.eps','BackgroundColor','none');

%% exemple regression

f = @(x)2*x.^5 - 3*x.^3 + 4*x.^2 - x + 10;

% generate data
s = -0.6:0.05:0.8;
n = length(s);
%x = f(t) + 0.2*randn(1,n);
x = load('donnees-regression.mat');
x = x.x;

clf, sc = scatter(s,x,150,cl1,'filled');
xlim([-0.7,0.9]), ylim([9.5,12.5]);
axis off

t = linspace(-0.6,0.8,1000);

% polynomial fit
d1 = 1;
c1 = polyregr(d1,s,x);
f1 = sum( c1(:)' .* t(:).^(0:d1), 2);
hold on, pl1 = plot(t,f1,'linewidth',6,'color',cl4);


legend([sc,pl1],"$(x_i,y_i)$","$f_\theta$",...
   'Interpreter','latex','fontsize',50);
legend('boxoff');

exportgraphics(gcf,'../figs/regression-lin.eps','BackgroundColor','none');

d2 = 2;
c2 = polyregr(d2,s,x);
f2 = sum( c2(:)' .* t(:).^(0:d2), 2);
hold on, pl2 = plot(t,f2,'linewidth',6,'color',cl3);

%text(-0.6,9.4,"Regression: y= f(x)",'color','k','fontsize',40);

legend([sc,pl1,pl2],"$(x_i,y_i)$","$f_\theta$","$f_{\theta'}$",...
   'Interpreter','latex','fontsize',50);
%legend([pl1,pl2],'$f_\theta$',"$f_{\theta'}$",...
%    'Interpreter','latex','fontsize',50);
exportgraphics(gcf,'../figs/regression.eps','BackgroundColor','none');

%% exemple regression (hack...)

f = @(x)2*x.^5 - 3*x.^3 + 4*x.^2 - x + 10;
t = linspace(-0.6,0.8,1000);

x0 = -0.7; y0 = 12.5;
x1 = 0;    y1 = 10;
x2 = 0.37; y2 = 9.87;
x3 = 0.80; y3 = 10.64;
%
a1 = (y0-y1)/(x0-x1);
b1 = 10;
%plot(t,a1*t+b1,'linewidth',3);

a2 = (y1-y2)/(x1-x2);
b2 = 10;
%plot(t,a2*t+b2,'linewidth',3);

a3 = (y2-y3)/(x2-x3);
b3 = 9.2;
%plot(t,a3*t+b3,'linewidth',3);

% random samples above
n  = 5000;
x  = [-0.7,9.5] + [1.6,2].*rand(n,2);
gx = 1/3.2 * ( ...
    (x(:,1) < x1 & a1*x(:,1)+b1+.15 < x(:,2)) | ...
    (x1 <= x(:,1) & x(:,1) < x2 & a2*x(:,1)+b2+.15 < x(:,2)) | ...
    (x2 < x(:,1) & a3*x(:,1)+b3+.15 < x(:,2)));
U  = rand(n,1);
P1 = x(U<gx,:);
P1 = P1(1:30,:);

% random samples below
x  = [-0.7,9.5] + [1.6,3].*rand(n,2);
gx = 1/4.8 * ( ...
    (x(:,1) < x1 & a1*x(:,1)+b1-.15 >= x(:,2)) | ...
    (x1 <= x(:,1) & x(:,1) < x2 & a2*x(:,1)+b2-.15 >= x(:,2)) | ...
    (x2 < x(:,1) & a3*x(:,1)+b3-.15 >= x(:,2)));
U  = rand(n,1);
P2 = x(U<gx,:);
P2 = P2(1:30,:);

P = load("donnees-classification.mat");
P1 = P.P1;
P2 = P.P2;

t2  = linspace(-0.55,0.8,1000);
f1 = sum( c1(:)' .* t2(:).^(0:d1), 2);
f2 = sum( c2(:)' .* t2(:).^(0:d2), 2);

clf, plot(t2,-f1,'linewidth',6,'color',cl4);
hold on;
scatter(P1(:,1),-P1(:,2),120,cl1,'filled');
scatter(P2(:,1),-P2(:,2),120,cl2,'filled');
axis tight, axis off
%xlim([-2,2]), 
ylim([-11.5,-9.5]);
text(0.2,-9.6,"$y=+1$",'color',cl2,'fontsize',40,'interpreter','latex');
text(-0.15,-11.1,"$y=-1$",'color',cl1,'fontsize',40,'interpreter','latex');
exportgraphics(gcf,'../figs/classification-lin.eps','BackgroundColor','none');
plot(t2,-f2,'linewidth',6,'color',cl3);
exportgraphics(gcf,'../figs/classification.eps','BackgroundColor','none');