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
import java.util.Random;

public class Agent extends BaseAgent {
    private ArrayList<Types.ACTIONS> lista_acciones; // Conjunto de acciones posibles
    private Random generador;
    Observation gemaCercana;
    boolean hayPLan;
    Nodo plan;

    public Agent(StateObservation so, ElapsedCpuTimer elapsedTimer){
        super(so, elapsedTimer);
        gemaCercana = null;
        hayPLan = false;
        plan = null;
    }

    @Override
    public Types.ACTIONS act(StateObservation stateObs, ElapsedCpuTimer elapsedTimer){
        ArrayList<Observation> gemas;
        PlayerObservation jugador_antiguo = getPlayer(stateObs);

        if (getRemainingGems(stateObs) > 0){
            gemas = getGemsList(stateObs);
            if(gemaCercana == null)
                gemaCercana = getGemaCercana(gemas,jugador_antiguo);
            else{

                if(!hayPLan){
                    plan = getPlan(gemaCercana,jugador_antiguo,stateObs);
                    hayPLan = true;
                }

                if(plan.getPadre() != null){
                    System.out.println(plan.getPosicion().toString());
                    plan = plan.getPadre();
                }

            }

        }
        return Types.ACTIONS.ACTION_NIL;
    }
    private  Observation getGemaCercana( ArrayList<Observation> gemas, PlayerObservation jugador ){
        //obtengo la distancia de la primera gema
        int distanciaMinima = jugador.getManhattanDistance(gemas.get(0));;
        Observation gemaCercana = gemas.get(0);
        //elimino para no iterar sobre ella
        gemas.remove(0);
        //las recorro buscando la mas cercana
        for (Observation gema_actual : gemas){
            int distanciaActual = jugador.getManhattanDistance(gema_actual);
            if( distanciaActual < distanciaMinima){
                gemaCercana = gema_actual;
                distanciaMinima = distanciaActual;
            }
        }
        return gemaCercana;
    }
    private Nodo getPlan( Observation gema, PlayerObservation jugador, StateObservation stateObs ) {
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
            if(actual.equals(destino))
                return actual;
            else {
                ArrayList<Nodo> adyacentes = getAdyacentes(actual, mundoActual);
                for (Nodo adyacente : adyacentes) {
                    if (!abiertos.contains(adyacente) & !cerrados.contains(adyacente)) {
                        setEcuacion(actual,adyacente);
                        adyacente.setPadre(actual);
                        abiertos.add(adyacente);
                    }else{
                        if(adyacente.getG()<actual.getG()){
                            setEcuacion(actual,adyacente);
                            adyacente.setPadre(actual);
                        }
                    }
                }
            }
        } while (abiertos.size() != 0);

        return null;
    }

    private void setEcuacion(Nodo actual, Nodo adyacente){
        float distancia_H = actual.getPosicion().getEuclideanDistance(adyacente.getPosicion());
        int distancia_G = actual.getPosicion().getManhattanDistance(adyacente.getPosicion());
        adyacente.setG(actual.getG()+distancia_G);
        adyacente.setH(actual.getG()+distancia_H);
        adyacente.setF(actual.getG()+actual.getH());
    }
    private Nodo nodoConMenorF(ArrayList<Nodo> nodos){
        Nodo resultado = nodos.get(0);

        if(nodos.size()>1)
            for  (Nodo nodo : nodos) {
                if(nodo.getF()< resultado.getF())
                    resultado = nodo;
            }
        return resultado;
    }
    private ArrayList<Nodo> getAdyacentes(Nodo nodo,  ArrayList<Observation>[][] mundoActual){
        ArrayList<Nodo> adyacentes = new ArrayList<Nodo>();
        if(mundoActual[nodo.getX()+1][nodo.getY()].get(0).getType() != ObservationType.WALL &
            mundoActual[nodo.getX()+1][nodo.getY()].get(0).getType() != ObservationType.SCORPION &
            mundoActual[nodo.getX()+1][nodo.getY()].get(0).getType() != ObservationType.BOULDER &
            mundoActual[nodo.getX()+1][nodo.getY()].get(0).getType() != ObservationType.BAT)
            adyacentes.add(new Nodo(mundoActual[nodo.getX()+1][nodo.getY()].get(0)));
        if(mundoActual[nodo.getX()-1][nodo.getY()].get(0).getType() != ObservationType.WALL &
                mundoActual[nodo.getX()-1][nodo.getY()].get(0).getType() != ObservationType.SCORPION &
                mundoActual[nodo.getX()-1][nodo.getY()].get(0).getType() != ObservationType.BOULDER &
                mundoActual[nodo.getX()-1][nodo.getY()].get(0).getType() != ObservationType.BAT)
            adyacentes.add(new Nodo(mundoActual[nodo.getX()-1][nodo.getY()].get(0)));
        if(mundoActual[nodo.getX()][nodo.getY()+1].get(0).getType() != ObservationType.WALL &
                mundoActual[nodo.getX()][nodo.getY()+1].get(0).getType() != ObservationType.SCORPION &
                mundoActual[nodo.getX()][nodo.getY()+1].get(0).getType() != ObservationType.BOULDER &
                mundoActual[nodo.getX()][nodo.getY()+1].get(0).getType() != ObservationType.BAT)
            adyacentes.add(new Nodo(mundoActual[nodo.getX()][nodo.getY()+1].get(0)));
        if(mundoActual[nodo.getX()][nodo.getY()-1].get(0).getType() != ObservationType.WALL &
                mundoActual[nodo.getX()][nodo.getY()-1].get(0).getType() != ObservationType.SCORPION &
                mundoActual[nodo.getX()][nodo.getY()-1].get(0).getType() != ObservationType.BOULDER &
                mundoActual[nodo.getX()][nodo.getY()-1].get(0).getType() != ObservationType.BAT)
            adyacentes.add(new Nodo(mundoActual[nodo.getX()][nodo.getY()-1].get(0)));
        return adyacentes;
    }
}
