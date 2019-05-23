(define (problem eje1-test1)
(:domain eje1-domain)
(:objects 
z1 - zona
z2 - zona
z3 - zona
z4 - zona
z5 - zona
z6 - zona
z7 - zona
z8 - zona
z9 - zona
z10 - zona
z11 - zona
z12 - zona
z13 - zona
z14 - zona
z15 - zona
z16 - zona
z17 - zona
z18 - zona
z19 - zona
z20 - zona
z21 - zona
z22 - zona
z23 - zona
z24 - zona
z25 - zona
bruja1 - bruja
Piedra - tiposSuelo
leo1 - leo
oscar1 - oscar
principe1 - principe
bikini1  -  bikini
princesa1 - princesa
algoritmo1 - algoritmos
Agua - tiposSuelo
manzana1 - manzanas
Bosque - tiposSuelo
Precipicio - tiposSuelo
rosa1 - rosas
zapatillas1  -  zapatillas
Arena - tiposSuelo
pepe - jugador
profesor1 - profesor
oro1 - oro
N - puntoCardinal
S - puntoCardinal
E - puntoCardinal
O - puntoCardinal
)
(:init 
(enZona bruja1 z1)
(tipozona Piedra z1)
(= (distancia z1 z2) 1)
(= (distancia z2 z1 ) 1)
(zonaVecina z1 z2 E)
(zonaVecina z2 z1 O)
(tipozona Piedra z2)
(= (distancia z2 z3) 1)
(= (distancia z3 z2 ) 1)
(zonaVecina z2 z3 E)
(zonaVecina z3 z2 O)
(tipozona Piedra z3)
(= (distancia z3 z5) 1)
(= (distancia z5 z3 ) 1)
(zonaVecina z3 z5 E)
(zonaVecina z5 z3 O)
(enZona leo1 z5)
(tipozona Piedra z5)
(= (distancia z5 z10) 1)
(= (distancia z10 z5 ) 1)
(zonaVecina z5 z10 E)
(zonaVecina z10 z5 O)
(enZona oscar1 z10)
(tipozona Piedra z10)
(= (distancia z10 z11) 1)
(= (distancia z11 z10 ) 1)
(zonaVecina z10 z11 E)
(zonaVecina z11 z10 O)
(tipozona Piedra z11)
(= (distancia z11 z14) 1)
(= (distancia z14 z11 ) 1)
(zonaVecina z11 z14 E)
(zonaVecina z14 z11 O)
(enZona principe1 z14)
(tipozona Piedra z14)
(= (distancia z14 z20) 1)
(= (distancia z20 z14 ) 1)
(zonaVecina z14 z20 E)
(zonaVecina z20 z14 O)
(enZona bikini1  z20)
(tipozona Piedra z20)
(= (distancia z20 z21) 1)
(= (distancia z21 z20 ) 1)
(zonaVecina z20 z21 E)
(zonaVecina z21 z20 O)
(enZona princesa1 z21)
(tipozona Piedra z21)
(enZona algoritmo1 z15)
(tipozona Agua z15)
(= (distancia z15 z16) 1)
(= (distancia z16 z15 ) 1)
(zonaVecina z15 z16 E)
(zonaVecina z16 z15 O)
(tipozona Agua z16)
(= (distancia z16 z17) 1)
(= (distancia z17 z16 ) 1)
(zonaVecina z16 z17 E)
(zonaVecina z17 z16 O)
(tipozona Agua z17)
(= (distancia z17 z18) 1)
(= (distancia z18 z17 ) 1)
(zonaVecina z17 z18 E)
(zonaVecina z18 z17 O)
(tipozona Agua z18)
(= (distancia z18 z24) 11)
(= (distancia z24 z18 ) 11)
(zonaVecina z18 z24 E)
(zonaVecina z24 z18 O)
(enZona manzana1 z24)
(tipozona Agua z24)
(= (distancia z24 z23) 11)
(= (distancia z23 z24 ) 11)
(zonaVecina z24 z23 E)
(zonaVecina z23 z24 O)
(tipozona Agua z23)
(tipozona Bosque z7)
(= (distancia z7 z8) 1)
(= (distancia z8 z7 ) 1)
(zonaVecina z7 z8 E)
(zonaVecina z8 z7 O)
(tipozona Precipicio z8)
(= (distancia z8 z9) 1)
(= (distancia z9 z8 ) 1)
(zonaVecina z8 z9 E)
(zonaVecina z9 z8 O)
(enZona rosa1 z9)
(tipozona Bosque z9)
(= (distancia z9 z12) 1)
(= (distancia z12 z9 ) 1)
(zonaVecina z9 z12 E)
(zonaVecina z12 z9 O)
(tipozona Bosque z12)
(enZona algoritmo1 z15)
(= (distancia z15 z6) 1)
(= (distancia z6 z15 ) 1)
(zonaVecina z15 z6 N)
(zonaVecina z6 z15 S)
(tipozona Agua z6)
(= (distancia z6 z5) 1)
(= (distancia z5 z6 ) 1)
(zonaVecina z6 z5 N)
(zonaVecina z5 z6 S)
(= (distancia z5 z4) 1)
(= (distancia z4 z5 ) 1)
(zonaVecina z5 z4 N)
(zonaVecina z4 z5 S)
(enZona zapatillas1  z4)
(tipozona Arena z4)
(= (distancia z4 z7) 1)
(= (distancia z7 z4 ) 1)
(zonaVecina z4 z7 N)
(zonaVecina z7 z4 S)
(= (distancia z18 z19) 1)
(= (distancia z19 z18 ) 1)
(zonaVecina z18 z19 N)
(zonaVecina z19 z18 S)
(tipozona Agua z19)
(= (distancia z19 z14) 1)
(= (distancia z14 z19 ) 1)
(zonaVecina z19 z14 N)
(zonaVecina z14 z19 S)
(= (distancia z14 z13) 1)
(= (distancia z13 z14 ) 1)
(zonaVecina z14 z13 N)
(zonaVecina z13 z14 S)
(enZona pepe z13)
(tipozona Bosque z13)
(= (distancia z13 z12) 1)
(= (distancia z12 z13 ) 1)
(zonaVecina z13 z12 N)
(zonaVecina z12 z13 S)
(enZona profesor1 z25)
(tipozona Agua z25)
(= (distancia z25 z24) 1)
(= (distancia z24 z25 ) 1)
(zonaVecina z25 z24 N)
(zonaVecina z24 z25 S)
(= (distancia z23 z22) 1)
(= (distancia z22 z23 ) 1)
(zonaVecina z23 z22 N)
(zonaVecina z22 z23 S)
(enZona oro1 z22)
(tipozona Agua z22)
(= (distancia z22 z21) 1)
(= (distancia z21 z22 ) 1)
(zonaVecina z22 z21 N)
(zonaVecina z21 z22 S)
(orientacionJug pepe S)
(= (distanciaTotal) 0)
)(:goal (AND 
        (tieneObjeto  rosa1 principe1)
        (tieneObjeto  manzana1 princesa1)
        (tieneObjeto  oro1 bruja1)
        (tieneObjeto  oscar1 leo1)
        (tieneObjeto  algoritmo1 profesor1)
        )
  )
  (:metric minimize (distanciaTotal))
)