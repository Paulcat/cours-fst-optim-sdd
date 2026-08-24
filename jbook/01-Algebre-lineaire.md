# Notions d'algèbre linéaire

L'objectif du cours est de vous introduire à des problèmes d'optimisation définis sur $\mathbb{R}^n$ (l'ensemble des vecteurs réels de dimension $n$). Cet espace est l'exemple le plus standard d'un *$\mathbb{R}$-espace vectoriel* de dimension finie. Ce chapitre est dédié à quelques concepts importants associés aux espaces vectoriels.

:::{note}
On peut étudier des problèmes d'optimisation sur des espaces bien plus généraux (espaces de dimension infinie, espaces métriques, etc...).  Avantage: norme, produit scalaire, etc...
:::


# Applications linéaires

L'idée clé du calcul différentiel est d'approximer une fonction localement par une application linéaire (la *tangente*). Commençons par définir ce qu'est une application linéaire.
Soient $E$ et $F$ deux $\mathbb{R}$-espaces vectoriels.

## Définition

:::{prf:definition}
:label:def-lineaire
Une application $f:E \to F$ est appelée *application linéaire* si pour tout $(x,y) \in E$, pour tout $\lambda,\mu \in \mathbb{R}$, on a
\begin{equation*}
    f(\lambda x + \mu y) = \lambda f(x) + \mu f(y)
\end{equation*}

Lorsque $f$ est à valeurs scalaires (i.e. $F = \mathbb{R}$), on parle de *forme linéaire*.
:::

On note en général $\mathcal{L}(E,F)$ l'ensemble des applications linéaires de $E$ dans $F$.

## Matrice d'une application

Dans la suite, on suppose que $E$ et $F$ sont tous deux de dimension finie, de base $\mathcal{E} = (e_1, \ldots, e_n)$ et $\mathcal{V} = (v_1,\ldots,v_m)$ respectivement. Dans ce cas, pour connaître une application $f$, il faut et il suffit de connaître les images $f(e_i)$ pour tout $e_i \in \mathcal{E}$.

:::{prf:definition}
:label: def-matrice
La matrice des coordonnées dans la base $\mathcal{V}$ des vecteurs $f(e_i)$, pour $e_i \in \mathcal{E}$, est appelée *matrice de l'application $f$ dans les base $\mathcal{E}$ et $\mathcal{F}$*, notée $M_{\mathcal{E},\mathcal{V}}(f)$. Autrement dit,
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

C'est une matrice de $\mathbb{R}^{m \times n}$.
:::


Dans les cas qui nous intéressent, l'espace $E$ sera $\mathbb{R}^n$ muni de sa base canonique, c'est-à-dire les vecteur $e_i$ tels que
\begin{equation*}
    e_{ik} = \left\{ \begin{aligned} &1 \quad \text{si}\quad  k=i \\ &0 \quad \text{sinon} \end{aligned} \right..
\end{equation*}
De même $F$ sera $\mathbb{R}^m$ muni de sa base canonique. On notera alors plus simplement $M(f)$, ou $M_f$, ou $M$ la matrice d'une application linéaire de $E$ dans $F$. 

:::{important}
Si $M$ est la matrice de l'application $f$, alors pour tout $x \in E$, $f(x) = Mx$.
:::


## Noyau et Image

Soit $f \in \mathcal{L}(E,F)$.

:::{prf:definition}
:label: def-noyau-image
- On appelle *noyau* de $f$ l'ensemble
```{math}
    \left\{ x \in E \; | \; f(x) = 0 \right\}
```
- On appelle *image* de $f$ l'ensemble
```{math}
    \left\{y \in F \; | \; \exists\, x \in E, \quad y = f(x) \right\}
```
:::

Le noyau et l'image de $f$ sont des sous-espaces vectoriels de $E$ et $F$, respectivement. On définit de la même manière le noyau et l'image d'une matrice.

# Valeurs et vecteur propres

Un concept fondamental en algèbre linéaire est celui de *spectre* d'une matrice.

## Définition
:::{prf:definition}Valeurs propres, vecteurs propres
:label: def-spectre

Soit $M \in \mathbb{R}^{n \times n}$. $\lambda \in \mathbb{R}$ est appelée *valeur propre* de $M$ si et seulement s'il existe un vecteur *non nul* $x$ de $\mathbb{R}^n$ tel que
```{math}
    Mx = \lambda x.
```
Autrement dit, s'il existe un vecteur non nul dans le [noyau](#def-noyau-image) de $M - \lambda I$.
Dans ce cas, on dit que $x$ est un *vecteur propre* de $M$ associé à la valeur propre $\lambda$. L'ensemble des valeurs propres de $M$ s'appelle le *spectre* de $M$.
:::

Lorsque l'on peut trouver une base $(x_1,\ldots,x_n)$ de $\mathbb{R}^n$, telle que les vecteurs $x_i$ soient tous vecteurs propres de $M$ (associés aux valeurs propres $\lambda_1,\ldots,\lambda_n$), on dit que la matrice $M$ est *diagonalisable*. Dans ce cas, on a
\begin{equation*}
    M = P \begin{pmatrix} \lambda_1 & & \\ & \ddots & \\ & & \lambda_n \end{pmatrix} P^{-1}
\end{equation*}
où $P = \begin{pmatrix} x_1 & \ldots & x_n \end{pmatrix} \in \mathbb{R}^n$. Autrement dit, exprimée dans la base $P$, la matrice $M$ est diagonale, avec les valeurs propres $\lambda_i$ pour entrées.

## Théorème spectral

Pour les matrices *symétriques*, nous avons le résultat important suivant:
:::{prf:theorem}Théorème spectral
Soit $M \in \mathbb{R}^{n \times n}$ une matrice *symétrique*. Alors $M$ est diagonalisable dans une base *orthonormale* avec valeurs propores réelles, c'est-à-dire qu'il existe $P \in \mathbb{R}^{n\times n}$ *orthogonale* et une matrice $D$ *diagonale* dont tous les coefficients sont réels, telles que
```{math}
    M = P D P^\top.
```
:::

:::{margin}
Une matrice $P \in \mathbb{R}^n$ est dite orthogonale si et seulement si
\begin{equation*}
    PP^\top = P^\top P = I_n.
\end{equation*}
:::

# Normes

Les normes sont un outil important en calcul différentiel, car elles permettent de définir des notions de voisinage d'un point, et donc d'étudier le comportement *local* des fonctions. On se contente dans ce cours de la définition et d'exemple

## Définition
:::{prf:definition}
:label: def-norme
Une *norme* sur $E$ est une application $x \mapsto |\!| x |\!|$ de $E$ dans $[0,+\infty)$ telle que, pour tout $x,y \in E$, pour tout $\lambda \in \mathbb{R}$,
- $|\!| x |\!| = 0 \implies x = 0$
- $|\!| \lambda x |\!| = |\lambda| |\!| x|\!|$ (homogénéité)
- $|\!| x + y |\!| \leq |\!|x|\!| + |\!|y|\!|$ (inégalité triangulaire)
:::

:::{margin}
De l'inégalité triangulaire on peut également déduire l'autre inégalité suivante, souvent moins connue:
\begin{equation*}
    ||\!|x|\!| - |\!|y|\!| | \leq |\!|x-y|\!|
\end{equation*}
:::

Les normes permettent de définir la notion de *boules*, cruciale pour étudier les propriétés de régularités des fonctions sur $E$ (continuité, dérivabilité, etc...). La *boule ouverte* $B(a,r)$ de centre $a \in E$ et de rayon $r$ est l'ensemble des points $x \in E$ tels que $|\!|x-a|\!| < r$. De même, la boule fermée $\overline{B(a,r)}$ de centre $a\in E$ et de rayon $r$ est l'ensemble des points $x \in E$ tels que $|\!|x-a|\!| \leq r$.

Les propriétés de continuité et de dérivabilité étant des propriétés *locales* des fonctions, il convient généralement de les étudier au *voisinage* d'un point donné, typiquement sur une boule ouverte centrée sur le point.

## Exemples

Les normes les plus usuelles sont des normes sur $\mathbb{R}^n$ (vecteurs de dimension $n$).
:::{prf:example}
- **La norme $1$ (ou de Manhattan)**: pour tout $x \in \mathbb{R}^n$, 
\begin{equation*}
    |\!| x |\!|_1 = \sum_{i=1}^n |x_i|
\end{equation*}
- **La norme $2$ (ou euclidienne)**: pour tout $x \in \mathbb{R}^n$, 
\begin{equation*}
    |\!| x |\!|_2= \sqrt{\sum_{i=1}^n x_i^2}
\end{equation*}
- **La norme infini (ou sup)**: pour tout $x \in \mathbb{R}^n$,
\begin{equation*}
    |\!|x|\!|_\infty = \sup_{i} |x_i|
\end{equation*}
:::

Il peut être utile d'avoir une image graphique des boules unités $B_i(0,1) = \{x : |\!|x|\!|_i < 1\} $ associées à chacune de ces normes ($i=1,2,\infty$).

:::{figure} images/normes.png
:label: fig-normes
:align: center

De gauche à droite: les 3 boules unités $B_1(0,1)$, $B_2(0,1)$ et $B_\infty(0,1)$
:::

On rencontrera également dans ce cours des normes matricielles, sur $\mathbb{R}^{n\times m}$.
:::{prf:example}
- **La norme de Frobenius**: pour tout $X \in \mathbb{R}^{n\times m}$,
\begin{equation*}
    |\!|X|\!|_F = \sqrt{\mathrm{Tr}(X^\top X)} = \sqrt{\sum_{i,j}X_{ij}^2}
\end{equation*}
- **La norme infini**: pour tout $X \in \mathbb{R}^{n \times m}$,
\begin{equation*}
    |\!|X|\!|_\infty = \sup_{ij} |{X_{ij}}|
\end{equation*}    
- **La norme d'opérateur**: pour tout $X \in \mathbb{R}^{n\times m}$,
\begin{equation*}
    |\!|X|\!|_{2,2} = \sup_{v \neq 0} \frac{|\!|Xv|\!|_2}{|\!|v|\!|_2}
\end{equation*}
En particulier, cette dernière norme vérifie la propriété importante que pour tout vecteur $v \in \mathbb{R^m}$, $|\!|Xv|\!|_2 \leq |\!|X|\!|_{2,2} |\!|v|\!|_2$.
:::


ceci est un [embedding](#def-norme)
##
