

#math-proofs #math #prop
## 1. Instance and Assumptions
Let $\mathcal{I}=\bigl(G,\ I,\ W_0,\ (s_k)_{k\in I},\ (e_k)_{k\in I}\bigr)$ be an instance.

> An instance is static data, what the map file says, that NEVER changes during the game. G (the grid), I the agents, ${}W_{0}{}$ the walls of the maze, $s_{k},k\in I$ means initial cell for each agent, ${}e_{k},k\in I{}$ means exit for each k agent.

... with $G=\lbrace 0,\dots,R-1\rbrace \times\lbrace 0,\dots,C-1\rbrace \subset\mathbb Z^2$ , ${}I=\{1,\dots,n\}{}$ with $n>=1$ , ${}W_{0}\subseteq G{}$ and ${}s_{k},e_{k}\in G{}$; ${}E=\{e_{1},\dots,e_{n}\}, F_{0}=G{}\setminus W_{0}$, initially free cells and ${}f = |{F_{0}}|{}$.

**Assumptions:**
$$
(A1)s_{k}\not\in W_{0},\forall k \text{ and }s_{j}\neq s_{k}\text{ for j!=k}.
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
(A5) S_{k} \not\in\partial{G}, \forall k\text{ (agents start inside)}.
$$

#### Lemma 1 (Consequences of the assumptions)

(a) ${}W_{0}\cap\partial G = \partial G\setminus E{}$
(b) ${}e_{k}\in\partial{G}\text{ by (A4) and }s_{j}\not\in \partial G\text{ by (A5).} {}$
(c) ${}s_{1}=(r,c) \not\in\partial{G}\text{ means }0<r<R-1\text{ and }0<c<C-1\text{ which needs }R-1\geq 2\text{ and }C-1\geq 2.{}$
(d)  ${}\text{The 2n cells }s_{1},\dots,s_{n},e_{1},\dots,e_{n}\text{ are pairwise distinct by (A1), (A2) and (b), and none is in }W_{0}\text{ so all lie in }F_{0}{}$
## 2. States

#### State Space

$$
\mathcal{S}=(G\cup\{\bot\})^I\times\mathcal{P}(G), S =(p,W)\in\mathcal{S}
$$
${}U(p)=\{k\in I|p_{k}\neq\bot\}{}$, is the set of active agents.
The initial state is ${}S_{0}=\{p^0,W_{0}\}{}$ with ${}p^0_{k}=s_{k}{}$.
$$
\text{Goal set: }G=\{(p,W)\in\mathcal{S}|U(p)=\emptyset\}
$$
For a function ${}p, p[k\mapsto v]{}$ denotes the function equal to ${}p{}$ except that it sends ${}k\text{ to }v{}$.

## 3. Actions and applicability

Actions are ${}\alpha=(k,\delta)\in I\times\Delta{}$; there are at most ${}4n{}$ of them.

#### Definition 1(Applicability)

Let ${}S=(p,W), k\in U(p),\delta\in\Delta ,x=p_{k},q=x+\delta\in\mathbb{Z}^2.$
The action ${}\alpha=(k,\delta){}$ is applicable in ${}S{}$ if:
- (P0) ${}q\in G{}$,
- (P1) ${}q\notin W{}$,
- (P2) ${}p_{j}\neq q,\forall j\neq k{}$.
#### Definition 3 (Applicable action set)

$$
A(S)=\{(k,\delta)\in I\times\Delta|k\in U(p)\text{ and }(k,\delta)\text{ is applicable in }S\}.
$$
Note that ${}A(S)=\emptyset \text{ for every }S\in \mathcal G,\text{since }U(p)=\emptyset{}$

$$
T(S,\alpha)=
\begin{cases}
\bigl(p[k\mapsto q],\;W\cup\lbrace x\rbrace\bigr) & \text{if } q\neq e_k \quad\text{(move, case N)}\cr
\bigl(p[k\mapsto \bot],\;W\cup\lbrace x,e_k\rbrace\bigr) & \text{if } q= e_k \quad\text{(exit, case X)}
\end{cases}
$$
 ${}T{}$ is undefined for ${}\alpha\notin A(S){}$

## 4. Transition function

The rules are: a cell an agent leaves becomes a wall; when an agent reaches its own exit it dissapears and the exit becomes a wall; an agent may step on another agent's exit, and that exit becomes wall when it leaves.
#### Definition 4 (Transition)

${}\text{For }S=(p,W) \text{ and }\alpha=(k,\delta)\in A(S)\text{ with }x=p_{k},q=x+\delta:{}$

