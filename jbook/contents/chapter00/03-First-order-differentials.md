# First-order differentials

The fundamental idea behind differential calculus is to approximate a function $f$, locally in the neighbourhood of a point, by a linear mapping (the *tangent*).
You are already familiar with the concept of the *derivative* of a function $f:\mathbb{R} \to \mathbb{R}$ (at a point where it is differentiable). The aim of this page is to introduce or revise the concepts that allow us to generalise this to the case of functions of several variables, and vector-valued.

## Definition

Let $E$ and $F$ be two vector spaces, equipped with their respective norms $|!| \cdot |!|E$ and $|!| \cdot |!|F$. The formal definition of local differentiability is given below.
:::{prf:definition}
:label: def:diff 
Let $U$ be an open set in $E$. A mapping $f:U \to F$ is said to be differentiable at a point $a \in U$ if there exists a linear mapping $D_af \in \mathcal{L}(E,F)$ such that
\begin{equation*}
    f(a+h) = f(a) + D_af(h) + o(|\!| h|\!|).
\end{equation*}
:::

:::{margin}
The notation $o(|\!|h|\!|)$ (read "little o of norm of $h$") means that the remainder
\begin{equation*}
    R(h) = f(a+h) - f(a) - D_af(h)
\end{equation*}
is infinitesimally small compared to $h$, *i.e.*
\begin{equation*}
    \lim_{h \to 0} \frac{|\!|R(h)|\!|}{|\!|h|\!|} = 0
\end{equation*}
:::

The advantage of considering an open set $U$ is that it allows us to define an open ball around $a$ such that, for $h$ sufficiently small, $a+h \in U$. When it exists, the map $D_af$ is unique: we write $D_af(h) = f'(a) \cdot h$, to highlight its linearity.

:::{margin} 
An *open* set $U$ in $E$ is a set such that, for any element $x$ in this set, one can always find an open ball $B$ centered at $x$ such that $B$ is entirely contained within $U$. 
:::

In what follows, we shall again focus on the cases where $E = \mathbb{R}^n$ and $F = \mathbb{R}^m$, equipped with their respective canonical bases.


## Functions from $\mathbb{R}$ to $\mathbb{R}$

