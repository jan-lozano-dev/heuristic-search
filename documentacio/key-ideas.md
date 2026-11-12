# Key Notes

This document states, in our own words, the four rules of the Multi-Snake
model that every later decision depends on: why the wall set is part of the
state (`equals`), why no state repeats on a branch, why A\* never needs to
reopen a node, and why the routes of different agents are disjoint. It is the
gate before any code is written. The full model and proofs are in
`model_formal.md`, which cites these facts by number.

## Fact (1): why the wall set is in `equals`

A move that is legal in one state can be illegal in another with the same
agent positions, because the target cell is a wall in one and free in the
other. Two such states have different futures, so merging them could discard
the state that leads to the solution. Therefore `equals` compares the agent
positions (exited agents included) and the whole wall set.

## Fact (2): no state repeats on a branch

Let $\Phi(S) = |W| + |U(p)|$: the number of walls plus the number of agents
still on the board. Every move raises $\Phi$ by exactly 1:

- **Move to a free cell.** The agent leaves cell $x$, and $x$ becomes a wall.
  $x$ was not a wall before, because an active agent never stands on a wall
  (I2). So $|W|$ grows by 1 and $|U|$ is unchanged: $\Phi$ grows by 1.
- **Move to its own exit $e_k$.** Both $x$ and $e_k$ become walls. They are
  two different new walls: $x$ is not a wall (I2), $e_k$ is not a wall
  (a move needs a non-wall target, P1) and $e_k \neq x$ (an agent never
  starts a move on its own exit, I4). So $|W|$ grows by 2, and $|U|$ drops
  by 1: $\Phi$ grows by 1.

Example: the agent is at (1,1) and its exit is (2,1). Moving to (2,1) walls
both (1,1) and (2,1), and the agent leaves the board.

Since $\Phi$ starts at $|W_0| + n$ and grows by 1 per move, it counts the
moves made so far. $\Phi$ is computed from the state ($W$ and $U(p)$), so two
equal states have the same $\Phi$. Two different positions on one branch have
different $\Phi$, so they are different states. Hence no state repeats on a
branch.

## Fact (3): A\* needs no reopening

Here $n$ is the number of agents and $W_0$ the initial walls, so
$\Phi$ at the start is $|W_0| + n$, and every move adds exactly 1 to $\Phi$
(Theorem 2). Hence every path from the initial state to a state $S$ has the
same length:

$$\text{depth}(S) = \Phi(S) - |W_0| - n$$

This depends only on $S$, so depth is a function of the state.

In A\*, $g$ is the number of moves made. If A\* reaches $S$ a second time by
another path, the new $g$ equals the stored one, never less. The stored $g$ is
already the best, so reopening $S$ gains nothing. A closed list here only
removes duplicate states (transpositions), and never has to improve a $g$
value.

## Fact (4): routes of different agents are disjoint

The route of agent $k$ is the list of cells it steps on from its start $s_k$
to its exit $e_k$. Two routes are **disjoint** if they have no cell in common.

**Claim (Theorem 3).** In any valid plan, the routes of different agents are
disjoint.

*Proof, by contradiction.* Suppose agents $j$ and $k$ both step on a cell $y$.
Only one agent moves per turn, so they cannot arrive at the same moment: one
of them, say $j$, arrives first. When $k$ later tries to enter $y$, there are
two cases:

- $j$ is still standing on $y$. Two agents cannot share a cell, so the move is
  illegal.
- $j$ has already left $y$, or exited through it. Every cell an agent leaves
  becomes a wall, and a used exit is a wall, so $y$ is a wall and the move is
  illegal.

Both cases make $k$'s move illegal, which contradicts the plan being valid.
So no such $y$ exists. ∎

Example: if agent 1 goes through (1,2) and agent 2 wants (1,2) later, agent 2
meets a wall; if agent 1 is standing there, agent 2 cannot enter. Either way
the two routes cannot both contain (1,2).
