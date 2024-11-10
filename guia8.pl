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