% Autor:
% Fecha: 26/05/2020

union1([],L,L).
%union1([X|L1],L2,L3) :- pertenece(X,L2),union1(L1,L2,L3).
%union1([X|L1],L2,L3) :- union1(L1,[X|L2],L3).
%pertenece(X,[X|_]).
%pertenece(X,[_|L]) :- pertenece(X,L).


%subconjunto(L, L2).
subconjunto([C|R],L2):- pertenece(C, L2), subconjunto(R, L2).
subconjunto([],_).


reverseL(L, L1):- reverse_aux(L, L1, []).
reverse_aux([X|R], L1, Laux):- reverse_aux(R, L1, [X|Laux]).
reverse_aux([], Laux, Laux).

cambiar(X,Y,L,L1):- reverseL(L, LOUT), cambiar_aux(X,Y,LOUT,L1, []).
cambiar_aux(X,Y,[X|R],L1,Laux):- cambiar_aux(X,Y,R,L1,[Y|Laux]).
cambiar_aux(X,Y,[E|R],L1,Laux):- cambiar_aux(X,Y,R,L1,[E|Laux]).
cambiar_aux(_,_,[],L1,L1).





appendl(X,Y,Z):-append_aux(X,Y,Z,[]).
append_aux([C|R], Y, Z, Laux):-append_aux(R, Y, Z, [C|Laux]).
append_aux([], [C|R], Z, Laux):-append_aux([], R, Z, [C|Laux]).
append_aux([], [], Z, Z).


interseccion(L,L1,L2):-interseccion_aux(L,L1,L2,[]).
interseccion_aux([C|R],L1,L2,Laux):-pertenece(C,L1),interseccion_aux(R,L1,L2,[C|Laux]).
interseccion_aux([C|R],L1,L2,Laux):-interseccion_aux(R,L1,L2,Laux).
interseccion_aux([],L,Laux,Laux).
pertenece(E,[E|R]).
pertenece(E,[C|R]):-pertenece(E,R).



sin_rep(L,L1):- sin_rep_aux(L,L1,[]).
sin_rep_aux([C|R],L1,Laux):- pertenece(C,R),sin_rep_aux(R,L1,Laux).
sin_rep_aux([C|R],L1,Laux):-sin_rep_aux(R,L1,[C|Laux]).
sin_rep_aux([], L1,L1).
pertenece(E,[E|Z]).
pertenece(E,[C|Z]):- pertenece(E,Z).