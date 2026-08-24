% Données XOR
X = [0 0; 0 1; 1 0; 1 1]'; % Entrées
Y = [0 1 1 0];             % Sorties

% Création du réseau de neurones
layer_width = 3;       % Nombre modéré de neurones cachés
net = feedforwardnet(layer_width);

% Configuration du réseau
net.performFcn = 'mse';
net.trainFcn = 'trainlm';   % help nntrain
net.layers{1}.transferFcn = 'poslin'; % help nntransfer
%net.layers{2}.transferFcn = 'logsig';

% Normalisation automatique
%net.input.processFcns = {'mapminmax'};
%net.output.processFcns = {'mapminmax'};

% Paramètres d'entraînement
net.divideFcn = 'dividetrain';
net.trainParam.epochs = 1000; 
net.trainParam.goal = 1e-8; 
net.trainParam.lr = 0.005; 


% Entraînement
[net_trained, tr] = train(net, X, Y);

% Test du réseau
Y_pred = net_trained(X);
Y_pred_rounded = round(Y_pred); % Arrondi des sorties pour 0 ou 1

% Résultats
disp('Sorties attendues :');
disp(Y);
disp('Sorties prédites :');
disp(Y_pred_rounded);

% Visualisation des performances
clf;
plotperform(tr); % Affichage de la 


% Entrainement avec division en ensemble d'entrainement/de validation/de
% test
%net.divideFcn = 'dividerand';
%[net_trained,tr] = train(net, [X,X,X],[Y,Y,Y]);

% Full classification
[B,A] = meshgrid(0:0.01:1);
F = [A(:) B(:)]';
M = net_trained(F);
M = reshape(M,[101,101])';
clf, imagesc([0,1],[0 1],round(M)); colorbar;




%% Données banane

n0 = 200; % number of points per class
[X,y] = data2class(n0);

nclass = 2;
col = {'r' 'b'};
clf; hold on;
for j=1:nclass
    I = find(y==j);
    plot(X(1,I), X(2,I), '.', 'color', col{j}, 'MarkerSize', 20);
end
xlim([-1,1]);
ylim([-1,1]);


nn = feedforwardnet([4,3,8,4]); % --> test architecture
%nn.output.processFcns = {'mapminmax'};
[nn_trained,tr] = train(nn,X,y);

% Generate new, unlabeled data
[Xnew,y_new] = data2class(200);
y_pred = nn_trained(Xnew);
y_pred_rounded = round(y_pred);


% Full classification
[B,A] = meshgrid(-1:0.01:1);
F = [A(:) B(:)]';
M = nn_trained(F);
M = reshape(M,[201,201])';
clf, imagesc([-1,1],[-1 1],round(M)); colorbar;


hold on;
for j=1:nclass
    I = find(y_pred_rounded==j);
    plot(Xnew(1,I), Xnew(2,I), '.', 'color', col{j}, 'MarkerSize', 10);

    I_true = find(y_new==j);
    plot(Xnew(1,I_true), Xnew(2,I_true), 'o', 'color', col{j}, 'MarkerSize', 10);
end
xlim([-1,1]);
ylim([-1,1]);



%% Données spirales

n0 = 400; % number of points per class
[X,y] = data3class(n0);

nclass = 3;
col = {'r' 'g' 'b'};
clf; hold on;
for j=1:nclass
    I = find(y==j);
    plot(X(1,I), X(2,I), '.', 'color', col{j}, 'MarkerSize', 20);
end
xlim([-1,1]);
ylim([-1,1]);


nn = feedforwardnet([4,3,2]); % --> test architecture
nn.performFcn = 'mse';
%nn.output.processFcns = {'mapminmax'};
nn.trainFcn = 'trainlm';
nn.trainParam.goal = 1e-9;
nn.trainParam.epochs = 1000;
[nn_trained,tr] = train(nn,X,y);

% Generate new, unlabeled data
[Xnew,y_new] = data3class(200);
y_pred = nn_trained(Xnew);
y_pred_rounded = round(y_pred);

% Full classification
[B,A] = meshgrid(-1:0.01:1);
F = [A(:) B(:)]';
M = nn_trained(F);
M = reshape(M,[201,201])';
clf, imagesc([-1,1],[-1 1],M); colorbar;

hold on;
for j=1:nclass
    I = find(y_pred_rounded==j);
    plot(Xnew(1,I), Xnew(2,I), '.', 'color', col{j}, 'MarkerSize', 10);

    I_true = find(y_new==j);
    plot(Xnew(1,I_true), Xnew(2,I_true), 'o', 'color', col{j}, 'MarkerSize', 10);
end
xlim([-1,1]);
ylim([-1,1]);
