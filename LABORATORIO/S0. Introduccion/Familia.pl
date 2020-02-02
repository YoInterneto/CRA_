% Author:
% Date: 30/01/2020

%nombre(X,Y). Y es nombre de X
%\+ -> negacion
%\= -> distinto de
%= -> igual que
%funcion:-cond1,cond2...
%var(nombreVariable) -> asigna var a una variable
%var(nombreVariable), funcion -> usamos el valor de una variable en una funcion
%varibleNum is (operacion) -> asgina el valor de una operacion a un numero


personas([adrian,manuel,alberto,pablo,enrique,yolanda,esther]).

padre(adrian,manuel).
padre(alberto,pablo).
padre(lucas,pablo).
padre(enrique,pablo).

madre(adrian,yolanda).
madre(alberto,esther).
madre(julio,yolanda).

hermano(Herm1,Herm2) :- padre(Herm1,Padre), padre(Herm2,Padre),\+ (Herm1=Herm2).
hermano(Herm1,Herm2) :- madre(Herm1,Madre), madre(Herm2,Madre),\+ (Herm1=Herm2).

imprimir_personas([Pers1|OtrasPersonas]) :- writeln(Pers1), imprimir_personas(OtrasPersonas).
imprimir_personas([]) :- writeln('No hay mas personas').

sumar_1([Num|MasNumeros]) :- NewNum is (Num+1), writeln(NewNum), sumar_1(MasNumeros).
sumar_1([]).

sumar_lista(ListaNums, Resultados) :- sumar_lista_aux(ListaNums,[],Resultados).
sumar_lista_aux(ListaNums,ResAux,Resultados) :-
    ListaNums = [Num|MasNums],
    NuevoNum is (Num+1),
    append(ResAux,[NuevoNum],ResAux2),
    sumar_lista_aux(MasNums,ResAux2,Resultados).
sumar_lista_aux([],Resultados,Resultados).
sumar_lista([]).