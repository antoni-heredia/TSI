package practica_busqueda;

import core.game.StateObservation;
import core.player.AbstractPlayer;
import ontology.Types;
import tools.ElapsedCpuTimer;
import tools.Vector2d;
import tools.pathfinder.Node;
import tools.pathfinder.PathFinder;

import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Random;

public class Agent extends BaseAgent {
    private ArrayList<Types.ACTIONS> lista_acciones; // Conjunto de acciones posibles
    private Random generador;
    boolean hayPLan;
    Nodo plan;
    ArrayList<Observation> gemas;
    ArrayList<Types.ACTIONS> escaparPiedra;

    public Agent(StateObservation so, ElapsedCpuTimer elapsedTimer) {
        super(so, elapsedTimer);
        hayPLan = false;
        plan = null;
        escaparPiedra = new ArrayList<Types.ACTIONS>();
        gemas = new ArrayList<Observation>();
    }

    @Override
    public Types.ACTIONS act(StateObservation stateObs, ElapsedCpuTimer elapsedTimer) {
        PlayerObservation jugador_antiguo = getPlayer(stateObs);
        Types.ACTIONS accion = Types.ACTIONS.ACTION_NIL;
        if (getRemainingGems(stateObs) > 0) {
            if (gemas.isEmpty()) {
                gemas = getGemsList(stateObs);
            } else {
                Collections.sort(gemas, new OrdenarGemas(jugador_antiguo));
                if (!hayPLan) {
                    plan = getPlan(gemas.get(0), jugador_antiguo, stateObs);

                    gemas.remove(0);
                    if (plan != null) {
                        hayPLan = true;
                        plan = reverse(plan);
                        plan = plan.getPadre();
                    } else {
                        hayPLan = false;
                    }
                }
                if (plan != null) {

                    //para comprobar la accion que va a realizar el jugador
                    accion = movimientoNeceario(plan, jugador_antiguo);
                    StateObservation estado_actual = stateObs.copy();
                    estado_actual.advance(accion); // Ejecuto una acción y avanzo la simulación en un paso
                    PlayerObservation jugador = getPlayer(estado_actual);
                    ArrayList<Observation>[][] mundoActual = getObservationGrid(estado_actual);


                    //Si el jugador se encuentra dos posiciones debajo de una piera y el siguiente movimiento lo va a realizar justo debajo de la piedra,
                    // para hacer que caiga
                    if (mundoActual[plan.getPosicion().getX()][plan.getPosicion().getY()].get(0).getType() == ObservationType.BOULDER) {
                        hayPLan = false;
                        gemas.clear();
                        escaparPiedra.clear();
                    }

                    if (jugador.hasDied()) {
                        hayPLan = false;
                        gemas.clear();
                        if (plan.getPosicion().getX() == jugador_antiguo.getX())
                            if (plan.getPosicion().getY() > jugador_antiguo.getY()) {
                                escaparPiedra.add(Types.ACTIONS.ACTION_UP);
                                escaparPiedra.add(Types.ACTIONS.ACTION_UP);

                            } else {
                                escaparPiedra.add(Types.ACTIONS.ACTION_DOWN);
                                escaparPiedra.add(Types.ACTIONS.ACTION_DOWN);

                            }
                        else if (plan.getPosicion().getX() > jugador_antiguo.getX()) {
                            escaparPiedra.add(Types.ACTIONS.ACTION_LEFT);
                            escaparPiedra.add(Types.ACTIONS.ACTION_LEFT);
                        } else {
                            escaparPiedra.add(Types.ACTIONS.ACTION_RIGHT);
                            escaparPiedra.add(Types.ACTIONS.ACTION_RIGHT);
                        }
                    }

                    if (mundoActual[plan.getPosicion().getX()][plan.getPosicion().getY() - 1].get(0).getType() == ObservationType.BOULDER & escaparPiedra.isEmpty() &
                            jugador_antiguo.getX() == plan.getPosicion().getX()) {
                        if (jugador_antiguo.getOrientation() != Orientation.N)
                            escaparPiedra.add(Types.ACTIONS.ACTION_UP);
                        if (plan.getPosicion().getType() == ObservationType.GEM)
                            escaparPiedra.add(Types.ACTIONS.ACTION_UP);
                        else {
                            escaparPiedra.add(Types.ACTIONS.ACTION_USE);
                            escaparPiedra.add(Types.ACTIONS.ACTION_LEFT);
                        }
                        escaparPiedra.add(Types.ACTIONS.ACTION_LEFT);
                    }

                    //se ha movido y por lo tanto a avanzado
                    if (jugador.getX() != jugador_antiguo.getX() | jugador.getY() != jugador_antiguo.getY())
                        plan = plan.getPadre();


                    if (plan == null) {
                        hayPLan = false;
                        gemas.clear();

                    }
                }

            }
        } else {
            if(!hayPLan){
                escaparPiedra.clear();
                Observation salida = getExit(stateObs); // La salida no cambia de posición
                plan = getPlan(salida, jugador_antiguo, stateObs);
                plan = reverse(plan);
                hayPLan = true;
                plan = plan.getPadre();
            }

            if (plan != null) {
                accion = movimientoNeceario(plan, jugador_antiguo);
                StateObservation estado_actual = stateObs.copy();
                estado_actual.advance(accion); // Ejecuto una acción y avanzo la simulación en un paso
                PlayerObservation jugador = getPlayer(estado_actual);
                ArrayList<Observation>[][] mundoActual = getObservationGrid(estado_actual);





                if (mundoActual[plan.getPosicion().getX()][plan.getPosicion().getY()].get(0).getType() == ObservationType.BOULDER) {
                    hayPLan = false;
                }

                if (jugador.hasDied() & mundoActual[plan.getPosicion().getX()][plan.getPosicion().getY()].get(0).getType() != ObservationType.PLAYER) {
                    hayPLan = false;
                    if (plan.getPosicion().getX() == jugador_antiguo.getX())
                        if (plan.getPosicion().getY() > jugador_antiguo.getY()) {
                            escaparPiedra.add(Types.ACTIONS.ACTION_UP);
                            escaparPiedra.add(Types.ACTIONS.ACTION_UP);

                        } else {
                            escaparPiedra.add(Types.ACTIONS.ACTION_DOWN);
                            escaparPiedra.add(Types.ACTIONS.ACTION_DOWN);

                        }
                    else if (plan.getPosicion().getX() > jugador_antiguo.getX()) {
                        escaparPiedra.add(Types.ACTIONS.ACTION_LEFT);
                        escaparPiedra.add(Types.ACTIONS.ACTION_LEFT);
                    } else {
                        escaparPiedra.add(Types.ACTIONS.ACTION_RIGHT);
                        escaparPiedra.add(Types.ACTIONS.ACTION_RIGHT);
                    }
                }
                //se ha movido y por lo tanto a avanzado
                if (jugador.getX() != jugador_antiguo.getX() | jugador.getY() != jugador_antiguo.getY() & hayPLan)
                    plan = plan.getPadre();
            } else {
                hayPLan = false;
            }
        }
        //System.out.println("Quedan  " +elapsedTimer.remainingTimeMillis()+" segundo");
        if (escaparPiedra.isEmpty()) {
            return accion;
        }
        else {
            Types.ACTIONS accionAc = escaparPiedra.get(0);
            escaparPiedra.remove(0);
            if (escaparPiedra.isEmpty()) {
                hayPLan = false;
                plan = null;
                gemas.clear();
            }
            return accionAc;
        }

    }

