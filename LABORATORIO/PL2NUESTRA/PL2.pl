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

%Oracion simple
sentence(s(S,V,O)) --> nom_p(S,N,_,_,_), verb(V,N), nom_p(O,_,_,_,_).

%Oracion ama a
sentence(s(S,V,P2,O)) --> nom_p(S,N,_,_,_), verb(V,N), preposition2(P2), nom_p(O,_,_,_,_).


%Oraciones con sintagmas preposicionales
sentence(s(S,V,P,O)) --> nom_p(S,N,_,_,_), verb(V,N), preposition(P,E),nom_p(O,_,E,_,_).
sentence(s(S,V,P,T,O)) --> nom_p(S,N,_,_,_), verb(V,N),nom_p(T,_,_,_,_), preposition(P,E),nom_p(O,_,E,_,_).

%Oraciones coordinaads
sentence(s(S,V,O,C,V2,O2)) --> nom_p(S,N,_,_,_), verb(V,N), nom_p(O,_,_,_,_),conjunction(C),verb(V2,N), nom_p(O2,_,_,_,_).
sentence(s(S,V,A,C,O,V2,A2)) --> nom_p(S,N,_,T,_), verb(V,N), adjective(A,_,T), conjunction(C),nom_p(O,_,_,T,_),verb(V2,N), adjective(A2,_,T).

%Oracion simple con sintagma adjetival
sentence(s(S,V,A)) --> nom_p(S,N,_,T,_), verb(V,N),adjective(A,_,T).

%Oraciones simples con sintagmas adverbiales
sentence(s(S,V,B)) --> nom_p(S,N,_,_,_), verb(V,N),adverb(B).
sentence(s(S,V,B,B2)) --> nom_p(S,N,_,_,_), verb(V,N),adverb(B),adverb(B2).

%Oracion subordinada
sentence(s(S,Y,V,B,V2,O)) --> nom_p(S,N,_,T,_), pronoun(Y),verb(V,_),adverb(B),verb(V2,N),nom_p(O,_,_,T,_).


%Caso para some apples
nom_p(np(M2,S),N,E,_,_) --> modifier2(M2), noun(S,N,_,E,_,u).

%Para no poner at the universidad
nom_p(np(P,M3,S),N,E,_,C) --> preposition(P,C), modifier3(M3), noun(S,N,_,E,_,C).

%Para caso quitar the university de ama la universidad
nom_p(np(M3,S),N,E,_,C) --> modifier3(M3), noun(S,N,_,E,_,C).




nom_p(np(M,S,A),N,E,T,_) --> modifier(M,L),adjective(A,L,T), noun(S,N,_,E,T,_). %se pone _ al noun porque no se tiene en cuenta la vocal o consonante
nom_p(np(M,S),N,E,T,_) --> modifier(M,L), noun(S,N,L,E,T,_).
nom_p(np(S),N,E,T,_) --> noun(S,N,_,E,T,_).
nom_p(np(S,S2),N,E,T,_) --> noun(S,N,_,E,T,_),noun(S2,N,_,E,T,_).






modifier(m(art_1),c) --> [the].
modifier(m(art_1),v) --> [the].
modifier(m(art_2),c) --> [a].
modifier(m(art_2),v) --> [an].
modifier(m(art_3),v) --> [my].
modifier(m(art_3),c) --> [my].

modifier2(m2(art2_1)) --> [some].


modifier3(m3(art3_1)) --> [].

%Caso ama a
preposition2(p2(p2_1)) --> [].

%Habria que meter un parametro para los incontables para el caso del some  (co --> contable un--> incontable)
noun(n(n_1),sg,c,o,b,co) --> [stone].
noun(n(n_2),sg,c,o,b,co) --> [paper].
noun(n(n_3),pl,c,o,b,co) --> [scissors].
noun(n(n_4),sg,c,i,b,co) --> [man].
noun(n(n_5),sg,v,i,b,co) --> [apple].
noun(n(n_6),pl,v,i,b,u) --> [apples].
noun(n(n_7),pl,c,i,b,co) --> [they].
noun(n(n_8),sg,c,i,b,co) --> [you].
noun(n(n_9),sg,c,i,b,co) --> [john].
noun(n(n_10),sg,c,i,b,co) --> [mary].
noun(n(n_11),sg,c,i,b,co) --> [cat].
noun(n(n_12),sg,c,i,b,co) --> [mouse].
noun(n(n_13),sg,v,a,l,a) --> [university].
noun(n(n_14),sg,c,i,b,co) --> [student].
noun(n(n_15),sg,c,i,b,co) --> [dog].
noun(n(n_16),sg,c,i,l,co) --> [garden].
noun(n(n_17),pl,c,i,b,co) --> [we].
noun(n(n_18),sg,c,i,b,co) --> [neighbour].
noun(n(n_19),sg,c,i,b,co) --> [canary].
noun(n(n_20),sg,c,i,b,co) --> [coffee].
noun(n(n_21),sg,c,i,b,co) --> [newspaper].
noun(n(n_22),sg,c,i,b,co) --> [oscar].
noun(n(n_23),sg,c,i,b,co) --> [wilde].
noun(n(n_24),sg,c,i,b,co) --> [ghost].
noun(n(n_25),sg,c,i,b,co) --> [canterville].



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

