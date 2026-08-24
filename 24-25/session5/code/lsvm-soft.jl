using LinearAlgebra
using Convex, ECOS


function lsvm_soft(X1,X2,lambda)
    p = size(X1,2) 
    q = size(X2,2)

    w = Variable(2)
    b = Variable()
    xi = Variable(p,Positive())
    zi = Variable(q,Positive())
    #
    obj = 1/2*sumsquares(w) + lambda*(sum(xi) + sum(zi))
    
    problem = minimize(obj, [w'*X1+b >= 1-xi', w'*X2+b <= -1+zi'])
    solve!(problem, ECOSSolver())

    return evaluate(w), evaluate(b)
end
