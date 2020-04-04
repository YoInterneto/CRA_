% Author:
% Date: 04/04/2020


:-consult('draw.pl').
%REGLAS GRAMATICALES



%TRADUCTOR



% Ingles

sentence(s(S,V,O)) --> nom_p(S,N), verb(V,N), nom_p(O,_).
nom_p(np(M,S,A),N) --> modifier(M),adjective(A), noun(S,N).
nom_p(np(M,S),N) --> modifier(M), noun(S,N).
nom_p(np(S),N) --> noun(S,N).

modifier(m(art_1)) --> [the].
modifier(m(art_2)) --> [a].

noun(n(n_1),sg) --> [stone].
noun(n(n_2),sg) --> [paper].
noun(n(n_3),pl) --> [scissors].
noun(n(n_4),sg) --> [man].
noun(n(n_5),sg) --> [apple].
noun(n(n_6),pl) --> [some,apples].
noun(n(n_7),pl) --> [they].
noun(n(n_8),sg) --> [you].
noun(n(n_9),sg) --> [john].
noun(n(n_10),sg) --> [mary].

verb(v(v_1),sg) --> [cuts].
verb(v(v_2),sg) --> [wraps].
verb(v(v_3),sg) --> [breaks].
verb(v(v_4),sg) --> [eats].
verb(v(v_5),sg) --> [comes].
verb(v(v_6),sg) --> [eat].
verb(v(v_7),sg) --> [loves].

verb(v(v_1),pl) --> [cut].
verb(v(v_2),pl) --> [wrap].
verb(v(v_3),pl) --> [break].
verb(v(v_4),pl) --> [eat].

adjective(a(a_1))  --> [red].

% Espanol

oracion(s(S,V,O)) --> sint_n(S,N), verbo(V,N), sint_n(O,_).
sint_n(np(M,S,A),N) --> articulo(M,G,N), nombre(S,G,N), adjetivo(A,G,N).
sint_n(np(M,S),N) --> articulo(M,G,N), nombre(S,G,N).
sint_n(np(S),N) --> nombre(S,_,N).

articulo(m(art_1),f,sg) --> [la].
articulo(m(art_1),m,sg) --> [el].
articulo(m(art_1),f,pl) --> [las].
articulo(m(art_2),f,sg) --> [una].

nombre(n(n_1),f,sg) --> [piedra].
nombre(n(n_2),m,sg) --> [papel].
nombre(n(n_3),f,pl) --> [tijeras].
nombre(n(n_4),m,sg) --> [hombre].
nombre(n(n_5),f,sg) --> [manzana].
nombre(n(n_6),f,pl) --> [manzanas].
nombre(n(n_7),m,pl) --> [ellos].
nombre(n(n_8),m,sg) --> [tu].
nombre(n(n_9),m,sg) --> [juan].
nombre(n(n_10),f,sg) --> [maria].

verbo(v(v_1),sg) --> [corta].
verbo(v(v_2),sg) --> [envuelve].
verbo(v(v_3),sg) --> [rompe].
verbo(v(v_4),sg) --> [come].
verbo(v(v_6),sg) --> [comes].
verbo(v(v_7),sg) --> [ama,a].

verbo(v(v_1),pl) --> [cortan].
verbo(v(v_2),pl) --> [envuelven].
verbo(v(v_3),pl) --> [rompen].
verbo(v(v_4),pl) --> [comen].

adjetivo(a(a_1),f,sg) --> [roja].


%ejemplo e-i oracion(X,[las,tijeras,cortan,el,papel],[]),sentence(X,Ingles,[]),draw(X).
%sentence(X,[the,paper,wraps,the,stone],[]),oracion(X,Espanol,[]),draw(X).

%1. El hombre come una manzana
%oracion(X,[el, hombre, come, una, manzana],[]),sentence(X,Ingles,[]).
%sentence(X,[the,man,eats,an,apple],[]),oracion(X,Espanol,[]).

%2.  Ellos comen manzanas
%oracion(X,[ellos, comen, manzanas],[]),sentence(X,Ingles,[]).
%sentence(X,[they, eat, some, apples],[]),oracion(X,Espanol,[]).

%3.  Tu comes una manzana roja. - You eat a red apple.
%oracion(X,[tu,comes,una,manzana,roja],[]),sentence(X,Ingles,[]).
%sentence(X,[you,eat,a,red,apple],[]),oracion(X,Espanol,[]).


%4.  Juan ama a Maria. - John loves Mary
%oracion(X,[juan, ama,a,maria],[]),sentence(X,Ingles,[]).
%sentence(X,[john,loves,mary],[]),oracion(X,Espanol,[]).









%PARA EJECUTAR-> oracion(X,[juan, ama,a,maria],[]),sentence(X,Ingles,[]),draw(X).








