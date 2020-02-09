% Author:
% Date: 08/02/2020

personas([mother, andolini, corleone, carmella, michael, santino, constanzia, frederico, tom,kay,apollonia,lucy,sandra,carlo,deanna,theresa,anthony,mary,vincent,santinojr,francesca,frank,victor,francis,two,frank2,andrew]).

%parent(X,Y) -> Y es el padre de X
parent(corleone,mother).
parent(corleone,andolini).
parent(michael,corleone).
parent(santino,corleone).
parent(constanzia,corleone).
parent(frederico,corleone).
parent(tom,corleone).
parent(michael,carmella).
parent(santino,carmella).
parent(constanzia,carmella).
parent(frederico,cocarmella).
parent(tom,carmella).
parent(anthony,michael).
parent(mary,anthony).
parent(anthony,kay).
parent(mary,kay).
parent(vincent,santino).
parent(vincent,lucy).
parent(santinojr,santino).
parent(francesca,santino).
parent(frank,santino).
parent(santinojr,sandra).
parent(francesca,sandra).
parent(frank,sandra).
parent(victor,carlo).
parent(michael,carlo).
parent(victor,constanzia).
parent(michael,constanzia).
parent(two,tom).
parent(frank2,tom).
parent(andrew,tom).
parent(two,theresa).
parent(frank2,theresa).
parent(andrew,theresa).

%pareja(X,Y) -> Y es la pareja de X
pareja(corleone,carmella).
pareja(andolini,mother).
pareja(michael,kay).
pareja(michael,apollonia).
pareja(santino,lucy).
pareja(santino,sandra).
pareja(carlo,constanzia).
pareja(vicent,lucy).
pareja(frederico,deanna).
pareja(tom,theresa).
pareja(carmella,corleone).
pareja(mother,andolini).
pareja(kay,michael).
pareja(apollonia,michael).
pareja(lucy,santino).
pareja(sandra,santino).
pareja(constanzia,carlo).
pareja(lucy,vicent).
pareja(deanna,frederico).
pareja(theresa,tom).


%casados(X,Y) -> X esta casado con Y
casados(X,Y):-parent(Hijo,X),parent(Hijo,Y).

%ancestro(X,Y) -> Y es el ancestro de X
ancestro(X,Y):-parent(X,Y).%y es ancestro de x si el padre de x es y
ancestro(X,Y):-parent(Z,Y),ancestro(X,Z).

%descendientes(persona, ) -> lista de descendientes


%hermano(X,Y) -> Y es el hermano de X
hermano(X,Y):- parent(X,Padre), parent(Y,Padre),\+ (X=Y).

%abuelo(X,Y) -> Y es el abuelo de X
abuelo(Nieto,Abuelo):-parent(Padre,Abuelo),parent(Nieto,Padre).

%nieto(X,Y) -> Y es el nieto de X
nieto(Abuelo,Nieto):-abuelo(Nieto,Abuelo).

%tio(X,Y) -> Y es el tio de X
tio(Sobrino,Tio):-hermano(Tio,Padre),parent(Sobrino,Padre).
tio(Sobrino,Tio):-pareja(Tio,Tio2),hermano(Tio2,Padre),parent(Sobrino,Padre).

%sobrino(X,Y) -> Y es el sobrino de X
sobrino(Tio,Sobrino):-tio(Sobrino,Tio).

%suegro(X,Y) -> Y es el suegro de X
suegro(Yerno,Suegro):-pareja(Yerno,Pareja),parent(Pareja,Suegro).

%cunado(X,Y) -> Y es el cuñado de X
cunado(X,Y):-pareja(Y,Hermano),hermano(Hermano,X).
cunado(X,Y):-pareja(X,Hermano),hermano(Hermano,Y).

%yernonuera(X,Y) -> Y es el yerno/nuera de X pareja de tu hijo
yernonuera(X,Y):-pareja(Y,Hijo),parent(Hijo,X).
