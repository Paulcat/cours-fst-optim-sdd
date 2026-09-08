---
kernelspec:
    name: python3
---

# A gradient-free approach: Nelder-Mead


Nelder-Mead algorithm is an instance of gradient-free approaches, which only evaluations of the objective $f(\x)$ to run.
- This is a practical heuristic when the objective is not differentiable \u2705;
- There is no guarantee to converge towards a local minimiser \u274c;

## Principle

The general principle of the algorithm is summarized below:

:::{prf:algorithm}Nelder-Mead
For an objective $f:\RR^n\to\RR$
1. draw $n+1$ points $\x_1, \x_2, \ldots, \x_{n+1}$ at random in $\RR^n$
2. build the corresponding simplex (a convex polytope with $n+1$ vertices: a triangle in 2D, a tetraedron in 3D, and so on...)
3. evaluate $f$ at each vertex
4. transform the simplex in order to make it "crawl" towards a (local) minimizer using reflexion, expansion, contraction or shrinking operations
5. repeat until the simplex is sufficiently small
:::

## Examples

The code below implements the Nelder-Mead algorithm following @nocedal2006 [Chapter 9.5].

:::{code-cell} python
:tags:[hide-input]
"""
Description
"""

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as anim
from IPython.display import HTML

def himmel(x):
    if len(x.shape)==1:
        x1, x2, = x
    else:
        x1 = x[:,0]
        x2 = x[:,1]
    return (x1**2 + x2 - 11)**2 + (x1 + x2**2 - 7)**2

def nm_update(obj, vertices, r=1, alpha=2, beta=0.5, gamma=0.5):
    """Nelder-Mead update
    """

    n, _ = vertices.shape # number of vertices

    f = obj(vertices)

    # Order the vertices
    order = np.argsort(f)
    vertices = vertices[order,:]
    f = f[order]

    # Compute the centroid of the n best points
    xb = vertices[:-1,:].mean(axis=0)

    # 1. Reflection
    xr = xb - r * (vertices[-1,:] - xb)
    fr = obj(xr)

    if f[0] <= fr and fr < f[-2]:
        # reflected point is neither best nor worst in the new simplex
        new_vertices = np.vstack((vertices[:-1,:], xr))

    # 2. Expansion
    elif fr < f[0]:
        # reflected point is better than current best: expand in that direction
        xe = xb - alpha * (vertices[-1,:] - xb)
        fe = obj(xe)

        if fe < fr:
            new_vertices = np.vstack((vertices[:-1,:], xe))
        else:
            new_vertices = np.vstack((vertices[:-1,:], xr))

    # 3. Contraction
    else:
        # reflected point is worst in the new simplex: contract
        contracted = 0
        if f[-2] <= fr and fr < f[-1]:
            # "outer" contraction
            xout = xb - beta * (vertices[-1,:] - xb)
            fout = obj(xout)

            if fout <= fr:
                new_vertices = np.vstack((vertices[:-1,:], xout))
                contracted = 1

        else:
            # "inner" contraction
            xin = xb + beta * (vertices[-1,:] - xb)
            fin = obj(xin)

            if fin < f[-1]:
                new_vertices = np.vstack((vertices[:-1,:], xin))
                contracted = 1

    # 4. Shrinking
        if not contracted:
            # shrink simplex toward x0
            new_vertices = np.zeros_like(vertices)
            new_vertices[0,:] = vertices[0,:]
            for k in range(1,n):
                new_vertices[k,:] = gamma * (vertices[0,:] + vertices[k,:])
           
    return new_vertices

# Contour data
npts = 201
x, y = np.mgrid[-6:6:npts*1j, -6:6:npts*1j]
x = x.reshape(-1)
y = y.reshape(-1)
z = himmel(np.column_stack((x,y)))
x = x.reshape(npts,npts)
y = y.reshape(npts,npts)
z = z.reshape(npts,npts)

# Animation setup
fig, ax = plt.subplots(figsize=(6,6))
levels = np.logspace(0.35, 3.2, 20)

ax.contour(x,y,z, levels=levels, cmap='viridis')
ax.set_title("Nelder-Mead iterations on Himmelblau's function")
ax.set_xlabel('$x_1$')
ax.set_ylabel('$x_2$')

# Initial simplex
vertices = np.array([[4, 6], [1, 1], [5, 2]])

