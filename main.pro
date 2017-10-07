implement main
    open core

class facts - relatives
    parent: (string Родитель, string Ребенок).
    married: (string Муж, string Жена).
    male: (string).
    female: (string).

class predicates
    father: (string Отец, string Ребенок) nondeterm (o,o).
    mother: (string Мать, string Ребенок) nondeterm (o,o).
    brother: (string, string) nondeterm (o,o).
    plem: (string, string) nondeterm (o,o).
    granddaughter: (string, string) nondeterm (o,o).
    two_plem: (string, string) nondeterm (o,o).
    three_plem: (string, string) nondeterm (o,o).
    two_uncle: (string,string) nondeterm (o,o).
    zolovka: (string, string) nondeterm (o,o).
    wifes_sister: (string, string) nondeterm (o,o).

    svekrov:(string, string) nondeterm (o,o).
    svekrovka:(string, string) nondeterm (o,o).

clauses

    svekrov(A, B):-
        male(B),
        married(B,C),
        parent(A,C).

    svekrovka(A, B):-
        female(B),
        married(C,B),
        parent(A,C).

    father(X, Y):-
        parent(X, Y),
        male(X).

    mother(X, Y):-
        parent(X, Y),
        female(X).

    brother(X,Y):-
        parent(Z,X),
        parent(Z,Y),
        male(X),
        X<>Y.

   plem(X,F):-      %племянник
        parent(Z,F),
        male(F),
        parent(P,X),
        parent(P,Z),
        Z<>X.

    granddaughter(X,P):- %правнучка
        parent(P,F),
        parent(F,Y),
        parent(Y,X),
        female(X),
        F<>Y.

    two_plem(X,C):-  %двоюродный племянник
        parent(Y,C),
        parent(F,Y),
        parent(F,D),
        parent(D,G),
        parent(G,X),
        male(X),
        Y<>D.

    three_plem(X,Y):- %  Троюродный племянник
        parent(F,X),
        parent(G,F),
        parent(H,G),
        parent(H,T),
        parent(T,P),
        parent(P,O),
        parent(O,Y),
        male(Y),
        G<>T.

    two_uncle(X, P):- % ДВОЮРОДНЫЙ ДЯДЯ
        parent(Y, P),
        parent(F,Y),
        parent(D,F),
        parent(D,H),
        parent(H,X),
        male(X),
        H<>F.


    zolovka(X,Y):-
        female(Y),
        married(D,Y),
        parent(F,D),
        parent(F,X),
        female(X).

    wifes_sister(Y,X):-
        parent(Z,K),
        parent(Z,Y),
        married(X,K),
        female(Y),
        Y<>K.

    run():-
        console::init(),
        file::consult("family.txt", relatives),
       % father(X, Y),
        %    console::write("отец - ", X, ", ребенок - ", Y), console::nl,
      %  fail;
       % mother(X, Y),
      %      console::write("мать - ", X, ", ребенок - ", Y), console::nl,
        %fail;
        console::nl,
        brother(X, Y),
            console::write(X, " является братом ", Y), console::nl,
        fail;
        console::nl,
        plem(X, F),
            console::write(F, " является племянником ", X), console::nl,
        fail;
        console::nl,
        granddaughter(X, F),
            console::write(X, " правнучка ", F), console::nl,
        fail;
        console::nl,
        two_plem(X, Y),
            console::write(X, " двоюродный племянник ", Y), console::nl,
        fail;
        console::nl,
        three_plem(X, Y),
            console::write(Y, " троюродный племянник ", X), console::nl,
        fail;
        console::nl,
        two_uncle(X,Y),
            console::write(X, " двоюродный дядя ", Y), console::nl,
        fail;
        console::nl,
        zolovka(X,Y),
            console::write(X, " сестра мужа, где ", Y, " жена мужа"), console::nl,
        fail;
        console::nl,
        svekrov(X,Y),
            console::write(X, " явлется свекром мужа ", Y), console::nl,
        fail;
        console::nl,
        svekrovka(X,Y),
            console::write(X, " явлется свекрой жены ", Y), console::nl,
        fail;
        console::nl,
        succeed().

end implement main

goal
    console::run(main::run).
