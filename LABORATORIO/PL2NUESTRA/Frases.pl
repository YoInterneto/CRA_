% Autor:
% Fecha: 07/04/2020

:-consult('Gramatica.pl').
:-consult('Diccionario.pl').
:-consult('draw.pl').

%Frases para validar
frase1:-oracion(X,[el,hombre,come,una,manzana],[]),draw(X).
frase2:-oracion(X,[la,mujer,come,manzanas],[]),draw(X).
frase3:-oracion(X,[maría,come,una,manzana,roja],[]),draw(X).
frase4:-oracion(X,[juan,ama,a,maría],[]),draw(X).
frase5:-oracion(X,[el,gato,grande,come,un,ratón,gris],[]),draw(X).
frase6:-oracion(X,[juan,estudia,en,la,universidad],[]),draw(X).
frase7:-oracion(X,[el,alumno,ama,la,universidad],[]),draw(X).
frase8:-oracion(X,[el,gato,come,ratones],[]),draw(X).
frase9:-oracion(X,[el,ratón,que,cazó,el,gato,era,gris],[]),draw(X).
frase10:-oracion(X,[la,universidad,es,grande],[]),draw(X).