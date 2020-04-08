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






%Oracion compuesta   coordinada
compound_sentence(os(O1,C,O2)) --> sentence(O1),conjunction(C),sentence(O2).

%Oracion compuesta subordinada
compound_sentence(os(O1,O2)) --> sentence(O1),sentence(O2).



%Oracion simple
sentence(s(S,V,O)) --> nom_p(S,N,_,_,_,n), verb(V,N), nom_p(O,_,_,_,_,_).

%Caso para coordinada
sentence(s(V,O)) --> verb(V,_),nom_p(O,_,_,_,_,_).

%Oracion con prep
sentence(s(S,V,O)) --> nom_p(S,N,_,_,_,n), verb(V,N), nom_prep(O,_,_,_,_,s).

%Oracion ama a
%sentence(s(S,V,O)) --> nom_p(S,N,_,_,_), verb(V,N), nom_p(O,_,_,_,_).


%Oraciones con sintagmas preposicionales
sentence(s(S,V,P,O)) --> nom_p(S,N,_,_,_,n), verb(V,N), preposition(P,E),nom_p(O,_,E,_,_,n).
%sentence(s(S,V,P,T,O)) --> nom_p(S,N,_,_,_), verb(V,N),nom_p(T,_,_,_,_), preposition(P,E),nom_p(O,_,E,_,_).

sentence(s(S,V,T,O)) --> nom_p(S,N,_,_,_,n), verb(V,N),nom_p(T,_,_,_,_,n), nom_prep(O,_,_,_,_,n).

%Oraciones coordinaads
%sentence(s(S,V,O,C,V2,O2)) --> nom_p(S,N,_,_,_,n), verb(V,N), nom_p(O,_,_,_,_,n),conjunction(C),verb(V2,N), nom_p(O2,_,_,_,_,n).
%sentence(s(S,V,A,C,O,V2,A2)) --> nom_p(S,N,_,T,_,n), verb(V,N), adjective(A,_,T), conjunction(C),nom_p(O,_,_,T,_,n),verb(V2,N), adjective(A2,_,T).

sentence(s(S,V,A)) --> nom_p(S,N,_,T,_,n), verb(V,N), adjective(A,_,T).

%Oracion simple con sintagma adjetival
%sentence(s(S,V,A)) --> nom_p(S,N,_,T,_,n), verb(V,N),adjective(A,_,T).

%Oraciones simples con sintagmas adverbiales
sentence(s(S,V,B)) --> nom_p(S,N,_,_,_,n), verb(V,N),nom_adv(B).
%sentence(s(S,V,B)) --> nom_p(S,N,_,_,_,n), verb(V,N),nom_adv(B).

%Oracion subordinada
sentence(s(S,Y,V,B)) --> nom_p(S,N,_,T,_,n), pronoun(Y),noun(n(n_17),pl,c,i,b,co),verb(V,_),nom_adv(B).

%sentence(s(S,Y,V,B,V2,O)) --> nom_p(S,N,_,T,_,n), pronoun(Y),noun(n(n_17),pl,c,i,b,co),verb(V,_),adverb(B),verb(V2,N),nom_p(O,_,_,T,_,n).


%Caso para some apples
%nom_p(np(S),N,E,_,_) --> modifier2(m2(art2_1)), noun(S,N,_,E,_,u).

%CASO NOSOTROS VIMOS*******************************************




%Caso para some apples
%nom_p(np(M2,S),N,E,_,_) --> modifier2(M2), noun(S,N,_,E,_,u).
nom_p(np(S),N,E,_,_,n) --> modifier2(m2(art2_1)), noun(S,N,_,E,_,u).

%Para no poner at the universidad, tambien vale para la 7 , suponemos que no vale
nom_p(np(S),N,E,_,C,s) --> noun(S,N,_,E,l,C).

%suponemos que no vale
%nom_p(np(S),N,E,_,C,s) --> noun(S,N,_,E,l,C).



%Caso para la 9
%METEMOS UN PARAMETRO NUEVO EN nom_p POR SI LLEVA ALGO ANTES, SI LLEVA(s), NO SE PONE EL THE, SINO SI SE PONE(n)
nom_p(np(M,S),N,E,T,_,n) --> modifier(M,c), noun(S,N,v,E,T,a).   %caso pregunta 9





%Para caso quitar the university de ama la universidad
%nom_p(np(M3,S),N,E,_,C) --> modifier3(M3), noun(S,N,_,E,_,C).






nom_p(np(M,S,A),N,E,T,_,n) --> modifier(M,L),adjective(A,L,T), noun(S,N,_,E,T,_). %se pone _ al noun porque no se tiene en cuenta la vocal o consonante
nom_p(np(M,S),N,E,T,co,n) --> modifier(M,L), noun(S,N,L,E,T,co).
nom_p(np(S),N,E,T,_,n) --> noun(S,N,_,E,T,co).
%nom_p(np(S),N,E,T,_) --> noun(S,N,_,E,T,a).
nom_p(np(S,S2),N,E,T,_,n) --> noun(S,N,_,E,T,_),noun(S2,N,_,E,T,_).

