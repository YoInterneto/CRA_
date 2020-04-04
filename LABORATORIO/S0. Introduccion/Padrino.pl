% Author:
% Date: 06/02/2020

personas([mother, andolini, corleone, carmella, michael, santino, constanzia, frederico, tom,kay,apollonia,lucy,sandra,carlo,deanna,theresa,anthony,mary,vincent,santinojr,francesca,frank,victor,francis,two,frank2,andrew]).


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



ancestro(X,Y):-parent(X,Y).%ancestro Y de X
ancestro(X,Y):-parent(X,Z),ancestro(Z,Y).

descendiente(X,Y):-parent(Y,X).%descendiente Y de X
descendiente(X,Y):-parent(Z,X),descendiente(Y,Z).

descendientes().

