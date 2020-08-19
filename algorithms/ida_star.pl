:- ['load_maze.pl', 'utils.pl'].

ida_star:-
    start(S), acceptable(S),
    final(F), acceptable(F),
    heuristic(S, F, HN),
    ida_main(S, HN, Solution),
    write("Solution: "),write(Solution).

ida_main(S, Limit, Solution):-
    ida_search(S, [S], Limit, 0, Solution),
    retractall(new_limit(_)).

ida_main(S, Limit, Solution):-
    findall(L, new_limit(L), LimitList),
    exclude(>=(Limit), LimitList, OverLimitList),
    sort(OverLimitList, SortedLimitList),
    nth0(0, SortedLimitList, NewLimit),
    write("Depth: "), write(NewLimit), write("\n"),
    retractall(new_limit(_)),
    ida_main(S, NewLimit, Solution).

ida_search(S, _, _, _, []):-
    final(S).
ida_search(S, Visited, Limit, PathCost, [Act|Actions]):-
    final(F),
    applicable(Act, S),
    move(Act, S, NewS),
    \+member(NewS, Visited),
    cost(S, NewS, Cost),
    NewPathCost is PathCost + Cost,
    heuristic(NewS, F, HN),
    FNew is NewPathCost + HN,
    asserta(new_limit(FNew)),
    FNew =< Limit,
    ida_search(NewS, [NewS|Visited], Limit, NewPathCost, Actions).