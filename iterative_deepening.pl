:- ['load_maze.pl', 'actions.pl'].

iterative_deepening:-
    start(S), acceptable(S),
    final(F), acceptable(F),
    num_rows(Rows),
    num_columns(Columns),
    MaxLimit is Rows * Columns,
    iterative_deepening_search(S, [S], Solution, 1, MaxLimit),
    write("Solution: "),write(Solution).
    
iterative_deepening_search(S, Visited, Solution, Iterations, _):-
    depth_search(S, Visited, Solution, Iterations).
iterative_deepening_search(S, Visited, Solution, Iterations, MaxLimit):-
    Iterations < MaxLimit,
    NewIterations is Iterations+1,
    write("Depth': "), write(NewIterations), write("\n"),
    iterative_deepening_search(S, Visited, Solution, NewIterations, MaxLimit).

depth_search(S, _, [], _):-
    final(S).
depth_search(S, Visited, [Act|Actions], Limit):-
    Limit > 0,
    NewLimit is Limit-1,
    applicable(Act, S),
    move(Act, S, NuovoS),
    \+member(NuovoS, Visited),
    depth_search(NuovoS, [NuovoS|Visited], Actions, NewLimit).