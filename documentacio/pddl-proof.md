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
- The test $q\neq e_k$ is `(not (exit k q))`. `move` is case N and `exit-maze`
  is case X. Exactly one of them can apply, since $q=e_k$ or it is not.

**Why walls need no objects.** A move needs $q\notin W$ (P1), and $W_0\subseteq W$
at all times (I1). So no action ever starts on, or enters, a cell of $W_0$, and
leaving those cells out of the problem changes no plan. `adj` only links cells
of $F_0$, so an illegal move to a wall or outside the grid has no action.

## 4. Effects

Let agent $k$ move from $x=p_k$ to $q$. Since $p_k=x$, we have $x\notin F(S)$.
By Definition 3, both cases add $x$ to $W$, so $x$ stays out of the free cells,
and no action ever adds `free x` back.

- **Case N** (`move`): $p'=p[k\mapsto q]$ and $W'=W\cup\{x\}$. Then
  $F(S')=F(S)\setminus\{q\}$. The effects are `(not (at k x))`,
  `(at k q)` and `(not (free q))`.
- **Case X** (`exit-maze`): $p'=p[k\mapsto\bot]$ and $W'=W\cup\{x,e_k\}$, with
  $q=e_k$. Again $F(S')=F(S)\setminus\{q\}$. The effects are
  `(not (at k x))`, `(exited k)` and `(not (free q))`.

In both cases the free cells lose exactly $q$ and nothing else changes. That is
why the domain needs no other effect.

If $q$ is the exit of another agent $j$, the move is case N. The cell is free
until $k$ stands on it, and it becomes a wall when $k$ leaves, as in the model.

## 5. Conclusion

Applying `move` or `exit-maze` to the encoding of $S$ gives the encoding of
$T(S,\alpha)$, and an action is applicable in the encoding of $S$ exactly when
$\alpha\in A(S)$. By induction on the length of the plan, starting from the
encoding of $S_0$ (Section 2), the plans of the PDDL are the plans of the model.
Every action costs 1, so plan length is plan cost.

## 6. What the proofs justify

The PDDL is a translation of the definitions (Sections 1 to 4 of the model). Two
results of the model are used on top of that:

- **Smaller problem.** Objects only for $F_0$ (I1), as shown in Section 3.
- **Properties carry over.** Since the PDDL equals the model, no plan has more
  than $f-n$ moves (Corollary 1.4), and moves of different agents can be
  reordered freely (Theorem 4).
