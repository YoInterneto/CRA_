
% ACLARACIONES
% f = femenino
% m = masculino
% s = singular
% p = plural
% n = neutro
%%%%%%%%%%%%%%%%%%%%


%DETERMINANTES
determinante(det(X),f,s) --> [X], {member(X,[la,una])}.
determinante(det(X),f,p) --> [X], {member(X,[las,unas])}.
determinante(det(X),m,s) --> [X], {member(X,[el,un])}.
determinante(det(X),m,p) --> [X], {member(X,[los,unos])}.
determinante(det(X),n,s) --> [X], {member(X,[su,mi])}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%NOMBRES

%Aclaraciones: nino = niño

%Comunes
nombre(n(X),c,m,s) --> [X], {member(X,[alumno,tenedor,cuchillo,canario,niño,lugar,gato,ratón,profesor,hombre,procesador,vuelo,café,pantalón,nacimiento])}.
nombre(n(X),c,m,p) --> [X], {member(X,[textos,ratones,documentos,reflejos])}.
nombre(n(X),c,f,s) --> [X], {member(X,[manzana, mujer,practica,paloma,esperanza,vida,herramienta,mesa,corbata,cerveza])}.
nombre(n(X),c,f,p) --> [X], {member(X,[patatas,manzanas])}.
%Propios
nombre(n(X),p,m,s) --> [X], {member(X,[juan,hector,madrid])}.
nombre(n(X),p,f,s) --> [X], {member(X,[maría,universidad,irene])}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%PRONOMBRES
pronombre(p(yo),pers1,_,s) --> [yo].
pronombre(p(tu),pers2,_,s) --> [tu].
pronombre(p(el),pers3,m,s) --> [él].
pronombre(p(ella),pers3,f,s) --> [ella].
pronombre(p(nosotros),pers1,m,p) --> [nosotros].
pronombre(p(nosotras),pers1,f,p) --> [nosotras].
pronombre(p(vosotros),pers2,f,p) --> [vosotros].
pronombre(p(vosotras),pers2,m,p) --> [vosotras].
pronombre(p(ellos),pers3,m,p) --> [ellos].
pronombre(p(ellas),pers3,f,p) --> [ellas].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%VERBOS
verbo(v(X),pers3,s) --> [X], {member(X,[cazó,come,hace,canta,alzó,habla,ama,depende,sirve,toma,estudia,recoge,toma,compré,salta,sonríe,está,es,era])}.
verbo(v(X),pers1,p) --> [X], {member(X,[vimos])}.
verbo(v(X),pers3,p) --> [X], {member(X,[comen,beben])}.
verbo(v(X),n,n) --> [X], {member(X,[escribir])}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%ADJETIVOS

adjetivo(a(X),f,s) --> [X], {member(X,[roja,blanca,alta])}.
adjetivo(a(X),f,p) --> [X], {member(X,[fritas,rojas])}.
adjetivo(a(X),m,s) --> [X], {member(X,[delicado,moreno,lento])}.
adjetivo(a(X),m,p) --> [X], {member(X,[negros])}.
adjetivo(a(X),n,s) --> [X], {member(X,[grande,potente,alegre,gris])}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%ADVERBIOS
adverbio(ad(X)) --> [X], {member(X,[muy,lejos,claramente,solamente,bastante])}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%CONJUNCIONES

conjuncion(c(X)) --> [X], {member(X,[y,ni,pero,mientras])}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Pronombre de relativo
pronombreRel(prR(X)) --> [X], {member(X,[que])}.

%PREPOSICIONES

preposicion(pr(X)) --> [X], {member(X,[a,con,de,en,para])}.

%Nexo coma
coma(com(X)) --> [X],{member(X,[','])}.