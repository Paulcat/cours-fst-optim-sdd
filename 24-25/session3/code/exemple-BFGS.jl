using Plots
using LinearAlgebra
using Optim
using LaTeXStrings

include("toolbox.jl")


f(x, y) = exp(x +3*y - 0.1) + exp(x -3*y - 0.1) + exp(-x - 0.1)
dfdx(x,y) = [(exp(x +3*y - 0.1) + exp(x -3*y - 0.1) - exp(-x - 0.1)), (3*exp(x +3*y - 0.1) -3*exp(x -3*y - 0.1))]
d2fd2x(x,y) = [(exp(x +3*y - 0.1) + exp(x -3*y - 0.1) +exp(-x - 0.1)) (3*exp(x +3*y - 0.1) -3*exp(x -3*y - 0.1));(3*exp(x +3*y - 0.1) -3*exp(x -3*y - 0.1)) (9*exp(x +3*y - 0.1) +9*exp(x -3*y - 0.1)) ]


xs = range(-2, stop=.6, length=100)
ys = range(-.5, stop=.6, length=100)



xinit = [-2, .5]
zn1 = BFGS(xinit, dfdx, inv(d2fd2x(xinit[1], xinit[2])), 1, niter=50, s=0.3, eta=0.5)
zn2 = NewtonMethod2DFixed(xinit, dfdx, d2fd2x, 1, niter=20)
zn3 = GradientMethod2DBacktracking(xinit, dfdx, 1,  niter=50, s=0.1, eta=0.5)

contourf(xs,ys, f, label="", cmap=:viridis,
         background_color = :transparent,
         background_color_legend = :white,
         grid = false
        )
plot!(zn1[1, :], zn1[2, :], linewidth=2, label="BFGS (backtracking)", marker=:circle)
plot!(zn2[1, :], zn2[2, :], linewidth=2, label="Newton (fixe)", marker=:circle)
plot!(zn3[1, :], zn3[2, :], linewidth=2, marker=:circle, label="Gradient (backtracking)")
xlabel!("x")
ylabel!("y")

name_generic = string("../figs/",PROGRAM_FILE)
name = replace(name_generic, ".jl" => "-comparison-traj.svg")
savefig(name)



# comparaison
xopt = zn2[:, end]

errorNewton = sum(abs2, zn2 .-xopt,dims=1)'
errorGrad  = sum(abs2, zn3 .-xopt,dims=1)'
errorBFGS = sum(abs2, zn1 .-xopt,dims=1)'


plot(errorNewton, yscale=:log10, label="Newton (fixe)", linewidth=3,
     background_color = :transparent,
     background_color_legend = :white,
     legend = :topright
    )
plot!(errorGrad, yscale=:log10, label="Gradient (backtracking)", linewidth=3)
plot!(errorBFGS, yscale=:log10, label="BFGS (backtracking)", linewidth=3)
xlabel!("iterations")
ylabel!("distance au minimiseur")
ylims!((1e-16, 10))

name = replace(name_generic, ".jl" => "-comparison-cv.svg")
savefig(name)

