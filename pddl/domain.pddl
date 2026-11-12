; Multi-Snake - PROP Activity 1 - Part 1: domain
;
; Correspondence with the formal model (documentacio/model_formal.md):
;   p_k = c              ->  (at ?k ?c)
;   c in F(S)            ->  (free ?c)    no wall, no trail and no agent on c
;   e_k = c              ->  (exit ?k ?c)
;   p_k = bot            ->  (exited ?k)
;   P0 (q = x + delta)   ->  (adj ?x ?q)
(define (domain multisnake)
  (:requirements :strips :typing :negative-preconditions)

  (:types
    agent cell
  )

  (:predicates
    (at ?k - agent ?c - cell)       ; dynamic
    (free ?c - cell)                ; dynamic
    (exit ?k - agent ?c - cell)     ; static
    (exited ?k - agent)             ; dynamic
    (adj ?x ?q - cell)              ; static
  )

  ; Case N: agent k moves to a free cell q that is not its own exit.
  ; The cell x it leaves is never free again: it stays a wall.
  (:action move
    :parameters (?k - agent ?x ?q - cell)
    :precondition (and
      (at ?k ?x)
      (adj ?x ?q)                   ; P0
      (free ?q)                     ; P1 and P2
      (not (exit ?k ?q))            ; q different from e_k
    )
    :effect (and
      (not (at ?k ?x))
      (at ?k ?q)
      (not (free ?q))
    )
  )

  ; Case X: agent k reaches its own exit q = e_k and leaves the board.
  ; The cell x it leaves stays a wall, and the exit becomes a wall.
  (:action exit-maze
    :parameters (?k - agent ?x ?q - cell)
    :precondition (and
      (at ?k ?x)
      (adj ?x ?q)                   ; P0
      (free ?q)                     ; P1 and P2
      (exit ?k ?q)                  ; q = e_k
    )
    :effect (and
      (not (at ?k ?x))
      (exited ?k)
      (not (free ?q))
    )
  )
)