%para disntiguir de preposicion ponemos y en vez de p
pronoun(y(y_1)) --> [that].

%Para distinguir que no ponga at the cuando es en el, y ponga at

preposition(p(p_1),a) --> [at].
preposition(p(p_1),i) --> [in].
preposition(p(p_1),o) --> [on].

conjunction(c(c_1))--> [and].

% Espanol
%Hay que annadir persona al verbo pri,seg,ter
%Annadir cuando es in y cuando at

%Oracion simple
oracion(s(S,V,O)) --> sint_n(S,N,_), verbo(V,N,_),sint_n(O,_,e).%probablemente haya que poner lo mismo pero con e2

%Oracion ama a
oracion(s(S,V,P2,O)) --> sint_n(S,N,_), verbo(V,N,t), preposicion2(P2,p), sint_n(O,_,p).

%Oraciones con sintagmas preposicionales
oracion(s(S,V,P,O)) --> sint_n(S,N,_), verbo(V,N,i), preposicion(P),sint_n(O,_,e).  %cambiar p
oracion(s(S,V,P,T,O)) --> sint_n(S,N,_), verbo(V,N,i),sint_n(T,_,_), preposicion(P),sint_n(O,_,_).

%Oraciones coordinadas
oracion(s(S,V,O,C,V2,O2)) --> sint_n(S,N,_), verbo(V,N,i),sint_n(O,_,_),conjuncion(C),verbo(V2,N,i),sint_n(O2,_,_).
oracion(s(S,V,A,C,O,V2,A2)) --> sint_n(S,N,_), verbo(V,N,i),adjetivo(A,_,N),conjuncion(C),sint_n(O,_,_),verbo(V2,N,i),adjetivo(A2,_,N).

%Oraciones con sintagmas adjetivales
oracion(s(S,V,A)) --> sint_n(S,N,_), verbo(V,N,i),adjetivo(A,_,N).

%Oraciones con sintagams adverbiales
oracion(s(S,V,B)) --> sint_n(S,N,_), verbo(V,N,i),adverbio(B).
oracion(s(S,V,B,B2)) --> sint_n(S,N,_), verbo(V,N,i),adverbio(B),adverbio(B2).

%Oracion subordinada
oracion(s(S,Y,V,B,V2,O)) --> sint_n(S,N,_), pronombre(Y),verbo(V,_,i),adverbio(B),verbo(V2,N,i),sint_n(O,_,_).

%Para distinguir cuando hay que poner some o no metemos un parametro de contable (c) o incontable(u)
%Controlar que no ponga la universidad (cambiando el at)
%oracion(s(S,V,P,O)) --> sint_n(S,N,_), verbo(V,N,i), preposicion(P),sint_n(O,_,_).


%Para caso de some apples
sint_n(np(M2,S),N,_) --> articulo2(M2,C), nombre(S,_,N,C,_).


%Para caso quitar the university
sint_n(np(P,M3,S),N,_) --> preposicion(P), articulo3(M3,C,_), nombre(S,_,N,C,_).


%Para caso quitar the university de ama la universidad
%sint_n(np(M3,S),N,_) --> articulo3(M3,C,e), nombre(S,_,N,C,e).



sint_n(np(M,S,A),N,_) --> articulo(M,G,N,C), nombre(S,G,N,C,_), adjetivo(A,G,N).
sint_n(np(M,S),N,TN) --> articulo(M,G,N,C), nombre(S,G,N,C,TN).
sint_n(np(S),N,TN) --> nombre(S,_,N,c,TN). %solo va a servir para los contables, por eso se mete la c
sint_n(np(S),N,TN) --> nombre(S,_,N,c2,TN). %solo va a servir para los contables, por eso se mete la c2
sint_n(np(S,S2),N,_) --> nombre(S,_,N,_,_),nombre(S2,_,N,_,_).




articulo(m(art_1),f,sg,c) --> [la].
articulo(m(art_1),f,sg,c2) --> [la].
articulo(m(art_1),m,sg,c) --> [el].
articulo(m(art_1),f,pl,c) --> [las].
articulo(m(art_2),f,sg,c) --> [una].
articulo(m(art_2),m,sg,c) --> [un].
articulo(m(art_2),f,pl,c) --> [unas].
articulo(m(art_2),m,pl,c) --> [unos].
articulo(m(art_3),m,sg,c) --> [mi].

%Para el some apples
articulo2(m2(art2_1),u) --> [].

articulo3(m3(art3_1),c2,e1) --> [la].



