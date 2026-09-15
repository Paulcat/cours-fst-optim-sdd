---
kernelspec:
    name: python3
---

# Descent methods: general principles

Descent methods build their solution *iteratively* from an **initial point** $\x_0$ by following an update rule of the form
```{math}
:numbered: false
    \x_{k+1} = \x_k + \alpha_k \d_k
```
where $\alpha_k \geq 0$ is the **stepsize**, and $\d_k$ is a **descent direction**. The algorithm then stops when some given **stopping criterion** is met.

Ideally, we would like that $\x_k$ converges towards a **global minimizer** $\x_\star$ as $k \to \infty$. In practice, this is not always possible as the objective may not be convex, and descent methods can only provide convergence guarantees towards a **local minimizer**.

:::{important}A descent algorithm should 
- produce a sequence $\{\x_k\}$ that makes the objective decrease, *i.e.*
\begin{equation*}
    f(\x_0) \geq f(\x_1) \geq \ldots \geq f(\x_k) \geq f(\x_{k+1}) \geq \ldots
\end{equation*}
- stop automatically when it is not making progress anymore.

These properties can be ensured by choosing carefully
1. the descent direction
2. the stepsize
3. the stopping criterion.

The initialisation may also influence the convergence of descent algorithms.
:::

## Descent directions

:::{prf:definition}Descent direction
We say that $\d \in \RR^n$ is a **descent direction** at $\x \in \RR^n$ when
\begin{equation*}
    \exists \alpha > 0 \quad \text{tel que} \quad f(\x) \geq f(\x + \alpha \d)
\end{equation*}
:::

A descent direction $\d \in \RR^n$ at $\x_k$ satisfies
```{math}
:label: eq:descent-condition
    \nabla f(\x_k) \cdot \d \leq 0.
```
Indeed, the Taylor expansion of $f$ at $\x_k$ in the direction $\d$ gives that locally around $\x_k$
\begin{equation*}
    f(\x_k + \alpha \d) - f(\x_k) \simeq_{\alpha \sim 0} \alpha \nabla f(\x_k) \cdot d.
\end{equation*}
which (locally) yields the inequality [](#eq:descent-condition) when $d$ is a descent direction.  

:::{figure} figures/direction-descente.svg
:label: fig-descent-directions
:width: 450px
:align: center

Descent directions at $\x_k$ (in red) are directions that make us cross the level line at $\x_k$.
:::

:::{hint} Zoology of descent methods
Each choice of descent direction gives a different descent algorithm. The generic form of descent directions is
```{math}
:numbered: false

\d_k = - \B_k^{-1} \nabla f(\x_k) 
```
where $\B_k$ is symmetric and invertible.
For instance, as we will see in the next section:
- $\B_k = I_n$ (identity matrix) corresponds to gradient descent methods
- $\B_k = \nabla^2 f(\x_k)$ (Hessian matrix) corresponds to Newton's method
- $\B_k \simeq \nabla^2f(\x_k)$ (approximate Hessian) corresponds to quasi-Newton methods
:::

## Stepsize

Once a direction is chosen, the **stepsize** governs how far each iteration goes along this direction. It has an impact on the convergence of descent algorithms: if chosen too small, the iterates may converge very slowly; if chosen too large, the iterates may diverge.

There are three main stepsize strategies that we will investigate in the next sections:
- *constant*
- *optimal*
- chosen via *linesearch*

## Stopping criteria

In theory, a descent algorithm produces a sequence $\{\x_k\}_{k=1,2,\ldots}$ such that the limit $\lim_{k \to \infty} \x_k$ be a local minimum. In practice however, the algorithm must stop after a *finite* number of iterations.

This is achieved by stopping the iterations as soon as a certain *quantitative* criterion goes below some small tolerance threshold $\epsilon$.

:::{important} The criteria most commonly used are:
- the change in objective: $|f(\x_{k+1}) - f(\x_k)| \leq \epsilon$
- the change in solution: $|\!|\x_{k+1} - \x_k|\!| \leq \epsilon$
- the norm of the gradient: $\|\!| \nabla f(\x_k) |\!| \leq \epsilon$
:::

In practice, it is preferable to use these criteria in *relative values* to avoid scaling issues, *e.g.*
```{math}
:numbered: false

\frac{|f(\x_{k+1}) - f(\x_k)|}{|f(\x_k)|}, \qquad \frac{|\!|\x_{k+1} - \x_k|\!|}{|\!|\x_k|\!|}.
```
