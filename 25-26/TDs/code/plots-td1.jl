using Plots
using LinearAlgebra
using LaTeXStrings
# using PlotlyJS


# Exemple 1
f1(x) = (x+3)^2 * (x <= -3) + (x-2)^3 * (x >=2)

x = range(-8,stop=5,length=100)
plot(x,f1,
     framestyle=:box,
     label="",
     lw=3,
     background_color=:transparent)



scalefontsizes(1.8)



name = string("../td1/", PROGRAM_FILE)
name = replace(name, ".jl" => "-exemple1.png")
savefig(name)

# fonction sigmoïde
f2(x) = 1 / (1 + exp(-x))

x = range(-8,stop=8,length=100)
plot(x,f2,
     framestyle=:box,
     label="",
     lw=3,
     background_color=:transparent)


name = string("../td1/", PROGRAM_FILE)
name = replace(name, ".jl" => "-exemple2.png")
savefig(name)





# fonction valeur absolue
f3(x) = abs(x)

x = range(-5,stop=5,length=100)
plot(x,f3,
     framestyle=:box,
     label="",
     lw=3,
     background_color=:transparent)

name = string("../td1/", PROGRAM_FILE)
name = replace(name, ".jl" => "-exemple3.png")
savefig(name)



# fonction de Rosenbrock
Ro(x,y) = (1-x)^2 + 10*(y-x^2)^2

xs = range(-1,stop=1,length=100)
ys = range(-0.6,stop=1.6,length=100)

contour(xs,ys,Ro,
         grid=false,
         framestyle=:box,
         levels=cat(0:0.5:2,[4,10,20,40,80,160,300],dims=(1,1)),
         label="",
         lw=2,
         cmap=:turbo,
         cbar=false,
         clabels=true,
         ticks=false,
         background_color=:transparent,
         right_margin=3Plots.mm)

name = string("../td1/", PROGRAM_FILE)
name = replace(name, ".jl" => "-Rosenbrock.png")
savefig(name)


# fonction de ?
f(x,y) = exp(x +3*y -0.1) + exp(x -3*y -0.1) + exp(-x -0.1)

xs = range(-2,stop=.6,length=100)
ys = range(-.5,stop=.5,length=100)

contour(xs,ys,f,
         grid=false,
         framestyle=:box,
         label="",
         levels=0:0.5:6,
         cmap=:turbo,
         lw=2,
         cbar=false,
         clabels=true,
         ticks=false,
         background_color=:transparent)
#plot!(xk[1,:],xk[2,:], linewidth=3, label="")
#scatter!(xk[1,:], xk[2,:], series_annotations=text.(sk,:top,16,color=:white), label="")
#scatter!(xk[1,:],xk[2,:],ms=4,label="")
#scatter!([0],[0],color=:red,ms=4,label="")




name = string("../td1/",PROGRAM_FILE)
name = replace(name, ".jl" => "-exp.svg")
#savefig(name)
name2 = replace(name, ".svg" => ".png")
savefig(name2)



# fonction de Rastrigin
R(x,y) = 20 + x^2 - 10*cos(2pi*x) + y^2 - 10*cos(2pi*y)

xs = range(-0.5, stop=2.5, length=100)
ys = range(-1, stop=3, length=100)


contour(xs,ys,R,
         grid=false,
         framestyle=:box,
         levels=cat(0:6:12,20:10:60,dims=(1,1)),
         cmap=:turbo,
         lw=2,
         cbar=false,
         clabels=true,
         ticks = false,
         background_color=:transparent)
#for i in 1:3
#    plot!(xk[i,1,:], xk[i,2,:], linewidth=3, label="")
#    scatter!(xk[i,1,:], xk[i,2,:], ms=4, label="")
#end
#scatter!([0],[0],color=:red,ms=4,label="")

name = string("../td1/",PROGRAM_FILE)
name = replace(name, ".jl" => "-Rastrigin.svg")
#savefig(name)
name2 = replace(name, ".svg" => ".png")
savefig(name2)
