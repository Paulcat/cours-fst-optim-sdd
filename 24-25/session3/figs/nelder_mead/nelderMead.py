"""
Animation of the Nelder-Mead method for the Himmelblau function.
"""
from __future__ import division, print_function
import numpy as np
import matplotlib as mpl
mpl.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.animation as animation
from matplotlib import rcParams

# In Windows the next line should provide the full path to convert.exe
# since convert is a Windows command
#rcParams['animation.convert_path'] = "C:\Program Files\ImageMagick-6.9.3-Q16\convert.exe"
rcParams['font.size'] = 12

def himmel(x):
    if len(x.shape) == 1:
        x1, x2, = x
    else:
        x1 = x[:, 0]
        x2 = x[:, 1]
    return (x1**2 + x2 - 11)**2 + (x1 + x2**2 - 7)**2

def nelder_mead_step(fun, verts, alpha=1, gamma=2, rho=0.5,
                     sigma=0.5):
    """Nelder-Mead iteration according to Wikipedia _[1]
    
    
    References
    ----------
     .. [1] Wikipedia contributors. "Nelder–Mead method." Wikipedia,
         The Free Encyclopedia. Wikipedia, The Free Encyclopedia,
         1 Sep. 2016. Web. 20 Sep. 2016. 
    """
    nverts, _ = verts.shape         
    f = fun(verts)
    # 1. Order
    order = np.argsort(f)
    verts = verts[order, :]
    f = f[order]
    # 2. Calculate xo, the centroid"
    xo = verts[:-1, :].mean(axis=0)
    # 3. Reflection
    xr = xo + alpha*(xo - verts[-1, :])
    fr = fun(xr)
    if f[0]<=fr and fr<f[1]:
        new_verts = np.vstack((verts[:-1, :], xr))
    # 4. Expansion
    elif fr<f[0]:
        xe = xo + gamma*(xr - xo)
        fe = fun(xe)
        if fe < fr:
            new_verts = np.vstack((verts[:-1, :], xe))
        else:
            new_verts = np.vstack((verts[:-1, :], xe))
    # 5. Contraction
    else:
        xc = xo + rho*(verts[-1, :] - xo)
        fc = fun(xc)
        if fc < f[-1]:
            new_verts = np.vstack((verts[:-1, :], xc))
    # 6. Shrink
        else:
            new_verts = np.zeros_like(verts)
            new_verts[0, :] = verts[0, :]
            for k in range(1, nverts):
                new_verts[k, :] = sigma*(verts[k,:] - verts[0,:])
 
    return new_verts

# Contour data
npts = 201
x, y = np.mgrid[-6:6:npts*1j, -6:6:npts*1j]
x.shape = (npts**2)
y.shape = (npts**2)
z = himmel(np.column_stack((x, y)))
x.shape = (npts, npts)
y.shape = (npts, npts)
z.shape = (npts, npts)

# Simplices data
def data_gen(num):
    x0 = np.array([3, 6])
    x1 = np.array([2, 2])
    x2 = np.array([3, 1])
    verts = np.vstack((x0, x1, x2))
    for k in range(num):
        verts = nelder_mead_step(himmel, verts)
    # Plots
    levels = np.logspace(0.35, 3.2, 8)
    plt.cla()
    plt.contour(x, y, z, levels, colors="k")
    poly = plt.Polygon(verts, facecolor="none", edgecolor="r",
                       linewidth=2)
    plt.gca().add_patch(poly)
    plt.xlabel(r"$x_1$", fontsize=14)
    plt.ylabel(r"$x_2$", fontsize=14)
    plt.xticks([-6, -3, 0, 3, 6])
    plt.yticks([-6, -3, 0, 3, 6])
    plt.xlim([-6, 6])
    plt.ylim([-6, 6])
    

fig = plt.figure(figsize=(5, 5))
ani = animation.FuncAnimation(fig, data_gen, range(20), blit=False)
ani.save("./Nelder-Mead_Himmelblau.gif", writer='imagemagick', fps=2,
         dpi=200)