%Para ama a
preposicion2(p2(p2_1),p) --> [a].

%Para quitar el the de loves the university






%Hay que annadir otro parametro (TN) para que cuando se anombre propio (p) ponga ama a y cuando sea comun (e) ponga ama solo
%Annadimos otro parametro para que ponga ama la universidad y al contrario loves

nombre(n(n_1),f,sg,c,e) --> [piedra].
nombre(n(n_2),m,sg,c,e) --> [papel].
nombre(n(n_3),f,pl,c,e) --> [tijeras].
nombre(n(n_4),m,sg,c,e) --> [hombre].
nombre(n(n_5),f,sg,c,e) --> [manzana].
nombre(n(n_6),f,pl,u,e) --> [manzanas].
nombre(n(n_7),m,pl,c,p) --> [ellos].
nombre(n(n_8),m,sg,c,e) --> [tu].
nombre(n(n_9),m,sg,c,p) --> [juan].
nombre(n(n_10),f,sg,c,p) --> [maria].
nombre(n(n_11),m,sg,c,e) --> [gato].
nombre(n(n_12),m,sg,c,e) --> [raton].
nombre(n(n_13),f,sg,c2,e2) --> [universidad].
nombre(n(n_14),m,sg,c,e) --> [alumno].
nombre(n(n_15),m,sg,c,e) --> [perro].
nombre(n(n_16),m,sg,c,e) --> [jardin].
nombre(n(n_17),m,pl,c,e) --> [nosotros].
nombre(n(n_18),m,sg,c,e) --> [vecino].
nombre(n(n_19),m,sg,c,e) --> [canario].
nombre(n(n_20),m,sg,c,e) --> [cafe].
nombre(n(n_21),m,sg,c,e) --> [periodico].
nombre(n(n_22),m,sg,c,p) --> [oscar].
nombre(n(n_23),m,sg,c,p) --> [wilde].
nombre(n(n_24),m,sg,c,p) --> [fantasma].
nombre(n(n_25),m,sg,c,p) --> [canterville].


%Para distinguir cuando hay que poner a o no, metemos un parametro de transitivo (t) o intransitivo (in)
verbo(v(v_1),sg,i) --> [corta].
verbo(v(v_2),sg,i) --> [envuelve].
verbo(v(v_3),sg,i) --> [rompe].
verbo(v(v_4),sg,i) --> [come].
verbo(v(v_6),sg,i) --> [comes].
verbo(v(v_7),sg,t) --> [ama].
verbo(v(v_8),sg,i) --> [estudia].
verbo(v(v_9),sg,i) --> [persiguio].
verbo(v(v_10),sg,i) --> [es].
verbo(v(v_11),sg,i) --> [canta].
verbo(v(v_12),sg,i) --> [toma].
verbo(v(v_13),sg,i) --> [lee].
verbo(v(v_14),sg,i) --> [escribio].

verbo(v(v_1),pl,i) --> [cortan].
verbo(v(v_2),pl,i) --> [envuelven].
verbo(v(v_3),pl,i) --> [rompen].
verbo(v(v_4),pl,i) --> [comen].
verbo(v(v_15),pl,i) --> [vimos].


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

%Hay que controlar lo de some, perfecto
%2.  Ellos comen manzanas
%oracion(X,[ellos, comen, manzanas],[]),sentence(X,Ingles,[]).
%sentence(X,[they, eat, some, apples],[]),oracion(X,Espanol,[]).

%Funciona perfectamente
%3.  Tu comes una manzana roja. - You eat a red apple.
%oracion(X,[tu,comes,una,manzana,roja],[]),sentence(X,Ingles,[]).
%sentence(X,[you,eat,a,red,apple],[]),oracion(X,Espanol,[]).


%Falta controlar lo de a Maria, ya funciona
%4.  Juan ama a Maria. - John loves Mary
%oracion(X,[juan, ama,a,maria],[]),sentence(X,Ingles,[]).
%sentence(X,[john,loves,mary],[]),oracion(X,Espanol,[]).

%Funciona perfectamente
%5.  El gato grande come un raton gris. The big cat eats a grey mouse.
%oracion(X,[el,gato,grande,come,un,raton,gris],[]),sentence(X,Ingles,[]).
%sentence(X,[the, big, cat, eats, a, grey, mouse],[]),oracion(X,Espanol,[]).


%Falta controlar que no ponga el the, ya funciona
%6. Juan estudia en la universidad. - John studies at university.
%oracion(X,[juan,estudia,en,la,universidad],[]),sentence(X,Ingles,[]).
%sentence(X,[john,studies,at,university],[]),oracion(X,Espanol,[]).

 %Falta controlar que no ponga el the, hay que hacer algo para que no ponga ama a
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

%Falta lo del sujeto
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








%PARA EJECUTAR-> oracion(X,[juan, ama,a,maria],[]),sentence(X,Ingles,[])