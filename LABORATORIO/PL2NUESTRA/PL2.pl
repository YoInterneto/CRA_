% Author:
% Date: 04/04/2020


:-consult('draw.pl').
%REGLAS GRAMATICALES



%TRADUCTOR



% Ingles

%verb-->verbo, numero
%noun-->nombre, numero     %hay que annadir a noun y adjective si empieza por vocal o consonante L  (v,c)
%adjective--> adjetivo
%vocal->V consonante->C

%in-->i    at-->a     nos referimos con e (en)

%Para diferencia big y large, metemos un parametro nuevo en nombre y adjetivo big es para personas u objetos y large para espacios, lugares
%big -->b    large-->l  T de tamanno
%luego habra que hacer sintagma adverbial, preposicional...
sentence(s(S,V,P,O)) --> nom_p(S,N,_,_), verb(V,N), preposition(P,E),nom_p(O,_,E,_).
sentence(s(S,V,P,T,O)) --> nom_p(S,N,_,_), verb(V,N),nom_p(T,_,_,_), preposition(P,E),nom_p(O,_,E,_).
sentence(s(S,V,O)) --> nom_p(S,N,_,_), verb(V,N), nom_p(O,_,_,_).

sentence(s(S,V,O,C,V2,O2)) --> nom_p(S,N,_,_), verb(V,N), nom_p(O,_,_,_),conjunction(C),verb(V2,N), nom_p(O2,_,_,_).
sentence(s(S,V,A,C,O,V2,A2)) --> nom_p(S,N,_,T), verb(V,N), adjective(A,_,T), conjunction(C),nom_p(O,_,_,T),verb(V2,N), adjective(A2,_,T).

sentence(s(S,V,A)) --> nom_p(S,N,_,T), verb(V,N),adjective(A,_,T).
sentence(s(S,V,B)) --> nom_p(S,N,_,_), verb(V,N),adverb(B).
sentence(s(S,V,B,B2)) --> nom_p(S,N,_,_), verb(V,N),adverb(B),adverb(B2).
%sentence(s(S,Y,V,B,A)) --> nom_p(S,N,_,T),pronoun(Y), verb(V,N),adverb(B),verb(V,N),adjective(A,_,T).

sentence(s(S,Y,V,B,V2,O)) --> nom_p(S,N,_,T), pronoun(Y),verb(V,_),adverb(B),verb(V2,N),nom_p(O,_,_,T).
%sentence(s(S,Y,V,B)) --> nom_p(S,N,_,T), pronoun(Y),verb(V,N),adverb(B).

nom_p(np(M,S,A),N,E,T) --> modifier(M,L),adjective(A,L,T), noun(S,N,_,E,T). %se pone _ al noun porque no se tiene en cuenta la vocal o consonante
nom_p(np(M,S),N,E,T) --> modifier(M,L), noun(S,N,L,E,T).
nom_p(np(S),N,E,T) --> noun(S,N,_,E,T).
nom_p(np(S,S2),N,E,T) --> noun(S,N,_,E,T),noun(S2,N,_,E,T).


%nom_p(np(P,M,S,A),N) --> preposition(P),modifier(M,L),adjective(A,L), noun(S,N,_). %se pone _ al noun porque no se tiene en cuenta la vocal o consonante
%nom_p(np(P,M,S),N) --> preposition(P),modifier(M,L), noun(S,N,L).
%nom_p(np(P,S),N) --> preposition(P),noun(S,N,_).
%nom_p(np(M,S,A),N) --> modifier(M,L),adjective(A,L), noun(S,N,_),preposition(P),modifier(M,L),noun(S,N,L).



modifier(m(art_1),c) --> [the].
modifier(m(art_1),v) --> [the].
modifier(m(art_2),c) --> [a].
modifier(m(art_2),v) --> [an].
modifier(m(art_3),v) --> [my].
modifier(m(art_3),c) --> [my].

