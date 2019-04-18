package practica_busqueda;

public class  Nodo {
    private Observation posicion;
    private Nodo padre;
    private float H;
    private int G;
    private float F;
    public Nodo(Observation nodo){
        posicion = nodo;
        padre = null;
        H = 0;
        G = 0;
        F = 0;
    }

    public int getX(){
        return posicion.getX();
    }

    public int getY(){
        return posicion.getY();
    }

    public Observation getPosicion() {
        return posicion;
    }

    public void setPosicion(Observation posicion) {
        this.posicion = posicion;
    }

    public Nodo getPadre() {
        return padre;
    }

    public void setPadre(Nodo padre) {
        this.padre = padre;
    }

    public float getH() {
        return H;
    }

    public void setH(float h) {
        H = h;
    }

    public int getG() {
        return G;
    }

    public void setG(int g) {
        G = g;
    }

    public float getF() {
        return F;
    }

    public void setF(float f) {
        F = f;
    }

    @Override
    public boolean equals(Object obj) {
        if(obj instanceof Nodo)
            return posicion.equals(((Nodo) obj).getPosicion());
        return false;
    }
}