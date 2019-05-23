(define (domain eje1-domain)	       ; Comment: adding location caused fail
  (:requirements :strips :equality :typing)
  (:types  
            personaje objeto jugador - locatable
            personaje jugador - cogedor
            princesa principe bruja profesor leo - personaje
            oscar manzanas rosas algoritmos oro zapatillas bikini zapatillas bikini - objeto
            tiposSuelo zona puntoCardinal)
 
  (:predicates 
            (zonaVecina ?z - zona ?vecino - zona ?puntoCar - puntoCardinal)
            (orientacionJug ?j - jugador ?orienta - puntoCardinal)
            (enZona ?obj - locatable ?zone - zona)
            (tieneObjeto ?obj - objeto ?prs - personaje)
            (manoOcupada  ?j - jugador)
            (tieneObjetoJ ?obj - objeto ?j - jugador)
            (mochilaOcupada  ?j - jugador)
            (enMochila ?obj - objeto  ?j - jugador)
            (enMano ?obj - objeto ?j - jugador)
            (tipozona ?tipe - tiposSuelo ?z - zona)

    )
  (:functions
(distancia ?x ?y - zona)
(distanciaTotal)
)         
  (:action GIROr-JUGADOR
        :parameters (?j - jugador ?z - zona ?o - puntoCardinal)
        :precondition (and (enZona ?j  ?z)(orientacionJug ?j ?o))
        :effect(and  
        (not(orientacionJug ?j ?o))
        (when (= ?o N)
        (orientacionJug ?j E)
        )
        (when (= ?o S)
        (orientacionJug ?j O)
        )
        (when (= ?o E)
        (orientacionJug ?j S)
        )
        (when (= ?o O)
        (orientacionJug ?j N)
        )    
        )
    )

    (:action GIROl-JUGADOR
        :parameters (?j - jugador ?z - zona ?o - puntoCardinal)
        :precondition (and (enZona ?j  ?z)(orientacionJug ?j ?o))
        :effect(and  
        (not(orientacionJug ?j ?o))
        (when (= ?o N)
        (orientacionJug ?j O)
        )
        (when (= ?o S)
        (orientacionJug ?j E)
        )
        (when (= ?o E)
        (orientacionJug ?j N)
        )
        (when (= ?o O)
        (orientacionJug ?j S)
        )    
        )
    )
    (:action IR-ZONA-SIN-OBJ
        :parameters (?j - jugador ?z - zona ?z2 - zona ?o - puntoCardinal ?t - tiposSuelo)
        :precondition (and (enZona ?j  ?z) (orientacionJug ?j ?o)(tipozona ?t ?z2 )(zonaVecina ?z ?z2 ?o))
        
        :effect(and
            (when (or (= ?t Piedra)(= ?t Arena))
                (and
                    (increase (distanciaTotal) (distancia ?z ?z2))
                    (not(enZona ?j ?z))
                    (enZona ?j ?z2)
                )
            )

        )
    )
    (:action IR-ZONA-OBJ-MOCHN-zapatillas
        :parameters (?j - jugador ?z - zona ?z2 - zona ?o - puntoCardinal ?t - tiposSuelo ?obj - zapatillas)
        :precondition (and (enZona ?j  ?z) (orientacionJug ?j ?o)(tipozona ?t ?z2 )(tieneObjetoJ ?obj  ?j )(zonaVecina ?z ?z2 ?o))
        
        :effect(and
        
            (when (or (= ?t Piedra)(= ?t Arena)(= ?t Bosque))
                (and
                    (increase (distanciaTotal) (distancia ?z ?z2))
                    (not(enZona ?j ?z))
                    (enZona ?j ?z2)
                )
            )
        )
    )
    (:action IR-ZONA-OBJ-MOCHN-bikini
        :parameters (?j - jugador ?z - zona ?z2 - zona ?o - puntoCardinal ?t - tiposSuelo ?obj - bikini)
        :precondition (and (enZona ?j  ?z) (orientacionJug ?j ?o)(tipozona ?t ?z2 )(tieneObjetoJ ?obj  ?j )(zonaVecina ?z ?z2 ?o))
        
        :effect(and
        
            (when (or (= ?t Piedra)(= ?t Arena)(= ?t Agua))
                (and
                    (increase (distanciaTotal) (distancia ?z ?z2))
                    (not(enZona ?j ?z))
                    (enZona ?j ?z2)
                )
            )
        )
    )

    (:action COGER-OBJETO
        :parameters (?j - jugador ?z - zona ?o - objeto)
        :precondition (and (enZona ?j  ?z)(enZona ?o ?z) (not(manoOcupada  ?j)))
        :effect(and 
        (not(enZona ?o ?z))
        (enMano ?o ?j)
        (manoOcupada ?j)
        (tieneObjetoJ ?o  ?j )

        )
    )

    (:action DEJAR-OBJETO
        :parameters (?j - jugador ?z - zona ?o - objeto)
        :precondition (and (enZona ?j  ?z) (manoOcupada ?j)(enMano ?o ?j))
        :effect(and 
        (not(enMano ?o ?j))
        (enZona ?o ?z)
        (not(manoOcupada ?j))
        (not(tieneObjetoJ ?o  ?j ))
        )
    )
    (:action GUARDAR-OBJETO
        :parameters (?j - jugador  ?o - objeto)
        :precondition (and (not(mochilaOcupada ?j))(manoOcupada  ?j) (enMano ?o ?j))
        :effect(and 
        (not (enMano ?o ?j))
        (not (manoOcupada ?j))
        (mochilaOcupada ?j)
        (enMochila ?o ?j)
        )
    )

    (:action SACAR-OBJETO
        :parameters (?j - jugador  ?o - objeto)
        :precondition (and (not(manoOcupada ?j))(mochilaOcupada  ?j) (enMochila ?o ?j))
        :effect(and 
        (not (enMochila ?o ?j))
        (not (mochilaOcupada ?j))
        (manoOcupada ?j)
        (enMano ?o ?j)
        )
    )
    (:action ENTREGAR-OBJETO
        :parameters (?j - jugador ?z - zona ?o - objeto ?p - personaje)
        :precondition (and (enZona ?p  ?z)(enZona ?j  ?z)(enMano ?o ?j))
        :effect(and 
        (not(enMano ?o ?j))
        (not(tieneObjetoJ ?o  ?j ))
        (tieneObjeto ?o ?p)
        (not(manoOcupada ?j))

        )
    )
)