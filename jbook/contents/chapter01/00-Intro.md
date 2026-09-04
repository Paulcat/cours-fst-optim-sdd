---
title: Iterative methods for unconstrained optimisation
---

# Introduction

In this chapter, we consider *unconstrained optimisation* problems of the form
\begin{equation*}
    \min_{\x \in \RR^n} f(\x)
\end{equation*}

In most cases, such problems do not admit *analytical solutions* (unlike the least-squares problem). To solve it we will resort to **iterative algorithms**:
- *choose* on (or several) initial point(s) $\x_0 \in \RR^n$
- at each step $k>0$, construct a new point $\x_k$ following *update rules depending on the objective $f$ and the previous iterate $\x_{k-1}$
- reiterate until some *stopping criterion* is satisfied

:::{important}Key notions
- Gradient-free methods
- First-order methods (gradient descent)
- Second-order methods (Newton algorithm)
- Stopping criteria
- Convergence rates, complexity
:::
