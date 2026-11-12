; Multi-Snake - Activitat 1 PROP - Primera part: domini
;
; Correspondencia amb el model formal (documentacio/model_formal.md):
;   p_k = c              ->  (esta-en ?a ?c)
;   c no es de W         ->  (esta-buida ?c)   sense paret, rastre ni agent
;   e_k = c              ->  (sortida ?a ?c)
;   p_k = bot            ->  (ha-sortit ?a)
;   P0 (q = x + delta)   ->  (veina ?c1 ?c2)
(define (domain multisnake)
  (:requirements :strips :typing :negative-preconditions)

  (:types
    agent casella
  )

  (:predicates
    (esta-en ?a - agent ?c - casella)   ; dinamic
    (esta-buida ?c - casella)           ; dinamic
    (sortida ?a - agent ?c - casella)   ; estatic
    (ha-sortit ?a - agent)              ; dinamic
    (veina ?c1 ?c2 - casella)           ; estatic
  )

  ; Cas N: l'agent es mou a una casella lliure que no es la seva sortida.
  ; La casella que deixa no torna a estar buida: queda com a rastre (paret).
  (:action moure
    :parameters (?a - agent ?origen ?desti - casella)
    :precondition (and
      (esta-en ?a ?origen)
      (veina ?origen ?desti)        ; P0
      (esta-buida ?desti)           ; P1 i P2
      (not (sortida ?a ?desti))     ; q diferent de e_k
    )
    :effect (and
      (not (esta-en ?a ?origen))
      (esta-en ?a ?desti)
      (not (esta-buida ?desti))
    )
  )

  ; Cas X: l'agent arriba a la seva sortida i desapareix del tauler.
  ; La casella que deixa queda com a rastre i la sortida es converteix en paret.
  (:action sortir
    :parameters (?a - agent ?origen ?desti - casella)
    :precondition (and
      (esta-en ?a ?origen)
      (veina ?origen ?desti)        ; P0
      (esta-buida ?desti)           ; P1 i P2
      (sortida ?a ?desti)           ; q = e_k
    )
    :effect (and
      (not (esta-en ?a ?origen))
      (ha-sortit ?a)
      (not (esta-buida ?desti))
    )
  )
)
