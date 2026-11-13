package edu.epsevg.prop.ac1.cerca;

import edu.epsevg.prop.ac1.cerca.model.Mapa;
import edu.epsevg.prop.ac1.model.Moviment;
import edu.epsevg.prop.ac1.resultat.ResultatCerca;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Queue;
import java.util.Set;

/**
 * Shared machinery for every search. It holds the only search loop of the project:
 * the algorithms differ only in the open list they supply (FIFO, LIFO, priority)
 * and in two optional hooks (depth limit, node filter).
 * <p>
 * Decisions, valid for every subclass:
 * <ul>
 *   <li>Goal test when a node leaves the open list, so "explored" means the same
 *       in every algorithm.</li>
 *   <li>LNT (usarLNT = true): a state enters the LNT when it is explored, as the
 *       statement defines it (p.5). A child whose state is already explored is pruned,
 *       and so is a node taken from the open list whose state was explored meanwhile.</li>
 *   <li>Without LNT: the current branch is checked by walking up the parents.</li>
 *   <li>Time limit of 120 s (statement p.4): past it the search stops with no solution.</li>
 * </ul>
 * Theorem numbers refer to documentacio/model_formal.md.
 */
public abstract class CercaBase extends Cerca {

    /** Statement p.4: a search that takes longer than 120 s does not finish. */
    public static final long LIMIT_TEMPS_MS = 120_000L;

    private long termini;

    protected CercaBase(boolean usarLNT) {
        super(usarLNT);
    }

    /**
     * Template method: starts the clock, runs the search and reports the solution.
     * On timeout the solution stays null.
     * OutOfMemoryError is not caught: the caller reports it as the failure reason.
     */
    @Override
    public final void ferCerca(Mapa inicial, ResultatCerca rc) {
        termini = System.currentTimeMillis() + LIMIT_TEMPS_MS;
        try {
            Node meta = cerca(new Node(inicial, null, null, 0, 0), rc);
            if (meta != null) rc.setSolucio(reconstruirCami(meta));
        } catch (TempsEsgotat e) {
            // over the limit: the search counts as not finishing
        }
    }

    /**
     * The search. By default one run of the general loop; IDS overrides it
     * to repeat the loop with growing limits.
     * @return the goal node, or null if there is no solution
     */
    protected Node cerca(Node arrel, ResultatCerca rc) {
        return cercaGeneral(arrel, rc);
    }

    // ------------------------------------------------------------------
    // Hooks for the subclasses
    // ------------------------------------------------------------------

    /** The open list (LNO): its order is what makes the algorithm. */
    protected abstract Queue<Node> nousOberts();

    /** Whether a node may be expanded. Default: always (DFS overrides it with the depth limit). */
    protected boolean expandible(Node n) {
        return true;
    }

    /**
     * Whether a generated node enters the open list. Default: always.
     * A* overrides it to prune the states with h = INF.
     */
    protected boolean accepta(Node n, ResultatCerca rc) {
        return true;
    }

    // ------------------------------------------------------------------
    // The only search loop
    // ------------------------------------------------------------------

    /**
     * General graph search. Each call starts with an empty LNO and LNT.
     * The counters in rc are never reset, so repeated calls (IDS) accumulate them.
     * @return the goal node, or null if the open list runs out
     */
    protected final Node cercaGeneral(Node arrel, ResultatCerca rc) {
        Queue<Node> oberts = nousOberts();
        Set<Mapa> tancats = usarLNT ? new HashSet<>() : null;
        if (accepta(arrel, rc)) oberts.add(arrel);

        while (!oberts.isEmpty()) {
            Node n = oberts.poll();
            if (tancats != null && !tancats.add(n.estat)) {
                rc.incNodesTallats(); // its state was explored through another node
                continue;
            }
            explora(n, rc);
            if (n.estat.esFinalPartida()) return n;
            if (expandible(n)) {
                for (Node fill : successors(n, tancats, rc)) {
                    if (accepta(fill, rc)) oberts.add(fill);
                }
            }
            rc.updateMemoria(oberts.size(), tancats == null ? 0 : tancats.size());
        }
        return null;
    }

    // ------------------------------------------------------------------
    // Private helpers
    // ------------------------------------------------------------------

    /** Once per explored node: checks the time limit and updates the counters. */
    private void explora(Node n, ResultatCerca rc) {
        if (System.currentTimeMillis() > termini || Thread.currentThread().isInterrupted()) {
            throw new TempsEsgotat();
        }
        rc.incNodesExplorats();
        rc.actualitzaProfunditat(n.depth);
    }

    /**
     * Children of n, without the repeated ones. Each repeated child counts as pruned.
     * Every move costs 1, so g = depth.
     */
    private List<Node> successors(Node n, Set<Mapa> tancats, ResultatCerca rc) {
        List<Node> fills = new ArrayList<>();
        for (Moviment m : n.estat.getAccionsPossibles()) {
            Mapa estat = (Mapa) n.estat.mou(m);
            Node fill = new Node(estat, n, m, n.depth + 1, n.g + 1);
            boolean repetit = (tancats != null) ? tancats.contains(estat) : repetitEnBranca(fill);
            if (repetit) {
                rc.incNodesTallats();
            } else {
                fills.add(fill);
            }
        }
        return fills;
    }

    /**
     * Cycle check inside the current branch (usarLNT = false), as the statement asks.
     * By Theorem 2 it never succeeds: Phi grows by 1 per move, so no state
     * repeats on a branch. The pruned counter then shows 0 (study [2]).
     */
    private static boolean repetitEnBranca(Node fill) {
        for (Node a = fill.pare; a != null; a = a.pare) {
            if (a.estat.equals(fill.estat)) return true;
        }
        return false;
    }

    /** Moves from the start to the goal, following the parent links back. */
    private static List<Moviment> reconstruirCami(Node meta) {
        List<Moviment> cami = new ArrayList<>(meta.depth);
        for (Node n = meta; n.pare != null; n = n.pare) cami.add(n.accio);
        Collections.reverse(cami);
        return cami;
    }

    /** Ends the search on timeout. No stack trace, so throwing it is cheap. */
    private static final class TempsEsgotat extends RuntimeException {
        private static final long serialVersionUID = 1L;

        TempsEsgotat() { super(null, null, false, false); }
    }
}
