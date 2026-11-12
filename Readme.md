# Multi-Snake

Heuristic search for a multi-agent snake puzzle (PROP Q1 26/27, Activity 1).
Several snakes share a grid. Each turn one snake moves, and each snake must
reach its own exit. The project contains a formal model, a PDDL translation,
and Java search algorithms with heuristics.

> **Status:** work in progress.

## Contents

- [Repository layout](#repository-layout)
- [Requirements](#requirements)
- [Build](#build)
- [Usage](#usage)
- [Tests](#tests)
- [Documentation](#documentation)
- [Results](#results)
- [Authors](#authors)

## Repository layout

| Path | Description | Status |
| --- | --- | --- |
| [`documentacio/`](documentacio/) | Formal model, proofs, study | In progress |
| [`pddl/`](pddl/) | `domain.pddl` and `problem.pddl` (map A) | Done |
| [`ac1-cerca/`](ac1-cerca/) | Search algorithms and heuristics (Java) | In progress |
| `ac1-model/`, `ac1-app/` | Base project provided by the course | Provided |

The PDDL, the Java code and the study are all derived from
[`documentacio/model_formal.md`](documentacio/model_formal.md).

## Requirements

- JDK 17 or newer (developed with JDK 21)
- Maven 3.x

## Build

From the project root:

```bash
mvn clean compile
```

## Usage

```bash
bash run.sh
```

<!-- TODO: arguments, maps, example output -->

## Tests

```bash
mvn clean test
```

## Documentation

| File | Content |
| --- | --- |
| [`model_formal.md`](documentacio/model_formal.md) | Model, invariants, heuristic admissibility |
| [`pddl-proof.md`](documentacio/pddl-proof.md) | The PDDL as a translation of the model |
| `estudi.md` | _TBD_ |

## Results

_TBD._

## Authors

- Joan Lozano Funosas
- Roger Martínez Rius

Course project, UPC.
