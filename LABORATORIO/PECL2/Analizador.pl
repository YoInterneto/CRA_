%Archivo Analizador PECL 2 Conocimiento y Razonamiento Automatizado

%NO HAY PUESTA NINGUNA TILDE POR SI NOS FALLA
%SI VEMOS QUE FUNCIONA SIN TILDES LAS PONEMOS PARA PROBAR

:-consult('Gramatica.pl').
:-consult('Diccionario.pl').
:-consult('draw.pl').

test1:-oracion(X,[el,hombre,come,una,manzana],[]),draw(X).
test2:-oracion(X,[la,mujer,come,manzanas],[]),draw(X).
test3:-oracion(X,[maría,come,una,manzana,roja],[]),draw(X).
test4:-oracion(X,[juan,ama,a,maría],[]),draw(X).
test5:-oracion(X,[el,gato,grande,come,un,ratón,gris],[]),draw(X).
test6:-oracion(X,[juan,estudia,en,la,universidad],[]),draw(X).
test7:-oracion(X,[el,alumno,ama,la,universidad],[]),draw(X).
test8:-oracion(X,[el,gato,come,ratones],[]),draw(X).
test9:-oracion(X,[el,ratón,que,cazó,el,gato,era,gris],[]),draw(X).
test10:-oracion(X,[la,universidad,es,grande],[]),draw(X).

%20 frases de la practica

test11:-oracion(X,[el,hombre,come,la,manzana,roja],[]),draw(X).
test12:-oracion(X,[el,hombre,con,un,tenedor,grande,come,la,manzana,roja],[]),draw(X).
test13:-oracion(X,[juan,y,maría,comen,la,manzana,roja,con,un,tenedor,y,un,cuchillo],[]),draw(X).
test14:-oracion(X,[ella,hace,la,practica,de,juan],[]),draw(X).
test15:-oracion(X,[el,canario,de,juan,y,maría,canta],[]),draw(X).
test16:-oracion(X,[la,blanca,paloma,alzó,el,vuelo],[]),draw(X).
test17:-oracion(X,[está,muy,lejos,de,madrid],[]),draw(X).
test18:-oracion(X,[él,es,lento,de,reflejos],[]),draw(X).
test19:-oracion(X,[juan,habla,muy,claramente],[]),draw(X).
test20:-oracion(X,[la,esperanza,de,vida,de,un,niño,depende,de,su,lugar,de,nacimiento],[]),draw(X).
test21:-oracion(X,[el,hombre,que,vimos,en,la,universidad,era,mi,profesor],[]),draw(X).
test22:-oracion(X,[juan,',',que,es,muy,delicado,',',come,solamente,manzanas,rojas],[]),draw(X).
test23:-oracion(X,[el,procesador,de,textos,',',que,es,una,herramienta,muy,potente,',',sirve,para,escribir,documentos],[]),draw(X).
test24:-oracion(X,[juan,es,moreno,y,maría,es,alta],[]),draw(X).
test25:-oracion(X,[juan,recoge,la,mesa,mientras,maría,toma,un,café],[]),draw(X).
test26:-oracion(X,[compré,un,pantalón,y,una,corbata,negros],[]),draw(X).
test27:-oracion(X,[juan,y,hector,comen,patatas,fritas,y,beben,cerveza],[]),draw(X).
test28:-oracion(X,[irene,canta,y,salta,mientras,juan,estudia],[]),draw(X).
test29:-oracion(X,[irene,canta,y,salta,y,sonríe,alegre],[]),draw(X).
test30:-oracion(X,[el,procesador,de,textos,es,una,herramienta,muy,potente,que,sirve,para,escribir,documentos,pero,es,bastante,lento],[]),draw(X).