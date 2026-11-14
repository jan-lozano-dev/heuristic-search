package edu.epsevg.prop.ac1.cerca;

import edu.epsevg.prop.ac1.resultat.ResultatCerca;

/**
 * Iterative deepening: the depth-limited search of {@link CercaDFS} with limit 0, 1, 2, ...
 * <ul>
 *   <li>The counters in rc are never reset, so explored nodes accumulate over the
 *       iterations, as the statement asks (p.7). Each iteration starts a new LNT.</li>
 *   <li>Optimal: iteration L tests every state of depth &lt;= L + 1. If d is the minimum
 *       solution length, iterations before d - 1 find nothing, and iteration d - 1 can
 *       only find a goal of depth d.</li>
 *   <li>Stops with no solution when an iteration was never cut by the limit: the whole
 *       state space (finite, Theorem 2) has been explored.</li>
 * </ul>
 */
public class CercaIDS extends CercaDFS {

    public CercaIDS(boolean usarLNT) {
        super(usarLNT);
    }

    @Override
    protected Node cerca(Node arrel, ResultatCerca rc) {
        for (int limit = 0; ; limit++) {
            Node meta = cercaLimitada(arrel, limit, rc);
            if (meta != null || !tallatPerLimit()) return meta;
        }
    }

    /**
     * Torna el nom de la cerca.
     * @return el nom de la cerca.
     */
    @Override
    public String getNomCerca() {
        return "IDS";
    }
}
