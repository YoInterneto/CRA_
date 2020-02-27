
bolsa([
    'A','A','A','A','A','A','A','A','A','A',
    'B','B','B','B','B','B','B','B','B','B',
    'V','V','V','V','V','V','V','V','V','V',
    'R','R','R','R','R','R','R','R','R','R',
    'N','N','N','N','N','N','N','N','N','N']).

centroMesa([]).

patron([
    ['_','','','',''],
    [],
    [],
    [],
    []
    ]).

mosaico([
    ['a','n','r','v','b'],
    ['b','a','n','r','v'],
    ['v','b','a','n','r'],
    ['r','v','b','a','n'],
    ['n','r','v','b','a']
    ]).

cementerio([]).

tablero1([]).
tablero2([]).

tableroJuego([]).






iniciar(Min,Max,Out):-
    repeat,
    write('Introduce el numero de jugadores (2-4): '),

    read(Out),
    ((Out>=Min,Out=<Max,!);
        writeln('Dato incorrecto, n jugadores entre 2 y 4.'),false),
    iniciar_juego(Out,[]).

iniciar_juego(Jugadores,Juego):-
    write('Tablero inicializado con '),write(Jugadores),write(' jugadores'),
    %Bolsa,
    ini_bolsa(Bolsa),
    ini_factorias_njug(Jugadores,Bolsa,BolsaOut,ListaFactorias),
    ini_tablero1(Tablero1),
    ini_tablero2(Tablero2),
    ini_centroMesa(Centro),
    ini_patron(Patron),
    ini_mosaico(Mosaico),
    ini_cementerio(Cementerio),

    Tablero1 = [BolsaOut,ListaFactorias,Centro],
    Tablero2 = [Patron,Mosaico,Cementerio],

    Juego=[Tablero1,Tablero2].

ini_bolsa(BolsaOut):-bolsa(Bolsa),random_permutation(Bolsa, BolsaOut).

ini_tablero1(Tablero1):-tablero1(Tablero1).

ini_tablero2(Tablero2):-tablero2(Tablero2).

ini_centroMesa(Centro):-centroMesa(Centro).

ini_mosaico(Mosaico):-mosaico(Mosaico).

ini_patron(Patron):-patron(Patron).

ini_cementerio(Cementerio):-cementerio(Cementerio).

ini_factoria(BolsaIn,BolsaOut,FactOut):-
    nth0(0, BolsaIn, Ficha1, BolsaAux1),
    nth0(0, BolsaAux1, Ficha2, BolsaAux2),
    nth0(0, BolsaAux2, Ficha3, BolsaAux3),
    nth0(0, BolsaAux3, Ficha4, BolsaOut),
    FactOut=[Ficha1,Ficha2,Ficha3,Ficha4].

ini_factorias(NFact,BolsaIn,BolsaOut,FactAux,FactOut):-
    NFact > 0,
    ini_factoria(BolsaIn,BolsaAux,FactoriaX),
    append(FactAux,FactoriaX,FactAux2),
    NFactOut is (NFact - 1),
    ini_factorias(NFactOut,BolsaAux,BolsaOut,FactAux2,FactOut).

ini_factorias(0,BolsaOut,BolsaOut,FactOut,FactOut).

ini_factorias_njug(NJug,BolsaIn,BolsaOut,FactsOut):-
    NFacts is (NJug * 2) + 1,
    ini_factorias(NFacts,BolsaIn,BolsaOut,[],FactsOut).














