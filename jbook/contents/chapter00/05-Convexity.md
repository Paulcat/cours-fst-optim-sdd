# Convexity

In minimisation problems, convexity is a key property, as it provides a simple (first-order) characterisation of global minima.

# Definitions and examples

:::{prf:definition}Convex set
A set $C$ is *convex* if any line joining two points of $C$ is entirely contained in $C$, *i.e.* for all $(x,y) \in C$ and for all $0 \leq \theta \leq 1$
```{math}
    \theta x + (1-\theta)y \in C.
```
:::

:::{figure} images/cvxsets.png
:label: fig:cvx-sets
Example of convex and non-convex sets. *Left*: the hexagon (with its contour) is convex. *Middle*: the ring is not convex, since the segment between the two drawn points is not contained in the set. *Right*: the square does not contain all the points on the edge, and hence is not convex.
:::

:::{prf:definition}Convex function
A function $f:E \to \mathbb{R}$ is said to be *convex* if for all $x,y \in E$, for all $\lambda \in [0,1]$,
```{math}
:label: eq:convexity
    f(\lambda x +  (1-\lambda)y) \leq \lambda f(x) + (1-\lambda) f(y).
```
When the inequality is strict, $f$ is said to be *strictly convex*. $f$ is said to be *(strictly) concave* when $-f$ is (strictly) convexe.
:::

Geometrically, the equation [](#eq:convexity) means that the *epigraph* of $f$, that is to say the sey of points that are above the graph of $f$, is convex. In other words, the segment joining the points of coordinates $(x,f(x))$ and $(y,f(y))$ is always avove the graph of $f$.

# Caracterisations

The convexity of a function is linked to various properties of the differentials of that function.

### First order condition
:::{prf:theorem}
Let $f$ be a differentiable function on $\mathbb{R}^n$. Then $f$ is convex if and only iff, for all $x,y \in \mathbb{R}^n$,
```{math}
:label: eq:first-order
    f(y) \geq f(x) + \nabla f(x)^\top(y-x).
```
:::

:::{margin}
We could more generaly consider a function $f$ differentiable on an arbitrary convex domain.
:::

The inequality [](#eq:first-order) means that at any point $x$, the first order Taylor approximation of $f at $x$ (*i.e.* the tangent at $x$) is a *lower bound* of $f$ globally.

### Second order condition
:::{prf:theorem}
Let $f$ be a function twice differentiable on $\mathbb{R}^n$. Then $f$ is convex if and only if, for all $x \in \mathbb{R}^n$,
```{math}
:label: eq:second-order
    \nabla^2 f(x) \succeq 0.
```
:::

:::{margin}
For a *symmetric* matrix $M \in \mathbb{R}^{n\times n}$, the notation $M \succeq 0$ means that, for all $x\in \mathbb{R}^n$,
\begin{equation*}
    x^\top M x \geq 0.
\end{equation*}
We say that $M$ is *positive semi-definite*. When the inequality is strict, $M$ is said to be *positive definite*, denoted by $M \succ 0$.
$M$ is positive semi-definite if and only if all its eigenvalues are nonnegative.
:::
