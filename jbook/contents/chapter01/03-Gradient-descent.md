---
kernelspec:
    name: python3
---

# Gradient descent algorithms

Recall that our goal is to solve the *unconstrained optimisation problem*
```{math}
:numbered: false

\min f(\x) \quad \st \quad  \x \in \RR^n.
```

Gradient desent algortihms attempt to solve this problem by via the following procedure

:::{prf:algorithm} Gradient descent
Starting with an initial point $\x_0 \in \RR^n$, update
```{math}
:numbered: false

\x_{k+1} = \x_k - \alpha_k \nabla f(\x_k)
```
until a [stopping criterion](./02-Descent-methods.md#stopping-criteria) is fulfilled.
:::

When the stepsize $\alpha_k$ is suitably chosen, $\x_k$ converges towards a stationary point of $f$ (*i.e.* such that $\nabla f(\x_k) = 0$).

## Gradient descent with constant stepsize

:::{prf:algorithm} Gradient descent with constant stepsize
Starting with an initial point $\x_0 \in \RR^n$, and for a given $\alpha > 0$, update
```{math}
:numbered: false

\x_{k+1} = \x_k - \alpha \nabla f(\x_k)
```
until a [stopping criterion](./02-Descent-methods.md#stopping-criteria) is fulfilled.
:::

In this case, the stepsize must be chosen in order to balance between speed of convergence ($\alpha$ not too small) and guarantees of convergence ($\alpha$ not too large). The regularity of the objective may bring information on how to choose $\alpha$.

:::{prf:theorem} Convergence for Lipschitz objectives
For an objective $f$ that is $L$-Lipschitz, *i.e.* such that
```{math}
:numbered: false

\forall \x, \y \in \RR^n, \quad |\!| \nabla f(\x) - \nabla f(\y) |\!| \leq L |\!| \x - \y |\!|,
```
then the algorithm converges towards a stationary point of $f$ if $\ 0 < \alpha < \frac{L}{2}$.
:::

:::{code-cell} python
:tags:[hide-input]

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as anim

def GradientUpdate2DFixed(x, gradf, alpha=0.1):
    """ GradientMethod2DFixed
    One gradient descent update with fixed stepsize (alpha) for a bivariate objective
    """

    return x - alpha * gradf(x)


# fonction quadratique
def q(x,gamma=10):
    return 1/2 * (x[0,:]**2 + gamma * x[1,:]**2)

# gradient
def gradq(x,gamma=10):
    return np.hstack((x[0,:], gamma*x[1,:]))

gamma = 10
x0 = np.array([[gamma],[1.]])
alphas = [0.02, 0.08, 0.14, 0.2]


# Contour data
npts = 101
x, y = np.mgrid[-10:10:npts*1j, -4:4:npts*1j]
x = x.reshape(-1) # flatten
y = y.reshape(-1)
z = q(np.vstack((x,y)))
x = x.reshape(npts, npts)
y = y.reshape(npts, npts)
z = z.reshape(npts, npts)

# Animation setup
fig, ax = plt.subplots(figsize=(6,6))

ax.contourf(x,y,z, levels=10, cmap='viridis')
ax.set_title("Fixed stepsize gradient descent on quadratic function")
ax.set_xlabel("$x_1$")
ax.set_ylabel("$x_2$")

colors = plt.cm.autumn(np.linspace(0,1,len(alphas)))
states = [x0.copy() for _ in alphas]
history = [[x0.copy()] for _ in alphas]
trajectories = [
    ax.plot(states[i][0], states[i][1], '.-', color=colors[i], lw=2, ms=10)[0] # TODO: understand...
    for i,a in enumerate(alphas)
]
ax.legend([fr"$\alpha={a}" for a in alphas])

def run_iterations(frame):
    for i,a in enumerate(alphas)
        states[i] = GradientUpdate2DFixed(states[i], gradq, alpha=a)
        history[i].append(states[i].copy())
        history_stack = np.hstack(history[i]) # shape (2, niter)
        trajectories[i].set_data(history_stack)
    return trajectories

ani = anim.FuncAnimation(fig, run_iterations, 20, blit=False)
plt.close()
HTML(ani.to_jshtml())
:::
## Gradient descent with optimal stepsize

:::{prf:algorithm} Gradient descent with optimal stepsize
Starting with an initial point $\x_0 \in \RR^n$, update
```{math}
:numbered: false

\begin{aligned}
    &\alpha_{k} = \argmin_{\alpha \geq 0} \; f(\x_k - \alpha \nabla f(\x_k))\\
    &\x_{k+1} = \x_k - \alpha_k \nabla f(\x_k)
\end{aligned}
```
until a [stopping criterion](./02-Descent-methods.md#stopping-criteria) is fulfilled.
:::

This strategy has the best performance in terms of *number of iterations*. However, computing the optimal stepsize may be as difficult as the original problem, or computationally expensive.

:::{code-cell} python
:tags:[hide-input]

def GradientUpdate2DOptimal(x, gradf, gamma):
    """
    One gradient update with optimal stepsize for bivariate quadratic objective
    """

    alpha = (x[0]**2 + gamma**2 * x[1]**2) / (x[0]**2 + gamma**3 * x[1]**2)
    return x - alpha * gradf(x)


:::

## Gradient descent with backtracking
