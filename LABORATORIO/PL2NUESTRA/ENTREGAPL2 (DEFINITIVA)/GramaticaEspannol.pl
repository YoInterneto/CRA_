% Author:
% Date: 09/04/2020

%GRAMATICA ESPANNOL


%ORACIONES SIMPLES
oracion(s(S,V,O)) --> sint_n(S,N,_,n), verbo(V,N,_),sint_n(O,_,e,_).
oracion(s(V,O)) --> verbo(V,_,_),sint_n(O,_,e,_).

%ORACIONES CON SINTAGMAS PREPOSICIONALES
oracion(s(S,V,O)) --> sint_n(S,N,_,n), verbo(V,N,_),sint_prep(O,_,e,_).
oracion(s(S,V,T,O)) --> sint_n(S,N,_,n), verbo(V,N,i),sint_n(T,_,_,n), sint_prep(O,_,e,n).

%ORACIONES CON ADJETIVOS
oracion(s(S,V,A)) --> sint_n(S,N,p,n), verbo(V,N,i),adjetivo(A,_,N).

%ORACIONES CON SINTAGMAS ADVERBIALES
oracion(s(S,V,B)) --> sint_n(S,N,_,n), verbo(V,N,i),sint_adv(B).

%ORACIONES PARA CASOS ESPECIALES

%CASO ESPECIAL PARA LA ORACION 4
oracion(s(S,V,O)) --> sint_n(S,N,_,n), verbo(V,N,t), preposicion2(p2(p2_1),p), sint_n(O,_,p,n).

%CASO ESPECIAL PARA LAS ORACIONES 6 Y 7
oracion(s(S,V,O)) --> sint_n(S,N,_,n), verbo(V,N,t), sint_n(O,_,e2,s).

%CASO ESPECIAL PARA ORACION 9
oracion(s(S,V,A)) --> sint_n(S,N,e2,n), verbo(V,N,i),adjetivo(A,_,N).

%CASO ESPECIAL PARA PREGUNTA 10 (SUBORDINADA)
oracion(s(S,Y,V,B)) --> sint_n(S,_,s2,n), pronombre(Y),verbo(V,_,i),sint_adv(B).

%ORACIONES COMPUESTAS

%COORDINADA
oracion_compuesta(os(O1,C,O2)) -->oracion(O1),conjuncion(C),oracion(O2).

%SUBORDINADA
oracion_compuesta(os(O1,O2)) -->oracion(O1),oracion(O2).

%SINTAGMAS NOMINALES
%SE INTRODUCEN COMO PARAMETROS EL NUMERO, SI ES PROPIO O COMUN Y N O S, ESTE ULTIMO SE UTILIZA PARA DIFERENCIAR LOS CASOS DE LAS PREGUNTAS 6 Y 7 CON LA 9
sint_n(np(M,S,A),N,_,n) --> articulo(M,G,N,C), nombre(S,G,N,C,_), adjetivo(A,G,N).
sint_n(np(M,S),N,_,n) --> articulo(M,G,N,C), nombre(S,G,N,C,e).
sint_n(np(S),N,e,n) --> nombre(S,_,N,c,e). %SOLO SIVRE PARA LOS CONTABLES, POR ESO LA C
sint_n(np(S),N,p,n) --> nombre(S,_,N,c,p).

%CASOS ESPECIALES

%CASO ESPECIAL PARA LA PREGUNTA 2
%sint_n(np(M2,S),N,_) --> nombre(S,_,N,C,_).
sint_n(np(S),_,e,n) --> nombre(S,_,_,u,e).


%CASO ESPECIAL PARA LAS PREGUNTAS 6 Y 7
sint_n(np(S),N,e2,s) --> articulo3(m3(art3_1),c2,e2), nombre(S,_,N,_,e2).

%CASO ESPECIAL PARA LA PREGUNTA 9
sint_n(np(M,S),N,e2,n) --> articulo(M,f,sg,c), nombre(S,_,N,_,e2).   %caso pregunta 9


%SINTAGMAS PREPOSICIONALES, LOS PARAMETROS SON IGUALES QUE EN EL NOMINAL
sint_prep(nprep(P,O),_,_,F) --> preposicion(P), sint_n(O,_,e2,F).


%SINTAGMAS ADVERBIALES
sint_adv(sadv(B)) --> adverbio(B).
sint_adv(sadv(B,B2)) --> adverbio(B),adverbio(B2).




