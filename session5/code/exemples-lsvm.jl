using Plots
using LinearAlgebra
using Convex, ECOS


# dataset bi-classes
X1 = [[-1.8,1.8];;
      [-1.2,1.4];;
      [-0.7,1.1];;
      [-0.68,2.9];;
      [-0.74,2.9];;
      [-0.4,3.4];;
      [-0.5,-0.2];;
      [-0.3,0.3];;
      [-0.21,1.6];;
      [-0.24,1.59];;
      [0.8,2];;
      [0.2,2.9]] .- [0.6;0];;

X2 = [[0.4,-0.19];;
      [0.55,-0.8];;
      [1,-1.5];;
      [1.1,-1];;
      [1.15,-0.9];;
      [1.3,0.1];;
      [1.6,0.5];;
      [1.9,0.6];;
      [2,0];;
      [2.55,-1];;
      [3.1,-0.4];;
      [3.2,-1.1]]

y = hcat(ones(1,12), -ones(1,12))

z = [1,1]

X = hcat(X1,X2)


# maximal margin classifier
w = Variable(2)
b = Variable()
# Form the objective.
#C = 50
#obj = 1/2*sumsquares(w) + C * sum(max(1 + b - w' * X1, 0)) + C * sum(max(1 - b + w' * X2, 0))
obj = 1/2*sumsquares(w)

# Form and solve problem.
#problem = minimize(obj)
problem = minimize(obj, [w'*X1 + b >= 1, w'*X2 + b <= -1])
solve!(problem, ECOSSolver())

w = evaluate(w)
b = evaluate(b)


xs = range(-2.5,stop=3.3,length=100)
plot(xs,(-w[1]*xs .- b)/w[2],lw=3,label="",
     background_color=:transparent,
     grid=false,
     xlims=(-3,3),
     ylims=(-2,4),
     aspect_ratio=:equal,
     framestyle=:box
    )
scatter!(X1[1,:],X1[2,:],ms=5,label="",color=:orange,msc=:orange)
scatter!(X2[1,:],X2[2,:],ms=5,label="",color=:purple,msc=:purple)


name_generic = string("../figs/",PROGRAM_FILE)
name = replace(name_generic, ".jl" => "-marge-maximale.svg")
savefig(name)



# support vectors
a = -w[1]/w[2]
c = -b/w[2]
x2 = 0.4
y2 = -0.19
x1 = -1.1
y1 = -0.2
x3 = 0.2
y3 = 2
p1 = 1/(a^2+1) * (-a*c +x1 +a*y1)
p2 = 1/(a^2+1) * (-a*c +x2 +a*y2)
p3 = 1/(a^2+1) * (-a*c +x3 +a*y3)
q1 = a/(a^2 +1) * (-a*c +x1 +a*y1) + c
q2 = a/(a^2 +1) * (-a*c +x2 +a*y2) + c
q3 = a/(a^2+1) * (-a*c +x3 +a*y3) + c

plot!([x2,p2], [y2,q2], lw=3, label="")
plot!(xs,a*xs .+y2 .-a*x2,linestyle=:dash,color=:steelblue1,label="")
plot!([x1,p1], [y1,q1], lw=3, label="",color=:darkgoldenrod1)
plot!(xs,a*xs .+y1 .-a*x1 ,linestyle=:dash,color=:steelblue1,label="")
plot!([x3,p3], [y3,q3], lw=3, label="",color=:darkgoldenrod1)
#plot!(xs,a*xs .+y3 .-a*x3 ,linestyle=:dash,color=:steelblue1,label="")

name = replace(name_generic, ".jl" => "-support-vectors.svg")
savefig(name)



# changing slightly the support vectors
X2p = copy(X2)
X2p[:,1]  = [-0.3,-0.2]
X1p = copy(X1)
X1p[:,11] = [1,0.9]

# new maximal margin classifier
wp = Variable(2)
bp = Variable()
# Form the objective.
#C = 50
#obj = sumsquares(wp) + C * sum(max(1 + bp - wp' * X1p, 0)) + C * sum(max(1 - bp + wp' * X2p, 0))
obj = 1/2*sumsquares(wp)

# Form and solve problem.
# problem = minimize(obj)
problem = minimize(obj, [wp'*X1p + bp >= 1, wp'*X2p + bp <= -1])
solve!(problem, ECOSSolver())

wp = evaluate(wp)
bp = evaluate(bp)


xs = range(-3.3,stop=3.3,length=100)
plot(xs,(-wp[1]*xs .- bp)/wp[2],lw=3,label="",
     background_color=:transparent,
     grid=false,
     xlims=(-3,3),
     ylims=(-2,4),
     aspect_ratio=:equal,
     framestyle=:box
    )
scatter!(X1p[1,:],X1p[2,:],ms=5,label="",color=:orange,msc=:orange)
scatter!(X2p[1,:],X2p[2,:],ms=5,label="",color=:purple,msc=:purple)

