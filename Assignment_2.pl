:- discontiguous evaluate/2.
%numbers

name("Eric", "Mertz", "ejm804").

evaluate(N, N) :- number(N).
evaluate(true, true).
evaluate(false, false).

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
%% previous imp...
%% evaluate(and(X, Y), true) :- 
%% 	evaluate(X, A),
%% 	evaluate(Y, B),
%% 	A = true,
%%  B = true,
%% 	!.
evaluate(and(_, _), false).

evaluate(or(X, Y), true) :- 
	evaluate(X, A),
	evaluate(Y, B),
	or(A,B),!.
%% previous imp...
%% evaluate(or(X, Y), true) :- 
%% 	evaluate(X, A),
%% 	evaluate(Y, B),
%% 	A = true, B = false,
%% 	!.
%% evaluate(or(X, Y), true) :- 
%% 	evaluate(X, A),
%% 	evaluate(Y, B),
%% 	A = false, B = true,
%% 	!.
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


%% function(fib(N,F) :-
%%     integer(N),
%%     N>1,
%%     N1 is N-1,
%%     fib(N1,F1),
%%     N2 is N-2,
%%     fib(N2,F2),
%%     F is F1+F2.)s
%% fib(1,1).
%% fib(0,1).

%assoc
%% pair(key, value).
%% same(A, B).

%% assoc(K, V, A) :-
%% 	A = [X|Y],
%% 	same(pair(K, V), X).

%% assoc(K, V, A),
%% 	A = [X|Y],
%% 	assoc(K, V, Y).
%% function(factorial(N),
%%          if(N = 0,
%%             1,
%%             factorial(N - 1) * N)).

%% function(multiply(N, M),
%%          N * M).


%% square(N, Z) :- Z is N * N.