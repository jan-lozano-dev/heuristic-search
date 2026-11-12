; Multi-Snake - Activitat 1 PROP - Primera part: problema del mapa A
;
;      0 1 2 3 4 5 6 7
;   0  # # # # # # # #
;   1  a . . . . . A #
;   2  # . . # . . . #
;   3  # B . . . . . b
;   4  # # # # # # # #
;
; La casella cF_C es la de la fila F i la columna C. Nomes hi ha objecte
; per a les caselles que no son paret.
(define (problem mapaA)
  (:domain multisnake)

  (:objects
    A B - agent
    c1_0 c1_1 c1_2 c1_3 c1_4 c1_5 c1_6 - casella
    c2_1 c2_2 c2_4 c2_5 c2_6 - casella
    c3_1 c3_2 c3_3 c3_4 c3_5 c3_6 c3_7 - casella
  )

  (:init
    ; Posicio inicial de cada agent (s_k)
    (esta-en A c1_6)
    (esta-en B c3_1)

    ; Caselles lliures: totes menys les que ocupen els agents
    (esta-buida c1_0) (esta-buida c1_1) (esta-buida c1_2) (esta-buida c1_3) (esta-buida c1_4) (esta-buida c1_5)
    (esta-buida c2_1) (esta-buida c2_2) (esta-buida c2_4) (esta-buida c2_5) (esta-buida c2_6)
    (esta-buida c3_2) (esta-buida c3_3) (esta-buida c3_4) (esta-buida c3_5) (esta-buida c3_6) (esta-buida c3_7)

    ; Sortida de cada agent (e_k)
    (sortida A c1_0)
    (sortida B c3_7)

    ; Veinatge en els dos sentits (P0)
    (veina c1_0 c1_1)
    (veina c1_1 c2_1) (veina c1_1 c1_0) (veina c1_1 c1_2)
    (veina c1_2 c2_2) (veina c1_2 c1_1) (veina c1_2 c1_3)
    (veina c1_3 c1_2) (veina c1_3 c1_4)
    (veina c1_4 c2_4) (veina c1_4 c1_3) (veina c1_4 c1_5)
    (veina c1_5 c2_5) (veina c1_5 c1_4) (veina c1_5 c1_6)
    (veina c1_6 c2_6) (veina c1_6 c1_5)
    (veina c2_1 c1_1) (veina c2_1 c3_1) (veina c2_1 c2_2)
    (veina c2_2 c1_2) (veina c2_2 c3_2) (veina c2_2 c2_1)
    (veina c2_4 c1_4) (veina c2_4 c3_4) (veina c2_4 c2_5)
    (veina c2_5 c1_5) (veina c2_5 c3_5) (veina c2_5 c2_4) (veina c2_5 c2_6)
    (veina c2_6 c1_6) (veina c2_6 c3_6) (veina c2_6 c2_5)
    (veina c3_1 c2_1) (veina c3_1 c3_2)
    (veina c3_2 c2_2) (veina c3_2 c3_1) (veina c3_2 c3_3)
    (veina c3_3 c3_2) (veina c3_3 c3_4)
    (veina c3_4 c2_4) (veina c3_4 c3_3) (veina c3_4 c3_5)
    (veina c3_5 c2_5) (veina c3_5 c3_4) (veina c3_5 c3_6)
    (veina c3_6 c2_6) (veina c3_6 c3_5) (veina c3_6 c3_7)
    (veina c3_7 c3_6)
  )

  ; Meta: tots els agents han sortit
  (:goal (and
    (ha-sortit A)
    (ha-sortit B)
  ))
)