%nom_prep(nprep(P,S),N,E,_,C) --> preposition(P,C), noun(S,N,_,E,_,C).
nom_prep(nprep(P,O),_,E,_,C,F) --> preposition(P,E), nom_p(O,_,E,_,C,F).

%Sintagma adverbial
nom_adv(sadv(B)) --> adverb(B).
nom_adv(sadv(B,B2)) --> adverb(B),adverb(B2).

%nom_prep(nprep(P,O),_,E,_,C) --> preposition(P,E),nom_p(O,_,E,_,_).



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

%Caso poner sujeto
%noun2(n2(n2_1)) --> [we].

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
noun(n(n_22),sg,c,i,b,co) --> [oscar,wilde].
%noun(n(n_23),sg,c,i,b,co) --> [wilde].
noun(n(n_24),sg,c,i,b,co) --> [canterville, ghost].
%noun(n(n_25),sg,c,i,b,co) --> [canterville].





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


%Oracion compuesta
oracion_compuesta(os(O1,C,O2)) -->oracion(O1),conjuncion(C),oracion(O2).

%Oracion compuesta subordinada
oracion_compuesta(os(O1,O2)) -->oracion(O1),oracion(O2).

%Oracion simple
oracion(s(S,V,O)) --> sint_n(S,N,_,n), verbo(V,N,_),sint_n(O,_,e,_).%probablemente haya que poner lo mismo pero con e2
%Caso para coordinada
oracion(s(V,O)) --> verbo(V,_,_),sint_n(O,_,e,_).


%Oracion con prep
oracion(s(S,V,O)) --> sint_n(S,N,_,n), verbo(V,N,_),sint_prep(O,_,e,_).

%Oracion ama a
oracion(s(S,V,O)) --> sint_n(S,N,_,n), verbo(V,N,t), preposicion2(p2(p2_1),p), sint_n(O,_,p,n).


%Oracion ama la universidad,
oracion(s(S,V,O)) --> sint_n(S,N,_,n), verbo(V,N,t), sint_n(O,_,e2,s).

%Oraciones con sintagmas preposicionales
%oracion(s(S,V,P,O)) --> sint_n(S,N,_), verbo(V,N,i), preposicion(P),sint_n(O,_,e).  %cambiar p
%oracion(s(S,V,P,T,O)) --> sint_n(S,N,_), verbo(V,N,i),sint_n(T,_,_), preposicion(P),sint_n(O,_,_).

oracion(s(S,V,T,O)) --> sint_n(S,N,_,n), verbo(V,N,i),sint_n(T,_,_,n), sint_prep(O,_,e,n).


%Oraciones coordinadas
%oracion(s(S,V,O,C,V2,O2)) --> sint_n(S,N,_,n), verbo(V,N,i),sint_n(O,_,_,n),conjuncion(C),verbo(V2,N,i),sint_n(O2,_,_,n).
oracion(s(S,V,A,C,O,V2,A2)) --> sint_n(S,N,_,n), verbo(V,N,i),adjetivo(A,_,N),conjuncion(C),sint_n(O,_,_,n),verbo(V2,N,i),adjetivo(A2,_,N).

%Oraciones con sintagmas adjetivales
%oracion(s(S,V,A)) --> sint_n(S,N,_,n), verbo(V,N,i),adjetivo(A,_,N).
oracion(s(S,V,A)) --> sint_n(S,N,p,n), verbo(V,N,i),adjetivo(A,_,N).

%Caso la universidad es grande
oracion(s(S,V,A)) --> sint_n(S,N,e2,n), verbo(V,N,i),adjetivo(A,_,N).

%Oraciones con sintagams adverbiales
oracion(s(S,V,B)) --> sint_n(S,N,_,n), verbo(V,N,i),sint_adv(B).
%oracion(s(S,V,B)) --> sint_n(S,N,_,n), verbo(V,N,i),sint_adv(B).

%Oracion subordinada
%oracion(s(S,Y,S2,V,B,V2,O)) --> sint_n(S,N,_,n), pronombre(Y),sint_n(S2,_,_,n),verbo(V,_,i),adverbio(B),verbo(V2,N,i),sint_n(O,_,_,n).
%oracion(s(S,Y,V,B,V2,O)) --> sint_n(S,N,s2,n), pronombre(Y),verbo(V,_,i),adverbio(B),verbo(V2,N,i),sint_n(O,_,_,n).
oracion(s(S,Y,V,B)) --> sint_n(S,N,s2,n), pronombre(Y),verbo(V,_,i),sint_adv(B).



