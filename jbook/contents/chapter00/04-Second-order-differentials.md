# Second-order differentials


The local analysis of a function can be refined beyond the tangential (linear) approximation by explicitly including higher-order terms in the "little o" correction terms. Geometrically, second-order terms determine the position of the manifold (curve, surface, etc.) relative to its tangent (convexity, concavity, inflection points, etc.).

## Functions from $\mathbb{R}^n$ to $\mathbb{R}$

### Definition
If $f:\mathbb{R}^n \to \mathbb{R}$ est [differentiable](#def:diff) on a neighbourhood $U$ of $a$, its differential $L$ defines an application $f'$ of $U$ in $\mathbb{R}^n$:

\begin{equation*}
    x = (x_1,\ldots,x_n) \mapsto f'(x) = \begin{bmatrix} \partial_1 f(x) \\ \vdots \\ \partial_n f(x) \end{bmatrix}.
\end{equation*}

:::{prf:definition}Second-order differential
If the application $f'$ is differentiable at $a$, we say that $f$ is *twice différentiable at $a$* and we denote by $D^2_af$ its *second-order differential*. The components $\partial_i f(x)$ then admit [partial derivatives](#lem:partial) at $a$, denoted by
\begin{equation*}
    \partial_{ij}^2 f(a) = \partial_i (\partial_j f) (a), \quad 1 \leq i,j \leq n.
\end{equation*}
:::

### Hessian matrix
Just as the *différential* defines a *linear* mapping 
\begin{equation*}
    h \mapsto f'(a) \cdot h = \sum_{i=1}^n \partial_i f(a) h_i,
\end{equation*}
represented by the [gradient](#def:gradient) of $f$, the second differential deines a *bilinear* application (that is to say linear in each of its variables)
\begin{equation*}
    (h,k) \mapsto f''(a) \cdot (h,k) = \sum_{i,j=1}^n \partial_{ij}^2 f(a) h_i k_j
\end{equation*}
represented by the *Hessian* matrix of $f$.

:::{prf:definition}Hessian matrix
:label: def:hessienne
The *Hessian matrix* of $f$ at $a \in \mathbb{R}^n$, commonly denoted by $\nabla^2 f(a)$, or $H_f(a)$ or $f''(a)$, is the matrix $n\times n$ defined by
\begin{equation*}
\nabla^2 f(a) = 
\begin{bmatrix} 
    \partial_{11}^2 f(a) & \ldots & \partial_{n1}^2 f(a) \\
    \vdots & & \vdots\\
    \partial_{1n}^2 f(a) & \ldots & \partial_{nn}^2 f(a)
    \end{bmatrix} \in \mathbb{R}^{n \times n}.
\end{equation*}
:::

When it is defined, the Hessian matrix is *symmetric*: indeed, Schwarz theorem ensures that for a function $f$ twice differentiable at $a \in \mathbb{R}^n$, one has
\begin{equation*}
    \partial_{ij}^2 f(a) = \partial_{ji}^2 f(a).
\end{equation*}

:::{prf:example}
The Hessian matrix in the [previous exemple](#ex:partial) is, for all $(x_1,x_2) \in \mathbb{R}^2$,
\begin{equation*}
    \nabla^2 f(x_1,x_2) = \begin{bmatrix} 4 & 1 \\ 1 & -6 \end{bmatrix}
\end{equation*}
:::

## Functions de $\mathbb{R}^n$ dans $\mathbb{R}^m$




## Taylor formula

Higher order differentials are defined similarly, giving the successive terms
\begin{equation*}
    D_af(h),\, D^2_af(h,h),\, D^3_af(h,h,h),\, \ldots
\end{equation*}
:::{margin}
The $k$-th-order differential of a function from $\mathbb{R}^n$ to $\mathbb{R}$ is thus represented by a tensor of order $k$, of size $n\times n \times \ldots \times n$.
:::
These terms enable us to obtain successively linear, quadratic, cubic approximations of the function $f$, and so on. Of particular note is the following theorem.

:::{prf:theorem}Taylor-Young formula 
:label: thm:taylor-young
If $f$ is $k$ times differentiable at $a\in U$, we have
\begin{equation*}
    f(a+h) = f(a) + D_af(h) + \frac{1}{2} D_a^2f(h,h) + \ldots + \frac{1}{k!}D^k_af(h,\ldots,h) + o(|\!|h|\!|^k)
\end{equation*}
when $h$ goes to $0$ in $\mathbb{R}^n$.
:::
