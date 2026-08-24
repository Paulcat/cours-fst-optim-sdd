# Convexité

Dans les problèmes de minimisation de fonctions, la *convexité* est une propriété clé, car elle donne une caractérisation simple (du premier ordre) des minimiseurs globaux.

# Définitions et exemples

:::{prf:definition}Ensemble convexe
Un ensemble $C$ est *convexe* si toute ligne joignant deux points de $C$ est entièrement contenues dans $C$, c'est-à-dire, pour tout $(x,y) \in C$ et pour tout $0 \leq \theta \leq 1$
```{math}
    \theta x + (1-\theta)y \in C.
```
:::

:::{figure} images/cvxsets.png
:label: fig:cvx-sets
Exemple d'ensembles convexes et non-convexes. *Gauche*: l'hexagone (avec son contour) est convexe. *Centre*: l'anneau n'est pas convexe, puisque le segment entre les deux points dessinés n'est pas incluse dans l'ensemble. *Droite*: le carré ne contient pas tous les points du bords, et n'est pas convexe.
:::

:::{prf:definition}Fonction convexe
Une fonction $f:E \to \mathbb{R}$ est dite *convexe* si pour tout $x,y \in E$, pour tout $\lambda \in [0,1]$,
```{math}
:label: eq:convexity
    f(\lambda x +  (1-\lambda)y) \leq \lambda f(x) + (1-\lambda) f(y).
```
Lorsque l'inégalité est stricte, $f$ est dite *strictement convexe*. $f$ est dite *(strictement) concave* lorsque $-f$ est (strictement) convexe.
:::

Géométriquement, l'équation [](#eq:convexity) exprime que l'*épigraphe* de $f$, c'est-à-dire l'ensemble des points situés au-dessus du graphe de $f$, est convexe. Autrement dit, le segment joignant les points de coordonnées $(x,f(x))$ et $(y,f(y))$ est toujours au-dessus du graphe de $f$.

# Caractérisations

La convexité d'une fonction est liée à différentes propriétés des différentielles de cette fonction.

### Condition d'ordre 1
:::{prf:theorem}
Soit $f$ une fonction différentiable sur $\mathbb{R}^n$. Alors $f$ est convexe si et seulement si, pour tout $x,y \in \mathbb{R}^n$,
```{math}
:label: eq:first-order
    f(y) \geq f(x) + \nabla f(x)^\top(y-x).
```
:::

:::{margin}
On pourrait plus généralement considérer une fonction $f$ différentiable sur un domaine convexe quelconque.
:::

L'inégalité [](#eq:first-order) exprime qu'en n'importe quel point $x$, l'approximation de Taylor d'ordre $1$ de $f$ en $x$ (c'est-à-dire la tangente en $x$) *minore* $f$ globalement.

### Condition d'ordre 2
:::{prf:theorem}
Soit $f$ une fonction deux fois différentiable sur $\mathbb{R}^n$. Alors $f$ est convexe si et seulement si, pour tout $x \in \mathbb{R}^n$,
```{math}
:label: eq:second-order
    \nabla^2 f(x) \succeq 0.
```
:::

:::{margin}
Pour une matrice $M \in \mathbb{R}^{n\times n}$ *symétrique*, la notation $M \succeq 0$ signifie que, pour tout $x\in \mathbb{R}^n$,
\begin{equation*}
    x^\top M x \geq 0.
\end{equation*}
On dit que $M$ est *semi-définie positive*. Si l'inégalité est stricte, $M$ est dite *définie positive*, noté $M \succ 0$.
$M$ est semi-définie positive si et seulement si toutes ses valeurs propres sont positives.
:::
