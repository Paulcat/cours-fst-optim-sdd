using Plots
using LinearAlgebra
using LaTeXStrings
using Optim

include("toolbox.jl")

# fonction quadratique
gamma = 10
f(x,y; gamma=10) = 1/2*(x^2 + gamma*y^2)
gradf(x,y; gamma=10) = [x,gamma*y]


# constante de Lipschitz
L = max(1,gamma)


name_generic = string("../td3/",PROGRAM_FILE)


#xinit = [8,3]
xinit = [gamma,1]

# various constant steps
#alphas = range(0.1, 1, 4)*2/L
alphas = [0.02,0.08,0.14,0.2]

for (i, alpha) in enumerate(alphas)
    zn = GradientMethod2DFixed(xinit, gradf, alpha, niter=100)
    error = zn[1, :].^2+ zn[2, :].^2
    errorf = f.(zn[1,:],zn[2,:])
    if i == 1
     plot(errorf, yscale=:log10, lw=3, color=:auto, linestyle=:auto, label="α = $(alpha)",
             background_color=:transparent,
             background_color_legend=:white
            )
    else
        plot!(errorf, yscale=:log10, lw=3, linestyle=:auto, label="α = $(alpha)")
    end
end
xlabel!("iterations")
#ylabel!("distance au minimiseur")
ylabel!("valeur de l'objectif")

name = replace(name_generic,".jl" => "-constant-cvf-initg.svg")
#savefig(name)
name2 = replace(name,".svg" => ".png")
savefig(name2)



# fonction exp
f(x,y) = exp(x + 3*y - 0.1) + exp(x - 3*y -0.1) + exp(-x -0.1)
dfdx(x,y) = [(exp(x +3*y - 0.1) + exp(x -3*y - 0.1) - exp(-x - 0.1)), (3*exp(x +3*y - 0.1) -3*exp(x -3*y - 0.1))]

xs = range(-2, stop=.6, length=100)
ys = range(-.5, stop=.5, length=100)


xinit = [-2, .5]



# various methods

# pas fixe
zn = GradientMethod2DFixed(xinit, dfdx, 0.1, niter=100)


# calcul du pas optimal
zn2, alphan = GradientMethod2DOptimal2(xinit, f, dfdx, niter=100);


# backtracking
zn_back = GradientMethod2DBacktracking(xinit, dfdx, 1,  niter=100, s=0.3, eta=0.5)


# comparaison
g(x) = f(x[1], x[2])
res = optimize(g, xinit, Newton())
xopt = Optim.minimizer(res)

errorFixe = sum(abs2, zn .-xopt,dims=1)'
erroropt = sum(abs2, zn2 .-xopt,dims=1)'
errorBack  = sum(abs2, zn_back .-xopt,dims=1)'


plot(erroropt, yscale=:log10, lw=3,#label="erreur pas optimal",
     background_color=:transparent,
     background_color_legend=:white
     )
plot!(errorFixe, yscale=:log10, lw=3#,label="erreur pas fixe"
      )
plot!(errorBack, yscale=:log10, lw=3#,label="erreur backtracking"
      )

xlabel!("iterations")
ylabel!("distance au minimiseur")
ylims!((1e-15, 2))

name = replace(name_generic, ".jl" => "-fix-opt-back-cv.svg")
#savefig(name)
name = replace(name, ".svg" => ".png")
savefig(name)
