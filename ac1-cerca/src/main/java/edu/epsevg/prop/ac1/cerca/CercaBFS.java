package edu.epsevg.prop.ac1.cerca;

import java.util.ArrayDeque;
import java.util.Queue;

/**
 * Breadth-first search: the general loop of {@link CercaBase} with a FIFO open list.
 * Nodes are explored in order of depth and every move costs 1, so the first goal
 * explored has minimum length (optimal).
 */
public class CercaBFS extends CercaBase {

    public CercaBFS(boolean usarLNT) {
        super(usarLNT);
    }

    @Override
    protected Queue<Node> nousOberts() {
        return new ArrayDeque<>();
    }

    /**
     * Torna el nom de la cerca.
     * @return el nom de la cerca.
     */
    @Override
    public String getNomCerca() {
        return "BFS";
    }
}