%Para distinguir cuando hay que poner some o no metemos un parametro de contable (c) o incontable(u)
%Controlar que no ponga la universidad (cambiando el at)
%oracion(s(S,V,P,O)) --> sint_n(S,N,_), verbo(V,N,i), preposicion(P),sint_n(O,_,_).

%CASO NOSOTROS VIMOS*******************************************




%Para caso de some apples
%sint_n(np(M2,S),N,_) --> nombre(S,_,N,C,_).
sint_n(np(S),_,e,n) --> nombre(S,_,_,u,e).

%PREGUNTA 9
%METEMOS UN PARAMETRO NUEVO EN SINT_N POR SI LLEVA ALGO ANTES, SI LLEVA(s), NO SE PONE EL THE, SINO SI SE PONE(n)


%Para caso quitar the university, tambien vale para la 7
sint_n(np(S),N,e2,s) --> articulo3(m3(art3_1),c2,e2), nombre(S,_,N,_,e2).
 %nom_p(np(S),N,E,_,_) --> modifier2(m2(art2_1)), noun(S,N,_,E,_,u).
 
sint_n(np(M,S),N,e2,n) --> articulo(M,f,sg,c), nombre(S,_,N,_,e2).   %caso pregunta 9


%Para caso quitar the university de ama la universidad
%sint_n(np(M3,S),N,e2) --> articulo3(M3,C,e2), nombre(S,_,N,C,e2).



sint_n(np(M,S,A),N,_,n) --> articulo(M,G,N,C), nombre(S,G,N,C,_), adjetivo(A,G,N).
sint_n(np(M,S),N,_,n) --> articulo(M,G,N,C), nombre(S,G,N,C,e).

sint_n(np(S),N,e,n) --> nombre(S,_,N,c,e). %solo va a servir para los contables, por eso se mete la c
sint_n(np(S),N,p,n) --> nombre(S,_,N,c,p).
%sint_n(np(S),N,e2) --> nombre(S,_,N,c2,e2). %solo va a servir para los contables, por eso se mete la c2 ****************************************
sint_n(np(S,S2),N,_,n) --> nombre(S,_,N,_,_),nombre(S2,_,N,_,_).

 %Sintagma_prep
%sint_prep(nprep(P,S),N,_) --> preposicion(P), articulo3(m3(art3_1),c2,e2), nombre(S,_,N,C,_).
sint_prep(nprep(P,O),_,_,F) --> preposicion(P), sint_n(O,_,e2,F).

%sint_prep(nprep(P,O),_,_) --> preposicion(P),sint_n(O,_,_).

%Sintagma adverbial
sint_adv(sadv(B)) --> adverbio(B).
sint_adv(sadv(B,B2)) --> adverbio(B),adverbio(B2).


articulo(m(art_1),f,sg,c) --> [la].
articulo(m(art_1),m,sg,c) --> [el].
articulo(m(art_1),f,pl,c) --> [las].
articulo(m(art_2),f,sg,c) --> [una].
articulo(m(art_2),m,sg,c) --> [un].
articulo(m(art_2),f,pl,c) --> [unas].
articulo(m(art_2),m,pl,c) --> [unos].
articulo(m(art_3),m,sg,c) --> [mi].

%Para el some apples
articulo2(m2(art2_1),u) --> [].

articulo3(m3(art3_1),c2,e2) --> [la].



%Para ama a
preposicion2(p2(p2_1),p) --> [a].




%Caso poner sujeto
%nombre2(n2(n2_1)) --> [].


%Hay que annadir otro parametro (TN) para que cuando se anombre propio (p) ponga ama a y cuando sea comun (e) ponga ama solo
%Annadimos otro parametro para que ponga ama la universidad y al contrario loves
%Para la universidad es grande, hay que controlar que ponga la universidad por lo que quizas tendremos que hacer otro tipo que sea nombre2

%lE METEMOS OTRO PARAMETRO PARA CUANDO SE PUEDA OMITIR (o) Y CUANDO NO (no)     para la subordinada, luego vemos
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
nombre(n(n_17),m,pl,c,so) --> [nosotros].
nombre(n(n_18),m,sg,c,e) --> [vecino].
nombre(n(n_19),m,sg,c,e) --> [canario].
nombre(n(n_20),m,sg,c,e) --> [cafe].
nombre(n(n_21),m,sg,c,e) --> [periodico].
nombre(n(n_22),m,sg,c,e) --> [oscar,wilde].
%nombre(n(n_23),m,sg,c,p) --> [wilde].
nombre(n(n_24),m,sg,c,e) --> [fantasma,de,canterville].
%nombre(n(n_25),m,sg,c,p) --> [canterville].


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