noun(n(n_1),sg,c,o,b) --> [stone].
noun(n(n_2),sg,c,o,b) --> [paper].
noun(n(n_3),pl,c,o,b) --> [scissors].
noun(n(n_4),sg,c,i,b) --> [man].
noun(n(n_5),sg,v,i,b) --> [apple].
noun(n(n_6),pl,c,i,b) --> [apples].
noun(n(n_7),pl,c,i,b) --> [they].
noun(n(n_8),sg,c,i,b) --> [you].
noun(n(n_9),sg,c,i,b) --> [john].
noun(n(n_10),sg,c,i,b) --> [mary].
noun(n(n_11),sg,c,i,b) --> [cat].
noun(n(n_12),sg,c,i,b) --> [mouse].
noun(n(n_13),sg,v,a,l) --> [university].
noun(n(n_14),sg,c,i,b) --> [student].
noun(n(n_15),sg,c,i,b) --> [dog].
noun(n(n_16),sg,c,i,l) --> [garden].
noun(n(n_17),pl,c,i,b) --> [we].
noun(n(n_18),sg,c,i,b) --> [neighbour].
noun(n(n_19),sg,c,i,b) --> [canary].
noun(n(n_20),sg,c,i,b) --> [coffee].
noun(n(n_21),sg,c,i,b) --> [newspaper].
noun(n(n_22),sg,c,i,b) --> [oscar].
noun(n(n_23),sg,c,i,b) --> [wilde].
noun(n(n_24),sg,c,i,b) --> [ghost].
noun(n(n_25),sg,c,i,b) --> [canterville].



verb(v(v_1),sg) --> [cuts].
verb(v(v_2),sg) --> [wraps].
verb(v(v_3),sg) --> [breaks].
verb(v(v_4),sg) --> [eats].
verb(v(v_5),sg) --> [eat].
verb(v(v_6),sg) --> [eat].
verb(v(v_7),sg) --> [loves].
verb(v(v_8),sg) --> [studies].
verb(v(v_9),sg) --> [chased].
verb(v(v_10),sg) --> [is].
verb(v(v_11),sg) --> [sings].
verb(v(v_12),sg) --> [has].
verb(v(v_13),sg) --> [reads].
verb(v(v_14),sg) --> [wrote].

verb(v(v_1),pl) --> [cut].
verb(v(v_2),pl) --> [wrap].
verb(v(v_3),pl) --> [break].
verb(v(v_4),pl) --> [eat].
verb(v(v_15),pl) --> [saw].


adjective(a(a_1),c,b)  --> [red].
adjective(a(a_2),c,b)  --> [grey].
adjective(a(a_3),c,b)  --> [big].
adjective(a(a_3),c,l)  --> [large].
adjective(a(a_4),c,b)  --> [black].
adjective(a(a_5),c,b)  --> [yellow].
adjective(a(a_6),c,b)  --> [thin].
adjective(a(a_7),c,b)  --> [tall].

adverb(b(b_1)) --> [yesterday].
adverb(b(b_2)) --> [well].
adverb(b(b_3)) --> [very].

%para disntiguir de preoposicion
pronoun(y(y_1)) --> [that].

preposition(p(p_1),a) --> [at].
preposition(p(p_1),i) --> [in].
preposition(p(p_1),o) --> [on].

conjunction(c(c_1))--> [and].

% Espanol
%Hay que annadir persona al verbo pri,seg,ter
%Annadir cuando es in y cuando at


oracion(s(S,V,P,O)) --> sint_n(S,N), verbo(V,N), preposicion(P),sint_n(O,_).
oracion(s(S,V,P,T,O)) --> sint_n(S,N), verbo(V,N),sint_n(T,_), preposicion(P),sint_n(O,_).

oracion(s(S,V,O,C,V2,O2)) --> sint_n(S,N), verbo(V,N),sint_n(O,_),conjuncion(C),verbo(V2,N),sint_n(O2,_).
oracion(s(S,V,A,C,O,V2,A2)) --> sint_n(S,N), verbo(V,N),adjetivo(A,_,N),conjuncion(C),sint_n(O,_),verbo(V2,N),adjetivo(A2,_,N).

oracion(s(S,V,O)) --> sint_n(S,N), verbo(V,N),sint_n(O,_).
oracion(s(S,V,A)) --> sint_n(S,N), verbo(V,N),adjetivo(A,_,N).
oracion(s(S,V,B)) --> sint_n(S,N), verbo(V,N),adverbio(B).
oracion(s(S,V,B,B2)) --> sint_n(S,N), verbo(V,N),adverbio(B),adverbio(B2).

oracion(s(S,Y,V,B,V2,O)) --> sint_n(S,N), pronombre(Y),verbo(V,_),adverbio(B),verbo(V2,N),sint_n(O,_).
%oracion(s(S,Y,V,B)) --> sint_n(S,N), pronombre(Y),verbo(V,N),adverbio(B).

