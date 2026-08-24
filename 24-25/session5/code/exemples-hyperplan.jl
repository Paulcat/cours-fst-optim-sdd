using Plots
using LinearAlgebra
using LaTeXStrings


# hyperplane in dimension 2
f(x; a=-2/3, b=-1/3) = a*x .+ b;

xs = range(-1.5, stop=1.5, length=100)
plot(xs,f(xs),
     lw=3,
     label="",
     grid=false,
     framestyle=:box,
     background_color=:transparent,
     aspect_ratio=:equal,
     xlims=(-1.6,1.6),
     ylims=(-1.6,1.6),
     xlabel=L"x_1",
     ylabel=L"x_2"
    )
npoints = 20
for i in 0:npoints
    for j in 0:npoints
        x = -1.5 + 2*(i)/npoints * 1.5
        y = -1.5 + 2*(j)/npoints * 1.5
        if f(x) < y
            scatter!([x],[y],ms=2,label="",color=:orange,msc=:orange)
        else
            scatter!([x],[y],ms=2,label="",color=:purple,msc=:purple)
        end
    end
end

name_generic = string("../figs/",PROGRAM_FILE)
name = replace(name_generic, ".jl" => "-2d.svg")
savefig(name)


# hyperplane in dimension 3
g(x,y; a=2/8, b=4/8, c=-7/8) = a*x + b*y .+ c

xs = range(-10,stop=10,length=100)
ys = range(-10,stop=10,length=100)


scatter((-10,-10,-10),ms=2,color=:orange,msc=:orange) # hack to clear plot
npoints = 7
for i=0:npoints
    x = -10 + 2*(i)/npoints * 10
    for j=0:npoints
        y = -10 + 2*(j)/npoints * 10
        for k=0:npoints
            z = -10 + 2*(k)/npoints * 10
            if g(x,y) > z
                scatter!((x,y,z),ms=2,label="",color=:purple,msc=:purple)
            end
        end
    end
end

surface!(xs,ys,g,
       framestyle=:box,
       cmap=:viridis,
       background_color=:transparent,
       legend=false,
       colorbar=false,
       camera=(40,15),
       xlabel=L"x_1",
       ylabel=L"x_2",
       zlabel=L"x_3"
      )

for i=0:npoints
    x = -10 + 2*(i)/npoints * 10
    for j=0:npoints
        y = -10 + 2*(j)/npoints * 10
        for k=0:npoints
            z = -10 + 2*(k)/npoints * 10
            if g(x,y) < z
                scatter!((x,y,z),ms=2,label="",color=:orange,msc=:orange)
            end
        end
    end
end


name = replace(name_generic, ".jl" => "-3d.svg")
savefig(name)
