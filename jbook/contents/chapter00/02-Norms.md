# Norms

Normes are important tools in differential calculus, as they allow to define the concept of neighborhood of a point, and thus to study the local behavior of functions. In this course, we shall confine ourselves to the definition and examples.

## Definition
:::{prf:definition}
:label: def-norme
A *norm* on $E$ is a mapping $x \mapsto |\!| x |\!|$ from $E$ to $[0,+\infty)$ such that, for all $x,y \in E$, for all $\lambda \in \mathbb{R}$,
- $|\!| x |\!| = 0 \implies x = 0$
- $|\!| \lambda x |\!| = |\lambda| |\!| x|\!|$ (homogeneity)
- $|\!| x + y |\!| \leq |\!|x|\!| + |\!|y|\!|$ (triangular inequality)
:::

:::{margin}
From the triangular inequality, one can also obtain the following inequality:
\begin{equation*}
    ||\!|x|\!| - |\!|y|\!| | \leq |\!|x-y|\!|
\end{equation*}
:::

Norms aloow us to define the concept of *balls*, which is crucial for studying the reularity properties of functions on $E$ (continuity, differentiability, etc...). The *open ball* $B(a,r)$ centered at $a \in E$ and with radius $r$ is the set of points $x \in E$ such that $|\!|x-a|\!| < r$. Similarly, the *closed ball* $\overline{B(a,r)}$ with center $a\in E$ and with radius $r$ is the set of points $x \in E$ such that $|\!|x-a|\!| \leq r$.

Continuity and differentiability properties being *local* properties of functions, they should be studied on *neighorhoods* of a given point, typically on open balls centered at this point.

## Examples

The most commonly used norms are norms on $\mathbb{R}^n$ ($n$-dimensional vectors).
:::{prf:example}
- **$\ell^1$-norm (or Manhattan norm)**: for all $x \in \mathbb{R}^n$, 
\begin{equation*}
    |\!| x |\!|_1 = \sum_{i=1}^n |x_i|
\end{equation*}
- **$\ell^2$-norm (ou Euclidean norm)**: for all $x \in \mathbb{R}^n$, 
\begin{equation*}
    |\!| x |\!|_2= \sqrt{\sum_{i=1}^n x_i^2}
\end{equation*}
- **Infinity norm (or supremum norm)**: for all $x \in \mathbb{R}^n$,
\begin{equation*}
    |\!|x|\!|_\infty = \sup_{i} |x_i|
\end{equation*}
:::

The following figure gives an illustration of the unit balls $B_i(0,1) = \{x : |\!|x|\!|_i < 1\} $ associated with each of these norms ($i=1,2,\infty$).

:::{figure} figures/normes.png
:label: fig-normes
:align: center

From left to right: the 3 unit balls $B_1(0,1)$, $B_2(0,1)$ et $B_\infty(0,1)$
:::

We will also encounter in this course *matrix norms* on $\mathbb{R}^{n\times m}$.
:::{prf:example}
- **Frobenius norm**: for all $X \in \mathbb{R}^{n\times m}$,
\begin{equation*}
    |\!|X|\!|_F = \sqrt{\mathrm{Tr}(X^\top X)} = \sqrt{\sum_{i,j}X_{ij}^2}
\end{equation*}
- **Infinity norm**: for all $X \in \mathbb{R}^{n \times m}$,
\begin{equation*}
    |\!|X|\!|_\infty = \sup_{ij} |{X_{ij}}|
\end{equation*}    
- **Operator norm**: for all $X \in \mathbb{R}^{n\times m}$,
\begin{equation*}
    |\!|X|\!|_{2,2} = \sup_{v \neq 0} \frac{|\!|Xv|\!|_2}{|\!|v|\!|_2}
\end{equation*}
In particular, this last norm satisfy is such that for all vector $v \in \mathbb{R^m}$, $|\!|Xv|\!|_2 \leq |\!|X|\!|_{2,2} |\!|v|\!|_2$.
:::



