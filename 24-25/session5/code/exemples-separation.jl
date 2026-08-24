using Plots
using LinearAlgebra
using Optimization
using JuMP

# hyperplans en dimension 2
f(x; a=2/3, b=-1/4) = a*x .+ b;

# dataset bi-classes
x1 = [[-1.8,1.8];;
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

x2 = [[0.4,-0.19];;
      [0.55,-0.8];;
      [1;-1.5];;
      [1.1;-1];;
      [1.15;-0.9];;
      [1.3;0.1];;
      [1.6;0.5];;
      [1.9;0.6];;
      [2,0];;
      [2.55,-1];;
      [3.1;-0.4];;
      [3.2;-1.1]]

scatter(x1[1,:],x1[2,:],
        ms=5,
        label="",
        color=:orange,
        msc=:orange,
        background_color=:transparent,
        grid=false,
        xlims=(-3,3),
        ylims=(-2,4),
        aspect_ratio=:equal,
        framestyle=:box
       )
scatter!(x2[1,:],x2[2,:],ms=5,label="",color=:purple,msc=:purple)

name_generic = string("../figs/",PROGRAM_FILE)
name = replace(name_generic, ".jl" => "-dataset.svg")
savefig(name)

xs = range(-4,stop=4,length=100)
plot!(xs,f(xs;a=2/3,b=-1/9),lw=3,label="",color=:steelblue1)
ub = f(xs;a=2/3,b=-1/9+0.2)
lb = f(xs;a=2/3,b=-1/9-0.2)
plot!(xs,ub,color=:steelblue1,linestyle=:dash,label="")
plot!(xs,lb,fillrange=ub,fillalpha=0.3,color=:steelblue1,linestyle=:dash,label="")
name = replace(name_generic, ".jl" => "-plain-1.svg")
savefig(name)

plot!(xs,f(xs;a=3/2,b=0.5),lw=3,label="",color=:steelblue1)
name = replace(name_generic, ".jl" => "-plain-2.svg")
ub = f(xs;a=3/2,b=0.5+0.4)
lb = f(xs;a=3/2,b=0.5-0.4)
plot!(xs,ub,color=:steelblue1,linestyle=:dash,label="")
plot!(xs,lb,fillrange=ub,fillalpha=0.3,color=:steelblue1,linestyle=:dash,label="")
savefig(name)

plot!(xs,f(xs;a=4,b=0),lw=3,label="",color=:steelblue1)
ub = f(xs;a=4,b=+0.3)
lb = f(xs;a=4,b=-0.3)
plot!(xs,ub,color=:steelblue1,linestyle=:dash,label="")
plot!(xs,lb,fillrange=ub,fillalpha=0.3,color=:steelblue1,linestyle=:dash,label="")
name = replace(name_generic, ".jl" => "-plain-3.svg")
savefig(name)


scatter(x1[1,:],x1[2,:],
        ms=5,
        label="",
        color=:orange,
        msc=:orange,
        background_color=:transparent,
        grid=false,
        xlims=(-3,3),
        ylims=(-2,4),
        aspect_ratio=:equal,
        framestyle=:box
       )
scatter!(x2[1,:],x2[2,:],ms=5,label="",color=:purple,msc=:purple)

plot!(xs,f(xs;a=2/3,b=-1/9),lw=3,label="",color=:steelblue1)

a = 2/3
b = -1/9
x1 = 0.4
y1 = -0.19
p = 1/(a^2 +1) * (-a*b +x1 +a*y1)
q = a/(a^2 +1) * (-a*b +x1 +a*y1) + b

plot!([x1,p], [y1,q], lw=3, label="")
plot!(xs,f(xs;a=2/3,b=y1-a*x1),linestyle=:dash,color=:steelblue1,label="")

x2 = -1.1
y2 = -0.2
p = 1/(a^2 +1) * (-a*b +x2 +a*y2)
q = a/(a^2 +1) * (-a*b +x2 +a*y2) + b

plot!([x2,p], [y2,q], lw=3, color=:darkgoldenrod1,label="")
plot!(xs,f(xs;a=2/3,b=y2-a*x2),linestyle=:dash,color=:steelblue1,label="")

x0 = 2.3
w  = 0.46 # margin size
plot!([x0,x0+w], [f(x0;a=2/3,b=y2-a*x2), f(x0;a=2/3,b=y2-a*x2)-3/2*w],
      lw=3, 
      color=:black,
      label="",
      arrow=:both
     )

name = replace(name_generic, ".jl" => "-marge.svg")
savefig(name)
