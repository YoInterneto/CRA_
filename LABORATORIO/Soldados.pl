% Author:
% Date: 13/02/2020

%soldado -> nombre,vida,daño
soldado(['john',15,1]).
soldado(['peter',10,2]).
soldado(['ryan',5,3]).

atacarSoldado(SoldadoAtk,SoldadoDef,SoldadoHerido):-
   SoldadoAtk=[NombreAtk,_,DanoAtk],
   SoldadoDef=[NombreDef,VidaDef,DanoDef],
   VidaNueva is VidaDef-DanoAtk,
   write('El soldado '),write(NombreAtk),write(' ataca a '),write(NombreDef),writeln(':'),
   write('  -'),write(NombreDef),write(' recibe '),write(DanoAtk),write('pts de daño (VIDA:'),write(VidaNueva),writeln(')'),
   SoldadoHerido=[NombreDef,VidaNueva,DanoDef],
   writeln(SoldadoHerido).
   