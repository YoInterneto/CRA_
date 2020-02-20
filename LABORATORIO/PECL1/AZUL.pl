
bolsa([
    ['A','A','A','A','A','A','A','A','A','A'],
    ['B','B','B','B','B','B','B','B','B','B'],
    ['V','V','V','V','V','V','V','V','V','V'],
    ['R','R','R','R','R','R','R','R','R','R'],
    ['N','N','N','N','N','N','N','N','N','N']
    ]).


iniciar(Min,Max,Out):-
    repeat,
    write('Introduce el numero de jugadores (2-4): '),

    read(Out),
    ((Out>=Min,Out=<Max,!);
        writeln('Dato incorrecto, n jugadores entre 2 y 4.'),false),
    iniciar_tablero(Out,[]).

iniciar_juego(Jugadores,Juego):-
    write('Tablero inicializado con '),write(Jugadores),write(' jugadores'),
    ini_bolsa(BolsaOut),ini_factorias(BolsaOut)

ini_bolsa(BolsaOut):-bolsa(Bolsa),random_permutation(Bolsa, BolsaOut).

ini_factoria(BolsaIn,BolsaOut,FactOut):-
    nth0(0, BolsaIn, Ficha1, BolsaAux1),
    nth0(0, BolsaAux1, Ficha2, BolsaAux2),
    FactOut=[Ficha1,Ficha2,Ficha3,Ficha4].

ini_factorias(NFacts,BolsaIn,)

ini_factorias_njug(NJug,BolsaIn,BolsaOut,FactsOut):-
    NFacts is (NJug * 2) + 1,














