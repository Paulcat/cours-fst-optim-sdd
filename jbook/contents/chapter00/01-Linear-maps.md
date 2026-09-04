# Linear mappings

The aim of the course is to introduce you to optimisation problems defined on $\mathbb{R}^n$ (the set of real vectors of dimension $n$). This space is the most standard example of a finite-dimensional $\mathbb{R}$-vector space.

:::{note}
Optimisation problems can be studied in much more general spaces (infinite-dimensional spaces, metric spaces, etc.). Advantages: norm, scalar product, etc.
:::

The key idea behind differential calculus is to approximate a function locally by a linear mapping (the tangent). Let us begin by defining what a linear mapping is. Let $E$ and $F$ be two $\mathbb{R}$-vector spaces.

## Basic definitions

:::{prf:definition}Linear maps
:label:def-lineaire
A mapping $f: E \to F$ is called a *linear mapping* if, for all $(x, y) \in E$ and all $\lambda, \mu \in \mathbb{R}$, we have
\begin{equation*} 
    f(\lambda x + \mu y) = \lambda f(x) + \mu f(y)
\end{equation*}
When $f$ takes scalar values (i.e. $F = \mathbb{R}$), it is referred to as a *linear form*.
:::

In general, we denote by $\mathcal{L}(E,F)$ the set of all linear mappings from $E$ to $F$.


In what follows, we assume that $E$ and $F$ are both finite-dimensional, with bases $\mathcal{E} = (e_1, \ldots, e_n)$ and $\mathcal{V} = (v_1, \ldots, v_m)$ respectively. In this case, to determine a mapping $f$, it is both necessary and sufficient to know the images $f(e_i)$ for all $e_i \in \mathcal{E}$.

:::{prf:definition}Matrix of a mapping
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

:::{important}Link between maps and matrices
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

## Eigenvalues and eigenvectors

A fundamental notion in linear algebra is that of the *spectrum* of a matrix.

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

