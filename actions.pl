acceptable(pos(Row, Column)):-
    num_rows(NR),
    num_columns(NC),
    Row > 0, Row =< NR,
    Column > 0, Column =< NC.

applicable(est, pos(Row, Column)):-
    num_columns(NC),
    Column < NC,
    NewColumn is Column+1,
    \+occupied(pos(Row, NewColumn)).

applicable(ovest, pos(Row,Column)):-
    Column > 1,
    NewColumn is Column-1,
    \+occupied(pos(Row, NewColumn)).

applicable(nord, pos(Row, Column)):-
    Row > 1,
    NewRow is Row-1,
    \+occupied(pos(NewRow, Column)).

applicable(sud, pos(Row, Column)):-
    num_rows(NR),
    Row < NR,
    NewRow is Row+1,
    \+occupied(pos(NewRow, Column)).

move(est, pos(Row, Column), pos(Row, NewColumn)):-
    NewColumn is Column+1.

move(ovest, pos(Row, Column), pos(Row, NewColumn)):-
    NewColumn is Column-1.

move(nord, pos(Row, Column), pos(NewRow, Column)):-
    NewRow is Row-1.

move(sud, pos(Row, Column), pos(NewRow, Column)):-
    NewRow is Row+1.