    private Types.ACTIONS movimientoNeceario(Nodo objetivo, PlayerObservation jugador) {
        Orientation orientation = jugador.getOrientation();
        Types.ACTIONS accion = Types.ACTIONS.ACTION_NIL;

        if (objetivo.getX() == jugador.getX()) {
            if (jugador.getY() > objetivo.getY())
                accion = Types.ACTIONS.ACTION_UP;
            if (jugador.getY() < objetivo.getY())
                accion = Types.ACTIONS.ACTION_DOWN;
        }
        if (objetivo.getY() == jugador.getY()) {
            if (jugador.getX() < objetivo.getX())
                accion = Types.ACTIONS.ACTION_RIGHT;
            if (jugador.getX() > objetivo.getX())
                accion = Types.ACTIONS.ACTION_LEFT;
        }

        return accion;
    }

    private Nodo reverse(Nodo plan) {
        Nodo nuevaLista = null;
        Nodo aux = plan;
        Nodo anterior = new Nodo();

        //recorro mientras haya padres
        while (plan.getPadre() != null) { //2,4,5,7
            aux = plan;
            while (aux.getPadre() != null) {
                anterior = aux;
                aux = aux.getPadre();
            }

            if (nuevaLista == null)
                nuevaLista = aux;
            else
                nuevaLista.aniadir(aux);

            anterior.setPadre(null);
        }
        nuevaLista.aniadir(plan);

        return nuevaLista;
    }


