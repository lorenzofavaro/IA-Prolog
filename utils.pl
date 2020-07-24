heuristic(pos(RowA,ColumnA), pos(RowB,ColumnB), Distance):-
    Distance is abs(RowA - RowB) + abs(ColumnA - ColumnB).

comparator(<, [_,_,A1], [_,_,A2]):- A1 < A2.
comparator(>, _, _).

cost(_, _, 1).