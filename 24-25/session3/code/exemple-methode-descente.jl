using Plots
using LinearAlgebra
using LaTeXStrings
# using PlotlyJS

# fonction de ?
f(x,y) = exp(x +3*y -0.1) + exp(x -3*y -0.1) + exp(-x -0.1)
gradf(x,y) = [(exp(x +3*y -0.1) + exp(x -3*y -0.1) - exp(-x -0.1)), (3*exp(x +3*y -0.1) -3*exp(x -3*y -0.1))]

xs = range(-2,stop=.6,length=100)
ys = range(-.5,stop=.5,length=100)

alpha = 0.1


niter = 7
x0 = [-2,.5]
xk = zeros(2,niter+1)
#sk = String[]
xk[:,1] = x0
for k in 1:niter
    xk[:,k+1] = xk[:,k] - alpha*gradf(xk[1,k], xk[2,k])
#    if k <= 5
#        push!(sk,"x"*Char(0x2080+k-1))
#    else
#        push!(sk,"")
#    end
end
#push!(sk,L"\ldots")


contourf(xs,ys,f,
         grid=false,
         framestyle=:box,
         label="",
         cmap=:viridis,
         lw=2,
         background_color=:transparent)
plot!(xk[1,:],xk[2,:], linewidth=3, label="")
#scatter!(xk[1,:], xk[2,:], series_annotations=text.(sk,:top,16,color=:white), label="")
scatter!(xk[1,:],xk[2,:],ms=4,label="")
scatter!([0],[0],color=:red,ms=4,label="")

scalefontsizes(1.3)

name = string("../figs/",PROGRAM_FILE)
name = replace(name, ".jl" => "-exp.svg")
#savefig(name)
name2 = replace(name, ".svg" => ".png")
savefig(name2)



# fonction de Rastrigin
R(x,y) = 20 + x^2 - 10*cos(2pi*x) + y^2 - 10*cos(2pi*y)
gradR(x,y) = [2*x + 20pi*sin(2pi*x);; 2*y + 20pi*sa julia siez julia lin(2pi*y)] # hack for having a line vector?

xs = range(-0.5, stop=2.5, length=100)
ys = range(-1, stop=3, length=100)


niter = 5
x0 = [[-0.3,0.5,1.8];;[2.5,-0.4,1.9]]
xk = zeros(3,2,niter+1)
xk[:,:,1] = x0
for k in 1:niter
    beta = 0.01/k
    d =  [gradR(xk[1,1,k], xk[1,2,k]);  gradR(xk[2,1,k], xk[2,2,k]); gradR(xk[3,1,k], xk[3,2,k])]
    xk[:,:,k+1] = xk[:,:,k] - beta*d;
end

contourf(xs,ys,R,
         grid=false,
         framestyle=:box,
         levels=10,
         cmap=:viridis,
         lw=2,
         background_color=:transparent)
for i in 1:3
    plot!(xk[i,1,:], xk[i,2,:], linewidth=3, label="")
    scatter!(xk[i,1,:], xk[i,2,:], ms=4, label="")
end
scatter!([0],[0],color=:red,ms=4,label="")

name = string("../figs/",PROGRAM_FILE)
name = replace(name, ".jl" => "-Rastrigin.svg")
#savefig(name)
name2 = replace(name, ".svg" => ".png")
savefig(name2)