simplex_lines, = ax.plot([], [], 'ro-', lw=2)
history = []

def run_iterations(frame):
    global vertices
    history.append(vertices.copy())
    vertices = nm_update(himmel, vertices)
    simplex = np.vstack([vertices, vertices[0]])
    simplex_lines.set_data(simplex[:,0], simplex[:,1])
    return simplex_lines,

ani = anim.FuncAnimation(fig, run_iterations, 20, blit=False)
plt.close()
HTML(ani.to_jshtml())
:::

We can choose a different initialization.

:::{code-cell} python
:tags:[hide-input]

# Contour data
npts = 201
x, y = np.mgrid[-6:6:npts*1j, -6:6:npts*1j]
x = x.reshape(-1)
y = y.reshape(-1)
z = himmel(np.column_stack((x,y)))
x = x.reshape(npts,npts)
y = y.reshape(npts,npts)
z = z.reshape(npts,npts)

# Animation setup
fig, ax = plt.subplots(figsize=(6,6))
levels = np.logspace(0.35, 3.2, 20)

ax.contour(x,y,z, levels=levels, cmap='viridis')
ax.set_title("Nelder-Mead iterations on Himmelblau's function")
ax.set_xlabel('$x_1$')
ax.set_ylabel('$x_2$')

# Initial simplex
vertices = np.array([[-3, -4], [-2, -2], [-3, -1]])

simplex_lines, = ax.plot([], [], 'ro-', lw=2)
history = []

def run_iterations(frame):
    global vertices
    history.append(vertices.copy())
    vertices = nm_update(himmel, vertices)
    simplex = np.vstack([vertices, vertices[0]])
    simplex_lines.set_data(simplex[:,0], simplex[:,1])
    return simplex_lines,

ani = anim.FuncAnimation(fig, run_iterations, 20, blit=False)
plt.close()
HTML(ani.to_jshtml())
:::

The algorithm now converges to a different local minima. An unlucky initialization may even result in the algorithm getting trapped and not converging anymore.



:::{code-cell} python
:tags:[hide-input]

def mckinnon(x,phi=60,theta=6,tau=2):
    if len(x.shape)==1:
        x1, x2, = x
    else:
        x1 = x[:,0]
        x2 = x[:,1]
    return theta*phi*np.abs(x1)**tau * (x1<=0) + theta*x1**tau * (x1 > 0) + x2*(1+x2)


# Contour data
npts = 201
x, y = np.mgrid[-0.2:1.2:npts*1j, -1.5:1:npts*1j]
x = x.reshape(-1)
y = y.reshape(-1)
z = himmel(np.column_stack((x,y)))
x = x.reshape(npts,npts)
y = y.reshape(npts,npts)
z = z.reshape(npts,npts)

# Animation setup
fig, ax = plt.subplots(figsize=(6,6))
levels = np.linspace(0, 10, 20)

ax.contour(x,y,z, levels=levels, cmap='viridis')
ax.scatter([0], [-0.5], marker="*", s=100, color="k")
ax.set_title("Nelder-Mead iterations on McKinnon's example")
ax.set_xlabel('$x_1$')
ax.set_ylabel('$x_2$')

# Unlucky initialisation
A = (1 + np.sqrt(33))/8
B = (1 + np.sqrt(33))/8
vertices = np.array([[0, 0], [1, 1], [A, B]])

simplex_lines, = ax.plot([], [], 'ro-', lw=2)
history = []

def run_iterations(frame):
    global vertices
    history.append(vertices.copy())
    vertices = nm_update(himmel, vertices)
    simplex = np.vstack([vertices, vertices[0]])
    simplex_lines.set_data(simplex[:,0], simplex[:,1])
    return simplex_lines,

ani = anim.FuncAnimation(fig, run_iterations, 20, blit=False)
plt.close()
HTML(ani.to_jshtml())
:::

In this example, the function is striclty convex and attains its minimum at $x_\star = (0,-0.5)$, but the Nelder-Mead simplex get trapped at the point $(0,0)$. The example is due to @mckinnon1998.

Gradient-free methods are thus cheap to implement, but may offer poor guarantees. In the reminder of the chapter, we will focus on *descent methods*, that leverage first-order (gradient) and second-order (Hessian) properties of the objective to construct iterates that iteratively progress towards a local minimum.


:::{bibliography}
:::
