using Plots
using LinearAlgebra
using Convex, ECOS

include("lsvm-soft.jl")


# dataset bi-classes
X1 = [[-1.9,3];;
      [-1.65,1.9];;
      [-0.89,-2.95];;
      [-0.56,-0.44];;
      [-0.63,1.05];;
      [-0.48,1.6];;
      [-0.44,1.43];;
      [-0.2,1.2];;
      [0.3,1.66];;
      [0.67,1.1];;
      [0.5,0.83];;
      [1.5,1.4]]

X2 = [[0.18,0.75];;
      [0.6,0.69];;
      [0.95,0.05];;
      [0.96,-0.7];;
      [1.01,-0.65];;
      [1.52,1.4];;
      [1.8;-1];;
      [2.05,-1.1];;
      [1.97;0];;
      [1.99;-0.04];;
      [2.04,-0.05];;
      [2.34;-0.07]]

y = hcat(ones(1,14), -ones(1,14)) # labels



scatter!(X1[1,:],X1[2,:],ms=5,color=:orange,msc=:orange,label="",
         background_color=:transparent,
         aspect_ratio=:equal,
         framestyle=:box,
         grid=false,
         xlims=(-2.5,2.5),
         ylims=(-3.2,3.1)
        )
scatter!(X2[1,:],X2[2,:],ms=5,color=:purple,msc=:purple,label="")

name_generic = string("../figs/",PROGRAM_FILE)
name = replace(name_generic, ".jl" => "-dataset.svg")
savefig(name)

# soft margin classifier
lambdas = [2e-2,7e-2,2e-1,7e-1]
for lambda in lambdas
    w,b = lsvm_soft(X1,X2,lambda)

    xs = range(-3,stop=3,length=100)
    plot(xs,(-w[1]*xs .- b)/w[2],lw=3,
         background_color=:transparent,
         aspect_ratio=:equal,
         framestyle=:box,
         grid=false,
         xlims=(-2.5,2.5),
         ylims=(-3.2,3.1),
         label=""
         )
    scatter!(X1[1,:],X1[2,:],ms=5,color=:orange,msc=:orange,label="")
    scatter!(X2[1,:],X2[2,:],ms=5,color=:purple,msc=:purple,label="")

    plot!(xs,(-w[1]*xs .-b .+1/norm(w))/w[2],lw=3,color=:lightsteelblue2,linestyle=:dash,label="")
    plot!(xs,(-w[1]*xs .-b .-1/norm(w))/w[2],lw=3,color=:lightsteelblue2,linestyle=:dash,label="")
    
    name = replace(name_generic, ".jl" => ("-l"*string(lambda)*".svg"))
    savefig(name)
end
