# Pddl

All this is built from the math proofs from the other md. I'll reference everything I use that I already checked.

The claim: a sequence of actions is a plan of `pddl/domain.pddl` and
`pddl/problem.pddl` exactly when it is a plan of the model, with the same
length. Theorem and invariant numbers refer to `model_formal.md`.

## 1. Encoding of a state

The free cells of a state $S=(p,W)$ are the cells that are neither walls nor
occupied by an active agent:
$$F(S)=G\setminus\bigl(W\cup\{p_j : j\in U(p)\}\bigr).$$

The encoding of $S$ is the set of facts:

| Model | PDDL fact |
|---|---|
| $p_k=c$ | `(at k c)` |
| $p_k=\bot$ | `(exited k)` |
| $c\in F(S)$ | `(free c)` |
| $e_k=c$ (never changes) | `(exit k c)` |
| $c'-c\in\Delta$, both in $F_0$ (never changes) | `(adj c c')` |

Objects exist only for the agents and for the cells of $F_0$.

## 2. Initial state and goal

- **Init.** The encoding of $S_0$ is the `:init` block. By Lemma 1(d), $s_k$ and
  $e_k$ are distinct cells of $F_0$, and $F(S_0)=F_0\setminus\{s_1,\dots,s_n\}$.
- **Goal.** `(exited k)` for every agent holds exactly when $U(p)=\emptyset$,
  that is, when $S\in\mathcal{S}_{\text{goal}}$.

## 3. Preconditions

- (P0) $q\in G$ is `(adj x q)`.
- (P1) and (P2) together say $q\notin W$ and $q\neq p_j$ for $j\neq k$. Since
  $q\neq x=p_k$, this is $q\in F(S)$, that is, `(free q)`.

  FALTA COSAS
