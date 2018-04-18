
%%CLASS EXAMPLE

edge(X,Y) :- link(X,Y)
edge(X,Y) :- link(Y,X)

edge(a,b).
edge(b,c).
edge(b,d).
edge(c,d).
%edge(X,Y) :- edge(Y,X)
% avoid left recursion! dont have the recursive call at the start
% at the rule (avoids doubling). Put the base cases first(avoids infinite recursion)!!

connected(Start, End) :-
 edge(Start, End).
connected(Start, End) :-
 edge(I, End),
 connected(Start, I).


%%END CLASS EXAMPLE


