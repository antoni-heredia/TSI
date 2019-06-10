#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue May 21 14:57:53 2019

@author: antonio
"""
import os
import re
import sys
ruta = sys.argv[1]
rutapro = sys.argv[2]
'''
ruta = input("Introduce la ruta del fichero a procesar: ")
rutapro = input("Introduce la ruta donde quieres que se guarde el fichero procesado: ")
'''
puntos = [
        [10,5,4,3,1],
        [1,10,5,4,3],
        [3,1,10,5,4],
        [4,3,1,10,5],
        [5,4,3,1,10],
        ]
ruta = "eje2"
rutapro = "eje2pro"

pro = open(rutapro, "w")
pro.write("(define (problem eje1-test1)"+ os.linesep+"(:domain eje1-domain)"+os.linesep+"(:objects "+ os.linesep )

f = open(ruta)
first_line = f.readline().strip()
first_line = first_line.split(":")
cantZonas = first_line[1]



for i in range(int(cantZonas)):
    pro.write("z"+str(i+1)+" - zona"+os.linesep)
listaObjetos = []
listaTipos = []

nombreJugador = "nombre"
for linea in f:
    lineaSeparada = linea.split("=")
    for i in lineaSeparada:
        objeto = re.findall('\[(.+?)\]', i,re.DOTALL)
        
        if(len(objeto) == 2):        
            tipoZona = objeto[1]
            objeto  = objeto[0]
            separador = objeto.split("-")
            if(any(separador[0] in s for s in listaObjetos) == False):
                listaObjetos.append(separador[0])
                pro.write(str(separador[0])+" - "+str(separador[1])+os.linesep)
                if(separador[1] == 'jugador'):
                    nombreJugador = separador[0]
        elif(len(objeto) == 1):
            tipoZona = objeto[0]
            tipoZona = tipoZona[ 2 : 2+len(tipoZona)]
            
        if(any(tipoZona in s for s in listaTipos) == False):
            listaTipos.append(tipoZona)
            pro.write(tipoZona+" - tiposSuelo"+os.linesep)
            
      
                    
pro.write("N - puntoCardinal"+os.linesep+"S - puntoCardinal"+os.linesep+"E - puntoCardinal"+os.linesep+"O - puntoCardinal"+os.linesep)
pro.write(")"+os.linesep+"(:init "+os.linesep)


f = open(ruta)
first_line = f.readline().strip()
listaObjetos = []
listaZonas = []
for linea in f:
    lineaSeparada = linea.split("->")
    horientacion = lineaSeparada[0].rstrip().lstrip()
    zonas = lineaSeparada[1]
    zonas = zonas.lstrip()
    zonas = zonas.split("=")
    anterior = zonas[0]
    distancia = zonas[1]
    objeto = re.findall('\[(.+?)\]', anterior,re.DOTALL)
    nombreZonaAnterior = anterior.split("[")[0]
    if(len(objeto) == 2):        
        tipoZona = objeto[1]
        objeto  = objeto[0]
        separador = objeto.split("-")
        pro.write("(enZona "+str(separador[0])+" "+str(nombreZonaAnterior)+ ")" +os.linesep)
    else:
        tipoZona = objeto[0]
        tipoZona = tipoZona[ 2 : 2+len(tipoZona)]
        
    if(any(nombreZonaAnterior in s for s in listaZonas) == False):
        pro.write("(tipozona "+str(tipoZona)+" "+str(nombreZonaAnterior)+ ")" +os.linesep)
        listaZonas.append(nombreZonaAnterior)
    zonas.pop(0)
    zonas.pop(0)
    for indice, i in enumerate(zonas):
        nombreZona = i.split("[")[0]
        pro.write("(= (distancia "+nombreZonaAnterior+" "+nombreZona+") "+distancia+")"+os.linesep)
        pro.write("(= (distancia "+nombreZona+" "+nombreZonaAnterior+" ) "+distancia+")"+os.linesep)

        if(horientacion == 'H'):
            pro.write("(zonaVecina "+nombreZonaAnterior+" "+nombreZona+" E)" +os.linesep)
            pro.write("(zonaVecina "+nombreZona+" "+nombreZonaAnterior+" O)" +os.linesep)
        else:
            pro.write("(zonaVecina "+nombreZonaAnterior+" "+nombreZona+" N)" +os.linesep)
            pro.write("(zonaVecina "+nombreZona+" "+nombreZonaAnterior+" S)" +os.linesep)
            
        objeto = re.findall('\[(.+?)\]', i,re.DOTALL)
        
        if(len(objeto) == 2):        
            tipoZona = objeto[1]
            objeto  = objeto[0]
            separador = objeto.split("-")
            if(any(separador[0] in s for s in listaObjetos) == False):
                if(any(tipoZona in s for s in listaTipos) == False):
                    listaTipos.append(tipoZona)
                    pro.write("(tipoSuelo "+str(tipoZona)+" "+str(nombreZona)+ ")" +os.linesep)

                listaObjetos.append(separador[0])
                pro.write("(enZona "+str(separador[0])+" "+str(nombreZona)+ ")" +os.linesep)
        else:
            tipoZona = objeto[0]
            tipoZona = tipoZona[ 2 : 2+len(tipoZona)]
            
        if(any(nombreZona in s for s in listaZonas) == False):
            pro.write("(tipozona "+str(tipoZona)+" "+str(nombreZona)+ ")" +os.linesep)
            listaZonas.append(nombreZona)
            
        if(indice+1 < len(zonas)):            
            distancia = zonas[indice+1]
        zonas.pop(0)               
        nombreZonaAnterior = nombreZona
pro.write("(orientacionJug "+nombreJugador+" S)"+os.linesep)
pro.write("(= (distanciaTotal) "+str(0)+")"+os.linesep)


pro.write(")(:goal ))")
pro.close()