# Progetto Prolog

Questo progetto è stato realizzato per l'esame di Intelligenza Artificiale e Laboratorio del corso di Laurea Magistrale all'Università di Torino.

## Setup
- Installare [SWI-Prolog](https://www.swi-prolog.org/download/stable).
- Installare [VSCode](https://code.visualstudio.com/download) e l'apposita estensione [VSC-Prolog](https://marketplace.visualstudio.com/items?itemName=arthurwang.vsc-prolog).
- Clonare il progetto.

## Il problema
Un sistema intelligente è collocato in uno spazio di n righe ed m colonne, in cui sono posti degli ostacoli. Il sistema si trova in una delle celle del labirinto e, muovendosi all’interno dello stesso, deve raggiungere una casella di uscita.

Il sistema può muoversi nelle quattro direzioni (nord, sud, est, ovest) e non in diagonale e, ovviamente, non può raggiungere una cella contenente un ostacolo.

Il sistema conosce la configurazione del labirinto (dimensioni, posizione degli ostacoli, uscite).

<p align="center">
  <img src="https://github.com/lorenzofavaro/IA-Prolog/blob/master/labyrinths/maze10.png"/>
</p>

## Struttura del progetto
- `labyrinths` contiene tutte le basi di conoscenza rappresentanti le mappe di labirinti.
- `actions.pl` descrive tutte le azioni possibili effettuabili dal sistema, a prescindere dall'algoritmo utilizzato.
  - il predicato `acceptable(S)` controlla se la posizione `S` esiste all'interno del labirinto.
  - `applicable(action, S)` dev'essere usata prima di ogni `move/3` per verificare che lo spostamento sia corretto.
  - `move(action, S, S1)` restituisce la nuova posizione `S1` effettuando lo spostamento derivato da `action` a partire dalla posizione di partenza `S`.
- `utils.pl` specifica ulteriori predicati.
  - `heuristic(S, S1, Distance)` calcola il valore di euristica `Distance` mediante la distanza di Manhattan tra le posizioni `S` ed `S1`
  - `comparator(`
- `load_maze.pl` effettua la load della mappa selezionata.
- `a_star.pl` algoritmo di ricerca A*.
- `iterative_deepening.pl` algoritmo di ricerca Iterative Deepening.
- `ida_star.pl` algoritmo di ricerca Iterative Deepening A*.
