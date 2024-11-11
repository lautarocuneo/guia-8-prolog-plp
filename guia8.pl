padre(juan, carlos).
padre(juan, luis).
padre(carlos, daniel).
padre(carlos, diego).
padre(luis, pablo).
padre(luis, manuel).
padre(luis, ramiro).
abuelo(X, Y) :- padre(X, Z), padre(Z, Y).

hijo(X,Y) :- padre(Y,X).

descendiente(X,Y) :- hijo(X,Y).
descendiente(X,Y) :- hijo(X,Z), descendiente(Z,Y).

hermano(X,Y) :- padre(Z,X), padre(Z,Y), X \= Y.

ancestro(X, X).
ancestro(X, Y) :- ancestro(Z, Y), padre(X, Z).


vecino(X, Y, [_|Resto]) :- vecino(X, Y, Resto).
vecino(X, Y, [X|[Y|_]]).


natural(zero).
natural(suc(X)) :- natural(X).

menorOIgual(X, X) :- natural(X).
menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).

append([], L, L).
append([X|L1],L2,[X|L3]) :- append(L1,L2,L3).

ultimo(L,U) :- append(_, [U], L).

primero(L,P) :- append([P], _ , L).

ultimo2([U],U).
ultimo2([_|L],U) :- ultimo2(L,U).

/*da igual el orden en ultimo*/
ultimo3([_|L],U) :- ultimo3(L,U). 
ultimo3([U],U).

/* reverse(+L, -L1), donde L1 contiene los mismos elementos que L, pero en orden inverso. */
revertir([], []).
revertir([X|L], P) :- revertir(L, R), append(R, [X], P).

/* prefijo(?P, +L), donde P es prefijo de la lista L. */
prefijo(P, L) :- append(P, _, L).

/* sufijo(?S, +L), donde S es sufijo de la lista L. */
sufijo(S, L) :- append(_, S, L).

/* sublista(?S, +L), donde S es sublista de L. */
sublista([], _).
sublista([X|Xs], L) :- prefijo(P, L), sufijo([X|Xs], P).

/* pertenece(?X, +L), que es verdadero sii el elemento X se encuentra en la lista L. */
/*asi no anda*/
pertenece(X,L) :- append([X|_], _, L). 

/*asi si*/
pertenece2(X,L) :- append(_, [X|_], L).

%longitud
longitud([], 0).
longitud([_|T], N) :- longitud(T, N1), N is N1 + 1.


partir(N,L,L1,L2) :- append(L1,L2,L), longitud(L1, N).