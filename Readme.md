# Multi-Snake: PROP Q1 26/27, Activity 1

- GitHub repository: https://github.com/jan-lozano-dev/heuristic-search/
- Team members: Joan Lozano Funosas, Roger Martínez Rius

## Contents

| Folder | Contents |
| --- | --- |
| pddl/ | A clear definition of the problem's conditions, actions, states, and goal. |
| documentacio/ | A formal model and proofs of why and how we built our heuristics and our code. Benchmark results and a study. | 
| ac1-cerca/ |  Different algorithms to solve the same problem, with different heuristics from simpler to more sophisticated. BFS, DFS, IDS, A* in addition to two different heuristics. |

## Formal model

The design of the pddl, java code and markdown documentation is derived from the extra mathematical proofs within documentacio/model_formal.md

## Build and run

From the project root

```
mvn clean compile
bash run.sh
```