ap = -wp[1]/wp[2]
cp = -bp/wp[2]
x2p = -0.3
y2p = -0.2
x1p = -1.1
y1p = -0.2
x3p = 1
y3p = 0.9
p1p = 1/(ap^2+1) * (-ap*cp +x1p +ap*y1p)
p2p = 1/(ap^2+1) * (-ap*cp +x2p +ap*y2p)
p3p = 1/(ap^2+1) * (-ap*cp +x3p +ap*y3p)
q1p = ap/(ap^2 +1) * (-ap*cp +x1p +ap*y1p) + cp
q2p = ap/(ap^2 +1) * (-ap*cp +x2p +ap*y2p) + cp
q3p = ap/(ap^2+1) * (-ap*cp +x3p +ap*y3p) + cp

plot!([x2p,p2p], [y2p,q2p], lw=3, label="")
plot!(xs,ap*xs .+y2p .-ap*x2p,linestyle=:dash,color=:steelblue1,label="")
plot!([x1p,p1p], [y1p,q1p], lw=3, label="",color=:darkgoldenrod1)
plot!(xs,ap*xs .+y1p .-ap*x1p ,linestyle=:dash,color=:steelblue1,label="")
plot!([x3p,p3p], [y3p,q3p], lw=3, label="",color=:darkgoldenrod1)
#plot!(xs,ap*xs .+y3p .-a*x3p ,linestyle=:dash,color=:steelblue1,label="")


scatter!([0.2],[2],ms=5,label="",color=:wheat,msc=:wheat)
scatter!([0.4],[-0.19],ms=5,label="",color=:thistle,msc=:thistle)

name = replace(name_generic, ".jl" => "-marge-maximale-perturbee.svg")
savefig(name)



# limitations
# non separables
xs = range(-2.5,stop=3.3,length=100)
plot(xs,(-w[1]*xs .- b)/w[2],lw=3,label="",
     background_color=:transparent,
     grid=false,
     xlims=(-3,3),
     ylims=(-2,4),
     color=:lightsteelblue2;
     linestyle=:dash,
     aspect_ratio=:equal,
     framestyle=:box
    )
scatter!(X1[1,:],X1[2,:],ms=5,label="",color=:orange,msc=:orange)
scatter!(X2[1,:],X2[2,:],ms=5,label="",color=:purple,msc=:purple)
scatter!([1.8,2.5],[-1.2,0.5],ms=5,label="",color=:orange,msc=:orange)
scatter!([-1.7,-2] ,[-0.1,1],ms=5,label="",color=:purple,msc=:purple)

#plot!(xs,a*xs .+y1 .-a*x1 ,linestyle=:dash,color=:lightsteelblue2,label="")
#plot!(xs,a*xs .+y2 .-a*x2 ,linestyle=:dash,color=:lightsteelblue2,label="")

name = replace(name_generic, ".jl" => "-non-separables.svg")
savefig(name)

# point aberrant
X1p = hcat(X1,[2.8,1.2])

# new maximal margin classifier
wp = Variable(2)
bp = Variable()
# Form the objective.
#C = 50
#obj = sumsquares(wp) + C * sum(max(1 + bp - wp' * X1p, 0)) + C * sum(max(1 - bp + wp' * X2, 0))
obj = 1/2*sumsquares(wp)

# Form and solve problem.
# problem = minimize(obj)
problem = minimize(obj, [wp'*X1p + bp >= 1, wp'*X2 + bp <= -1])
solve!(problem, ECOSSolver())

wp = evaluate(wp)
bp = evaluate(bp)

xs = range(-3.3,stop=3.3,length=100)
plot(xs,(-wp[1]*xs .- bp)/wp[2],lw=3,label="",
     background_color=:transparent,
     grid=false,
     xlims=(-3,3),
     ylims=(-2,4),
     aspect_ratio=:equal,
     framestyle=:box
    )

plot!(xs,(-w[1]*xs .+ b)/w[2],lw=3,linestyle=:dash,color=:lightsteelblue2,label="")
#plot!(xs,a*xs .+y1 .-a*x1 ,linestyle=:dash,color=:lightsteelblue2,label="")
#plot!(xs,a*xs .+y2 .-a*x2 ,linestyle=:dash,color=:lightsteelblue2,label="")

scatter!(X1p[1,:],X1p[2,:],ms=5,label="",color=:orange,msc=:orange)
scatter!(X2[1,:],X2[2,:],ms=5,label="",color=:purple,msc=:purple)

#plot!(xs,(-wp[1]*xs .+bp .+1)/wp[2],linestyle=:dash,color=:steelblue1,label="")
#plot!(xs,(-wp[1]*xs .+bp .-1)/wp[2] ,linestyle=:dash,color=:steelblue1,label="")

name = replace(name_generic, ".jl" => "-points-aberrants.svg")
savefig(name)
