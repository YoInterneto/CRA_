

%Archivo Gramatica PECL 2 Conocimiento y Razonamiento Automatizado
%%Mejora: La mejora de predecir la frase se encuentra comentada va desde las lineas 9 a la 20

%%Estructura general de una oracion
oracion(Orac) --> oracion_subordinada(Orac); oracion_simple(Orac);oracion_coordinada(Orac);{escribir_mensaje_Diccionario}.

%oracion(X,Y,Z):- comprobarVerbo(Y,0,R),(R>=2 ->
%        (oracion_c(X,Y,Z) ->true);
%        (oracion_s(X,Y,Z) -> true));{escribir_mensaje_Diccionario}.

%Comprobar Verbos
%palabra(X):-adverbio(X);adjetivo(X,_,_);conjuncion(X);preposicion(X);verbo(X,_,_);pronombre(X,_,_,_);nombre(X,_,_);determinante(X,_,_).

%contarVerbos(X,Y,P,R):- verbo(X,_,_)->succ(P,P2),comprobarVerboo(Y,P2,R);comprobarVerbo(Y,P,R).

%comprobarVerbo([],T,T).

%comprobarVerbo([X|Y],T,R):-palabra(X)->contarVerbos(X,Y,T,R).



%Posibilidades de oracion simple
%oracion_s(O) --> oracion_simple(O).

%Oracion simple
oracion_simple(o(Gn,Gv)) --> grupo_nominal(Gn,P1,_,N1), grupo_verbal(Gv,_,P2,N2),
                                    comprobacion_numero(N1,N2),comprobacion_persona(P1,P2).
oracion_simple(o(Gv)) --> grupo_verbal(Gv,_,_,_).

%Posibilidades de oracion compuesta
%oracion_c(O) --> oracion_coordinada(O);oracion_subordinada(O).

%Oracion coordinada
oracion_coordinada(oc(Orac1,Conj,Orac2))--> oracion_simple(Orac1), conjuncion(Conj),oracion_simple(Orac2).
oracion_coordinada(oc(Orac1,Conj,Orac2))--> oracion_subordinada(Orac1), conjuncion(Conj),oracion_simple(Orac2).
oracion_coordinada(oc(Orac1,Conj1,Orac2,Conj2,Orac3))--> oracion_simple(Orac1), conjuncion(Conj1),oracion_simple(Orac2),conjuncion(Conj2),oracion_simple(Orac3).

%Oracion subordinada
oracion_subordinada(os(S,C1,ProR,C2,V)) --> grupo_nominal(S,P1,_,N1), coma(C1), complemento_nombre(ProR), coma(C2), grupo_verbal(V,_,P2,N2),
                                    comprobacion_numero(N1,N2),comprobacion_persona(P1,P2).
oracion_subordinada(os(S,V)) --> grupo_nominal_compuesto(S,P1,_,N1), grupo_verbal(V,_,P2,N2),
                                    comprobacion_numero(N1,N2),comprobacion_persona(P1,P2).
oracion_subordinada(os(S,V,ProR)) --> grupo_nominal(S,P1,_,N1), grupo_verbal(V,_,P2,N2), complemento_nombre(ProR),
                                    comprobacion_numero(N1,N2),comprobacion_persona(P1,P2).

%Sintagma nominal compuesto
grupo_nominal_compuesto(gnC(Det,S,ProR),pers3,G2, N2) --> determinante(Det, G1, N1), nombre(S, _, G2, N2), complemento_nombre(ProR),
                                    comprobacion_numero(N1,N2),comprobacion_genero(G1,G2).

%Sintagmas Nominales
grupo_nominal(gn(S1,C,S2),pers3,n,n) --> nombre(S1,_,_,_), conjuncion(C), nombre(S2,_,_,_).


grupo_nominal(gn(Det1,S1,C,Det2,S2),pers3,n,n) -->  determinante(Det1, G1, N1), nombre(S1,_,G2,N2), conjuncion(C),determinante(Det2, G3, N3), nombre(S2,_,G4,N4),
                                    comprobacion_numero(N1,N2),comprobacion_genero(G1,G2),comprobacion_numero(N3,N4),comprobacion_genero(G3,G4).


grupo_nominal(gn(Det, S, Gprep),pers3,G2,N2) --> determinante(Det, G1, N1), nombre(S, _, G2, N2), grupo_preposicional(Gprep),
                                    comprobacion_numero(N1,N2),comprobacion_genero(G1,G2).


grupo_nominal(gn(Det, S, Adj, Gprep),pers3,G2,N2) --> determinante(Det, G1, N1), nombre(S, _, G2, N2),adjetivo(Adj, G3, N3), grupo_preposicional(Gprep),
                                    comprobacion_numero(N1,N2),comprobacion_genero(G1,G2),comprobacion_numero(N3,N2),comprobacion_genero(G3,G2).


