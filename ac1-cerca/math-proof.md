# Math proofs

## 1. Instance and Assumptions
Let \(\mathcal{I}=\bigl(G, I, W_0, (s_k)_{k\in I}, (e_k)_{k\in I}\bigr)\) be an instance.

> An instance is static data, what the map file says, that NEVER changes during the game. G (the grid), I the agents, W_0 the walls of the maze, s_k, k\in I means initial cell for each agent, etc.

... with

\[
G = \{0,\dots,R-1\}\times\{0,\dots,C-1\} \subset \mathbb{Z}^2,
\]

\(I=\{1,\dots,n\}\) with \(n\ge 1\), \(W_0\subseteq G\) and \(s_k,e_k\in G\); \(E=\{e_1,\dots,e_n\}\).

**Assumptions:**

\[
(A1)\quad s_k \notin W_0\quad\text{for all }k,\ \text{and }s_j\neq s_k\text{ for }j\neq k.
\]

\[
(A2)\quad e_k \notin W_0\quad\text{for all }k,\ \text{and }e_j\neq e_k\text{ for }j\neq k.
\]

\[
(A3)\quad \partial G \setminus E \subseteq W_0\qquad\text{(the contour is wall except at exits).}
\]

\[
(A4)\quad e_k\in\partial G\quad\text{for all }k\qquad(\text{exits on the contour}).
\]

\[
(A5)\quad s_k\notin\partial G\quad\text{for all }k\qquad(\text{agents start inside}).
\]

#### Lemma 1 (Consequences of the assumptions)

(a) \(W_0\cap\partial G = \partial G\setminus E\).

(b) \(e_k\in\partial G\) by (A4) and \(s_j\notin\partial G\) by (A5).

(c) If \(s_1=(r,c)\notin\partial G\) then \(0<r<R-1\) and \(0<c<C-1\), which requires \(R-1\ge 2\) and \(C-1\ge 2\).

(d) The \(2n\) cells \(s_1,\dots,s_n,e_1,\dots,e_n\) are pairwise distinct by (A1), (A2) and (b), and none is in \(W_0\), so all lie in \(F_0\).

## 2. States

#### State Space

\[
\mathcal{S} = (G\cup\{\bot\})^I \times \mathcal{P}(G),\qquad S=(p,W)\in\mathcal{S}.
\]

Define

\[
U(p)=\{k\in I\mid p_k\neq\bot\},
\]

the set of active agents. The initial state is \(S_0=(p^0,W_0)\) with \(p^0_k=s_k\).

\[
\mathcal{G} = \{(p,W)\in\mathcal{S}\mid U(p)=\emptyset\}\quad\text{(goal set).}
\]

For a function \(p\), write \(p[k\mapsto v]\) for the function equal to \(p\) except that it sends \(k\) to \(v\).

## 3. Actions and applicability

Actions are \(\alpha=(k,\delta)\in I\times\Delta\); there are at most \(4n\) of them.

#### Definition 1 (Applicability)

Let \(S=(p,W)\), \(k\in U(p)\), \(\delta\in\Delta\), \(x=p_k\), \(q=x+\delta\in\mathbb{Z}^2\).
The action \(\alpha=(k,\delta)\) is applicable in \(S\) if:

- (P0) \(q\in G\),
- (P1) \(q\notin W\),
- (P2) \(p_j\neq q\) for all \(j\neq k\).

#### Definition 3 (Applicable action set)

\[
A(S)=\{(k,\delta)\in I\times\Delta \mid k\in U(p)\text{ and }(k,\delta)\text{ is applicable in }S\}.
\]

Note that \(A(S)=\emptyset\) for every \(S\in\mathcal{G}\), since \(U(p)=\emptyset\).

\[
T(S,\alpha)=
\begin{cases}
\bigl(p[k\mapsto q],\;W\cup\{x\}\bigr) & \text{if } q\neq e_k \quad\text{(move, case N)}\\
\bigl(p[k\mapsto \bot],\;W\cup\{x,e_k\}\bigr) & \text{if } q=e_k \quad\text{(exit, case X)}
\end{cases}
\]

\(T\) is undefined for \(\alpha\notin A(S)\).

## 4. Transition function

The rules are: a cell an agent leaves becomes a wall; when an agent reaches its own exit it disappears and the exit becomes a wall; an agent may step on another agent's exit, and that exit becomes a wall.

#### Definition 4 (Transition)

For \(S=(p,W)\) and \(\alpha=(k,\delta)\in A(S)\) with \(x=p_k\), \(q=x+\delta\):

(transition cases as above)
