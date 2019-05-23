#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue May 21 14:57:53 2019

@author: antonio
"""
import os
import re
'''
ruta = input("Introduce la ruta del fichero a procesar: ")
rutapro = input("Introduce la ruta donde quieres que se guarde el fichero procesado: ")
'''
ruta = "eje1"
rutapro = "eje1pro"

pro = open(rutapro, "w")
pro.write("(define (problem eje1-test1)"+ os.linesep+"(:domain eje1-domain)"+os.linesep+"(:objects "+ os.linesep )

f = open(ruta)
first_line = f.readline().strip()
first_line = first_line.split(":")
cantZonas = first_line[1]
for i in range(int(cantZonas)):
    pro.write("z"+str(i+1)+" - zona"+os.linesep)
listaObjetos = []
nombreJugador = "nombre"
for linea in f:
    lineaSeparada = linea.split()
    for i in lineaSeparada:
        objeto = re.search('\[(.+?)\]', i)
        if(objeto):
            objeto = objeto.group(0)
            objeto = objeto.split("[")[1]
            objeto = objeto.split("]")[0]
            separador = objeto.split("-")
            if(any(separador[0] in s for s in listaObjetos) == False):
                listaObjetos.append(separador[0])
                pro.write(str(separador[0])+" - "+str(separador[1])+os.linesep)
                if(separador[1] == "jugador"):
                    nombreJugador = separador[0]
pro.write("N - puntoCardinal"+os.linesep+"S - puntoCardinal"+os.linesep+"E - puntoCardinal"+os.linesep+"O - puntoCardinal"+os.linesep)
pro.write(")"+os.linesep+"(:init "+os.linesep)


f = open(ruta)
first_line = f.readline().strip()
listaObjetos = []
for linea in f:
    lineaSeparada = linea.split("->")
    horientacion = lineaSeparada[0].rstrip().lstrip()
    zonas = lineaSeparada[1]
    zonas = zonas.lstrip()
    zonas = zonas.split()
    anterior = zonas[0]
    objeto = re.search('\[(.+?)\]', anterior)
    nombreZonaAnterior = anterior.split("[")[0]
    if(objeto):
        objeto = objeto.group(0)
        objeto = objeto.split("[")[1]
        objeto = objeto.split("]")[0]
        separador = objeto.split("-")
        pro.write("(enZona "+str(separador[0])+" "+str(nombreZonaAnterior)+ ")" +os.linesep)
    zonas.pop(0)
    for i in zonas:
        nombreZona = i.split("[")[0]
        if(horientacion == 'H'):
            pro.write("(zonaVecina "+nombreZonaAnterior+" "+nombreZona+" E)" +os.linesep)
            pro.write("(zonaVecina "+nombreZona+" "+nombreZonaAnterior+" O)" +os.linesep)
        else:
            pro.write("(zonaVecina "+nombreZonaAnterior+" "+nombreZona+" N)" +os.linesep)
            pro.write("(zonaVecina "+nombreZona+" "+nombreZonaAnterior+" S)" +os.linesep)
            
        objeto = re.search('\[(.+?)\]', i)
        if(objeto):
            objeto = objeto.group(0)
            objeto = objeto.split("[")[1]
            objeto = objeto.split("]")[0]
            separador = objeto.split("-")
            if(any(separador[0] in s for s in listaObjetos) == False):
                listaObjetos.append(separador[0])
                pro.write("(enZona "+str(separador[0])+" "+str(nombreZona)+ ")" +os.linesep)
        nombreZonaAnterior = nombreZona
pro.write("(orientacionJug "+nombreJugador+" S)")

pro.write(")(:goal ))")
pro.close()