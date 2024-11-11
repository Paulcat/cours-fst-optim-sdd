

# méthode du gradient à pas fixe
function GradientMethod2DFixed(xinit, dfdx, alpha; niter=10)

    xn = zeros(2, niter+1)

    xn[:, 1] = xinit
    for n ∈ 1:niter
        xn[:, n+1] = xn[:, n] - alpha*dfdx(xn[1, n], xn[2, n])
    end
    return xn
end


# methode du gradient à pas optimal
function GradientMethod2DOptimal(xinit, dfdx, gamma; niter=10)

    xn = zeros(2, niter+1)
    alphan = zeros(niter)
    xn[:, 1] = xinit

    for n ∈ 1:niter

        # determination de alpha 
        x1 = xn[1, n]
        x2 = xn[2, n]
        alphan[n] = (x1^2 + gamma^2*x2^2)/(x1^2 + gamma^3*x2^2)
        xn[:, n+1] = xn[:, n] - alphan[n]*dfdx(xn[1, n], xn[2, n])
    end
    return xn,alphan
end


# methode du gradient à pas optimal
function GradientMethod2DOptimal2(xinit, f, dfdx; niter=10)

    xn = zeros(2, niter+1)
    alphan = zeros(niter)
    xn[:, 1] = xinit

    for n ∈ 1:niter

        # determination de alpha 
        x1 = xn[1, n]
        x2 = xn[2, n]
        grad = dfdx(xn[1, n], xn[2, n])

        # line search
        g(alpha) = f(x1 -alpha.*grad[1], x2 -alpha.*grad[2])
        t = optimize(g, 0, 10)
        alphan[n] = Optim.minimizer(t)
        xn[:, n+1] = xn[:, n] - alphan[n]*dfdx(xn[1, n], xn[2, n])
    end
    return xn,alphan
end


# methode du gradient avec backtracking
function GradientMethod2DBacktracking(xinit, dfdx, alphainit; niter=10, s=0.3, eta=0.9)

    xn = zeros(2, niter+1)

    xn[:, 1] = xinit

    for n ∈ 1:niter
        alpha = alphainit # could reuse alpha from previous iteration
        grad = dfdx(xn[1, n], xn[2, n])
        xtemp = xn[:, n] - alpha*grad
        # check bactracking condition
        ftemp = f(xtemp[1], xtemp[2])
        backtrack_comp = f(xn[1, n], xn[2, n]) - alpha*s*norm(grad)^2
        while ftemp > backtrack_comp
            alpha = eta*alpha
            println("backtracking kicks in at iteration n=
alpha)")

            xtemp = xn[:, n] - alpha*grad
            # check bactracking condition
            ftemp = f(xtemp[1], xtemp[2])
            backtrack_comp = f(xn[1,n], xn[2,n]) - alpha*s*norm(grad)^2
        end
        xn[:, n+1] = xtemp
    end
    return xn
end



# methode de Newton à pas fixe
function NewtonMethod2DFixed(xinit, dfdx,d2fd2x, alpha; niter=10)

    xn = zeros(2, niter+1)

    xn[:, 1] = xinit
    for n ∈ 1:niter
        hess = d2fd2x(xn[1, n], xn[2, n])
        xn[:, n+1] = xn[:, n] - alpha*inv(hess)*dfdx(xn[1, n], xn[2, n])
    end
    return xn
end

# methode de Newton avec backtracking
function NewtonMethod2DBacktracking(xinit, dfdx,d2fd2x, alphainit; niter=10, s=0.3, eta=0.9)

    xn = zeros(2, niter+1)

    xn[:, 1] = xinit

    for n ∈ 1:niter
        alpha = alphainit # could reuse alpha from previous iteration

        hess = d2fd2x(xn[1, n], xn[2, n])
        grad = dfdx(xn[1, n], xn[2, n])
        xtemp = xn[:, n] - alpha*inv(hess)*grad


        # check bactracking condition
        ftemp = f(xtemp[1], xtemp[2])
        backtrack_comp = f(xn[1, n], xn[2, n]) - alpha*s*grad'*inv(hess)*grad
                while ftemp > backtrack_comp
                    alpha = eta*alpha
                    println("backtracking kicks in at iteration n=alpha)")
        
                    xtemp = xn[:, n] - alpha*inv(hess)*grad
                    # check bactracking condition
                    ftemp = f(xtemp[1], xtemp[2])
                    backtrack_comp = f(xn[1,n], xn[2,n]) - alpha*s*grad'*inv(hess)*grad
                end
                xn[:, n+1] = xtemp

    end
    return xn
end


# méthode de BFGS
function BFGS(xinit, dfdx, Hinit, alphainit; niter=10, s=0.3, eta=0.9)

    xn = zeros(2, niter+1)

    xn[:, 1] = xinit
    Hk = Hinit
    grad = dfdx(xn[1, 1], xn[2, 1])
    for n ∈ 1:niter
        alpha = alphainit # could reuse alpha from previous iteration
        xtemp = xn[:, n] - alpha*Hk*grad

        # check bactracking condition
        ftemp = f(xtemp[1], xtemp[2])
        backtrack_comp = f(xn[1, n], xn[2, n]) - alpha*s*grad'*Hk*grad
        while ftemp > backtrack_comp
            alpha = eta*alpha
            #println("backtracking kicks in at iteration n=alpha)")

            xtemp = xn[:, n] - alpha*Hk*grad
            # check bactracking condition
            ftemp = f(xtemp[1], xtemp[2])
            backtrack_comp = f(xn[1,n], xn[2,n]) - alpha*s*grad'*Hk*grad
        end
        xn[:, n+1] = xtemp

        #update Hk 
        if n < niter
            newgrad = dfdx(xn[1, n+1], xn[2, n+1])
            sk = xn[:, n+1] - xn[:, n]
            yk = newgrad - grad
            rhok = 1/(yk'*sk)

            grad = newgrad # update gradent
            mat = I - rhok.*(sk*yk')
            mat2 = I - rhok.*(yk*sk')
            Hk = mat * Hk *mat2 + rhok.*(sk*sk')
        end
    end
    return xn
end

