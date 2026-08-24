using Plots
using LinearAlgebra
using LaTeXStrings
using Optim

include("toolbox.jl")

# fonction quadratique
gamma = 10
f(x,y; gamma=10) = 1/2*(x^2 + gamma*y^2)
gradf(x,y; gamma=10) = [x,gamma*y]

# fonction de Rosenbrock
# R(x,y; a=1, b=5) = (a-x)^2 + b*(y-x^2)^2
# gradR(x,y; a=1, b=5) = [2*(a-x) - 4*b*x*(y-x^2), 2*b*(y-x^2)]

# constante de Lipschitz
L = max(1,gamma)


name_generic = string("../figs/",PROGRAM_FILE)


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


xs = range(-10, stop=10, length=100)
ys = range(-4, stop=4, length=100)


contourf(xs,ys, f, label="", cmap=:viridis,
         background_color=:transparent,
         background_color_legend=:white,
         grid = false
        )
for (i, alpha) in enumerate(alphas)
    zn = GradientMethod2DFixed(xinit, gradf, alpha, niter=100)

    plot!(zn[1, :], zn[2, :], linewidth=2, #label="α = $(alpha)",
          color=:auto, marker=:circle)
    #scatter!(zn[1, :], zn[2, :], ms=3, label="")

end
xlabel!("x")
ylabel!("y")

name = replace(name_generic, ".jl" => "-constant-traj.svg")
#savefig(name)
name2 = replace(name,".svg" => ".png")
savefig(name2)




# fix vs optimal
znfixe = GradientMethod2DFixed(xinit, gradf, 2/(L+1), niter=300)
zn, alphan = GradientMethod2DOptimal(xinit, gradf, 10, niter=300)

contourf(xs,ys, f, label="", cmap=:viridis,
         background_color=:transparent,
         grid=false
        )
plot!(zn[1, :], zn[2, :], linewidth=2, label="")
scatter!(zn[1, :], zn[2, :], linewidth=2, label="")
xlabel!("x")
ylabel!("y")

name = replace(name_generic, ".jl" => "-optimal.svg")

# plot two strategies 
contourf(xs,ys, f, label="", cmap=:viridis,background_color=:transparent,grid=false,background_color_legend=:white)
plot!(znfixe[1, :], znfixe[2, :], linewidth=3, label="pas fixe", color="violet")
#scatter!(znfixe[1, :], znfixe[2, :], linewidth=2, label="")
plot!(zn[1, :], zn[2, :], linewidth=3, label="pas optimal", color="orange")
#scatter!(zn[1, :], zn[2, :], linewidth=2, label="")
#savefig("01_exemple2D_comparison01.pdf")

name = replace(name_generic, ".jl" => "-constant-vs-optimal.svg")
#savefig(name)

error = sqrt.(zn[1, :].^2+ zn[2, :].^2)
errorfixe = sqrt.(znfixe[1, :].^2+ znfixe[2, :].^2)
plot(error, yscale=:log10, label="pas optimal", linewidth=3,background_color=:transparent)
plot!(errorfixe, yscale=:log10, label="pas fixe", linewidth=3)



xlabel!("iterations")
ylabel!("distance au minimiseur")

name = replace(name_generic, ".jl" => "-constant-vs-optimal2-initg.svg")
savefig(name)



# backtracking
f(x) = x^2
dfdx(x) = 2*x
xk = -1

linCost(t) = f(xk - t*dfdx(xk))
linApp(t) = f(xk) - t*dfdx(xk)^2

ts = range(0, 1, 100)

s = 0.2
plot(ts, linCost, label=L"f(x^{(k)}- \alpha \nabla f(x^{(k)})", linewidth=2,
     background_color=:transparent,
     background_color_legend=:white
    )
#plot!(ts, linApp)
plot!(ts, linApp.(s*ts), label=L"f(x^{(k)}) - s \alpha  \Vert\nabla f(x^{(k)})\Vert^2", linewidth=2)

t0 = 1
eta = 0.95

while linCost(t0) > linApp(s*t0)
    scatter!([t0], [linCost(t0)], label="", color="blue")
    scatter!([t0], [linApp(s*t0)], label="", color="red")
    vline!([t0], linestyle=:dash, label="", color="black")
    global t0 = eta*t0
end
scatter!([t0], [linCost(t0)], color="blue", label="")
scatter!([t0], [linApp(s*t0)], color="red", label="")
xlabel!(L"\alpha")
vline!([t0], linestyle=:dash, label="", color="black")
#annotate!([t0], -0.25, label="t_0 =($t0)", color="black")
title!("backtracking line search, s = $(s), η = $(eta)")

name = replace(name_generic,".jl" => "-backtracking04.svg")
#savefig(name)




# 2eme exemple
f(x, y) = exp(x +3*y - 0.1) + exp(x -3*y - 0.1) + exp(-x - 0.1)

dfdx(x,y) = [(exp(x +3*y - 0.1) + exp(x -3*y - 0.1) - exp(-x - 0.1)), (3*exp(x +3*y - 0.1) -3*exp(x -3*y - 0.1))]

xs = range(-2, stop=.6, length=100)
ys = range(-.5, stop=.5, length=100)


xinit = [-2, .5]


# pas fixe
zn = GradientMethod2DFixed(xinit, dfdx, 0.1, niter=100)


# calcul du pas optimal
zn2, alphan = GradientMethod2DOptimal2(xinit, f, dfdx, niter=100);


# backtracking
zn_back = GradientMethod2DBacktracking(xinit, dfdx, 1,  niter=100, s=0.3, eta=0.5)



contourf(xs,ys, f, label="", cmap=:viridis,
         background_color=:transparent,
         background_color_legend=:white,
         grid=false
        )
plot!(zn[1, :], zn[2, :], linewidth=2, label="pas fixe", marker=:circle)
plot!(zn2[1, :], zn2[2, :], linewidth=2, label="pas optimal",  marker=:circle)
plot!(zn_back[1, :], zn_back[2, :], linewidth=2, label="pas backtracké",  marker=:circle)
xlabel!("x")
ylabel!("y")

name = replace(name_generic, ".jl" => "-fix-opt-back-traj.svg")
#savefig(name)
name = replace(name, ".svg" => ".png")
savefig(name)


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