%Perfecta
%1. El hombre come una manzana     , bieeen
%oracion(X,[el, hombre, come, una, manzana],[]),sentence(X,Ingles,[]).
%sentence(X,[the,man,eats,an,apple],[]),oracion(X,Espanol,[]).

%Perfecta, revisar arbol
%2.  Ellos comen manzanas
%oracion(X,[ellos, comen, manzanas],[]),sentence(X,Ingles,[]).
%sentence(X,[they, eat, some, apples],[]),oracion(X,Espanol,[]).

%Perfecta
%3.  Tu comes una manzana roja. - You eat a red apple., bieeen
%oracion(X,[tu,comes,una,manzana,roja],[]),sentence(X,Ingles,[]).
%sentence(X,[you,eat,a,red,apple],[]),oracion(X,Espanol,[]).


%Perfecta, controlar arbol
%4.  Juan ama a Maria. - John loves Mary
%oracion(X,[juan, ama,a,maria],[]),sentence(X,Ingles,[]).
%sentence(X,[john,loves,mary],[]),oracion(X,Espanol,[]).

%Perfecta
%5.  El gato grande come un raton gris. The big cat eats a grey mouse.
%oracion(X,[el,gato,grande,come,un,raton,gris],[]),sentence(X,Ingles,[]).
%sentence(X,[the, big, cat, eats, a, grey, mouse],[]),oracion(X,Espanol,[]).


%Perfecta, controlar arbol
%6. Juan estudia en la universidad. - John studies at university.
%oracion(X,[juan,estudia,en,la,universidad],[]),sentence(X,Ingles,[]).
%sentence(X,[john,studies,at,university],[]),oracion(X,Espanol,[]).

%Perfecta, controlar arbol
%7.  El alumno ama la universidad. - The student loves university.
%oracion(X,[el,alumno,ama,la,universidad],[]),sentence(X,Ingles,[]).
%sentence(X,[the,student,loves,university],[]),oracion(X,Espanol,[]).

%Perfecta
%8. El perro persiguio un gato negro en el jardin. - The dog chased a black cat in the garden.
%oracion(X,[el,perro,persiguio,un,gato,negro,en,el,jardin],[]),sentence(X,Ingles,[]).
%sentence(X,[the, dog, chased, a, black, cat, in, the, garden],[]),oracion(X,Espanol,[]).

%Perfecta
%9.  La Universidad es grande. - The University is large.
%oracion(X,[la, universidad, es, grande],[]),sentence(X,Ingles,[]).
%sentence(X,[the,university,is,large],[]),oracion(X,Espanol,[]).

%Perfecta, falta el arbol
%10. El hombre que vimos ayer es mi vecino. - The man that we saw yesterday is my neighbour.
%oracion(X,[el,hombre,que,vimos,ayer,es,mi,vecino],[]),sentence(X,Ingles,[]).
%sentence(X,[the,man,that,we,saw,yesterday,is,my,neighbour],[]),oracion(X,Espanol,[]).


%oracion_compuesta(X,[el,hombre,que,vimos,ayer,es,mi,vecino],[]),compound_sentence(X,Ingles,[]).
%compound_sentence(X,[the,man,that,we,saw,yesterday,is,my,neighbour],[]),oracion_compuesta(X,Espanol,[]).

%oracion(X,[vimos,una,manzana],[]),sentence(X,Ingles,[]).
%sentence(X,[we,saw,an,apple],[]),oracion(X,Espanol,[]).

%Perfecta
%11. El canario amarillo canta muy bien. - The yellow canary sings very well.
%oracion(X,[el,canario,amarillo,canta,muy,bien],[]),sentence(X,Ingles,[]).
%sentence(X,[the, yellow, canary, sings, very, well],[]),oracion(X,Espanol,[]).

%Perfecta
%12.  Juan toma un cafe y lee el periodico. - John has a co?ee and reads the newspaper.
%oracion_compuesta(X,[juan,toma,un,cafe,y,lee,el,periodico],[]),compound_sentence(X,Ingles,[]).
%compound_sentence(X,[john, has, a, coffee, and, reads, the, newspaper],[]),oracion_compuesta(X,Espanol,[]).

%Perfecta
%13. Juan es delgado y Maria es alta. - John is thin and Mary is tall.
%oracion_compuesta(X,[juan,es,delgado,y,maria,es,alta],[]),compound_sentence(X,Ingles,[]).
%compound_sentence(X,[john, is,thin,and,mary,is,tall],[]),oracion_compuesta(X,Espanol,[]).

%Perfecta, comprobar
%14. Oscar Wilde escribio El Fantasma de Canterville - Oscar Wilde wrote The Canterville Ghost.
% oracion(X,[oscar,wilde,escribio,el,fantasma,de,canterville],[]),sentence(X,Ingles,[]).
% sentence(X,[oscar,wilde,wrote,the,canterville,ghost],[]),oracion(X,Espanol,[]).


