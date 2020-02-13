% Author:
% Date: 13/02/2020

pedir_numero(Min,Max,Out):-
   repeat,
   write('Introduce un numero entre '),
   write(Min),write(' y '),write(Max),write(':'),
   
   read(Out),
   ((Out>=Min,Out=<Max,!);
   writeln('Dato incorrecto'),false).


%select(valorLista,variable,valor de reemplazo,salida)
%  -> simbolos(X), select(b,X,x,Out) - Reemplaza la b por la x
simbolos([a,b,c,b,a]).


lista_simbolos([[a,a,b,b],[c,c,d,d],[a,b,c,d]]).
remplazar_simbolo_sublista(Lista,NSublista,ValorOri,ValorNue,ListaOut):-
   nth1(NSublista,Lista,Sublista,Res),
   select(ValorOri,Sublista,ValorNue,SublistaOut),
   nth1(NSublista,ListaOut,SublistaOut,Res).
   
%nth1 ->