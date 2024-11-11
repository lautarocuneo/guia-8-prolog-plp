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


borrar([], _, []).
borrar([X|Xs], X, Ys) :- borrar(Xs, X, Ys).
borrar([X|Xs], Y, [X|Ys]) :- X \= Y, borrar(Xs, Y, Ys).

% sacarDuplicados(+L1, -L2), que saca todos los elementos duplicados de la lista L1.

sacarDuplicados([], []).
sacarDuplicados([X|L1], L2) :-
    sacarDuplicados(L1, Ys),
    borrar(Ys, X, Xs),
    append([X], Xs, L2).


%longitud
longitud([], 0).
longitud([_|T], N) :- longitud(T, N1), N is N1 + 1.

%partir
partir(N,L,L1,L2) :- append(L1,L2,L), longitud(L1, N).

%insertar
insertar(X, L, LX) :- append(P, S, L), append(P, [X|S], LX).

%permutacion
permutacion([], []).
permutacion([X|Xs], Ys) :- permutacion(Xs, Zs), insertar(X, Zs, Ys).


%parqueQueSuma
parteQueSuma(_, 0, []).

parteQueSuma([X|L], S, [X|P]) :-
    S1 is S - X,               
    S1 >= 0,                   
    parteQueSuma(L, S1, P).    

parteQueSuma([_|L], S, P) :-
    parteQueSuma(L, S, P).

%desde2 arreglando reversibilidad
desde2(X, X).
desde2(X, Y) :- var(Y), N is X+1, desde2(N, Y).
desde2(X, Y) :- nonvar(Y), X < Y.

%intercalar
intercalar([], [], []).
intercalar([], L1, L1).
intercalar(L2, [], L2).
intercalar([X|L1], [Y|L2], [X,Y|L3]) :- intercalar(L1, L2, L3).



%arbol
vacío(nil).

raiz(bin(_, V, _), V).

altura(nil, 0).
altura(bin(I, _, D), A) :- altura(I, AI), altura(D, AD), A is 1+max(AI, AD).

cantidadDeNodos(nil, 0).
cantidadDeNodos(bin(I, _, D), N) :- cantidadDeNodos(I, NI), cantidadDeNodos(D, ND), N is 1+NI+ND.