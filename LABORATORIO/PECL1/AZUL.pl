
%Listas para cada uno de los tableros usados en el programa
bolsa([
    'A','A','A','A','A','A','A','A','A','A',
    'B','B','B','B','B','B','B','B','B','B',
    'V','V','V','V','V','V','V','V','V','V',
    'R','R','R','R','R','R','R','R','R','R',
    'N','N','N','N','N','N','N','N','N','N']).
patron([
    ['*','*','*','*','_'],
    ['*','*','*','_','_'],
    ['*','*','_','_','_'],
    ['*','_','_','_','_'],
    ['_','_','_','_','_']
    ]).
mosaico([
    ['a','n','r','v','b'],
    ['b','a','n','r','v'],
    ['v','b','a','n','r'],
    ['r','v','b','a','n'],
    ['n','r','v','b','a']
    ]).
centroMesa([]).
cementerio([]).
caja([]).
tablero1([]).
tablero2([]).
tableroJuego([]).


%Inicializacion de las listas que usaran en el programa
ini_bolsa(BolsaOut):-bolsa(Bolsa),random_permutation(Bolsa, BolsaOut).


ini_centroMesa(Centro):-centroMesa(Centro).


ini_mosaico(Mosaico):-mosaico(Mosaico).


ini_caja(Caja):-caja(Caja).


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
    append(FactAux,[FactoriaX],Sublista),
    NFactOut is (NFact - 1),
    ini_factorias(NFactOut,BolsaAux,BolsaOut,Sublista,FactOut).
ini_factorias(0,BolsaOut,BolsaOut,FactOut,FactOut).


ini_factorias_njug(NJug,BolsaIn,BolsaOut,FactsOut):-
    NFacts is (NJug * 2) + 1,
    ini_factorias(NFacts,BolsaIn,BolsaOut,[],FactsOut).



%Logica del programa
jugarAzul():-
    iniciar(2,4,Jugadores).


iniciar(Min,Max,Jugadores):-
    repeat,
    write('Introduce el numero de jugadores (2-4): '),

    read(Jugadores),
    ((Jugadores>=Min,Jugadores=<Max,!);
        writeln('Dato incorrecto, n jugadores entre 2 y 4.'),false),
        
    iniciar_juego(Jugadores).


iniciar_juego(Jugadores):-
    write('Tablero inicializado con '),write(Jugadores),writeln(' jugadores'),
    
    ini_bolsa(Bolsa),
    ini_factorias_njug(Jugadores,Bolsa,BolsaOut,ListaFactorias),
    ini_centroMesa(Centro),
    ini_patron(Patron),
    ini_caja(Caja),
    ini_mosaico(Mosaico),
    ini_cementerio(Cementerio),
    
    Tablero1 = [Caja,BolsaOut,ListaFactorias,Centro],
    Tablero2 = [Patron,Mosaico,Cementerio],
    Juego = [Tablero1,Tablero2],

    empezar_juego(Jugadores,Juego).


empezar_juego(Jugadores,Juego):-

    Juego=[Tablero1,Tablero2],
    Tablero1=[Caja,Bolsa,Factorias,Centro],
    Tablero2=[Patron,Mosaico,Cementerio],

    write('Turno del jugador '), writeln(Jugadores),

    elegir_factoria(Centro,Factorias,NFactoriaOut).

%Muestra y pide al usuario que diga la factoria/centro que quiere elegir
%Poner algo asi para hacer un IF??????
%<NFactorias,!);
%        writeln('Dato incorrecto, n jugadores entre 2 y 4.'),false).
elegir_factoria(Centro,Factorias,NFactoriaOut):-
    length(Factorias, Long),
    Longitud is Long + 1,
    
    imprimir_factorias(Factorias, 0, Longitud),
    
    C is Longitud + 1,
    write(Longitud),write('C. '),writeln(Centro),

    pedir_n_factoria(Elegida,Longitud),
    Index is Elegida - 1,
    nth0(Index, Factorias, FactoriaElegida),
    write('Elegida factoria '),write(Index),write(' '),writeln(FactoriaElegida),
    %CON FACTORIAELEGIDA TENEMOS LA FACTORIA QUE QUEREMOS PARA OPERAR CON ELLA
    %elegir_color(FactoriaElegida, FactoriaElegidaOut, Eleccion),
    elegir_color(FactoriaElegida, Color),
    eleccion_color(FactoriaElegida, FactoriaElegidaOut, [], Color),
    writeln(FactoriaElegidaOut).

%Imprime todas las factorias que hay en el tablero
imprimir_factorias(Factorias,NFactoria,Longitud):-
    NFactoria < Longitud,
    nth0(NFactoria, Factorias, FactoriaWrite, FactoriasOut),

    Num is NFactoria + 1,
    write(Num),write('.  '),writeln(FactoriaWrite),

    imprimir_factorias(Factorias, Num, Longitud).
imprimir_factorias(Factorias,NFactoria,Longitud).

%Pide un n�mero de factoria elegido por el usuario
pedir_n_factoria(Elegida,NFactorias):-
    repeat,
    write('Introduce el numero de factoria: '),

    read(Elegida),
    ((Elegida>=1,Elegida=<NFactorias,!);
        writeln('ERROR: Color de factoria no valido'),false).
        
%Con la factoria elegida y el color que queremos nos retorna una lista con las fichas a colocar
%eleccion_color(FactoriaElegida, Contador, Cero, Color):-
%    d
    

eleccion_color(FactoriaElegida, FactoriaElegidaOut, Lista, Color, Index):-
    Index < 3,
    nth0(Index,FactoriaElegida,Posicion),
    (member(Posicion, FactoriaElegida)),
    append(Posicion, Lista, Salida),
    IndexSiguiente is Index + 1,
    eleccion_color(FactoriaElegida, FactoriaElegidaOut, Salida, Color, IndexSigguiente).

eleccion_color(FactoriaElegida, FactoriaElegidaOut, Lista, Color, Index):-
    Index < 3,
    IndexSiguiente is Index + 1,
    eleccion_color(FactoriaElegida, FactoriaElegidaOut, Lista, Color, IndexSigguiente).
eleccion_color(FactoriaElegida, Lista, Lista, Color, Index).

%Sirve para elegir un color de la lista elegida
elegir_color(FactoriaElegida, Color):-
    repeat,
    write('Introduce el color quieres elegir: '),

    read(Color),
    ((member(Color, FactoriaElegida),!);
        writeln('ERROR: Color de factoria no valido'),false).
        