% Données XOR
X = [0 0; 0 1; 1 0; 1 1]'; % Entrées
Y = [0 1 1 0];             % Sorties binaires

% Encodage des sorties pour entropie croisée (vecteurs catégoriels)
Y_categorical = ind2vec(Y + 1); % Transforme [0,1] en vecteurs [1 0], [0 1]

% Réseau avec MSE
hiddenLayerSize = 10;
net_mse = feedforwardnet(hiddenLayerSize);
net_mse.trainFcn = 'trainscg';
net_mse.divideFcn = 'dividetrain';
net_mse.performFcn = 'mse'; % Fonction de coût MSE
net_mse = configure(net_mse, X, Y); % Configurer pour sorties scalaires

% Réseau avec Entropie Croisée
net_ce = patternnet(hiddenLayerSize);
net_ce.trainFcn = 'trainscg';
net_ce.divideFcn = 'dividetrain';
net_ce.performFcn = 'crossentropy'; % Fonction de coût Entropie Croisée

% Entraînement
disp('Entraînement avec MSE...');
[net_mse, tr_mse] = train(net_mse, X, Y);

disp('Entraînement avec Entropie Croisée...');
[net_ce, tr_ce] = train(net_ce, X, Y_categorical);

% Prédictions
Y_pred_mse = round(net_mse(X)); % Sorties arrondies pour classification
Y_pred_ce = vec2ind(net_ce(X)) - 1; % Classes prédites par Entropie Croisée

% Résultats
disp('Résultats avec MSE :');
disp(Y_pred_mse');
disp('Résultats avec Entropie Croisée :');
disp(Y_pred_ce');

% Visualisation des performances
figure;
subplot(1, 2, 1);
plotperform(tr_mse);
title('Performance avec MSE');

subplot(1, 2, 2);
plotperform(tr_ce);
title('Performance avec Entropie Croisée');