function X = outerprod (A, B)
% function X = outerprod (A, B)
% A, B : Tenseurs
% X : Résultat du produit extérieur

sA = size(A); sA = sA(sA >1);
sB = size(B); sB = sB(sB >1);
sX = [sA sB];
X = reshape (kron(B(:) ,A(:)), sX);

end