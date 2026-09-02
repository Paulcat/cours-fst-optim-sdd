# Basics of linear algebra

The aim of the course is to introduce you to optimisation problems defined on $\mathbb{R}^n$ (the set of real vectors of dimension $n$). This space is the most standard example of a finite-dimensional $\mathbb{R}$-vector space. This chapter is devoted to a number of important concepts associated with vector spaces.

:::{note}
Optimisation problems can be studied in much more general spaces (infinite-dimensional spaces, metric spaces, etc.). Advantages: norm, scalar product, etc.
:::


# Applications linéaires

The key idea behind differential calculus is to approximate a function locally by a linear mapping (the tangent). Let us begin by defining what a linear mapping is. Let $E$ and $F$ be two $\mathbb{R}$-vector spaces.

## Definition

:::{prf:definition}
:label:def-lineaire
A mapping $f: E \to F$ is called a *linear mapping* if, for all $(x, y) \in E$ and all $\lambda, \mu \in \mathbb{R}$, we have
\begin{equation*} 
    f(\lambda x + \mu y) = \lambda f(x) + \mu f(y)
\end{equation*}
When $f$ takes scalar values (i.e. $F = \mathbb{R}$), it is referred to as a *linear form*.
:::

In general, we denote by $\mathcal{L}(E,F)$ the set of all linear mappings from $E$ to $F$.

## Matrix of a mapping

In what follows, we assume that $E$ and $F$ are both finite-dimensional, with bases $\mathcal{E} = (e_1, \ldots, e_n)$ and $\mathcal{V} = (v_1, \ldots, v_m)$ respectively. In this case, to determine a mapping $f$, it is both necessary and sufficient to know the images $f(e_i)$ for all $e_i \in \mathcal{E}$.

:::{prf:definition}
:label: def-matrice
The matrix of coordinates of the vectors $f(e_i)$ in the basis $\mathcal{V}$, for $e_i \in \mathcal{E}$, is called *matrix of the mapping $f$ in the bases $\mathcal{E}$ and $\mathcal{F}$*, denoted by $M_{\mathcal{E},\mathcal{V}}(f)$. In other words,
\begin{equation*}
    \begin{aligned}
        & \begin{matrix} & f(e_1) & & f(e_i) & & f(e_n) \end{matrix}\\
        M_{\mathcal{E},\mathcal{V}}(f) = &\begin{bmatrix}
                & & & & & a_{i,1} & & & & &\\
                & & & & & a_{i,2} & & & & &\\
                & & & & & & & & & &\\
                & & & & & a_{i,m} & & & & &\\
            \end{bmatrix}
        \begin{matrix} v_1 \\ v_2 \\ \\ v_m \end{matrix} 
    \end{aligned}.
\end{equation*}

It is a matrix in $\mathbb{R}^{m \times n}$.
:::

In the cases that concern us, the space $E$ will be $\mathbb{R}^n$ equipped with its canonical basis, that is, the vectors $e_i$ such that
\begin{equation*}
    e_{ik} = \left\{ \begin{aligned} &1 \quad \text{si}\quad  k=i \\ &0 \quad \text{sinon} \end{aligned} \right..
\end{equation*}

Similarly, $F$ will be $\mathbb{R}^m$ equipped with its canonical basis. We shall then denote by $M(f)$, or $M_f$, or $M$, the matrix of a linear mapping from $E$ to $F$.

:::{important}
If $M$ is the matrix of the mapping $f$, then for all $x \in E$, $f(x) = Mx$.
:::


## Kernel and Range

Let $f \in \mathcal{L}(E,F)$.

:::{prf:definition}
:label: def-noyau-image
- The *kernel* of $f$ is the set
```{math}
    \left\{ x \in E \; | \; f(x) = 0 \right\}
```
- The *range* of $f$ is the set
```{math}
    \left\{y \in F \; | \; \exists\, x \in E, \quad y = f(x) \right\}
```
:::

The kernel and the range of $f$ are vector subspaces of $E$ and $F$, respectively. The kernel and the range of a matrix are defined in the same way.

# Eigenvalues and eigenvectors

A fundamental notion in linear algebra is that of the *spectrum* of a matrix.

## Définition
:::{prf:definition}Eigenvalues, eigenvectors
:label: def-spectre

Let $M \in \mathbb{R}^{n \times n}$. $\lambda \in \mathbb{R}$ is called *eigenvalue* de $M$ if and only if there exists a *non-zero* vector $x \in \mathbb{R}^n$ sucg that
```{math}
    Mx = \lambda x.
```
In other words, if there exists a non-zero vector in the [kernel](#def-noyau-image) of $M - \lambda I$.
In this case, $x$ is called an *eigenvector* of $M$ associated with the eignevalue $\lmbda$. The set of all eigenvalues of $M$ is called the *spectrum* of $M$.
:::

 
When there exists a basis $(x_1,\ldots,x_n)$ of $\mathbb{R}^n$, such that the vectors $x_i$ are all eigenvectors of $M$ (associated with the eigenvalues $\lambda_1,\ldots,\lambda_n$), the matrix $M$ is said to be *diagonalisable*. In this case, one has
\begin{equation*}
    M = P \begin{pmatrix} \lambda_1 & & \\ & \ddots & \\ & & \lambda_n \end{pmatrix} P^{-1}
\end{equation*}
where P = \begin{pmatrix} x_1 & \ldots & x_n \end{pmatrix} \in \mathbb{R}^n$. In other words, onec expressed in the basis $P$, the matrix $M$ is diagonal, with eigenvalues $\lambda_i$ as diagonal values.

## Spectral theorem

For *symmetric* matrices, the following important result holds:
:::{prf:theorem}Spectral theorem
Let $M \in \mathbb{R}^{n \times n}$ be a *symmetric* matrix. Then $M$ is diagonalisable in an *orthogonal* basis with *real* eigenvalues, *i.e.* there exists an *orthogonal* matrix $P \in \mathbb{R}^{n\times n}$ and a *diagonal* matrix $D$ whose coefficients are all real, such that
```{math}
    M = P D P^\top.
```
:::

:::{margin}
A matrix $P \in \mathbb{R}^n$ is said to be orthogonal if and only if
\begin{equation*}
    PP^\top = P^\top P = I_n.
\end{equation*}
:::

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

## Exemples

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

:::{figure} images/normes.png
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
In particular, the latter satsify the important property that for all vector $v \in \mathbb{R^m}$, $|\!|Xv|\!|_2 \leq |\!|X|\!|_{2,2} |\!|v|\!|_2$.
:::

##
