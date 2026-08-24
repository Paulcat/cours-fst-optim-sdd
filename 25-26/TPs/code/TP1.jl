using Plots
using LinearAlgebra
using LaTeXStrings

# Simulation des donnees non bruitees
x = collect(0:0.5:15) # grille
N = length(x)
h = [500, 10, -10, -5, 0.4] # coefficients du polynome

X = cat(x.^0,x,x.^2,x.^3,x.^4,dims=2)
y = sum(h' .* X, dims=2) # observations

# affichage
plot(x,y,line=(2),marker=(5,:circle),label=L"Echantillons non bruités (inconnus), $\sigma=0$",legendfont=font(13),tickfontsize=13)
#savefig("mesures_sans_bruit.png")


# Ajout du bruit
mu = 0
sigma = 100
b = mu .+ sigma*randn(N,1)

# mesures bruitees
yb = y .+ b

# affichage
plot!(x,yb,line=(2),marker=(5,:xcross),label=L"Echantillons bruités (mesurés), $\sigma = %$sigma$",legendfont=font(13),tickfontsize=13)
savefig("mesures_bruit.png")

plot(x,b,linewidth=2,color=2,label="Bruit gaussien",legendfont=font(13),tickfontsize=13)
savefig("bruit_seul.png")


# Energie du bruit et sigma
n_scales = 10
Wb = zeros(n_scales,1)
for (id,scale) in enumerate(range(0,stop=4,length=n_scales))
   si = 10^scale
   bi = mu .+ si*randn(N,1)
   
   Wb[id] = norm(bi)^2
end

plot(10 .^ range(0,stop=4,length=n_scales),Wb,xaxis=:log,yaxis=:log,linewidth=2,label="Energie du bruit",legendfont=font(13),tickfontsize=13)
savefig("Wb.png")


#  Affichage de la SVD de la matrice X
U, S, V = svd(X)
plot(S,line=(2),marker=(5,:circle),label="Valeurs singulières de X", legendfont=font(13),yaxis=:log,tickfontsize=13)
savefig("sing_values.png")


# Affichage de la sortie estimee
h_est = pinv(X)*yb
y_est = X*h_est

plot(x,y,line=(2),marker=(5,:circle),label="Vrais echantillons",legendfont=font(13),tickfontsize=13)
plot!(x,yb,line=(2),marker=(5,:xcross),label=L"Echantillons bruités ($\sigma = %$sigma$)", legendfont=font(13))
plot!(x,y_est,line=(2),marker=(5,:diamond),label="Reconstruction",legendfont=font(13))
savefig("reconstruction.png")

plot(x,y_est-yb,line=(2),label=L"Résidus (y_b - y_{est})",legendfont=font(13),tickfontsize=13)
savefig("residus.png")

# Test pour differents degres
dmax = 10

scatter(x,yb,marker=(5,:circle),label="Bruités ",legendfont=font(13),tickfontsize=13)
for d in 1:dmax
   Xd = hcat([x.^k for k in 0:d]...)
   hd = pinv(Xd)*yb
   yd = Xd*hd

   plot!(x,yd,line=(2),label=L"$d=%$d$",legendfont=font(13),legend=:outertopleft)
end
savefig("degres.png")

# Critère d'Akaike
dmax = 10
akaike = zeros(dmax)
for d in 1:dmax
   Xd = hcat([x.^k for k in 0:d]...)
   h_est_d = pinv(Xd)*yb
   y_est_d = Xd*h_est_d
   residu_d = yb-y_est_d

   akaike[d] = 2*log(norm(residu_d)^2) + 2*(d+1)
end

plot(1:dmax,akaike,line=(2),xlabel="Degré du polynôme (modèle)",label="Critère d'Akaike",legendfont=font(13),tickfontsize=13,guidefontsize=13)
savefig("akaike.png")
