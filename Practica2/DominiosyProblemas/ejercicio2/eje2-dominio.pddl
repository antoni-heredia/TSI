(define (domain eje1-domain)	       ; Comment: adding location caused fail
  (:requirements :strips :equality :typing)
  (:types  
            personaje objeto jugador - locatable
            personaje jugador - cogedor
            princesa principe bruja profesor leo - personaje
            oscar manzanas rosas algoritmos oro - objeto
            zona puntoCardinal)
 
  (:predicates 
	       (zonaVecina ?zona - zona ?vecino - zona ?puntoCar - puntoCardinal)
	       (orientacionJug ?j - jugador ?orienta - puntoCardinal)
           (enZona ?obj - locatable ?zone - zona)
           (tieneObjeto ?obj - objeto ?j - cogedor)
            (tienenUnObjeto ?j - jugador)

	       )
  (:functions
(distancia ?x ?y - zona)
(distanciaTotal))         
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
    (:action IR-ZONA
        :parameters (?j - jugador ?z - zona ?z2 - zona ?o - puntoCardinal)
        :precondition (and (enZona ?j  ?z) (orientacionJug ?j ?o)(zonaVecina ?z ?z2 ?o))
        :effect(and
        (increase (distanciaTotal) (distancia ?z ?z2))
        (not(enZona ?j ?z))
        (enZona ?j ?z2)
        )
    )
    (:action COGER-OBJETO
        :parameters (?j - jugador ?z - zona ?o - objeto)
        :precondition (and (enZona ?j  ?z)(enZona ?o ?z) (not(tienenUnObjeto ?j)))
        :effect(and 
        (not(enZona ?o ?z))
        (tieneObjeto ?o ?j)
        (tienenUnObjeto ?j)
        )
    )

    (:action DEJAR-OBJETO
        :parameters (?j - jugador ?z - zona ?o - objeto)
        :precondition (and (enZona ?j  ?z)(tieneObjeto ?o ?j))
        :effect(and 
        (not(tieneObjeto ?o ?j))
        (enZona ?o ?z)
        (not(tienenUnObjeto ?j))
        )
    )
    (:action ENTREGAR-OBJETO
        :parameters (?j - jugador ?z - zona ?o - objeto ?p - personaje)
        :precondition (and (enZona ?p  ?z)(enZona ?j  ?z)(tieneObjeto ?o ?j))
        :effect(and 
        (not(tieneObjeto ?o ?j))
        (tieneObjeto ?o ?p)
        (not(tienenUnObjeto ?j))
        )
    )
)