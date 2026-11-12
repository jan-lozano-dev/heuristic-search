; Multi-Snake - PROP Activity 1 - Part 1: problem for map A
;
;      0 1 2 3 4 5 6 7
;   0  # # # # # # # #
;   1  a . . . . . A #
;   2  # . . # . . . #
;   3  # B . . . . . b
;   4  # # # # # # # #
;
; Cell cR_C is the cell in row R and column C. Only the cells of F_0 (the
; cells that are not walls) have an object, because by (I1) no agent ever
; enters a cell of W_0.
(define (problem mapaA)
  (:domain multisnake)

  (:objects
    A B - agent
    c1_0 c1_1 c1_2 c1_3 c1_4 c1_5 c1_6 - cell
    c2_1 c2_2 c2_4 c2_5 c2_6 - cell
    c3_1 c3_2 c3_3 c3_4 c3_5 c3_6 c3_7 - cell
  )

  (:init
    ; Start cell of each agent (s_k)
    (at A c1_6)
    (at B c3_1)

    ; Free cells: all cells of F_0 except those where an agent starts
    (free c1_0) (free c1_1) (free c1_2) (free c1_3) (free c1_4) (free c1_5)
    (free c2_1) (free c2_2) (free c2_4) (free c2_5) (free c2_6)
    (free c3_2) (free c3_3) (free c3_4) (free c3_5) (free c3_6) (free c3_7)

    ; Exit of each agent (e_k)
    (exit A c1_0)
    (exit B c3_7)

    ; Adjacency in both directions (P0)
    (adj c1_0 c1_1)
    (adj c1_1 c2_1) (adj c1_1 c1_0) (adj c1_1 c1_2)
    (adj c1_2 c2_2) (adj c1_2 c1_1) (adj c1_2 c1_3)
    (adj c1_3 c1_2) (adj c1_3 c1_4)
    (adj c1_4 c2_4) (adj c1_4 c1_3) (adj c1_4 c1_5)
    (adj c1_5 c2_5) (adj c1_5 c1_4) (adj c1_5 c1_6)
    (adj c1_6 c2_6) (adj c1_6 c1_5)
    (adj c2_1 c1_1) (adj c2_1 c3_1) (adj c2_1 c2_2)
    (adj c2_2 c1_2) (adj c2_2 c3_2) (adj c2_2 c2_1)
    (adj c2_4 c1_4) (adj c2_4 c3_4) (adj c2_4 c2_5)
    (adj c2_5 c1_5) (adj c2_5 c3_5) (adj c2_5 c2_4) (adj c2_5 c2_6)
    (adj c2_6 c1_6) (adj c2_6 c3_6) (adj c2_6 c2_5)
    (adj c3_1 c2_1) (adj c3_1 c3_2)
    (adj c3_2 c2_2) (adj c3_2 c3_1) (adj c3_2 c3_3)
    (adj c3_3 c3_2) (adj c3_3 c3_4)
    (adj c3_4 c2_4) (adj c3_4 c3_3) (adj c3_4 c3_5)
    (adj c3_5 c2_5) (adj c3_5 c3_4) (adj c3_5 c3_6)
    (adj c3_6 c2_6) (adj c3_6 c3_5) (adj c3_6 c3_7)
    (adj c3_7 c3_6)
  )

  ; Goal: every agent has exited
  (:goal (and
    (exited A)
    (exited B)
  ))
)
