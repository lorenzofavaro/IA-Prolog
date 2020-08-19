:- ['load_maze.pl', 'utils.pl'].

a_star:-
    start(S), acceptable(S),
    final(F), acceptable(F),
    heuristic(S, F, HN),
    a_star_search([ [[],S,HN] ], [], ReverseSolution),
    reverse(ReverseSolution, Solution),
    length(Solution, Length),
    write("Solution: "),write(Solution), write("\nLength: "), write(Length).

a_star_search([[A,S,_]|_], _, A):-
    final(S).
% Node: [[Actions], pos(X,Y), f(n)]
a_star_search([Node|Tail], ClosedSet, Solution):-
    expand(Node, ClosedSet, ExpandedNodes), % ExpandedNodes: children applicabili ordinati
    subtract(ClosedSet, ExpandedNodes, NewClosedSet),
    add(ExpandedNodes, Tail, OpenSet), % OpenSet: lista ordinata contenente tutti gli elementi di ExpandedNodes e Tail
    !, \+length(OpenSet, 0), % Condizione di terminazione
    a_star_search(OpenSet, [Node|NewClosedSet], Solution).

expand([A,S,FN], ClosedSet, ExpandedNodes):-
    final(F),
    gn([A,S,FN], GN),
    %length(A, GN), Alternativa per il calcolo di g(n)
    findall([[Az|A],NewS,FNew], 
        (applicable(Az,S), move(Az, S, NewS), heuristic(NewS, F, HN), cost(S, NewS, Cost), FNew is GN+Cost+HN, (\+member([_,NewS,_], ClosedSet); (member([_,NewS,Eur], ClosedSet), FNew < Eur))),
         ExpandedNodes).
    
add(ExpandedNodes, OldNodes, Sorted):-
    append(ExpandedNodes, OldNodes, Concatenated),
    predsort(comparator, Concatenated, Sorted).

gn([_,S,FN], GN):-
    final(F),
    heuristic(S, F, HN),
    GN is FN-HN.