sint_n(np(M,S,A),N) --> articulo(M,G,N), nombre(S,G,N), adjetivo(A,G,N).
sint_n(np(M,S),N) --> articulo(M,G,N), nombre(S,G,N).
sint_n(np(S),N) --> nombre(S,_,N).
sint_n(np(S,S2),N) --> nombre(S,_,N),nombre(S2,_,N).

%sint_n(np(P,M,S,A),N) --> preposicion(P),articulo(M,G,N), nombre(S,G,N), adjetivo(A,G,N).
%sint_n(np(P,M,S),N) --> preposicion(P),articulo(M,G,N), nombre(S,G,N).
%sint_n(np(P,S),N) --> preposicion(P),nombre(S,_,N).
%sint_n(np(P,S),N) --> preposicion(P),sint_n(S,N).
%sint_n(np(P,M,S,A),N) --> articulo(M,G,N), nombre(S,G,N), adjetivo(A,G,N),preposicion(P), articulo(M,G,N), nombre(S,G,N).

articulo(m(art_1),f,sg) --> [la].
articulo(m(art_1),m,sg) --> [el].
articulo(m(art_1),f,pl) --> [las].
articulo(m(art_2),f,sg) --> [una].
articulo(m(art_2),m,sg) --> [un].
articulo(m(art_2),f,pl) --> [unas].
articulo(m(art_2),m,pl) --> [unos].
articulo(m(art_3),m,sg) --> [mi].


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
nombre(n(n_11),m,sg) --> [gato].
nombre(n(n_12),m,sg) --> [raton].
nombre(n(n_13),f,sg) --> [universidad].
nombre(n(n_14),m,sg) --> [alumno].
nombre(n(n_15),m,sg) --> [perro].
nombre(n(n_16),m,sg) --> [jardin].
nombre(n(n_17),m,pl) --> [nosotros].
nombre(n(n_18),m,sg) --> [vecino].
nombre(n(n_19),m,sg) --> [canario].
nombre(n(n_20),m,sg) --> [cafe].
nombre(n(n_21),m,sg) --> [periodico].
nombre(n(n_22),m,sg) --> [oscar].
nombre(n(n_23),m,sg) --> [wilde].
nombre(n(n_24),m,sg) --> [fantasma].
nombre(n(n_25),m,sg) --> [canterville].


verbo(v(v_1),sg) --> [corta].
verbo(v(v_2),sg) --> [envuelve].
verbo(v(v_3),sg) --> [rompe].
verbo(v(v_4),sg) --> [come].
verbo(v(v_6),sg) --> [comes].
verbo(v(v_7),sg) --> [ama].
verbo(v(v_8),sg) --> [estudia].
verbo(v(v_9),sg) --> [persiguio].
verbo(v(v_10),sg) --> [es].
verbo(v(v_11),sg) --> [canta].
verbo(v(v_12),sg) --> [toma].
verbo(v(v_13),sg) --> [lee].
verbo(v(v_14),sg) --> [escribio].

verbo(v(v_1),pl) --> [cortan].
verbo(v(v_2),pl) --> [envuelven].
verbo(v(v_3),pl) --> [rompen].
verbo(v(v_4),pl) --> [comen].
verbo(v(v_15),pl) --> [vimos].


adjetivo(a(a_1),f,sg) --> [roja].
adjetivo(a(a_2),m,sg) --> [gris].
adjetivo(a(a_3),m,sg) --> [grande].
adjetivo(a(a_4),m,sg) --> [negro].
adjetivo(a(a_5),m,sg) --> [amarillo].
adjetivo(a(a_6),m,sg) --> [delgado].
adjetivo(a(a_7),f,sg) --> [alta].


%se llama b para disntiguirlo del a de adjetivo
adverbio(b(b_1)) --> [ayer].
adverbio(b(b_2)) --> [bien].
adverbio(b(b_3)) --> [muy].

pronombre(y(y_1)) --> [que].

preposicion(p(p_1)) --> [en].

conjuncion(c(c_1))--> [y].


%ejemplo e-i oracion(X,[las,tijeras,cortan,el,papel],[]),sentence(X,Ingles,[]),draw(X).
%sentence(X,[the,paper,wraps,the,stone],[]),oracion(X,Espanol,[]),draw(X).

%Controlada perfectamente
%1. El hombre come una manzana
%oracion(X,[el, hombre, come, una, manzana],[]),sentence(X,Ingles,[]).
%sentence(X,[the,man,eats,an,apple],[]),oracion(X,Espanol,[]).