    private Nodo getPlan(Observation gema, PlayerObservation jugador, StateObservation stateObs) {
        //obtengo todas las casillas
        ArrayList<Observation>[][] mundoActual = getObservationGrid(stateObs);
        //listas de nodos abiertos y cerrados
        ArrayList<Nodo> abiertos = new ArrayList<Nodo>();
        ArrayList<Nodo> cerrados = new ArrayList<Nodo>();

        //meto el origen como nodo inicial
        Observation posJug = new Observation(jugador.getX(), jugador.getY(), ObservationType.PLAYER);
        Nodo destino = new Nodo(gema);
        Nodo nJugador = new Nodo(posJug);
        abiertos.add(nJugador);
        Nodo actual = null;
        do {
            actual = nodoConMenorF(abiertos);
            abiertos.remove(actual);
            cerrados.add(actual);
            if (actual.equals(destino))
                return actual;
            else {
                ArrayList<Nodo> adyacentes = getAdyacentes(actual, mundoActual);
                for (Nodo adyacente : adyacentes) {
                    if (!abiertos.contains(adyacente) & !cerrados.contains(adyacente)) {
                        setEcuacion(actual, adyacente);
                        adyacente.setPadre(actual);
                        abiertos.add(adyacente);
                    } else {
                        if (adyacente.getG() < actual.getG()) {
                            setEcuacion(actual, adyacente);
                            adyacente.setPadre(actual);
                        }
                    }
                }
            }
        } while (abiertos.size() != 0);

        return null;
    }

    private void setEcuacion(Nodo actual, Nodo adyacente) {
        float distancia_H = actual.getPosicion().getEuclideanDistance(adyacente.getPosicion());
        int distancia_G = actual.getPosicion().getManhattanDistance(adyacente.getPosicion());
        adyacente.setG(actual.getG() + distancia_G);
        adyacente.setH(actual.getG() + distancia_H);
        adyacente.setF(actual.getG() + actual.getH());
    }

    private Nodo nodoConMenorF(ArrayList<Nodo> nodos) {
        Nodo resultado = nodos.get(0);

        if (nodos.size() > 1)
            for (Nodo nodo : nodos) {
                if (nodo.getF() < resultado.getF())
                    resultado = nodo;
            }
        return resultado;
    }


    private ArrayList<Nodo> getAdyacentes(Nodo nodo, ArrayList<Observation>[][] mundoActual) {
        ArrayList<Nodo> adyacentes = new ArrayList<Nodo>();
        if (mundoActual[nodo.getX() + 1][nodo.getY()].get(0).getType() != ObservationType.WALL &
                mundoActual[nodo.getX() + 1][nodo.getY()].get(0).getType() != ObservationType.SCORPION &
                mundoActual[nodo.getX() + 1][nodo.getY()].get(0).getType() != ObservationType.BOULDER &
                mundoActual[nodo.getX() + 1][nodo.getY()].get(0).getType() != ObservationType.BAT)
            adyacentes.add(new Nodo(mundoActual[nodo.getX() + 1][nodo.getY()].get(0)));
        if (mundoActual[nodo.getX() - 1][nodo.getY()].get(0).getType() != ObservationType.WALL &
                mundoActual[nodo.getX() - 1][nodo.getY()].get(0).getType() != ObservationType.SCORPION &
                mundoActual[nodo.getX() - 1][nodo.getY()].get(0).getType() != ObservationType.BOULDER &
                mundoActual[nodo.getX() - 1][nodo.getY()].get(0).getType() != ObservationType.BAT)
            adyacentes.add(new Nodo(mundoActual[nodo.getX() - 1][nodo.getY()].get(0)));
        if (mundoActual[nodo.getX()][nodo.getY() + 1].get(0).getType() != ObservationType.WALL &
                mundoActual[nodo.getX()][nodo.getY() + 1].get(0).getType() != ObservationType.SCORPION &
                mundoActual[nodo.getX()][nodo.getY() + 1].get(0).getType() != ObservationType.BOULDER &
                mundoActual[nodo.getX()][nodo.getY() + 1].get(0).getType() != ObservationType.BAT)
            adyacentes.add(new Nodo(mundoActual[nodo.getX()][nodo.getY() + 1].get(0)));
        if (mundoActual[nodo.getX()][nodo.getY() - 1].get(0).getType() != ObservationType.WALL &
                mundoActual[nodo.getX()][nodo.getY() - 1].get(0).getType() != ObservationType.SCORPION &
                mundoActual[nodo.getX()][nodo.getY() - 1].get(0).getType() != ObservationType.BOULDER &
                mundoActual[nodo.getX()][nodo.getY() - 1].get(0).getType() != ObservationType.BAT)
            adyacentes.add(new Nodo(mundoActual[nodo.getX()][nodo.getY() - 1].get(0)));
        return adyacentes;
    }
}
