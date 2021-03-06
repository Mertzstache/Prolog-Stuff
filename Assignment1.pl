%%%
%%% Assignment 1
%%%

:- discontiguous male/1, female/1, parent/2.

name("Eric", "Mertz", "ejm804").

%male(X).
%female(X).
%parent(C, P).

%%mother/father
mother(C, P) :- 
	female(P), 
	parent(C, P).

father(C, P) :- 
	male(P), 
	parent(C, P).

%%sibling relations - consider this, they will be listed twice due to different bindings of parents whenit comes to aunt and uncle stuff... what do?
siblings(X, Y) :- 
	parent(X, Z), 
	parent(Y, Z), 
	X \= Y.

sister(X, S) :- 
	female(S),
	siblings(X, S).

brother(X, B) :- 
	male(B),
	siblings(X, B).

%aunt and uncle
aunt(X, A) :- 
	parent(X, P), 
	sister(P, A).

uncle(X, U) :- 
	parent(X, P), 
	brother(P, U).

niece(X, N) :- 
	female(N), 
	siblings(X, I), 
	parent(N, I).

nephew(X, N) :- 
	male(N), 
	siblings(X, I), 
	parent(N, I).

%gpa gma
grandparent(C, G) :- 
	parent(I, G), 
	parent(C, I).

grandmother(C, M) :- 
	female(M),
	grandparent(C, M).

grandfather(C, F) :- 
	male(F)
	grandparent(C, F).

%ancestors
ancestor(X, A) :- 
	parent(X, A).
ancestor(X, A) :- 
	parent(X, P), 
	ancestor(P, A).

male(eric).
female(grace).

male(dad).
male(robert).
female(wendy).

male(connor).
female(brooke).
female(taylor).

female(deborah).
female(tina).
female(maribel).

male(david).
male(jonathan).

male(thomas).
male(michael).
female(maria).

male(gpa).
female(elaine).

female(lola).
male(papa).

parent(eric, deborah).
parent(grace, deborah).
parent(eric, dad).
parent(grace, dad).

parent(dad, gpa).
parent(robert, gpa).
parent(wendy, gpa).
parent(dad, elaine).
parent(robert, elaine).
parent(wendy, elaine).

parent(connor, wendy).
parent(brooke, wendy).
parent(taylor, wendy).

parent(deborah, papa).
parent(maribel, papa).
parent(tina, papa).
parent(deborah, lola).
parent(maribel, lola).
parent(tina, lola).

parent(david, tina).
parent(jonathan, tina).

parent(thomas, maribel).
parent(maria, maribel).
parent(michael, maribel).




%part 2

calls(a, b).
calls(b, c).
calls(b, d).
calls(c, d).
calls(d, x).
calls(x, s).

reachable_from(A, B) :- 
	calls(A, B).

reachable_from(A, B) :- 
	calls(A, I),
	reachable_from(I, B).

called_jointly(A, B, C) :-
	reachable_from(A, C),
	reachable_from(B, C).






