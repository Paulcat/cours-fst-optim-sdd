using ImplicitPlots, Plots
using LinearAlgebra
using Convex, ECOS

# datasets

# random samples in disc (rejection method)
n  = 300
X1 = [-1;-1] .+ 2*rand(Float64,(2,10*n))
f1 = 1/pi * (sum(X1.^2,dims=1) .<= 1)
U  = rand(Float64,(1,10*n))
X1 = X1[:,vec(U .< f1*pi/4)] # rejection
X1 = X1[:,1:n] # take only first n


# random samples in ring (rejection method)
X2 = [-3;-3] .+ 6*rand(Float64,(2,100*n))
r2 = sum(X2.^2,dims=1)
f2 = 1/5/pi * (r2 .<= 9 .&& r2 .>= 4)
U  = rand(Float64,(1,100*n))
X2 = X2[:,vec(U .< f2*5*pi/36)] # rejection
X2 = X2[:,1:n] # take only first n



scatter(X1[1,:],X1[2,:],ms=3,label="",
        background_color=:transparent,
        grid = false,
        xlims=(-4,4),
        ylims=(-4,4),
        aspect_ratio=:equal,
        framestyle=:box,
        color=:orange,
        msc=:orange)
scatter!(X2[1,:],X2[2,:],ms=3,label="",color=:purple,msc=:purple)

name_generic = string("../figs/",PROGRAM_FILE)
name = replace(name_generic, ".jl" => "-dataset.svg")
savefig(name)

# double moon
n = 200

Y1 = [-3.5;-2] .+ 6*rand(Float64,(2,400*n)) # square around ring
r1 = sum((Y1.-[-0.5;1]).^2,dims=1)
f1 = 1/4/pi * (Y1[1,:]' .>= -0.7 .&& r1 .<= 7 .&& r1 .>= 3)
U  = rand(Float64,(1,400*n))
Y1 = Y1[:,vec(U .< f1*4*pi/36)] # rejection
Y1 = Y1[:,1:n] # take only first n

Y2 = [-2.5;-4] .+ 6*rand(Float64,(2,400*n)) # square around ring
r2 = sum((Y2.-[0.5;-1]).^2,dims=1)
f2 = 1/4/pi * (Y2[1,:]' .<= 0.7 .&& r2 .<= 7 .&& r2 .>= 3)
U  = rand(Float64,(1,400*n))
Y2 = Y2[:,vec(U .< f2*4*pi/36)] # rejection
Y2 = Y2[:,1:n] # take only first n


scatter(Y1[1,:], Y1[2,:], ms=3, label="",
        xlims=(-4,4),
        ylims=(-4,4),
        background_color=:transparent,
        framestyle=:box,
        aspect_ratio=:equal,
        grid=:false,
        color=:purple,
        msc=:purple
       )
scatter!(Y2[1,:], Y2[2,:], ms=3, label="",
         color=:orange,
         msc=:orange
        )

name = replace(name_generic, ".jl" => "-dataset-moons.svg")
savefig(name)



# non-linear features lifting
Z1 = [X1; sum(X1.^2,dims=1)]
Z2 = [X2; sum(X2.^2,dims=1)]

scatter(Z1[1,:],Z1[2,:],Z1[3,:],ms=2,label="",
        background_color=:transparent,
        grid = false,
        xlims=(-4,4),
        ylims=(-4,4),
        aspect_ratio=:equal,
        framestyle=:box,
        color=:orange,
        msc=:orange)
scatter!(Z2[1,:],Z2[2,:],Z2[3,:],ms=2,label="",color=:purple,msc=:purple)
#plot!([-4,-4],[-4,4],[-0.5,-0.5],color=:black,label="")
#plot!([-4,4],[4,4],[-0.5,-0.5],color=:black,label="")
#plot!([-4,-4],[4,4],[-0.5,9],color=:black,label="")
name = replace(name_generic, ".jl" => "-dataset-lifted.svg")
savefig(name)


# polynomial kernel
Y  = [Y1;;Y2]
labels= [ones(n);-ones(n)]
K1 = (1 .+ Y'*Y).^2 # degree 2 polynomial
K = diagm(labels) * K1 * diagm(labels)
L = sqrt(K)

# kernel trick
alpha = 1e-2
la = Variable(2*n,Positive())
#
obj = sum(la) - 1/2* sumsquares(L*la)

problem = maximize(obj, [labels'*la==0, la <= alpha])
solve!(problem, ECOSSolver())

la = evaluate(la)
w  = vec(sum(la'.*labels'.*Y, dims=2))

I = findall(!iszero,vec(la))
id = I[1]
b = labels[id] - w'*Y[:,id]

f(x,y) = w'*[x y] + b
implicit_plot(f)
name = replace(name_generic, ".jl" => "separating-curve.svg")
savefig(name)
