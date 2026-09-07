---
kernelspec:
    name: python3
---

# A gradient-free approach: Nelder-Mead


Nelder-Mead algorithm is an instance of gradient-free approaches, which only evaluations of the objective $f(\x)$ to run.
- This is a practical heuristic when the objective is not differentiable &#x2611;
- There is no guarantee to converge towards a local minimiser &#x2612;

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

Implementation following \cite{nocedal2006}

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
    return (x[:,0]**2 + x[:,1] - 11)**2 + (x[:,0] + x[:,1]**2 - 7)**2

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
        xe = xb + alpha * (vertices[-1,:] - xb)
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
            # "outside" contraction
            xout = xb - beta * (vertices[-1,:] - xb)
            fout = obj(xout)

            if fout <= fr:
                new_vertices = np.vstack((vertices[:-1,:], xout))
                contracted = 1

        else:
            # "inside" contraction
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
npts = 101
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

ax.contour(x,y,z, levels=levels)
ax.set_title("Nelder-Mead iterations")
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
