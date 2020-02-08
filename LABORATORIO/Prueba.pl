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

%ancestro(X,Y) -> Y es el ancestro de X
ancestro(X,Y):-parent(X,Y).%y es ancestro de x si el padre de x es y
ancestro(X,Y):-parent(Z,Y),ancestro(X,Z).

%descendientes() -> Y es el descendiente de X
%descendientes(X,Y):-
