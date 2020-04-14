% Author:
% Date: 09/04/2020


:-consult('DiccionarioIngles.pl').
:-consult('DiccionarioEspannol.pl').
:-consult('GramaticaEspannol.pl').
:-consult('GramaticaIngles.pl').
:-consult('draw.pl').


%PARA EJECUTAR TODO A LA VEZ --> testTotal.



saltoDeLinea:- write('\n').


%PRUEBAS DE ESPANIOL A INGLES
test1e:- oracion(X, [el, hombre, come, una, manzana], []), sentence(X,Ingles,[]),write(X),saltoDeLinea, write(Ingles), saltoDeLinea, saltoDeLinea.

test2e:- oracion(X, [ellos, comen, manzanas], []), sentence(X,Ingles,[]),write(X),saltoDeLinea, write(Ingles), saltoDeLinea, saltoDeLinea.

test3e:- oracion(X, [tu,comes,una,manzana,roja], []), sentence(X,Ingles,[]),write(X),saltoDeLinea, write(Ingles), saltoDeLinea, saltoDeLinea.

test4e:- oracion(X, [juan, ama,a,maria], []), sentence(X,Ingles,[]),write(X),saltoDeLinea, write(Ingles), saltoDeLinea, saltoDeLinea.

test5e:- oracion(X, [el,gato,grande,come,un,raton,gris], []), sentence(X,Ingles,[]),write(X),saltoDeLinea, write(Ingles), saltoDeLinea, saltoDeLinea.

test6e:- oracion(X, [juan, estudia, en, la, universidad], []), sentence(X,Ingles,[]),write(X),saltoDeLinea, write(Ingles), saltoDeLinea, saltoDeLinea.

test7e:- oracion(X, [el,alumno,ama,la,universidad], []), sentence(X,Ingles,[]),write(X),saltoDeLinea, write(Ingles), saltoDeLinea, saltoDeLinea.

test8e:- oracion(X, [el,perro,persiguio,un,gato,negro,en,el,jardin], []), sentence(X,Ingles,[]),write(X),saltoDeLinea, write(Ingles), saltoDeLinea, saltoDeLinea.

test9e:- oracion(X, [la, universidad, es, grande], []), sentence(X,Ingles,[]),write(X),saltoDeLinea, write(Ingles), saltoDeLinea, saltoDeLinea.

test10e:- oracion_compuesta(X, [el,hombre,que,vimos,ayer,es,mi,vecino], []), compound_sentence(X,Ingles,[]),write(X),saltoDeLinea, write(Ingles), saltoDeLinea, saltoDeLinea.

test11e:- oracion(X, [el,canario,amarillo,canta,muy,bien], []), sentence(X,Ingles,[]),write(X),saltoDeLinea, write(Ingles), saltoDeLinea, saltoDeLinea.

test12e:- oracion_compuesta(X, [juan,toma,un,cafe,y,lee,el,periodico], []), compound_sentence(X,Ingles,[]),write(X),saltoDeLinea, write(Ingles), saltoDeLinea, saltoDeLinea.

test13e:- oracion_compuesta(X, [juan,es,delgado,y,maria,es,alta], []), compound_sentence(X,Ingles,[]),write(X),saltoDeLinea, write(Ingles), saltoDeLinea, saltoDeLinea.

test14e:- oracion(X, [oscar,wilde,escribio,el,fantasma,de,canterville], []), sentence(X,Ingles,[]),write(X),saltoDeLinea, write(Ingles), saltoDeLinea, saltoDeLinea.

testEspanolIngles:- write('TRADUCCION DE ESPANIOL A INGLES\n'),
                    test1e,
                    test2e,
                    test3e,
                    test4e,
                    test5e,
                    test6e,
                    test7e,
                    test8e,
                    test9e,
                    test10e,
                    test11e,
                    test12e,
                    test13e,
                    test14e.


%PRUEBAS DE INGLES A ESPANIOL
test1i:- sentence(X, [the,man,eats,an,apple], []), oracion(X,Espanol,[]),write(X),saltoDeLinea, write(Espanol), saltoDeLinea, saltoDeLinea.

test2i:- sentence(X, [they, eat, some, apples], []), oracion(X,Espanol,[]),write(X),saltoDeLinea, write(Espanol), saltoDeLinea, saltoDeLinea.

test3i:- sentence(X, [you,eat,a,red,apple], []), oracion(X,Espanol,[]),write(X),saltoDeLinea, write(Espanol), saltoDeLinea, saltoDeLinea.

test4i:- sentence(X, [john,loves,mary], []), oracion(X,Espanol,[]),write(X),saltoDeLinea, write(Espanol), saltoDeLinea, saltoDeLinea.

test5i:- sentence(X, [the, big, cat, eats, a, grey, mouse], []), oracion(X,Espanol,[]),write(X),saltoDeLinea, write(Espanol), saltoDeLinea, saltoDeLinea.

test6i:- sentence(X, [john,studies,at,university], []), oracion(X,Espanol,[]),write(X),saltoDeLinea, write(Espanol), saltoDeLinea, saltoDeLinea.

test7i:- sentence(X, [the,student,loves,university], []), oracion(X,Espanol,[]),write(X),saltoDeLinea, write(Espanol), saltoDeLinea, saltoDeLinea.

test8i:- sentence(X, [the, dog, chased, a, black, cat, in, the, garden], []), oracion(X,Espanol,[]),write(X),saltoDeLinea, write(Espanol), saltoDeLinea, saltoDeLinea.

test9i:- sentence(X, [the,university,is,large], []), oracion(X,Espanol,[]),write(X),saltoDeLinea, write(Espanol), saltoDeLinea, saltoDeLinea.

test10i:- compound_sentence(X, [the,man,that,we,saw,yesterday,is,my,neighbour], []), oracion_compuesta(X,Espanol,[]),write(X),saltoDeLinea, write(Espanol), saltoDeLinea, saltoDeLinea.

test11i:- sentence(X, [the, yellow, canary, sings, very, well], []), oracion(X,Espanol,[]),write(X),saltoDeLinea, write(Espanol), saltoDeLinea, saltoDeLinea.

test12i:- compound_sentence(X, [john, has, a, coffee, and, reads, the, newspaper], []), oracion_compuesta(X,Espanol,[]),write(X),saltoDeLinea, write(Espanol), saltoDeLinea, saltoDeLinea.

test13i:- compound_sentence(X, [john, is,thin,and,mary,is,tall], []), oracion_compuesta(X,Espanol,[]),write(X),saltoDeLinea, write(Espanol), saltoDeLinea, saltoDeLinea.

test14i:- sentence(X, [oscar,wilde,wrote,the,canterville,ghost], []), oracion(X,Espanol,[]),write(X),saltoDeLinea, write(Espanol), saltoDeLinea, saltoDeLinea.


testInglesEspanol:- write('TRADUCCION DE INGLES A ESPANIOL\n'),
                    test1i,
                    test2i,
                    test3i,
                    test4i,
                    test5i,
                    test6i,
                    test7i,
                    test8i,
                    test9i,
                    test10i,
                    test11i,
                    test12i,
                    test13i,
                    test14i.


testTotal:- testEspanolIngles,
               saltoDeLinea,
               testInglesEspanol.





