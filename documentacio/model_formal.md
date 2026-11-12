# Multi-Snake: Formal Model

## Contents

1. [Instance and Assumptions](#1-instance-and-assumptions)
2. [States](#2-states)
3. [Actions and applicability](#3-actions-and-applicability)
4. [Transition function](#4-transition-function)
5. [Invariants](#5-invariants): Theorem 1
6. [The potential Phi](#6-the-potential-phi): Theorem 2, Corollary 1
7. [Disjoint routes and order independence](#7-disjoint-routes-and-order-independence): Theorem 3, Lemma 2, Theorem 4
8. [Heuristic admissibility](#8-heuristic-admissibility)

## 1. Instance and Assumptions
Let $\mathcal{I}=\bigl(G,\ I,\ W_0,\ (s_k)_{k\in I},\ (e_k)_{k\in I}\bigr)$ be an instance.

> An instance is static data, what the map file says, that NEVER changes during the game. G (the grid), I the agents, ${}W_{0}{}$ the walls of the maze, $s_{k},k\in I$ means initial cell for each agent, ${}e_{k},k\in I{}$ means exit for each k agent.

... with $G=\lbrace 0,\dots,R-1\rbrace \times\lbrace 0,\dots,C-1\rbrace \subset\mathbb Z^2$ , ${}I=\{1,\dots,n\}{}$ with $n\geq 1$ , ${}W_{0}\subseteq G{}$ and ${}s_{k},e_{k}\in G{}$; ${}E=\{e_{1},\dots,e_{n}\}, F_{0}=G{}\setminus W_{0}$, initially free cells and ${}f = |{F_{0}}|{}$. $\partial G$ denotes the contour: the cells of $G$ with row $0$ or $R-1$, or column $0$ or $C-1$.

**Assumptions:**
$$
(A1)s_{k}\not\in W_{0},\forall k \text{ and }s_{j}\neq s_{k}\text{ for }j\neq k.
$$
$$
(A2)e_{k}\not\in W_{0},\forall k, \text{ and }e_{j}\neq e_{k} \text{ for }j\neq k.
$$
$$
(A3)\partial{G}∖ E \subseteq W_{0}\text{ (the contour is wall except at exits).}
$$
$$
(A4) e_{k}\in\partial{G}, \forall k(\text{exits on the contour}).
$$
$$
(A5) s_{k} \not\in\partial{G}, \forall k\text{ (agents start inside)}.
$$

#### Lemma 1 (Consequences of the assumptions)

(a) ${}W_{0}\cap\partial G = \partial G\setminus E\text{ by (A2) and (A3).}{}$
(b) ${}e_{k}\in\partial{G}\text{ by (A4) and }s_{j}\not\in \partial G\text{ by (A5), so }s_{j}\neq e_{k}\text{ for all }j,k.{}$
(c) ${}s_{k}=(r,c) \not\in\partial{G}\text{ means }0<r<R-1\text{ and }0<c<C-1\text{ which needs }R-1\geq 2\text{ and }C-1\geq 2.{}$
(d)  ${}\text{The 2n cells }s_{1},\dots,s_{n},e_{1},\dots,e_{n}\text{ are pairwise distinct by (A1), (A2) and (b), and none is in }W_{0}\text{ so all lie in }F_{0}{}$
## 2. States

#### State Space

$$
\mathcal{S}=(G\cup\{\bot\})^I\times\mathcal{P}(G), S =(p,W)\in\mathcal{S}
$$
${}U(p)=\{k\in I|p_{k}\neq\bot\}{}$, is the set of active agents.
The initial state is ${}S_{0}=(p^0,W_{0}){}$ with ${}p^0_{k}=s_{k}{}$.
$$
\text{Goal set: }\mathcal{S}_{\text{goal}}=\{(p,W)\in\mathcal{S}|U(p)=\emptyset\}
$$
For a function ${}p, p[k\mapsto v]{}$ denotes the function equal to ${}p{}$ except that it sends ${}k\text{ to }v{}$.

## 3. Actions and applicability

Actions are ${}\alpha=(k,\delta)\in I\times\Delta{}$; there are at most ${}4n{}$ of them.

#### Definition 1 (Applicability)

Let ${}S=(p,W), k\in U(p),\delta\in\Delta ,x=p_{k},q=x+\delta\in\mathbb{Z}^2.$
The action ${}\alpha=(k,\delta){}$ is applicable in ${}S{}$ if:
- (P0) ${}q\in G{}$,
- (P1) ${}q\notin W{}$,
- (P2) ${}p_{j}\neq q,\forall j\neq k{}$.
#### Definition 2 (Applicable action set)

$$
A(S)=\{(k,\delta)\in I\times\Delta|k\in U(p)\text{ and }(k,\delta)\text{ is applicable in }S\}.
$$
Note that ${}A(S)=\emptyset \text{ for every }S\in \mathcal{S}_{\text{goal}},\text{since }U(p)=\emptyset{}$

## 4. Transition function

The rules are: a cell an agent leaves becomes a wall; when an agent reaches its own exit it disappears and the exit becomes a wall; an agent may step on another agent's exit, and that exit becomes wall when it leaves.
#### Definition 3 (Transition)

${}\text{For }S=(p,W) \text{ and }\alpha=(k,\delta)\in A(S)\text{ with }x=p_{k},q=x+\delta:{}$

$$
T(S,\alpha)=
\begin{cases}
\bigl(p[k\mapsto q],\;W\cup\lbrace x\rbrace\bigr) & \text{if } q\neq e_k \quad\text{(move, case N)}\cr
\bigl(p[k\mapsto \bot],\;W\cup\lbrace x,e_k\rbrace\bigr) & \text{if } q= e_k \quad\text{(exit, case X)}
\end{cases}
$$
${}T{}$ is undefined for ${}\alpha\notin A(S){}$. Every move costs 1.


## 5. Invariants

#### Theorem 1 (Invariants)

Every reachable state $S=(p,W)$ satisfies:

- (I1) $W_0\subseteq W$.
- (I2) No active agent is on a wall: $p_k\notin W$ for all $k\in U(p)$.
- (I3) No two active agents share a cell: $p_j\neq p_k$ for $j\neq k$ in $U(p)$.
- (I4) No active agent is on its own exit: $p_k\neq e_k$ for all $k\in U(p)$.
- (I5) Used exits are walls: if $p_k=\bot$ then $e_k\in W$.

*Proof.* By induction on the length of the plan that reaches $S$.

**Base case, $S_0=(p^0,W_0)$.**

- (I1): In $S_0$ the wall set is $W_0$, so $W_0\subseteq W_0$ holds.
- (I2): In $S_0$ every agent is active ($U(p^0)=I$) and $p^0_k=s_k$. By (A1),
  $s_k\notin W_0$ for all $k$, so no active agent is on a wall.
- (I3): In $S_0$ every agent is active with $p^0_k=s_k$. By (A1) the $s_k$ are
  pairwise distinct, so no two active agents share a cell.
- (I4): By Lemma 1(b), $s_j\neq e_k$ for all $j,k$; in particular $s_k\neq e_k$.
  Since $p^0_k=s_k$, no agent starts on its own exit.
- (I5): In $S_0$ no agent has $p^0_k=\bot$, so the premise of (I5) is false
  and the statement holds vacuously.

**Inductive step.** Let $S=(p,W)$ satisfy (I1) to (I5), let $\alpha=(k,\delta)\in A(S)$,
$x=p_k$, $q=x+\delta$, and $S'=T(S,\alpha)=(p',W')$.

Facts from applicability that you will need: (P1) gives $q\notin W$, (P2) gives
$q\neq p_j$ for all $j\neq k$, and $q\neq x$ because $\delta\in\Delta$ is
not the zero vector.

- (I1) for $S'$: Walls are never removed. In case N, $W'=W\cup\{x\}$, and in
  case X, $W'=W\cup\{x,e_k\}$, so $W\subseteq W'$ in both cases. By the
  induction hypothesis $W_0\subseteq W$, hence $W_0\subseteq W'$.
- (I2) for $S'$: Case N, agent $k$: its new cell is $q$, and $q\notin W$ by (P1)
  and $q\neq x$, so $q\notin W'=W\cup\{x\}$. Case X: agent $k$ is no longer
  active. Any other active agent $j$ did not move, and $p_j\notin W$ by the
  induction hypothesis (I2). The new walls are not under $j$ either: $p_j\neq x=p_k$
  by (I3), and in case X also $p_j\neq e_k=q$ by (P2). So $p_j\notin W'$.
- (I3) for $S'$: Only agent $k$ changes position. Two active agents $j,j'$ both
  different from $k$ keep their cells, which were different in $S$ by the
  induction hypothesis (I3). For agent $k$ in case N, its new cell is $q$, and
  $q\neq p_j$ for every other agent $j$ by (P2), so $k$ does not share a cell
  with anyone. In case X, agent $k$ is no longer active, so there is nothing to
  check for it.
- (I4) for $S'$: Case N: agent $k$ is on $q$ and $q\neq e_k$ by the definition of
  case N. Case X: agent $k$ is no longer active. Every other active agent $j$ did
  not move, so $p_j\neq e_j$ by the induction hypothesis (I4).
- (I5) for $S'$: Let $p'_j=\bot$. If $j=k$ (only possible in case X), then
  $e_k\in W'$ by the definition of $T$. Otherwise $p_j=\bot$ already in $S$, so
  $e_j\in W$ by (I5) and $W\subseteq W'$. In case N no agent changes to $\bot$.

∎

## 6. The potential Phi

For a state $S=(p,W)$ let
$$\Phi(S)=|W|+|U(p)|,$$
the number of walls plus the number of agents still on the board. In $S_0$,
$\Phi(S_0)=|W_0|+n$.

#### Theorem 2 (Φ grows by exactly 1)

For every reachable state $S$ and every $\alpha\in A(S)$, $\Phi(T(S,\alpha))=\Phi(S)+1$.

*Proof.* Let $\alpha=(k,\delta)$, $x=p_k$, $q=x+\delta$, $S'=T(S,\alpha)=(p',W')$.
By (I2), $x\notin W$.

- **Case N** ($q\neq e_k$). $W'=W\cup\{x\}$ and $x\notin W$, so $|W'|=|W|+1$.
  No agent leaves the board, so $|U|$ is unchanged. Hence $\Phi$ grows by 1.
- **Case X** ($q=e_k$). $W'=W\cup\{x,e_k\}$. Here $x\notin W$ by (I2), $e_k\notin W$
  by (P1) since $e_k=q$, and $e_k\neq x$ because $q\neq x$. So $|W'|=|W|+2$.
  Agent $k$ leaves the board, so $|U|$ drops by 1. Hence $\Phi$ grows by
  $2-1=1$. ∎

#### Corollary 1 (consequences of Theorem 2)

Let $S_0,S_1,\dots,S_m$ be the states along a plan from $S_0$.

1. **No state repeats on a plan.** $\Phi(S_i)=|W_0|+n+i$, so $\Phi(S_i)\neq\Phi(S_j)$ for
   $i\neq j$. Equal states have equal $\Phi$ (it is computed from $W$ and $U(p)$),
   hence $S_i\neq S_j$.
2. **Depth is a function of the state.** Every plan from $S_0$ to a state $S$ has
   length $\Phi(S)-|W_0|-n$. Call this number $\text{depth}(S)$.
3. **A\* never needs to reopen a node.** By (2), every path from $S_0$ to $S$ has
   the same cost $g=\text{depth}(S)$, so a second path to $S$ is never
   cheaper than the first. A closed list only removes duplicate states
   (transpositions) and never has to improve a stored $g$.
4. **Plan bound.** By (I2) and (I3), the cells of $W$ and the cells of the active
   agents are pairwise distinct cells of $G$, so $\Phi(S)\le|G|$. Hence every plan
   has at most $|G|-|W_0|-n=f-n$ moves, and every search over this model
   terminates.

## 7. Disjoint routes and order independence

In a plan, the *route* of agent $k$ is the set of cells it occupies, from $s_k$
to $e_k$. Two routes are *disjoint* if they share no cell.

#### Theorem 3 (Disjoint routes)

In any valid plan, the routes of different agents are disjoint.

*Proof.* Suppose agents $j\neq k$ both occupy a cell $y$. One move is made per
turn, so they do not arrive at the same moment: let $j$ be the first to arrive.
When $k$ later tries to enter $y$, one of two things holds.

- $j$ is still on $y$. Then (P2) forbids the move.
- $j$ has already left $y$, or has exited through it. A cell an agent leaves is
  added to $W$, and a used exit is a wall (I5), so $y\in W$ and (P1) forbids the
  move.

Both cases make $k$'s move inapplicable, which contradicts the plan being valid. ∎

#### Lemma 2 (An agent never revisits a cell)

In a valid plan, an agent never enters a cell it has already left.

*Proof.* When agent $k$ leaves a cell $x$, the transition adds $x$ to $W$, and
walls are never removed ($W\subseteq W'$ in every transition, as shown in the
proof of (I1)). Entering $x$ again would need $x\notin W$ by (P1), which fails. ∎

#### Theorem 4 (Order independence)

Let a valid plan solve the instance, and let $\pi_k$ be the sequence of moves of
agent $k$ in it. Any interleaving of $\pi_1,\dots,\pi_n$ that keeps the order
inside each $\pi_k$ is also a valid plan, with the same cost.

*Proof.* Execute the interleaving move by move. We show by induction that
every move is applicable, and that each agent $k$ is, after its first $i$
moves, on the same cell as after its first $i$ moves in the original plan.
At the start this holds, since every agent is on $s_k$.

Let agent $k$ make its next move, to a cell $y$ of its own route. The move is
applicable in the interleaving:

- (P0) $y\in G$, because the same move is applicable in the original plan.
- (P1) $y\notin W$. At this point $W$ consists of $W_0$ and the cells already
  left by agents, together with used exits. $y\notin W_0$, because $y$ was not a
  wall when $k$ entered it in the original plan and $W_0\subseteq W$ (I1).
  $y$ was not left by $k$ itself by Lemma 2, and it was not left by another agent
  $j$ because the routes of $j$ and $k$ are disjoint (Theorem 3).
- (P2) $y$ is not occupied. Every other active agent $j$ stands on a cell of its
  own route, which is disjoint from the route of $k$ (Theorem 3).

The move is of the same kind (N or X) as in the original plan, since its target
is the same. Hence every move of the interleaving is applicable, every agent ends
on its exit, and the plan is valid. The interleaving uses exactly the same moves
as the original plan, so it has the same number of moves, and each costs 1. ∎

## 8. Heuristic admissibility

_To be written._
