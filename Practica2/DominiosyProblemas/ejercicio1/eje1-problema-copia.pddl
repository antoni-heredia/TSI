(define (problem eje1-test1)
    (:domain eje1-domain)
    (:objects 
          p1 - zona
          p2 - zona
          p3 - zona
          p4 - zona
          p5 - zona
          p6 - zona
          p7 - zona
          p8 - zona
          p9 - zona
          p10 - zona
          p11 - zona
          p12 - zona
          p13 - zona
          p14 - zona
          p15 - zona
          p16 - zona
          p17 - zona
          p18 - zona 
          p19 - zona
          p20 - zona
          p21 - zona
          p22 - zona
          p23 - zona
          p24 - zona
          p25 - zona
            
          pepe - jugador
          N - puntoCardinal
          S - puntoCardinal
          E - puntoCardinal
          O - puntoCardinal
          obj1 - oscar
          obj2 - algoritmos
          obj3 - manzanas
          obj4 - oro
          obj5 - rosas

          personaje1 - leo
          personaje2 - profesor
          personaje3 - bruja
          personaje4 - principe
          personaje5 - princesa

          )
  (:init 
    (enZona personaje1 p1)
    (enZona personaje2 p5)
    (enZona personaje3 p14)
    (enZona personaje4 p21)
    (enZona personaje5 p25)
    (enZona obj1 p10)
    (enZona obj2 p22)
    (enZona obj3 p24)
    (enZona obj4 p9)
    (enZona obj5 p15)

    (enZona pepe p1)
    (orientacionJug pepe S)

    (zonaVecina p1 p2 E)
    (zonaVecina p2 p1 O)
    (zonaVecina p2 p3 E)
    (zonaVecina p3 p2 O)
    (zonaVecina p3 p5 E)
    (zonaVecina p5 p3 O)
    (zonaVecina p5 p10 E)
    (zonaVecina p10 p5 O)    
    (zonaVecina p10 p11 E)
    (zonaVecina p11 p10 O)
    (zonaVecina p11 p14 E)
    (zonaVecina p14 p11 O)
    (zonaVecina p14 p20 E)
    (zonaVecina p20 p14 O)
    (zonaVecina p20 p21 E)
    (zonaVecina p21 p20 O)
    (zonaVecina p7 p8 E)
    (zonaVecina p8 p7 O)  
    (zonaVecina p8 p9 E)
    (zonaVecina p9 p8 O)
    (zonaVecina p9 p12 E)
    (zonaVecina p12 p9 O)
    (zonaVecina p15 p16 E)
    (zonaVecina p16 p15 O)
    (zonaVecina p16 p17 E)
    (zonaVecina p17 p16 O)
    (zonaVecina p17 p18 E)
    (zonaVecina p18 p17 O)
    (zonaVecina p18 p24 E)
    (zonaVecina p24 p18 O)
    (zonaVecina p24 p23 E)
    (zonaVecina p23 p24 O)

    (zonaVecina p15 p6 N)
    (zonaVecina p6 p15 S)
    (zonaVecina p6 p5 N)
    (zonaVecina p5 p6 S)
    (zonaVecina p5 p4 N)
    (zonaVecina p4 p5 S)
    (zonaVecina p4 p7 N)
    (zonaVecina p7 p4 S)

    (zonaVecina p18 p19 N)
    (zonaVecina p19 p18 S)
    (zonaVecina p19 p14 N)
    (zonaVecina p14 p19 S)
    (zonaVecina p14 p13 N)
    (zonaVecina p13 p14 S)
    (zonaVecina p13 p12 N)
    (zonaVecina p12 p13 S)

    (zonaVecina p25 p24 N)
    (zonaVecina P24 p25 S)
    (zonaVecina p23 p22 N)
    (zonaVecina p22 p23 S)
    (zonaVecina p22 p21 N)
    (zonaVecina p21 p22 S)
    )
  (:goal (AND 
        (tieneObjeto  obj1 personaje1)
        (tieneObjeto  obj2 personaje2)
        (tieneObjeto  obj3 personaje3)
        (tieneObjeto  obj4 personaje4)
        (tieneObjeto  obj5 personaje5)
        )
  )
  )