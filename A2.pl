:- discontiguous evaluate/2, function/2.
%numbers

name("Eric", "Mertz", "ejm804").

evaluate(N, N) :- number(N).
evaluate(true, true).
evaluate(false, false).
%% uncomment the line below for a test value of function
%% function(qwertyasdfh(X), true).
evaluate(X + Y, Z) :- 
	evaluate(X, A),
	evaluate(Y, B),
	Z is A + B.

evaluate(X - Y, Z) :- 
	evaluate(X, A),
	evaluate(Y, B),
	Z is A - B.

evaluate(X * Y, Z) :- 
	evaluate(X, A),
	evaluate(Y, B),
	Z is A * B.

evaluate(X / Y, Z) :- 
	evaluate(X, A),
	evaluate(Y, B),
	Z is A / B.

evaluate(-X, Z) :- 
	evaluate(X, A),
	Z is -A.

%boolean constructs
evaluate(X = Y, true) :- 
	evaluate(X, A),
	evaluate(Y, B),
	A = B,!.
evaluate(_ = _, false).
evaluate(X > Y, true) :- 
	evaluate(X, A),
	evaluate(Y, B),
	A > B,!.
evaluate(_ > _, false).

evaluate(X >= Y, true) :- 
	evaluate(X, A),
	evaluate(Y, B),
	A >= B,!.
evaluate(_ >= _, false).

evaluate(X =< Y, true) :- 
	evaluate(X, A),
	evaluate(Y, B),
	A =< B,!.
evaluate(_ =< _, false).

evaluate(X < Y, true) :- 
	evaluate(X, A),
	evaluate(Y, B),
	A < B,!.
evaluate(_ < _, false).

evaluate(X \= Y, true) :- 
	evaluate(X, A),
	evaluate(Y, B),
	A \= B,!.
evaluate(_ \= _, false).

%easier to have and and or up here...
and(A,B):- truep(A), truep(B).
or(A,B):- truep(A) ; truep(B).
truep(true). 
truep(A):- var(A), !, false.

evaluate(and(X, Y), true) :- 
	evaluate(X, A),
	evaluate(Y, B),
	and(A,B),!.

evaluate(and(_, _), false).

evaluate(or(X, Y), true) :- 
	evaluate(X, A),
	evaluate(Y, B),
	or(A,B),!.

evaluate(or(_, _), false).

evaluate(not(X), true) :-
	evaluate(X, A),
	A = false,!.
evaluate(not(_), false).

evaluate(F, V) :-
	function(F, E),
	evaluate(E, V).

evaluate(if(B, T, E), V) :-
	evaluate(B, Z),
	Z -> evaluate(T, V); evaluate(E, V).

equals(X, Y) :- X = Y.
assoc(X, Y, A) :-
	A = [B|_],
	equals(B, X=Y).

assoc(X, Y, A) :-
	A = [_|C],
	assoc(X, Y, C).

assoc_lazy(X, Y, A) :-
	member(X=Y, A).