grupo_nominal(gn(S),P,G,N)--> pronombre(S,P,G,N).


grupo_nominal(gn(S,Adj),pers3,G1,N1)--> nombre(S,_,G1,N1),adjetivo(Adj, G2, N2),
                                    comprobacion_numero(N1,N2),comprobacion_genero(G1,G2).


grupo_nominal(gn(Det, S, Adv),pers3, G2, N2) --> determinante(Det, G1, N1), nombre(S, _, G2, N2), grupo_adverbial(Adv),
                                    comprobacion_numero(N1,N2),comprobacion_genero(G1,G2).


grupo_nominal(gn(S,Gprep),pers3,G,N)--> nombre(S,_,G,N), grupo_preposicional(Gprep).


grupo_nominal(gn(Det, S, Adj),pers3, G2, N2) --> determinante(Det, G1, N1), nombre(S, _, G2, N2), adjetivo(Adj, G3, N3),
                                    comprobacion_numero(N1,N2),comprobacion_genero(G1,G2),comprobacion_numero(N3,N2),comprobacion_genero(G3,G2).


grupo_nominal(gn(Det, Adj, S),pers3, G3, N3) --> determinante(Det, G1, N1), adjetivo(Adj, G2, N2), nombre(S, _, G3, N3),
                                    comprobacion_numero(N1,N2),comprobacion_genero(G1,G2),comprobacion_numero(N3,N2),comprobacion_genero(G3,G2).


grupo_nominal(gn(Det, S),pers3, G2, N2) --> determinante(Det, G1, N1), nombre(S, _, G2, N2),
                                    comprobacion_numero(N1,N2),comprobacion_genero(G1,G2).


grupo_nominal(gn(S),pers3,G,N)--> nombre(S,_,G,N).


%Sintagmas Verbales

grupo_verbal(gv(V,A),G,P,N2) --> verbo(V,P,N1), adjetivo(A,G,N2),
                                    comprobacion_numero(N1,N2).


grupo_verbal(gv(V, Adv), {n}, P, N1) --> verbo(V,P, N1), grupo_adverbial(Adv).


grupo_verbal(gv(V, S), G, P, N1) --> verbo(V,P, N1), grupo_nominal(S,_, G, _).


grupo_verbal(gv(V, S, Adj), _, P, N1) --> verbo(V,P, N1), grupo_nominal(S,_, _, _), adjetivo(Adj, _, _).


grupo_verbal(gv(V, Prep), n, P, N) --> verbo(V,P,N), grupo_preposicional(Prep).


grupo_verbal(gv(V,A,Prep),G,P,N1) --> verbo(V,P,N1), adjetivo(A,G,N2), grupo_preposicional(Prep),
                                    comprobacion_numero(N1,N2).


grupo_verbal(gv(V),n,P,N) --> verbo(V,P,N).



%Sintagma Adverbial
grupo_adverbial(gadv(ADV)) --> adverbio(ADV).
grupo_adverbial(gadv(ADV,ADV2)) --> adverbio(ADV), adverbio(ADV2).
grupo_adverbial(gadv(ADV,ADV2,Gprep)) --> adverbio(ADV), adverbio(ADV2), grupo_preposicional(Gprep).
grupo_adverbial(gadv(ADV,A)) --> adverbio(ADV), adjetivo(A,_,_).
grupo_adverbial(gadv(ADV,S)) --> adverbio(ADV), grupo_nominal(S,_, _, _).

%Sintagmas Preposicionales
grupo_preposicional(gp(PRE,S)) --> preposicion(PRE), grupo_nominal(S,_,_,_).
grupo_preposicional(gp(PRE,V)) --> preposicion(PRE), grupo_verbal(V,_,_,_).


%%Estructura complemento del nombre:
complemento_nombre(cn(PROR,V)) --> pronombreRel(PROR), grupo_verbal(V,_,_,_).

%%%%% Comprobaciones %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

escribir_mensaje_Diccionario :- write('Error de diccionario').

comprobacion_numero(N1,N2,L,L) :- N1 == n;
                                    N2 == n;
                                    N1 == N2;
                                    not(N1 == N2), not(N2 == n), not(N1 == n), write('Fallo de numero\n').

comprobacion_genero(G1,G2,L,L) :-G1 == n;
                                    G2 == n;
                                    G1 == G2;
                                    not(G1 == G2), not(G2 == n), not(G1 == n), write('Fallo de género\n').
                                    
comprobacion_persona(P1,P2,L,L) :-P1 == n;
                                    P2 == n;
                                    P1 == P2;
                                    not(P1 == P2), not(P2 == n), not(P1 == n), write('Fallo de persona\n').
