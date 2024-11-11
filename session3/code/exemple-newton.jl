using LinearAlgebra
using Plots
using Optim
using LaTeXStrings

include("toolbox.jl")


f(x, y) = exp(x +3*y - 0.1) + exp(x -3*y - 0.1) + exp(-x - 0.1)
dfdx(x,y) = [(exp(x +3*y - 0.1) + exp(x -3*y - 0.1) - exp(-x - 0.1)), (3*exp(x +3*y - 0.1) -3*exp(x -3*y - 0.1))]
d2fd2x(x,y) = [(exp(x +3*y - 0.1) + exp(x -3*y - 0.1) +exp(-x - 0.1)) (3*exp(x +3*y - 0.1) -3*exp(x -3*y - 0.1));(3*exp(x +3*y - 0.1) -3*exp(x -3*y - 0.1)) (9*exp(x +3*y - 0.1) +9*exp(x -3*y - 0.1)) ]


xs = range(-2, stop=.6, length=100)
ys = range(-.5, stop=.5, length=100)





xinit = [-2, .5]
zn = NewtonMethod2DFixed(xinit, dfdx, d2fd2x, 1, niter=20)
zn3 = GradientMethod2DBacktracking(xinit, dfdx, 1,  niter=50, s=0.3, eta=0.5)

contourf(xs,ys, f, label="", cmap=:viridis,
         background_color=:transparent,
         background_color_legend=:white,
         grid=false
        )
plot!(zn[1, :], zn[2, :], linewidth=2, label="Newton à pas fixe", marker=:circle)
plot!(zn3[1, :], zn3[2, :], linewidth=2, marker=:circle, label="Gradient avec backtracking")
xlabel!("x")
ylabel!("y")

name_generic = string("../figs/",PROGRAM_FILE)
name = replace(name_generic, ".jl" => "-vs-gd-traj.svg")
savefig(name)


# comparaison
xopt = zn[:, end]

errorNewton = sum(abs2, zn .-xopt,dims=1)'
#erroropt = sum(abs2, zn2 .-xopt,dims=1)'
errorGrad  = sum(abs2, zn3 .-xopt,dims=1)'


plot(errorNewton, yscale=:log10, label="Newton à pas fixe", linewidth=2,
     background_color=:transparent,
     background_color_legend=:white
    )
plot!(errorGrad, yscale=:log10, label="Gradient avec backtracking", linewidth=2)
xlabel!("iterations")
#ylabel!(L"\Vert \mathbf{x}^{(k)} - \mathbf{x}^\star\Vert^2")
ylabel!("distance au minimiseur")
ylims!((1e-16, 10))

name = replace(name_generic, ".jl" => "-vs-gd-cv.svg")
savefig(name)
