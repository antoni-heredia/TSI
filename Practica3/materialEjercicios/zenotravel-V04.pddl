(define (domain zeno-travel)


(:requirements
  :typing
  :fluents
  :derived-predicates
  :negative-preconditions
  :universal-preconditions
  :disjuntive-preconditions
  :conditional-effects
  :htn-expansion

  ; Requisitos adicionales para el manejo del tiempo
  :durative-actions
  :metatags
 )

(:types aircraft person city - object)
(:constants slow fast - object)
(:predicates (at ?x - (either person aircraft) ?c - city)
             (in ?p - person ?a - aircraft)
             (different ?x ?y) (igual ?x ?y)
             (hay-fuel-rapido ?a ?c1 ?c2)
            (hay-fuel-lento ?a ?c1 ?c2)

             )
(:functions (fuel ?a - aircraft)
            (distance ?c1 - city ?c2 - city)
            (fuel-limit ?a - aircraft) 
            (fuel-used ?a - aircraft) 

            (slow-speed ?a - aircraft)
            (fast-speed ?a - aircraft)
            (slow-burn ?a - aircraft)
            (fast-burn ?a - aircraft)
            (capacity ?a - aircraft)
            (refuel-rate ?a - aircraft)
            (total-fuel-used)
            (boarding-time)
            (debarking-time)

            (capacidad ?a - aircraft)
            (cantPasajeros ?a - aircraft)
            (destino ?x - person ?y - city)
            (limiteTiempo ?a - aircraft)
            (tiempo ?a - aircraft)
            )

;; el consecuente "vac�o" se representa como "()" y significa "siempre verdad"
(:derived
  (igual ?x ?x) ())

(:derived 
  (different ?x ?y) (not (igual ?x ?y)))



;; este literal derivado se utiliza para deducir, a partir de la información en el estado actual, 
;; si hay fuel suficiente para que el avión ?a vuele de la ciudad ?c1 a la ?c2
;; el antecedente de este literal derivado comprueba si el fuel actual de ?a es mayor que 1. 
;; En este caso es una forma de describir que no hay restricciones de fuel. Pueden introducirse una
;; restricción más copleja  si en lugar de 1 se representa una expresión más elaborada (esto es objeto de
;; los siguientes ejercicios).
(:derived 
  
  (hay-fuel-rapido ?a - aircraft ?c1 - city ?c2 - city)
  (>= (fuel ?a)  (* (distance ?c1 ?c2) (fast-burn ?a)))
)

(:derived 
  
  (hay-fuel-lento ?a - aircraft ?c1 - city ?c2 - city)
  (>= (fuel ?a)  (* (distance ?c1 ?c2) (slow-burn ?a)))
)

(:task iniciarSistema
 :parameters() 

   (:method TodosEnDestino
    :precondition(and
      (not ( destino ?p - person ?c - city))
    )
    :tasks()
   ) 
   (:method YaEnDestino ; si la persona est� en la ciudad no se hace nada
	  :precondition (and 
                  (destino ?p1 - person ?c1 - city)
                  (at ?p1 ?c1)
                  ) 
	  :tasks (
      (eliminarDestino ?p1 ?c1)
      (iniciarSistema)
    )
    )

    (:method Desembarcar ;la gente ha embarcado en el avion
      :precondition (and 
                      (in ?p - person ?a - aircraft)
                      (at ?a - aircraft ?c1 - city)
                      (destino ?p ?c1)
                    )
				     
	    :tasks ( 
        (debark ?p ?a ?c1 )
        (iniciarSistema)
      )
    )

    (:method Embarcar ;si no est� en la ciudad destino, pero avion y persona est�n en la misma ciudad
	    :precondition (and 
                      (at ?p - person ?c1 - city)
                      (at ?a - aircraft ?c1 - city)
                      (destino ?p - person ?ciudad - city)
                    )
				     
	    :tasks ( 
        (board ?p ?a ?c1)
        (iniciarSistema)
      )
    )

    (:method Volar ;la gente ha embarcado en el avion
      :precondition (and 
                      (at ?a - aircraft ?c1 - city)
                      (in ?p ?a)
                      (destino ?p - person ?c2 - city)
                    )
				     
	    :tasks ( 
        (mover-avion ?a ?c1 ?c2)
        (iniciarSistema)
      )
    )



    (:method LlevarAvion
	      :precondition (and (at ?p - person ?c1 - city)
			                   (at ?a - aircraft ?c2 - city)
                        (destino ?p - person ?c3 - city)
                      )
				     
	    :tasks ( 
        (mover-avion ?a ?c2 ?c1)
        (iniciarSistema)
      )
    )
)

(:task mover-avion
 :parameters (?a - aircraft ?c1 - city ?c2 -city)

 
  (:method noHayFuelRapido
    :precondition (and (< (tiempo ?a) (limiteTiempo ?a)) (not(hay-fuel-rapido ?a ?c1 ?c2)) (< (+ (fuel-used ?a) (* (distance ?c1 ?c2) (fast-burn ?a))) (fuel-limit ?a) ))
    :tasks (
            (refuel ?a  ?c1)
            (zoom ?a ?c1 ?c2)

          )
    )
    
 (:method fuel-suficiente
  :precondition (and (< (tiempo ?a) (limiteTiempo ?a)) (hay-fuel-rapido ?a ?c1 ?c2) (< (+(fuel-used ?a) (* (distance ?c1 ?c2) (fast-burn ?a))) (fuel-limit  ?a) ))
  :tasks (
          (zoom ?a ?c1 ?c2)
         )
   )



    (:method noHayFuelLento
    :precondition (and (< (tiempo ?a) (limiteTiempo ?a)) (not(hay-fuel-lento ?a ?c1 ?c2)) (< (+(fuel-used ?a) (* (distance ?c1 ?c2) (slow-burn ?a))) (fuel-limit  ?a) ))
    :tasks (
            (refuel ?a  ?c1)
            (fly ?a ?c1 ?c2)

          )
    )

    (:method fuel-suficiente-lento
    :precondition (and (< (tiempo ?a) (limiteTiempo ?a)) (hay-fuel-lento ?a ?c1 ?c2) (< (+(fuel-used ?a) (* (distance ?c1 ?c2) (slow-burn ?a))) (fuel-limit ?a) ))
    :tasks (
            (fly ?a ?c1 ?c2)
          )
    )
)
  

(:durative-action eliminarDestino
 :parameters (?p - person ?c - city)
 :duration (= ?duration 0)
 :condition (and  (destino ?p ?c)
            )
 :effect (not(destino ?p ?c))
) 
(:import "F:\TSI\Practica3\materialEjercicios\Primitivas-ZenoTravel-eje4.pddl") 


)