%Hay que controlar lo de some
%2.  Ellos comen manzanas
%oracion(X,[ellos, comen, manzanas],[]),sentence(X,Ingles,[]).
%sentence(X,[they, eat, some, apples],[]),oracion(X,Espanol,[]).

%Funciona perfectamente
%3.  Tu comes una manzana roja. - You eat a red apple.
%oracion(X,[tu,comes,una,manzana,roja],[]),sentence(X,Ingles,[]).
%sentence(X,[you,eat,a,red,apple],[]),oracion(X,Espanol,[]).


%Falta controlar lo de a Maria
%4.  Juan ama a Maria. - John loves Mary
%oracion(X,[juan, ama,a,maria],[]),sentence(X,Ingles,[]).
%sentence(X,[john,loves,mary],[]),oracion(X,Espanol,[]).

%Funciona perfectamente
%5.  El gato grande come un raton gris. The big cat eats a grey mouse.
%oracion(X,[el,gato,grande,come,un,raton,gris],[]),sentence(X,Ingles,[]).
%sentence(X,[the, big, cat, eats, a, grey, mouse],[]),oracion(X,Espanol,[]).


%Falta controlar que no ponga el the
%6. Juan estudia en la universidad. - John studies at university.
%oracion(X,[juan,estudia,en,la,universidad],[]),sentence(X,Ingles,[]).
%sentence(X,[john,studies,at,university],[]),oracion(X,Espanol,[]).

 %Falta controlar que no ponga el the
%7.  El alumno ama la universidad. - The student loves university.
%oracion(X,[el,alumno,ama,la,universidad],[]),sentence(X,Ingles,[]).
%sentence(X,[the,student,loves,university],[]),oracion(X,Espanol,[]).

%Funciona bien
%8. El perro persiguio un gato negro en el jardin. - The dog chased a black cat in the garden.
%oracion(X,[el,perro,persiguio,un,gato,negro,en,el,jardin],[]),sentence(X,Ingles,[]).
%sentence(X,[the, dog, chased, a, black, cat, in, the, garden],[]),oracion(X,Espanol,[]).

%Funciona perfectamente
%9.  La Universidad es grande. - The University is large.
%oracion(X,[la, universidad, es, grande],[]),sentence(X,Ingles,[]).
%sentence(X,[the,university,is,large],[]),oracion(X,Espanol,[]).

%Con la calma
%10. El hombre que vimos ayer es mi vecino. - The man that we saw yesterday is my neighbour.
%oracion(X,[el,hombre,que,vimos,ayer,es,mi,vecino],[]),sentence(X,Ingles,[]).
%sentence(X,[the,man,that,we,saw,yesterday,is,my,neighbour],[]),oracion(X,Espanol,[]).

%Funciona perfectamente
%11. El canario amarillo canta muy bien. - The yellow canary sings very well.
%oracion(X,[el,canario,amarillo,canta,muy,bien],[]),sentence(X,Ingles,[]).
%sentence(X,[the, yellow, canary, sings, very, well],[]),oracion(X,Espanol,[]).

%Funciona perfectamente
%12.  Juan toma un cafe y lee el periodico. - John has a co?ee and reads the newspaper.
%oracion(X,[juan,toma,un,cafe,y,lee,el,periodico],[]),sentence(X,Ingles,[]).
%sentence(X,[john, has, a, coffee, and, reads, the, newspaper],[]),oracion(X,Espanol,[]).

%Funciona perfectamente
%13. Juan es delgado y Maria es alta. - John is thin and Mary is tall.
% oracion(X,[juan,es,delgado,y,maria,es,alta],[]),sentence(X,Ingles,[]).
%sentence(X,[john, is,thin,and,mary,is,tall],[]),oracion(X,Espanol,[]).

%Falta comprobar quitar el de
%14. Oscar Wilde escribio El Fantasma de Canterville - Oscar Wilde wrote The Canterville Ghost.
% oracion(X,[oscar,wilde,escribio,el,fantasma,de,canterville],[]),sentence(X,Ingles,[]).
% sentence(X,[oscar,wilde,wrote,the,canterville,ghost],[]),oracion(X,Espanol,[]).








%PARA EJECUTAR-> oracion(X,[juan, ama,a,maria],[]),sentence(X,Ingles,[]),draw(X).








