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
leo1 - leo
oscar1 - oscar
principe1 - principe
princesa1 - princesa
algoritmo1 - algoritmos
manzana1 - manzanas
rosa1 - rosas
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
(zonaVecina z1 z2 E)
(zonaVecina z2 z1 O)
(zonaVecina z2 z3 E)
(zonaVecina z3 z2 O)
(zonaVecina z3 z5 E)
(zonaVecina z5 z3 O)
(enZona leo1 z5)
(zonaVecina z5 z10 E)
(zonaVecina z10 z5 O)
(enZona oscar1 z10)
(zonaVecina z10 z11 E)
(zonaVecina z11 z10 O)
(zonaVecina z11 z14 E)
(zonaVecina z14 z11 O)
(enZona principe1 z14)
(zonaVecina z14 z20 E)
(zonaVecina z20 z14 O)
(zonaVecina z20 z21 E)
(zonaVecina z21 z20 O)
(enZona princesa1 z21)
(enZona algoritmo1 z15)
(zonaVecina z15 z16 E)
(zonaVecina z16 z15 O)
(zonaVecina z16 z17 E)
(zonaVecina z17 z16 O)
(zonaVecina z17 z18 E)
(zonaVecina z18 z17 O)
(zonaVecina z18 z24 E)
(zonaVecina z24 z18 O)
(enZona manzana1 z24)
(zonaVecina z24 z23 E)
(zonaVecina z23 z24 O)
(zonaVecina z7 z8 E)
(zonaVecina z8 z7 O)
(zonaVecina z8 z17 E)
(zonaVecina z17 z8 O)
(zonaVecina z17 z9 E)
(zonaVecina z9 z17 O)
(enZona rosa1 z9)
(zonaVecina z9 z12 E)
(zonaVecina z12 z9 O)
(enZona algoritmo1 z15)
(zonaVecina z15 z6 N)
(zonaVecina z6 z15 S)
(zonaVecina z6 z5 N)
(zonaVecina z5 z6 S)
(zonaVecina z5 z4 N)
(zonaVecina z4 z5 S)
(zonaVecina z4 z7 N)
(zonaVecina z7 z4 S)
(zonaVecina z18 z19 N)
(zonaVecina z19 z18 S)
(zonaVecina z19 z14 N)
(zonaVecina z14 z19 S)
(zonaVecina z14 z13 N)
(zonaVecina z13 z14 S)
(enZona pepe z13)
(zonaVecina z13 z12 N)
(zonaVecina z12 z13 S)
(enZona profesor1 z25)
(zonaVecina z25 z24 N)
(zonaVecina z24 z25 S)
(zonaVecina z23 z22 N)
(zonaVecina z22 z23 S)
(enZona oro1 z22)
(zonaVecina z22 z21 N)
(zonaVecina z21 z22 S)
(orientacionJug pepe S))
  (:goal (AND 
        (tieneObjeto  rosa1 principe1)
        (tieneObjeto  manzana1 princesa1)
        (tieneObjeto  oro1 bruja1)
        (tieneObjeto  oscar1 leo1)
        (tieneObjeto  algoritmo1 profesor1)
        )
  )
)