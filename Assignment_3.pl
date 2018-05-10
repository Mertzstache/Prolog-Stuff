%% member(X, [X]).
%% member(X, [X|T]) :- member(X, T).

:- discontiguous provable/1.
mode :- subset(+, +), same_set(+, +).


mymember(X, [X]).
mymember(X, [H|T]) :- H = X ; mymember(X, T).

subset([], _).
%% subset(+Sub, +Super) :- 

subset([H|T] , Super) :-
  	member(H, Super),
  	subset(T, Super).

same_set(Set1, Set2):-
	length(Set1, A),
	length(Set2, B),
	A == B,
	subset(Set1, Set2).

intersection([], _, []).

intersection([H|T], Set2, [H|Intersection]) :-
    member(H, Set2),
    intersection(T, Set2, Intersection).

intersection([_|T], Set2, Intersection) :-
    intersection(T, Set2, Intersection).

%% union([], _, _).
union([], [], []).
union(Set1,[],Set1).     
union([],Set2,Set2). 

union([H|T], Set2, Union) :- 
	member(H, Set2), 
	union(T, Set2, Union).

union([H|T], Set2, [H|Union]) :- 
	union(T, Set2, Union).

maplist(_, []).
maplist(P, [H|T]) :-
	call(P, H),
	maplist(P, T).

maplist(_ , [], []).
maplist(P , [H1|T1], [H2|T2]) :-
	call(P, H1, H2),
	maplist(P, T1, T2).

partition(_, [], [], []).
partition(P, [H|T], [H|Included], Excluded) :-
	call(P, H),
	partition(P, T, Included, Excluded).

partition(P, [H|T], Included, [H|Excluded]) :-
	\+call(P, H),
	partition(P, T, Included, Excluded).


%% provable(P = Q) :-

%% provable( (X = Y) ):- !, provable(X), provable(Y).

provable(true).
provable((A, B)) :- 
	provable(A), 
	provable(B). 

provable(A \= B) :-
    A \= B.
provable(A = B) :-
	A = B.
provable(number(A)) :-
	number(A).
provable(string(A)) :-
	string(A).
provable(is(A, B)) :-
	A is B.
provable(A > B) :-
	A > B.
provable(A < B) :-
	A < B.
provable(A >= B) :-
	A >= B.
provable(A =< B) :-
	A =< B.
provable(call(A)) :-
	call(A).
provable(\+A) :-
	\+A.
provable( (A; B) ) :- !, (provable(A); provable(B)).

provable(Goal) :- 
    Goal \= (_\=_),
    Goal \= (_=_),
    Goal \= (number(_)),
    Goal \= (string(_)),
    Goal \= (is(_,_)),
    Goal \= (_>_),
    Goal \= (_<_),
    Goal \= (_>=_),
    Goal \= (_=<_),
    Goal \= (call(_)),
    Goal \= (\+_),
    clause(Goal, Body),
    provable(Body).

%% proveable( \+ P) :- \+proveable(P).
%% provable(X = Y, )




%% union([H1|T1], [H2|T2], [H1, H2 | Res]) :-
%% 	H1 \= H2,
%% 	union(T1, T2, Res).

%% union([H1|T1], [H2|T2], [H1| Res]) :-
%% 	H1 == H2,
%% 	union(T1, T2, Res).