For a numerical function $f$ of a numerical variable, the notion of [differentiability](#def:diff) given above is equivalent to that of derivability: indeed, the existence of the limit
\begin{equation*}
    \lim_{h \to 0} \frac{f(a+h) - f(a)}{h} = f'(a) \in \mathbb{R}
\end{equation*}
clearly shows that $f(a+h) = f(a) + f'(a)h + o(h)$. In this case, $f'(a)$ is a *real number*: it is the slope of the tangent line to $f$ at $a$: locally, i.e. by zooming in sufficiently on the point $a$, the function $f$ behaves like the affine line $h \mapsto f(a) + f'(a)h$.

## Functions from $\mathbb{R}^n$ to $\mathbb{R}$

We now consider a numerical function $f$ of a vector variable.

### Partial derivatives
Differentiability of $f$ implies the existence of derivatives along each vector in the canonical basis $e_i$.
:::{margin}
For $x = (x_1,\ldots,x_n)^\top$ in the canonical basis, we shall write $f(x)$ or $f(x_1,\ldots,x_n)$ interchangeably. 
:::

:::{prf:lemma}Partial derivative
:label: lem:partial
Let $f:\mathbb{R}^n\to\mathbb{R}$ [differentiable](#def:diff) at $a$. Then, for all $i=1,\ldots,n$, one has 
\begin{equation*}
    \lim_{t\to 0} \frac{f(a_1,\ldots,a_i+t,\ldots,a_n)-f(a)}{t} = f'(a) \cdot e_i .
\end{equation*}
We shall denote this limit $\partial_i f(a)$, known as the *partial derivative* of $f$ at $a$.
:::

In practice, computing the $i$-th partial derivative of $f(x_1,\ldots,x_n)$ is easy: we set all the variables $x_j$ for $j\neq i$, and compute the derivative with respect to the remaining variable $x_i$.

:::{prf:example}
:label: ex:partial
Let $f(x_1,x_2) = 2x_1^2 + x_1x_2 - 3x_2^2 - x_1 + 1$. The partial derivatives of $f$ are
\begin{equation*}
\left\{
\begin{aligned}

    &\partial_1 f(x_1,x_2) = 4x_1 + x_2 - 1\\
    &\partial_2 f(x_1,x_2) = x_1 - 6x_2

\end{aligned}
\right..
\end{equation*}
:::

:::{warning}Warning
The differentiability of a function implies the existence of partial derivatives, but the converse is not true: a function may have partial derivatives at $a$ without even being continuous at $a$.
:::


### Gradient

The gradietn of $f$ is the vector of its partial derivatives.

:::{prf:definition}Gradient
:label: def:gradient
Let $f:\mathbb{R}^n \to \mathbb{R}$ be a differentiable function. The *gradient* of $f$ at a point $a$, usually denoted by $\nabla f(a)$ or $f'(a)$, is the vector defined by
\begin{equation*}
    \nabla f(a) = \begin{bmatrix} \partial_1f(a) \\ \partial_2 f(a) \\ \vdots \\ \partial_n f(a) \end{bmatrix} \in \mathbb{R}^n.
\end{equation*}
:::

On $\mathbb{R}^n$, one may define the usual scalar product
\begin{equation*}
    x \cdot y = \sum_{i=1}^n x_i y_i \quad \forall x,y \in \mathbb{R}^n
\end{equation*}
When $f$ is [differentiable](#def:diff) with differential $D_af$, the gradient of $f$ is the unique vector such that, for all $h \in \mathbb{R}^n$
\begin{equation*}
    D_af(h) = \nabla f(a) \cdot h
\end{equation*}

:::{prf:example}
The gradient of the function $f$ of the [previous example](#ex:partial) is given by
\begin{equation*}
    \nabla f(x_1,x_2) = \begin{bmatrix} 4x_1 + x_2 -1 \\ x_1 - 6x_2 \end{bmatrix}.
\end{equation*}
:::


## Functions from $\mathbb{R}^n$ to $\mathbb{R}^m$

When $f$ is a vector-valued function with vector variable, we shall write
\begin{equation*}
    f(x) = \begin{bmatrix} f_1(x) \\ \vdots \\ f_m(x) \end{bmatrix} \in \mathbb{R}^m
\end{equation*}
where for all $j=1,\ldots,m$, $f_j$ is a function from $\mathbb{R}^n$ to $\mathbb{R}$.

:::{prf:definition}Jacobian matrix
Let $f:\mathbb{R}^n \to \mathbb{R}^m$ be a differentiable function. The Jacobian matrix of $f$ at a point $a \in \mathbb{R}^n$, commonly denoted by $J_f(a)$ or $f'(a)$, is the matrix
\begin{equation*}
    J_f(a) = 
    \begin{bmatrix} 
        \partial_1 f_1(a) & \partial_2 f_1(a) & \ldots & \partial_n f_1(a) \\
        \partial_1 f_2(a) & \partial_2 f_2(a) & \ldots & \partial_n f_2(a) \\
        \vdots & \vdots & & \vdots \\
        \partial_1 f_m(a) & \partial_2 f_m(a) & \ldots & \partial_n f_m(a)
    \end{bmatrix} \in \mathbb{R}^{m \times n}.
\end{equation*}
:::

Similarly to the gradient, the Jacobian matrix of $f$ is the only matrix such that, for all $h \in \mathbb{R}^n$,
:::{margin}
We overload the notation $f'(a)$, which takes on a different meaning depending on whether
- $f'(a)$ is a real number and $h$ a real number
- $f'(a)$ is a vector and $h$ a vector
- $f'(a)$ is a matrix and $h$ a vector.

The common feature in all three cases is the linearity of $D_af:h\mapsto f'(a) \cdot h$.
:::
\begin{equation*}
    D_af(h) = J_f(a) \cdot h,
\end{equation*}
where, in this instance, the operation $\cdot$ is to be understood as a matrix product.

:::{important}
It is worth noting that the fundamental principle of differential calculus is to recognise that
\begin{equation*}
    \left( \begin{array}{c} \text{change} \\ \text{in the function} \end{array} \right)
    =
    \left( \begin{array}{c} \text{linear term in} \\ \text{the change in the variable} \end{array} \right)
    +
    \left( \begin{array}{c} \text{a small corrective} \\ \text{term} \end{array} \right)
\end{equation*}
\begin{equation*}
    \qquad f(x)-f(x_0) \quad = \qquad \qquad f'(x_0) \cdot (x-x_0) \qquad \qquad \; + \;\, \quad o(|\!|x-x_0|\!|) \qquad \quad  
\end{equation*}
Geometrically, this means that a curve, in the neighbourhood of a point, coincides with a line (the tangent), a surface with a tangent space, etc...:
\begin{equation*}
    f(x) \simeq f(x_0) + f'(x_0)\cdot (x-x_0)
\end{equation*}
:::

## Chain rule

An important property of the differentials is the **differentiation rule for composite functions**.

:::{prf:proposition}
If $f : E \to F$ and $g : F \to G$ are functions that are differentiables at $a$ (on vector spaces $E, F$ and $G$), then the application $g \circ f$ is differentiable at $a$ and one has
\begin{equation*}
    (g \circ f)'(a) = g'(f(a)) \cdot f'(a)
\end{equation*}
:::

This formula is crucial to understand gradient propagations algorithms in neural networks.

