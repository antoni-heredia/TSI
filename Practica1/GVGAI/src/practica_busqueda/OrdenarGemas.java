package practica_busqueda;

import javax.xml.stream.Location;
import java.util.Comparator;


public class OrdenarGemas implements Comparator
{
    PlayerObservation origin;
    OrdenarGemas(PlayerObservation origin){
        this.origin= origin;
    }

    @Override
    public int compare(Object o1, Object o2) {
        return Float.compare(origin.getManhattanDistance((Observation) o1), origin.getManhattanDistance((Observation) o2));

    }
}