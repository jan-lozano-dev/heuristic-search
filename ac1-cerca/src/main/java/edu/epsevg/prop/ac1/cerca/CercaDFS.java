package edu.epsevg.prop.ac1.cerca;

import edu.epsevg.prop.ac1.resultat.ResultatCerca;

import java.util.ArrayDeque;
import java.util.Collections;
import java.util.Queue;

/**
 * Depth-first search: the general loop of {@link CercaBase} with a LIFO open list
 * and a depth limit. Also provides the depth-limited search that {@link CercaIDS} repeats.
 */
public class CercaDFS extends CercaBase {
    /** Statement p.5: nodes deeper than 50 are not expanded. */
    private static final int LIMIT_PER_DEFECTE = 50;

    private int limit;
    private boolean tallatPerLimit;

    public CercaDFS(boolean usarLNT) {
        super(usarLNT);
    }

    @Override
    protected Node cerca(Node arrel, ResultatCerca rc) {
        return cercaLimitada(arrel, LIMIT_PER_DEFECTE, rc);
    }

    @Override
    protected Queue<Node> nousOberts() {
        return Collections.asLifoQueue(new ArrayDeque<>());
    }

    /**
     * Read literally from the statement: a node deeper than the limit is not expanded,
     * a node at depth == limit still is. Its children (depth limit + 1) are only goal-tested.
     */
    @Override
    protected boolean expandible(Node n) {
        if (n.depth <= limit) return true;
        tallatPerLimit = true;
        return false;
    }

    /**
     * One run of the general loop with the given depth limit.
     * With LNT it stays complete up to the limit: every copy of a state has the same
     * depth (Corollary 1), so a state explored once never needs exploring again.
     */
    protected final Node cercaLimitada(Node arrel, int limit, ResultatCerca rc) {
        this.limit = limit;
        this.tallatPerLimit = false;
        return cercaGeneral(arrel, rc);
    }

    /** @return true if the last limited run left some node unexpanded because of the limit */
    protected final boolean tallatPerLimit() {
        return tallatPerLimit;
    }

    /**
     * Torna el nom de la cerca.
     * @return el nom de la cerca.
     */
    @Override
    public String getNomCerca() {
        return "DFS";
    }
}
